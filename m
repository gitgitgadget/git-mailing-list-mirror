From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Do not ignore errors during make check
Date: Wed, 14 Dec 2005 15:38:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512141535130.3292@g5.osdl.org>
References: <20051214210932.GA2642@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 00:39:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmgCu-0001jo-Vn
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVLNXig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVLNXig
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:38:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965060AbVLNXif (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 18:38:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBENc1DZ014401
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Dec 2005 15:38:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBENc0Sw013165;
	Wed, 14 Dec 2005 15:38:00 -0800
To: Amos Waterland <apw@us.ibm.com>
In-Reply-To: <20051214210932.GA2642@kvasir.watson.ibm.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13658>



On Wed, 14 Dec 2005, Amos Waterland wrote:
>
>  check:
> -	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
> +	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || break; done

Actually, you might be better off with just

	sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) *.c

these days. It will cause some interesting warnings (it actually 
cross-checks things, and is unhappy about multiple "main()" declarations 
with different types ;), but especially with eventual libification it 
might even be a good idea to try to avoid global functions with the same 
names in different programs ("main", of course, is special, sparse is 
just too stupid to know).

		Linus
