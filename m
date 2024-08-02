Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA81A34A0
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614729; cv=none; b=CIKtZL8B755I19pauId3IZBf8BjROyuYz9VS1Jsj+wSQPy/6txcdJIGe/S5WUnm9PtKC4WRULSOwPMoBRNUc/kyEmC/DLjLSjkANHlRMT8e762frpnPkziCbgljcP+rbQPf9PyngNGvpej51IsYKm9iWyT4gQbklho2t8HRNd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614729; c=relaxed/simple;
	bh=5Wbim3BkWDdAGEeeWmEhG28uq58l7ofJYDB7ekqjw1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqLODjNv/hSbyZV90z9EChqEYA4P7YRjnVhgsWlS+nuubU9JozpoLvsbOHhQw8+Gl5oZcH+aEvZG1ZxJPmg0PuHewdG3iBlsZ4bwHr7ZmigRRfVsqHzX0awd17xwLqMZ2oWvGISF7SS2AiG+M3JxWMkMcNfhhPb7GUEb2KmyVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gxjQNRwo; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gxjQNRwo"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A177334846;
	Fri,  2 Aug 2024 12:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5Wbim3BkWDdAGEeeWmEhG28uq58l7ofJYDB7ek
	qjw1M=; b=gxjQNRwoeAZKF4lpU//Ef34XDGrrUDhhcwwzKwk6whofWen/xNksiG
	1O2xPqTHPgKDeHlCdGx0zV1wiy3w+2bmXABHe1pjxx2cFhjQMAHnmaA6KVhEzFGC
	kg+Pm627d97sX3Jfg3cbLWRr9af6nI2QEWboXVKsFTyvefBkR4JTI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 992B034845;
	Fri,  2 Aug 2024 12:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A008A34844;
	Fri,  2 Aug 2024 12:05:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH][Newcomer] t7004-tag: modernize the test script
In-Reply-To: <20240802064719.513498-1-abdobngad@gmail.com> (AbdAlRahman Gad's
	message of "Fri, 2 Aug 2024 09:47:19 +0300")
References: <20240802064719.513498-1-abdobngad@gmail.com>
Date: Fri, 02 Aug 2024 09:05:21 -0700
Message-ID: <xmqqttg2ewqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0665DD72-50E9-11EF-8E2D-92D9AF168FA5-77302942!pb-smtp20.pobox.com

AbdAlRahman Gad <abdobngad@gmail.com> writes:

> Modernaize 't7004-tag.sh' by removing whitespace
> after the redirect operators.

It is a good start.  There are other modernization opportunities in
this file, though.

 - Output from "test-tool ref-store" piped to "sed" means the exit
   status from an abnormal exit of "test-tool" is hidden.  They
   should be split into two commands.

 - Expected output file prepared outside test_expect_success that
   uses it.

 - Here-doc that does not interpolate leaving the EOF marker
   unquoted.

> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
> ---
>  t/t7004-tag.sh | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index fa6336edf9..3100a4c219 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -213,9 +213,9 @@ mytag
>  EOF
>  test_expect_success \
>  	'trying to delete tags without params should succeed and do nothing' '
> -	git tag -l > actual && test_cmp expect actual &&
> +	git tag -l >actual && test_cmp expect actual &&
>  	git tag -d &&
> -	git tag -l > actual && test_cmp expect actual
> +	git tag -l >actual && test_cmp expect actual
>  '
>  
>  test_expect_success \
> @@ -269,9 +269,9 @@ test_expect_success 'listing all tags should print them ordered' '
>  	git tag a1 &&
>  	git tag v1.0 &&
>  	git tag t210 &&
> -	git tag -l > actual &&
> +	git tag -l >actual &&
>  	test_cmp expect actual &&
> -	git tag > actual &&
> +	git tag >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -283,7 +283,7 @@ EOF
>  test_expect_success \
>  	'listing tags with substring as pattern must print those matching' '
>  	rm *a* &&
> -	git tag -l "*a*" > current &&
> +	git tag -l "*a*" >current &&
>  	test_cmp expect current
>  '
>  
> @@ -293,7 +293,7 @@ v1.0.1
>  EOF
>  test_expect_success \
>  	'listing tags with a suffix as pattern must print those matching' '
> -	git tag -l "*.1" > actual &&
> +	git tag -l "*.1" >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -303,7 +303,7 @@ t211
>  EOF
>  test_expect_success \
>  	'listing tags with a prefix as pattern must print those matching' '
> -	git tag -l "t21*" > actual &&
> +	git tag -l "t21*" >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -312,7 +312,7 @@ a1
>  EOF
>  test_expect_success \
>  	'listing tags using a name as pattern must print that one matching' '
> -	git tag -l a1 > actual &&
> +	git tag -l a1 >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -321,7 +321,7 @@ v1.0
>  EOF
>  test_expect_success \
>  	'listing tags using a name as pattern must print that one matching' '
> -	git tag -l v1.0 > actual &&
> +	git tag -l v1.0 >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -331,13 +331,13 @@ v1.1.3
>  EOF
>  test_expect_success \
>  	'listing tags with ? in the pattern should print those matching' '
> -	git tag -l "v1.?.?" > actual &&
> +	git tag -l "v1.?.?" >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success \
>  	'listing tags using v.* should print nothing because none have v.' '
> -	git tag -l "v.*" > actual &&
> +	git tag -l "v.*" >actual &&
>  	test_must_be_empty actual
>  '
>  
> @@ -349,7 +349,7 @@ v1.1.3
>  EOF
>  test_expect_success \
>  	'listing tags using v* should print only those having v' '
> -	git tag -l "v*" > actual &&
> +	git tag -l "v*" >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -1171,7 +1171,7 @@ test_expect_success GPG \
>  	git tag -v emptyfile-signed-tag
>  '
>  
> -printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
> +printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
>  printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
>  printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
>  printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
> @@ -1569,7 +1569,7 @@ test_expect_success \
>  
>  test_expect_success \
>  	'message in editor has initial comment' '
> -	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
> +	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
>  '
>  
>  test_expect_success 'message in editor has initial comment: first line' '
> @@ -1587,7 +1587,7 @@ test_expect_success \
>  '
>  
>  get_tag_header reuse $commit commit $time >expect
> -echo "An annotation to be reused" >> expect
> +echo "An annotation to be reused" >>expect
>  test_expect_success \
>  	'overwriting an annotated tag should use its previous body' '
>  	git tag -a -m "An annotation to be reused" reuse &&
> @@ -1639,7 +1639,7 @@ hash3=$(git rev-parse HEAD)
>  
>  # simple linear checks of --continue
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v0.2.1
>  v1.0
>  v1.0.1
> @@ -1679,7 +1679,7 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
>  	test_must_be_empty actual
>  "
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v2.0
>  EOF
>  
> @@ -1688,7 +1688,7 @@ test_expect_success 'checking that second commit only has one tag' "
>  	test_cmp expected actual
>  "
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v0.2.1
>  v1.0
>  v1.0.1
> @@ -1705,7 +1705,7 @@ test_expect_success 'checking that third commit has no tags' "
>  	test_must_be_empty actual
>  "
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v0.2.1
>  v1.0
>  v1.0.1
> @@ -1723,14 +1723,14 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
>  test_expect_success 'creating simple branch' '
>  	git branch stable v2.0 &&
>          git checkout stable &&
> -	echo foo-3.0 > foo &&
> +	echo foo-3.0 >foo &&
>  	git commit foo -m fourth &&
>  	git tag v3.0
>  '
>  
>  hash4=$(git rev-parse HEAD)
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v3.0
>  EOF
>  
> @@ -1739,7 +1739,7 @@ test_expect_success 'checking that branch head only has one tag' "
>  	test_cmp expected actual
>  "
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v0.2.1
>  v1.0
>  v1.0.1
> @@ -1757,7 +1757,7 @@ test_expect_success 'merging original branch into this branch' '
>          git tag v4.0
>  '
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v4.0
>  EOF
>  
> @@ -1766,7 +1766,7 @@ test_expect_success 'checking that original branch head has one tag now' "
>  	test_cmp expected actual
>  "
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v0.2.1
>  v1.0
>  v1.0.1
> @@ -1780,7 +1780,7 @@ test_expect_success 'checking that original branch head with --no-contains lists
>  	test_cmp expected actual
>  "
>  
> -cat > expected <<EOF
> +cat >expected <<EOF
>  v0.2.1
>  v1.0
>  v1.0.1
