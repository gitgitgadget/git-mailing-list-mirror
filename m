X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem with git-apply?
Date: Sat, 4 Nov 2006 08:27:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611040821290.25218@g5.osdl.org>
References: <20061104072349.GA19667@cubit> <7v8xir4k3w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 4 Nov 2006 16:27:56 +0000 (UTC)
Cc: Kevin Shanahan <kmshanah@disenchant.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v8xir4k3w.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30928>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgOMv-0007Mt-HO for gcvg-git@gmane.org; Sat, 04 Nov
 2006 17:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965541AbWKDQ11 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 11:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965542AbWKDQ11
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 11:27:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37250 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S965541AbWKDQ11 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 11:27:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA4GRKoZ024728
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 4
 Nov 2006 08:27:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA4GRJ3f026052; Sat, 4 Nov
 2006 08:27:19 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sat, 4 Nov 2006, Junio C Hamano wrote:
> 
> The problem appears that GNU diff _never_ uses "--- /dev/null" or "+++ 
> /dev/null" to indicate creation or deletion of the file, but the 
> "traditional patch parser" builtin-apply has assumed that is what the 
> traditional diff output from day one.  Where we got that idea is mystery 
> to me (this is Linus's code), but I suspect it is what other SCMs did.

No, the original code used to trigger a "create" diff on
 - source was /dev/null
OR
 - source had zero patches.

It used to have code like

        if (patch->is_new < 0) {
                patch->is_new =  !oldlines;
                if (!oldlines)
                        patch->old_name = NULL;
        }
        if (patch->is_delete < 0) {
                patch->is_delete = !newlines;
                if (!newlines)
                        patch->new_name = NULL;
        }

and I think the person who broke it was you ;)

According to git-pickaxe, the buggy commit is 4be60962.

You should know by now that I never have bugs. 

