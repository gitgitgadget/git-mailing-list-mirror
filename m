Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4F131E4B
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660140; cv=none; b=dnk+Iq6r7Yc8DugR1YvbsXU4tsGczg8i/j/otO1YdME1ZkEGJ66r7d+YKZV9um9l2JUE0h70jPwChZG5SiHEm2LMqfMWvVF1LHNtdfey7fPy8lfaDj6CXYS9q5pMWcrtIsBIEEz20hMTH1mpRp/dmwFDjltGEoc28eAlsNgIXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660140; c=relaxed/simple;
	bh=n0K3xn65h+Ta8ZhLgwrPT2wX/kZVHOPg5RBghVlNlpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRZIA2XteBLDwJD1LLuce646/feFJZPJOz05DH1iDy1BMQXMoK5zWmZxieVsx8phNRMVyRq7qoPMGLjjqrCHAKBPNnEx7z3pOQfh5RHFZdtxdB3+2/ggJn1yFDDyRxRB0SduYwSyPdPu2gLVn8dGlSDwneH+NB3caq2awuJkn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NcjHvDiW; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcjHvDiW"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AF1DC299BA;
	Thu, 28 Mar 2024 17:08:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n0K3xn65h+Ta8ZhLgwrPT2wX/kZVHOPg5RBghV
	lNlpg=; b=NcjHvDiWqaO6XWu/q4EUsC1pTJx6h0bpfgB0WEQ1qKn0rBtowGWbyD
	6eurCjBjBmWfLDK6sA7QzkBfyQ+i4oWRUmTXMMcS2NDCT1fLQ3c5aYkU7ehsuE5x
	pnFhSPhXYp7E5VRJgl8rvfvqbMTgSRHbEidL7OG1y3txWcKVNcAD0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F3DA299B9;
	Thu, 28 Mar 2024 17:08:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10C6B29979;
	Thu, 28 Mar 2024 17:08:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,  Han
 Young <hanyang.tony@bytedance.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] t4126: make sure a directory with SP at the end is usable
In-Reply-To: <xmqqa5miuutd.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	28 Mar 2024 10:31:42 -0700")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	<xmqqa5miuutd.fsf@gitster.g>
Date: Thu, 28 Mar 2024 14:08:47 -0700
Message-ID: <xmqqh6gqt674.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F355064-ED47-11EE-BE6F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

As afb31ad9 (t1010: fix unnoticed failure on Windows, 2021-12-11)
said:

    On Microsoft Windows, a directory name should never end with a period.
    Quoting from Microsoft documentation[1]:

	Do not end a file or directory name with a space or a period.
	Although the underlying file system may support such names, the
	Windows shell and user interface does not.

    [1]: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file

and the condition addressed by this change is exactly that.  If the
platform is unable to properly create these sample patches about a
file that lives in a directory whose name ends with a SP, there is
no point testing how "git apply" behaves there on the filesystem.

Even though the ultimate purpose of "git apply" is to apply a patch
and to update the filesystem entities, this particular test is
mainly about parsing a patch on a funny pathname correctly, and even
on a system that is incapable of checking out the resulting state
correctly on its filesystem, at least the parsing can and should work
fine.  Rewrite the test to work inside the index without touching the
filesystem.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > As this test _is_, unlike the cited patch that was not about a
    > directory with a funny name, about parsing a patch and applying it
    > to a path with a directory with a funny name, I am tempted to keep
    > the test with the filesystem, instead of replacing it with the one
    > using the "--cached" that Peff suggested.  I am _also_ tempted to
    > add that "--cached" thing (instead of replacing), though.

    So, I changed my mind and just took Peff's "--cached" approach
    with no filesystem-based test.  format-patch --range-diff just
    didn't understand that the single patch corresponds to the only
    one patch in the older "series", and I had to force it to match
    them with --creation-factor=999 in a separate invocation.  The
    patch text has changed too much so it is useless, but the log
    message change may be easier to see in the range-diff.

