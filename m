Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6971411EE
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314579; cv=none; b=r8Wy29h0yQ73GxTw9r+/F+5kq6BBffmw5Yw7XV8od8arWdI6NObAynBW48Y3A5KEwHsctj2Y+UM6ZyxSJe+nPO8Bj/1geeMyZrZeiLPsWOgLWS/S5CM7VKiwvIQv+xnpYb96I2YKNBmbzHV4VnxenhYxQuo395I84b8A4nB67pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314579; c=relaxed/simple;
	bh=M1PadeWusjD8OZJaxLglF35Z384L8PArqmv8GZf44Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ORhhfc00TR4iP5szsJkveaQF2sS+NvNtwyJ0Se0rsF2l4MW8WKaiN3077ExPhPB1ZtzEVfL6xIN9l8MD/yVfUr3M7iVvHOuxnXNj5pQwzzWwesLe8dSDB21BM8URxA+ItzFDjaI1ZfE4nPWl+gR+52vzpcT6inQplCp1Y4K6XuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lf8nTGmn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lf8nTGmn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E03FE3C8DD;
	Thu, 18 Jul 2024 10:56:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M1PadeWusjD8OZJaxLglF35Z384L8PArqmv8GZ
	f44Zs=; b=Lf8nTGmnyZG6LTIoDohnFgvutVknswfFpobekdmQwfwUUnx5Wsyfuc
	/5VhM8aVDWH3GB7y0wiphB5avY6o8e8s/pE6cNgAXoUTKfBddFlJVuHPChr/lPX/
	HeIBZDJXYcL8PIhEgwKZVxuRzZ6IVdvDgUYcCtCyd3ztokwurhy8c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D8C373C8DC;
	Thu, 18 Jul 2024 10:56:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 647EC3C8DB;
	Thu, 18 Jul 2024 10:56:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 4/6] ci: run style check on GitHub and GitLab
In-Reply-To: <20240718081605.452366-5-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 18 Jul 2024 10:16:03 +0200")
References: <20240715093047.49321-1-karthik.188@gmail.com>
	<20240718081605.452366-1-karthik.188@gmail.com>
	<20240718081605.452366-5-karthik.188@gmail.com>
Date: Thu, 18 Jul 2024 07:56:12 -0700
Message-ID: <xmqqmsmeycj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E10F3BBA-4515-11EF-BA7D-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
> +  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
> +  # be defined in all pipelines.
> +  script:
> +    - |
> +      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
> +
> +      if test -z "$R"
> +      then
> +        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
> +        exit 1
> +      fi

If you update the assignment to R to

    R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}}

an unset CI_MERGE_REQUEST_DIFF_BASE_SHA1 or an empty value in it
will be rejected there.  Then you can lose the if/then/fi here.

> +      ./ci/run-style-check.sh "$R"
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> +
>  documentation:
>    image: ubuntu:latest
>    variables:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 6ec0f85972..fb34ced8f0 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -87,6 +87,10 @@ macos-*)
>  esac
>  
>  case "$jobname" in
> +ClangFormat)
> +	sudo apt-get -q update
> +	sudo apt-get -q -y install clang-format
> +	;;
>  StaticAnalysis)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
> diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
> new file mode 100755
> index 0000000000..76dd37d22b
> --- /dev/null
> +++ b/ci/run-style-check.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +#
> +# Perform style check
> +#
> +
> +baseCommit=$1
> +
> +git clang-format --style file --diff --extensions c,h "$baseCommit"
