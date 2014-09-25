From: Luke Lee <luke.yx.lee@gmail.com>
Subject: Re: Fix a critical bug in git-cvsexportcommit.perl
Date: Thu, 25 Sep 2014 11:15:51 +0800
Message-ID: <ppekl7a0.fsf@gmail.com>
References: <wq8tquzz.fsf@gmail.com> <54229AFC.6080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 05:16:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWzXF-0000Gu-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 05:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbaIYDP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 23:15:57 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32989 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbaIYDP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 23:15:57 -0400
Received: by mail-pa0-f43.google.com with SMTP id kx10so10097822pab.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EW3l15XNdrX/x7N1cFB/1CTn9GBm9329dg+1PVQ9YmI=;
        b=wSahtOjAC4DWjgppAaT4RwpSUwTfCeeJWGQs5NLrYSU8MSrlwMHkDGmgE/nhQNKQ8x
         WFNJazEOnFTRhpdjktDPMDonp8J9Iaqacz4RWIHJQaHSsqSF4qyjTqgaLVks7azT9pzA
         MkNOKPrE0mwg/ZFG3QzaQsAiVdbBKKwDke++piBxy7RyNf0WXs93O/vKMokIuVon1zzP
         +zRkXAR5O23JoumoF6t6VMjUXchmAKNCgqfWIgd1fi57qtvEfZLwML4O7fXjs053O/6n
         sfyOpTo6DoCxlHlxfDADS91KrxsUwxMKBzo6dVHdz/qAJTbXJyiwS+BN9ySPocs53BGw
         WeRQ==
X-Received: by 10.68.233.197 with SMTP id ty5mr1105304pbc.22.1411614956574;
        Wed, 24 Sep 2014 20:15:56 -0700 (PDT)
Received: from tw-fw-dt-1 (59-120-45-147.HINET-IP.hinet.net. [59.120.45.147])
        by mx.google.com with ESMTPSA id h12sm627938pdk.48.2014.09.24.20.15.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Sep 2014 20:15:56 -0700 (PDT)
In-Reply-To: <54229AFC.6080704@gmail.com> (Stefan Beller's message of "Wed, 24
	Sep 2014 12:20:44 +0200")
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257469>

Stefan Beller <stefanbeller@gmail.com> writes:

> Please have a look at Documentation/SubmittingPatches,
> also found online at
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches
>
> Specially look at section "(2) Describe your changes well."
> So the headline could be shorter and then in the body of the commit
> message you may want to be more descriptive
>
> Also look at section "(5) Sign your work"
> This is to make sure you're legally allowed to send in the patch,
> i.e. you're doing it on your own time or your employer allowed you to
> send code here to the mailing list.

I followed both (2) and (5), a new patch is generated and signed as
follows. Hopefully this time it fits the criteria :). Thanks.


>From a265cffc5f5bbfb3309a5ef2b425096523c94066 Mon Sep 17 00:00:00 2001
From: "Luke Y.X. Lee" <luke.yx.lee@gmail.com>
Date: Thu, 25 Sep 2014 10:56:46 +0800
Subject: [PATCH] Fix git-cvs bug that kills non-keyword source texts

* git-cvsexportcommit.perl: the wild matching on unexpanding keywords
overkilled texts that are not CVS keywords. Limits the matching to
CVS keywords only; also prevents OO syntax that accidentally matched.

Signed-off-by: Luke Y.X. Lee <luke.yx.lee@gmail.com>
---
 git-cvsexportcommit.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d13f02d..8671d41 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -309,7 +309,7 @@ foreach my $f (@files) {
 	while (<FILTER_IN>)
 	{
 	    my $line = $_;
-	    $line =~ s/\$([A-Z][a-z]+):[^\$]+\$/\$$1\$/g;
+	    $line =~ s/\$(Author|Date|Header|Id|Locker|Log|RCSfile|Revision|Source|State):[^:\$][^\$]*\$/\$$1\$/g;
 	    print FILTER_OUT $line;
 	}
 	close FILTER_IN;
-- 
2.1.1.304.gb913e04
