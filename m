From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] t4255: test am submodule with diff.submodule
Date: Sat, 27 Dec 2014 21:24:17 -0500
Message-ID: <20141228022417.GA2256@flurp.local>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
 <1419728664-18627-1-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 03:24:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y53X9-0004Tf-Km
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 03:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaL1CYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 21:24:24 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61887 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaL1CYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 21:24:24 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so10952503ier.14
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4d9ZHbe0lKu4Ao+uOI6Ylrm0YCcn2s5ceA+Ikfhj//g=;
        b=Dc7Z4Z7z5aurb3IXkHfys+Gn8M5geGcTVrc16kBnBI9iJyy4eETUhI8dJvHvb3MXoE
         Xk3dV4OKQ/6QYfdFL3Xm2QNQ4Ol3fuyoS8etWwOWwEGkP1nT2iQv2THeMBiJKKREc+Yt
         IdyMI1uF58Y+rrHsCYuJo56RWHgdxyiHyOOpsnZ4Uewmoz7k6pUamolM1pqplwrvpEy0
         kR2p2DNo9ALvG4GhYZSnOFVdkBQ73exRfgN55YdksIi+0ROBfOg7soxsY/FTUW7XQ37R
         MBkueWUanf9HpiHZIPb+8eebx7EA7pw7ogr2s8zj8ZvchLZpay6CXgsNAkI6GPaKDRXe
         mM5w==
X-Received: by 10.50.35.195 with SMTP id k3mr40279735igj.11.1419733463356;
        Sat, 27 Dec 2014 18:24:23 -0800 (PST)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id nm13sm12546425igb.5.2014.12.27.18.24.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Dec 2014 18:24:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419728664-18627-1-git-send-email-dougk.ff7@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261852>

On Sat, Dec 27, 2014 at 07:04:23PM -0600, Doug Kelly wrote:
> git am will break when using diff.submodule=log; add some test cases
> to illustrate this breakage as simply as possible.  There are
> currently two ways this can fail:
> 
> * With errors ("unrecognized input"), if only change
> * Silently (no submodule change), if other files change
> 
> Test for both conditions and ensure without diff.submodule this works.
> 
> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> ---

Here below the "---" line is a good place to explain what changed
since the last version of the patch (or do so in the cover letter of
the new patch series). It's also helpful to reviewers to provide a
link to the previous round, like this[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/261830

More below.

>  t/t4255-am-submodule.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
> index 8bde7db..a2dc083 100755
> --- a/t/t4255-am-submodule.sh
> +++ b/t/t4255-am-submodule.sh
> @@ -18,4 +18,88 @@ am_3way () {
>  KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
>  test_submodule_switch "am_3way"
>  
> +test_expect_success 'setup diff.submodule' '
> +	echo one >one &&
> +	git add one &&
> +	test_tick &&
> +	git commit -m initial &&

Perhaps squash in the following to improve succinctness?

-- >8 --
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index b7ec0f1..b58e776 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -19,50 +19,37 @@ KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "am_3way"
 
 test_expect_success 'setup diff.submodule' '
-	echo one >one &&
-	git add one &&
-	test_tick &&
-	git commit -m initial &&
+	test_commit one &&
 	INITIAL=$(git rev-parse HEAD) &&
 
 	git init submodule &&
 	(
 		cd submodule &&
-		echo two >two &&
-		git add two &&
-		test_tick &&
-		git commit -m "initial submodule" &&
+		test_commit two &&
 		git rev-parse HEAD >../initial-submodule
 	) &&
 	git submodule add ./submodule &&
-	test_tick &&
 	git commit -m first &&
 
 	(
 		cd submodule &&
-		echo three >three &&
-		git add three &&
-		test_tick &&
-		git commit -m "first submodule" &&
+		test_commit three &&
 		git rev-parse HEAD >../first-submodule
 	) &&
 	git add submodule &&
-	test_tick &&
 	git commit -m second &&
 	SECOND=$(git rev-parse HEAD) &&
 
 	(
 		cd submodule &&
-		git mv two four &&
+		git mv two.t four.t &&
 		test_tick &&
 		git commit -m "second submodule" &&
 		git rev-parse HEAD >../second-submodule
 	) &&
+	test_commit four &&
 	git add submodule &&
-	echo four >four &&
-	git add four &&
-	test_tick &&
-	git commit -m third &&
+	git commit --amend --no-edit &&
 	THIRD=$(git rev-parse HEAD) &&
 	git submodule update --init
 '
-- 
2.2.1.302.gdfcd89f