1:  7e84d0f64f ! 1:  a107f21ea2 t4126: make sure a directory with SP at the end is usable
    @@ Commit message
         and the condition addressed by this change is exactly that.  If the
         platform is unable to properly create these sample patches about a
         file that lives in a directory whose name ends with a SP, there is
    -    no point testing how "git apply" behaves there.
    +    no point testing how "git apply" behaves there on the filesystem.
     
    -    Protect the test that involves the filesystem access with a
    -    prerequisite, and perform the same test only within the index
    -    everywhere.
    +    Even though the ultimate purpose of "git apply" is to apply a patch
    +    and to update the filesystem entities, this particular test is
    +    mainly about parsing a patch on a funny pathname correctly, and even
    +    on a system that is incapable of checking out the resulting state
    +    correctly on its filesystem, at least the parsing can and should work
    +    fine.  Rewrite the test to work inside the index without touching the
    +    filesystem.
     
         Helped-by: Jeff King <peff@peff.net>
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
    @@ t/t4126-apply-empty.sh: test_expect_success 'apply --index create' '
      '
      
     -test_expect_success 'apply with no-contents and a funny pathname' '
    -+test_expect_success 'setup patches in dir ending in SP' '
    -+	test_when_finished "rm -fr \"funny \"" &&
    - 	mkdir "funny " &&
    - 	>"funny /empty" &&
    - 	git add "funny /empty" &&
    +-	mkdir "funny " &&
    +-	>"funny /empty" &&
    +-	git add "funny /empty" &&
     -	git diff HEAD "funny /" >sample.patch &&
     -	git diff -R HEAD "funny /" >elpmas.patch &&
    -+	git diff HEAD -- "funny /" >sample.patch &&
    -+	git diff -R HEAD -- "funny /" >elpmas.patch &&
    ++test_expect_success 'parsing a patch with no-contents and a funny pathname' '
      	git reset --hard &&
     -	rm -fr "funny " &&
    -+
    -+	if  grep "a/funny /empty b/funny /empty" sample.patch &&
    -+	    grep "b/funny /empty a/funny /empty" elpmas.patch
    -+	then
    -+		test_set_prereq DIR_ENDS_WITH_SP
    -+	else
    -+		# Win test???
    -+		ls -l
    -+	fi
    -+'
    -+
    -+test_expect_success DIR_ENDS_WITH_SP 'apply with no-contents and a funny pathname' '
    -+	test_when_finished "rm -fr \"funny \"" &&
    - 
    - 	git apply --stat --check --apply sample.patch &&
    - 	test_must_be_empty "funny /empty" &&
    -@@ t/t4126-apply-empty.sh: test_expect_success 'apply with no-contents and a funny pathname' '
    - 	test_path_is_missing "funny /empty"
    - '
    - 
    -+test_expect_success 'parsing a patch with no-contents and a funny pathname' '
    -+	git reset --hard &&
    -+
     +	empty_blob=$(test_oid empty_blob) &&
    -+	echo $empty_blob >expect &&
    -+
    ++	echo "$empty_blob" >expect &&
    + 
    +-	git apply --stat --check --apply sample.patch &&
    +-	test_must_be_empty "funny /empty" &&
     +	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
     +	git diff --cached HEAD -- "funny /" >sample.patch &&
     +	git diff --cached -R HEAD -- "funny /" >elpmas.patch &&
     +	git reset &&
    -+
    + 
    +-	git apply --stat --check --apply elpmas.patch &&
    +-	test_path_is_missing "funny /empty" &&
     +	git apply --cached --stat --check --apply sample.patch &&
     +	git rev-parse --verify ":funny /empty" >actual &&
     +	test_cmp expect actual &&
    -+
    + 
    +-	git apply -R --stat --check --apply elpmas.patch &&
    +-	test_must_be_empty "funny /empty" &&
     +	git apply --cached --stat --check --apply elpmas.patch &&
     +	test_must_fail git rev-parse --verify ":funny /empty" &&
    -+
    + 
    +-	git apply -R --stat --check --apply sample.patch &&
    +-	test_path_is_missing "funny /empty"
     +	git apply -R --cached --stat --check --apply elpmas.patch &&
     +	git rev-parse --verify ":funny /empty" >actual &&
     +	test_cmp expect actual &&
     +
     +	git apply -R --cached --stat --check --apply sample.patch &&
     +	test_must_fail git rev-parse --verify ":funny /empty"
    -+'
    -+
    + '
    + 
      test_done

 t/t4126-apply-empty.sh | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index eaf0c5304a..2462cdf904 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -66,26 +66,29 @@ test_expect_success 'apply --index create' '
 	git diff --exit-code
 '
 
-test_expect_success 'apply with no-contents and a funny pathname' '
-	mkdir "funny " &&
-	>"funny /empty" &&
-	git add "funny /empty" &&
-	git diff HEAD "funny /" >sample.patch &&
-	git diff -R HEAD "funny /" >elpmas.patch &&
+test_expect_success 'parsing a patch with no-contents and a funny pathname' '
 	git reset --hard &&
-	rm -fr "funny " &&
+	empty_blob=$(test_oid empty_blob) &&
+	echo "$empty_blob" >expect &&
 
-	git apply --stat --check --apply sample.patch &&
-	test_must_be_empty "funny /empty" &&
+	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
+	git diff --cached HEAD -- "funny /" >sample.patch &&
+	git diff --cached -R HEAD -- "funny /" >elpmas.patch &&
+	git reset &&
 
-	git apply --stat --check --apply elpmas.patch &&
-	test_path_is_missing "funny /empty" &&
+	git apply --cached --stat --check --apply sample.patch &&
+	git rev-parse --verify ":funny /empty" >actual &&
+	test_cmp expect actual &&
 
-	git apply -R --stat --check --apply elpmas.patch &&
-	test_must_be_empty "funny /empty" &&
+	git apply --cached --stat --check --apply elpmas.patch &&
+	test_must_fail git rev-parse --verify ":funny /empty" &&
 
-	git apply -R --stat --check --apply sample.patch &&
-	test_path_is_missing "funny /empty"
+	git apply -R --cached --stat --check --apply elpmas.patch &&
+	git rev-parse --verify ":funny /empty" >actual &&
+	test_cmp expect actual &&
+
+	git apply -R --cached --stat --check --apply sample.patch &&
+	test_must_fail git rev-parse --verify ":funny /empty"
 '
 
 test_done
-- 
2.44.0-368-gc75fd8d815
