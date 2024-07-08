Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C9AD2C
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460148; cv=none; b=hYTbaDNvWTQgEN3sKVJwgkPLo1UUTrlw0JydYkUUh9czoPRmPYX7dPTBWkvsOy+vcz4NIfcMM/8jC62niFrJMQ160mZNFipWwEholIVmGdICCfbtZipeUJlAIhpxTcF5SmjQB0qvYe8jFmjcCVD8CdzqLVDlFmY9PKHPKn8tFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460148; c=relaxed/simple;
	bh=9X3NawNvwifTQN3QdHNHrP214fsph4Bt/zwi3/4fD74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFnwToSNu5V0nczQYtpvfoVC9NQNSMKoHZ98FbxEk0N8rhnzugjJ4ob87j6PvGZ6Z1E78/qZV97ehwEGrbaUMIA19sko6x8ue1IBjavY/NG5+UvjDgJeb2AcwCVPSVCemlpL/3wgFIq+cSD0pv7HWyTm2Mw9FnabhCR5kRADyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EuH/MNfB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EuH/MNfB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8706D1B470;
	Mon,  8 Jul 2024 13:35:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9X3NawNvwifTQN3QdHNHrP214fsph4Bt/zwi3/
	4fD74=; b=EuH/MNfBgeqNgh7iHMGztO4k1rsBIj/rLo2tVX5Kf8EMqgVG5RozLb
	S58ekzIhmL225TB5OW6ldqYg2jq2kHcP8q7sqLFGV/3s3kAj4rzB8zjnzfLgqSFK
	cn4LARM1Hm4ij3dJGyKo1UQFtPC8r5pS8DCbyClqN2/hCVLqCcwts=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ED5D1B46E;
	Mon,  8 Jul 2024 13:35:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0ED1D1B464;
	Mon,  8 Jul 2024 13:35:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
In-Reply-To: <20240708092317.267915-9-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:16 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-9-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 10:35:41 -0700
Message-ID: <xmqqbk37hjma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80494928-3D50-11EF-BE68-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'check-whitespace' CI script exists gracefully if no base commit is

"exists" -> "exits"

> provided or if an invalid revision is provided...
> ...
> Let's fix the variable used in the GitLab CI. Let's also add a check for
> incorrect base_commit in the 'check-whitespace.sh' script. While here,
> fix a small typo too.
>
> [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .gitlab-ci.yml         |  2 +-
>  ci/check-whitespace.sh | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 65fd261e5e..36199893d8 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -119,7 +119,7 @@ check-whitespace:
>    before_script:
>      - ./ci/install-dependencies.sh
>    script:
> -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>    rules:
>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>  
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> index db399097a5..ab023f9519 100755
> --- a/ci/check-whitespace.sh
> +++ b/ci/check-whitespace.sh
> @@ -9,12 +9,19 @@ baseCommit=$1
>  outputFile=$2
>  url=$3
>  
> -if test "$#" -ne 1 && test "$#" -ne 3
> +if { test "$#" -ne 1 && test "$#" -ne 3; } || test -z "$1"

You can just add || test -z "$1" after the existing one, making the
thing A && B || C which evaulates left to right with the same
precedence for && and ||.

>  then
>  	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
>  	exit 1
>  fi
>  
> +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)

That is a large string to hold in a variable for a potentially large
series with lots of breakages.  I didn't quite read the reasoning
behind this change in the proposed log message.  Under what
condition do you expect the command to exit with non-zero status?
$basecommit being a non-empty string but does not name a valid
commit object or something, in which case shouldn't "git log
--oneline $baseCommit.."  or something simpler should suffice?

> +if test $? -ne 0
> +then
> +	echo -n $gitLogOutput

What is "-n" doing here?  Why are you squashing run of spaces in the
$gitLogOutput variable into a space by not "quoting" inside a dq-pair?

> +	exit 1
> +fi

Looking for "--check" in

	$ git log --help

tells me that the command exits with non-zero status if problems are
found, so wouldn't that mean the cases with problems always exit
early, bypassing the while loop with full of bash-ism that comes
after this block?

>  problems=()
>  commit=
>  commitText=
> @@ -58,7 +65,7 @@ do
>  		echo "${dash} ${sha} ${etc}"
>  		;;
>  	esac
> -done <<< "$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)"
> +done <<< "$gitLogOutput"
>  
>  if test ${#problems[*]} -gt 0
>  then
> @@ -67,7 +74,7 @@ then
>  		goodParent=${baseCommit: 0:7}
>  	fi
>  
> -	echo "A whitespace issue was found in onen of more of the commits."
> +	echo "A whitespace issue was found in one of more of the commits."
>  	echo "Run the following command to resolve whitespace issues:"
>  	echo "git rebase --whitespace=fix ${goodParent}"
