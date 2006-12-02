X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: correctly access repos when only given partial
 read permissions
Date: Sun, 03 Dec 2006 10:57:59 +1300
Message-ID: <4571F6E7.4050809@vilain.net>
References: <11644366982320-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 21:58:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <11644366982320-git-send-email-normalperson@yhbt.net>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33060>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcsM-0003pU-2B for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424436AbWLBV6U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424324AbWLBV6T
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:58:19 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:26337 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1424446AbWLBV6S (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:58:18 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id F2F73139B0D;
 Sun,  3 Dec 2006 10:58:15 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 AA10A1380C2; Sun,  3 Dec 2006 10:58:07 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
> Sometimes users are given only read access to a subtree inside a
> repository, and git-svn could not read log information (and thus
> fetch commits) when connecting a session to the root of the
> repository.  We now start an SVN::Ra session with the full URL
> of what we're tracking, and not the repository root as before.
> 
> This change was made much easier with a cleanup of
> repo_path_split() usage as well as improving the accounting of
> authentication batons.

This broke mirroring file:/// URIs;

eg, if I have ~/.svk/local as a SVN repository, which has a complete
mirror of a URL under mirror/fai, and I want to copy the revisions into
git using git-svn, I use:

perl ~/src/git/git-svn multi-init -t tags -T trunk \
     file:///home/samv/.svk/local/mirror/fai

I now get this error:

Filesystem has no item: File not found: revision 8514, path
'/mirror/fai/tags/mirror/fai/tags' at /home/samv/src/git/git-svn line 3236

(next, I'll make git-svn correctly look at the svm:* revprops to get the
upstream repo URL and revision number for the commit message)

