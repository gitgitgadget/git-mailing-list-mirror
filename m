From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git stash: status from current dir not top dir?
Date: Sat, 19 Mar 2011 10:24:24 +0100
Message-ID: <4D847648.6080404@gmail.com>
References: <4D7A8AC9.1030506@gmail.com> <20110311223232.GA21410@sigill.intra.peff.net> <4D7B358A.5010101@gmail.com> <7v1v2agnww.fsf@alter.siamese.dyndns.org> <4D7E7065.20908@gmail.com> <4D824F46.70107@gmail.com> <7vsjul35p3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 10:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0sOm-0004no-Cr
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 10:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab1CSJYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 05:24:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53559 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab1CSJYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 05:24:34 -0400
Received: by fxm17 with SMTP id 17so4342941fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+S/iTuP5QtLl7579XVthGskItXCAt1GwaGKokaQlYAM=;
        b=GylpeAKqdVH0evUS9BD0af15QFjLqxNaCepbiIBmzOoWTPk0zpdYN5diYaJl6E72uP
         deEJPZgGbO1qQ3LK+dFs3sURSI1A+NnEGDRB85D4Ama/pYYZRybWYAOodTrbkDJJd8ql
         aI3ldaHzq8gKGRFPTL4LU6gSeokbs4ViADe9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=N2LrnSz236KUx8Ju0zG79waFqr1HCUxHZL+0/oEwCsHC7HOj8HQcFxqdpt05AKv57T
         S+z4ozBDjV43T/zz78RRvyS1VDwmGbJn5vCH+m72cimdtUcXaZJvrcSmCgviOU7afz/z
         tv8Ki4kBZfrmbGPmNMiA2O7UZVBt1pS1MqC6c=
Received: by 10.223.159.142 with SMTP id j14mr2365941fax.40.1300526673107;
        Sat, 19 Mar 2011 02:24:33 -0700 (PDT)
Received: from [192.168.1.101] (aapp186.neoplus.adsl.tpnet.pl [83.5.149.186])
        by mx.google.com with ESMTPS id n15sm1683265fam.12.2011.03.19.02.24.31
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 02:24:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vsjul35p3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169422>

W dniu 17.03.2011 20:30, Junio C Hamano pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> Now I don't know how should I handle this:
>>
>>     1. unset it just before "git stash apply" in my test
>>        A safe, local change
> 
> This is the preferred method; in addition to "a safe local", more
> importantly, at that point you are testing what you _want_ to be testing,
> namely, how the output appears to the _real_ end users who do not use
> verbose message. So for that purpose, mucking locally with MERGE_VERBOSITY
> is perfectly acceptable.
> 
> You would not just "unset it just before", but "unset around it" in a
> subshell like this:
> 
> 	git stash &&
> 	(
> 		sane_unset GIT_MERGE_VERBOSITY &&
> 	        git stash apply
> 	) >../actual &&
> 	git status >../expect &&
>         test_cmp ../expect ../actual
> 
> so that if somebody adds new tests later in the script, they are not
> affected by this change.
> 
> Write your test_cmp always to compare expected with actual, not the other
> way around, so that the diff output you see when the test is run under -v
> option shows the changes from what is expected.
> 
> Thanks.

Thanks, updated according to your suggestions.

I've also added a check to see if the output contains a relative path
(so we really test not only that git-stash shows the same status
as git-status, but that the paths are relative).
    
I'm not resending the original patch for git-stash.sh - I don't know if
it's expected to always send full set of patches?


---8<---
From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Mon, 14 Mar 2011 20:19:36 +0100
Subject: [PATCH 2/2] Add test: git stash shows status relative to current dir


Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 t/t3903-stash.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 6fd560c..13f9ae8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -556,4 +556,23 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
+test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
+	git stash clear &&
+	echo 1 > subdir/subfile1 &&
+	echo 2 > subdir/subfile2 &&
+	git add subdir/subfile1 &&
+	git commit -m subdir &&
+	cd subdir &&
+	echo x > subfile1 &&
+	echo x > ../file &&
+	git stash &&
+	(
+		sane_unset GIT_MERGE_VERBOSITY &&
+		git stash apply
+	) > ../actual &&
+	git status > ../expect &&
+	test_cmp ../expect ../actual &&
+	grep "[.][.]/actual" ../actual 
+'
+
 test_done
-- 
1.7.4.1.296.gca6da


-- 
Piotr Krukowiecki
