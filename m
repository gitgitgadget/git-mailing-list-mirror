From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Fri, 22 Oct 2010 10:38:03 -0500
Message-ID: <20101022153803.GD9224@burratino>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
 <7viq0urfbz.fsf@alter.siamese.dyndns.org>
 <20101022053140.GB786@burratino>
 <4CC194DF.9040803@lugmen.org.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fede <fedux@lugmen.org.ar>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Jkk-00047n-KC
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab0JVPlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:41:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab0JVPlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:41:51 -0400
Received: by iwn34 with SMTP id 34so1082683iwn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jBGOjidzeCpYAipaUh8Wt/iY+PZY5Uq3Vdu9afJ0x/I=;
        b=uNTTaGS76KCdmpBHUZoW/9pj1qLLhUprDNmbKv8TsDwKsudkS1nObm1u+NkQQfwtgA
         S4SrA8t7i8hJPzY71oHsfIuBs5E0H0xO/yHp29QrhqNuSYmyG6Aks6Iqf8565230ya5l
         Wawp9rqrYxH8TmdV9LZeRcFr25+AeYvCV2SJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b6bSaFxjrcAOdLVopqelLib9ppQXNm6D/A4zjiOdM2xG/r7hcP4L+ZXjGDxz4q7Tr7
         9VGPV2s+bx1VBXOBgWOQFjXDsvoeJQt2ViZjJEjblMw3OQwgD0RNH26m0yh6qtFbpvUO
         UrWKYHK1nMfHguW0TbzbEpxcTa/qveOava56Q=
Received: by 10.231.166.139 with SMTP id m11mr2689757iby.136.1287762110949;
        Fri, 22 Oct 2010 08:41:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm2708082qco.6.2010.10.22.08.41.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 08:41:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CC194DF.9040803@lugmen.org.ar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159702>

Fede wrote:
> Jonathan Nieder wrote:

>> I had thought -p was only supposed to apply to traditional patches.
>> Maybe a documentation update would avoid confusion?
>>
>> 	-p<n>
>> 	   Remove <n> leading slashes from traditional diff paths.
>> 	   The default is 1.
>
> Currently, if the patch is mode-change only then the filename is taken
> from the line "diff --git ...".

Ah, found it:

commit 79ee194e52a140412da475e102145bad80d5d00a
Author: Shawn O. Pearce <spearce@spearce.org>
Date:   Wed Apr 4 11:19:14 2007 -0400

    Honor -p<n> when applying git diffs
    
    If the user is trying to apply a Git generated diff file and they
    have specified a -p<n> option, where <n> is not 1, the user probably
    has a good reason for doing this.  Such as they are me, trying to
    apply a patch generated in git.git for the git-gui subdirectory to
    the git-gui.git repository, where there is no git-gui subdirectory
    present.
    
    Users shouldn't supply -p2 unless they mean it.  But if they are
    supplying it, they probably have thought about how to make this
    patch apply to their working directory, and want to risk whatever
    results may come from that.
    
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

-- 8< --
Subject: Documentation: update description of "git apply -p"

The "git apply -p" (strip path components) option has gone through some
changes since it was last documented:

 ec7fc0b (builtin-apply.c: pay attention to -p<n> when..., 2009-11-25)
 79ee194 (Honor -p<n> when applying git diffs, 2007-04-04)
 3e8a5db (git-apply: guess correct -p<n> value for non-git..., 2007-02-21)
 56185f4 (git-apply: require -p<n> when working in a subdirectory, 2007-02-19)

Document some of the new rules:

 - the -p option applies to both traditional and --git format diffs
 - in traditional diffs, since there is no customary standard -p value,
   'git apply' will try to guess
 - in all cases, the default is 1

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thoughts?  Improvements?

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4a74b23..8bb7422 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -103,8 +103,11 @@ respectively, and the pathname will be enclosed in double quotes if
 any of those replacements occurred.
 
 -p<n>::
-	Remove <n> leading slashes from traditional diff paths. The
-	default is 1.
+	Remove <n> leading path components from paths found in the
+	diff. The default is 1 for --git format diffs.  For
+	traditional diffs, if this option is not supplied, 'git apply'
+	will try to detect an appropriate -p value, defaulting to 1
+	if there is not enough information to guess.
 
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
