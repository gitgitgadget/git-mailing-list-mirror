From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at
 prompt
Date: Mon, 10 Oct 2011 13:56:58 -0700
Message-ID: <7v8voslg4l.fsf@alter.siamese.dyndns.org>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
 <20111006125658.GB18709@sita-lt.atc.tcs.com>
 <7v62k210pj.fsf@alter.siamese.dyndns.org>
 <20111006181522.GA2936@sita-lt.atc.tcs.com>
 <7vwrcgtvh4.fsf@alter.siamese.dyndns.org>
 <20111008131015.GA28213@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDMuM-0002X1-1v
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 22:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155Ab1JJU5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 16:57:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1JJU5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 16:57:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C79046FE;
	Mon, 10 Oct 2011 16:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4AnfHcxefNU4ZTI/+7RCLIJSXqw=; b=F95h55nfcyzPjN3IDwQq
	dAtsvHeiTpkvyW70nCz3CkxHub0AjH3Q3cu9RKbgmAQdhHiGYd1X8aCadh9XtQsA
	4BWD1kKAFJ3zDN93D8/BxHZVMUBk4FBen87CL1JQkeykThs5szgkiDZkeTMf2Hwe
	mTHydVXQx9SKX2tFQ/JQ+xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dso74qbZB5GMu/YXdI/Sy9mQ5/EsWfeo6snehY3uJb0K0w
	dYOEIxBRGPIGUyY5vzzqR4bTzLYAFIuwZCqudSD8RffalmF8fy2LuzFcjyxSxLWQ
	HnUtC7qtemt2IepKN5Rs5CNYOyMb4V0Wu1KuM21xCA+LNb2mc/n43eEuiwAtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4375E46FD;
	Mon, 10 Oct 2011 16:57:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69E2C46FC; Mon, 10 Oct 2011
 16:57:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 660BB8BE-F382-11E0-9C67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183254>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> However, I'm not sure the file names that 'git difftool'
> comes up with are in a predictable order.  That would mess
> up the test, but I can neither make it fail not find
> definitive information on the order in which the changed
> files are processed.

Hmm, that may be an issue, I would think.

>  git-difftool--helper.sh |    9 +++++----
>  t/t7800-difftool.sh     |   44 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 8452890..0468446 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -38,15 +38,16 @@ launch_merge_tool () {
>  
>  	# $LOCAL and $REMOTE are temporary files so prompt
>  	# the user with the real $MERGED name before launching $merge_tool.
> +	ans=y
>  	if should_prompt
>  	then
>  		printf "\nViewing: '$MERGED'\n"
>  		if use_ext_cmd
>  		then
> -			printf "Hit return to launch '%s': " \
> +			printf "Launch '%s' [Y/n]: " \
>  				"$GIT_DIFFTOOL_EXTCMD"
>  		else
> -			printf "Hit return to launch '%s': " "$merge_tool"
> +			printf "Launch '%s' [Y/n]: " "$merge_tool"
>  		fi
>  		read ans
>  	fi
> @@ -54,9 +55,9 @@ launch_merge_tool () {
>  	if use_ext_cmd
>  	then
>  		export BASE
> -		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
> +		test "$ans" != "n" && eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
>  	else
> -		run_merge_tool "$merge_tool"
> +		test "$ans" != "n" && run_merge_tool "$merge_tool"
>  	fi
>  }

I also found suggestion by Charles Bailey to return from the launch
function when the user says "no" easier to follow.

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 395adfc..f547e0b 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -38,7 +38,18 @@ restore_test_defaults()
>  prompt_given()
>  {
>  	prompt="$1"
> -	test "$prompt" = "Hit return to launch 'test-tool': branch"
> +	test "$prompt" = "Launch 'test-tool' [Y/n]: branch"
> +}
> +
> +stdin_contains()
> +{
> +	grep >/dev/null "$1"
> +}
> +
> +stdin_doesnot_contain()
> +{
> +	grep >/dev/null "$1" && return 1
> +	return 0
>  }

Doesn't

	! grep >/dev/null "$1"

work in this case?        

I also wondered if this is easier to read:

	pipe | stdin_contains m2 &&
	! pipe | stdin_contains master

but I do not think it is (we cannot say "pipe | ! stdin_contains master").

In any case, here is what I ended up queuing.  Thanks.

-- >8 --
From: Sitaram Chamarty <sitaramc@gmail.com>
Date: Sat, 8 Oct 2011 18:40:15 +0530
Subject: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt

This is useful if you forgot to restrict the diff to the paths you want
to see, or selecting precisely the ones you want is too much typing.

[jc: with a change to return from the function upon 'n' by Charles Bailey
and a small tweak in stdin_doesnot_contain() in the test]

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-difftool--helper.sh |    9 ++++++---
 t/t7800-difftool.sh     |   43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 8452890..e6558d1 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -43,12 +43,15 @@ launch_merge_tool () {
 		printf "\nViewing: '$MERGED'\n"
 		if use_ext_cmd
 		then
-			printf "Hit return to launch '%s': " \
+			printf "Launch '%s' [Y/n]: " \
 				"$GIT_DIFFTOOL_EXTCMD"
 		else
-			printf "Hit return to launch '%s': " "$merge_tool"
+			printf "Launch '%s' [Y/n]: " "$merge_tool"
+		fi
+		if read ans && test "$ans" = n
+		then
+			return
 		fi
-		read ans
 	fi
 
 	if use_ext_cmd
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 395adfc..7fc2b3a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -38,7 +38,17 @@ restore_test_defaults()
 prompt_given()
 {
 	prompt="$1"
-	test "$prompt" = "Hit return to launch 'test-tool': branch"
+	test "$prompt" = "Launch 'test-tool' [Y/n]: branch"
+}
+
+stdin_contains()
+{
+	grep >/dev/null "$1"
+}
+
+stdin_doesnot_contain()
+{
+	! stdin_contains "$1"
 }
 
 # Create a file on master and change it on branch
@@ -265,4 +275,35 @@ test_expect_success PERL 'difftool --extcmd cat arg2' '
 	test "$diff" = branch
 '
 
+# Create a second file on master and a different version on branch
+test_expect_success PERL 'setup with 2 files different' '
+	echo m2 >file2 &&
+	git add file2 &&
+	git commit -m "added file2" &&
+
+	git checkout branch &&
+	echo br2 >file2 &&
+	git add file2 &&
+	git commit -a -m "branch changed file2" &&
+	git checkout master
+'
+
+test_expect_success PERL 'say no to the first file' '
+	diff=$((echo n; echo) | git difftool -x cat branch) &&
+
+	echo "$diff" | stdin_contains m2 &&
+	echo "$diff" | stdin_contains br2 &&
+	echo "$diff" | stdin_doesnot_contain master &&
+	echo "$diff" | stdin_doesnot_contain branch
+'
+
+test_expect_success PERL 'say no to the second file' '
+	diff=$((echo; echo n) | git difftool -x cat branch) &&
+
+	echo "$diff" | stdin_contains master &&
+	echo "$diff" | stdin_contains branch &&
+	echo "$diff" | stdin_doesnot_contain m2 &&
+	echo "$diff" | stdin_doesnot_contain br2
+'
+
 test_done
-- 
1.7.7.138.g7f41b6
