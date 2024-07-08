Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62509AD55
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458943; cv=none; b=FOjQ/mx3fCRP2kDnY9QTt6JL5nsg5B9q1TozMoIGzJYIjpTZWWDeN0zeAJrDJrjMx1fYksmrlf85YQW+0nfi0oeup2XnadR8Rb0k5O1JrEAn0df6ibOHladyjECuyultjz5RupTY569PQBG7SEpnhSZwvQ231hSsZtbBz7/PyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458943; c=relaxed/simple;
	bh=kTE3NVCeg5V6xXokxB+W4TUDncsuNIr9gsMIKhLafsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KXe4/xWSWEUyR1xIetdgFAtYXsv/UJU1KcR6SL6eXL326HyCoVn9k0tCvk6Fj6xwS5T4D8KR5Cd8cJ64uDt4ns2v/9LqtixGz17fWAGPvUmSNXCf5nHEKXT/PcbFQ+cYnIFz9twjgUAvYAEzV6qipQ96Skij0tnSus+BhKbbmLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pGu5yU6t; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pGu5yU6t"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 318AE22147;
	Mon,  8 Jul 2024 13:15:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kTE3NVCeg5V6xXokxB+W4TUDncsuNIr9gsMIKh
	LafsU=; b=pGu5yU6tZebmkj3YydVbUgZNVtNO8DfOrFVkPzz6yCQKBOl1HBBI9X
	+Jga0jedS2/vCtAGZGvRo90RNyG1/5PXs8UQXnrKpp+X2dD01EI6xwF5PV7ouItY
	9k6KzTRfYgH3G3iP45Dl8+wZC4DnxoBtS/oRpZu70S+5EIR9IU6RQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 292FD22146;
	Mon,  8 Jul 2024 13:15:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9292D22145;
	Mon,  8 Jul 2024 13:15:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
In-Reply-To: <20240708092317.267915-8-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:15 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-8-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 10:15:35 -0700
Message-ID: <xmqqr0c3hkjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B12E7552-3D4D-11EF-AD35-965B910A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> We don't run style checks on our CI, even though we have a
> '.clang-format' setup in the repository. Let's add one, the job will
> validate only against the new commits added and will only run on merge
> requests.

I hope "against new commits" means what I think it does ;-) I am
worried about the case where a new commit touches a file that has
existing style violations but the commit does not make the situation
any worse at all.

OK, "git clang-format" is used to for this thing and it is designed
to address only lines that differ, so hopefully that would be good.

> Since we're introducing it for the first time, let's allow
> this job to fail, so we can validate if this is useful and eventually
> enforce it.

Very good idea.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .github/workflows/check-style.yml | 29 +++++++++++++++++++++++++++++
>  .gitlab-ci.yml                    | 12 ++++++++++++
>  ci/install-dependencies.sh        |  2 +-
>  ci/run-style-check.sh             |  8 ++++++++
>  4 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 .github/workflows/check-style.yml
>  create mode 100755 ci/run-style-check.sh
>
> diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
> new file mode 100644
> index 0000000000..27276dfe5e
> --- /dev/null
> +++ b/.github/workflows/check-style.yml
> @@ -0,0 +1,29 @@
> +name: check-style
> +
> +# Get the repository with all commits to ensure that we can analyze
> +# all of the commits contributed via the Pull Request.
> +
> +on:
> +  pull_request:
> +    types: [opened, synchronize]
> +
> +# Avoid unnecessary builds. Unlike the main CI jobs, these are not
> +# ci-configurable (but could be).
> +concurrency:
> +  group: ${{ github.workflow }}-${{ github.ref }}
> +  cancel-in-progress: true
> +
> +jobs:
> +  check-style:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v4
> +      with:
> +        fetch-depth: 0
> +
> +    - name: git clang-format
> +      continue-on-error: true
> +      id: check_out
> +      run: |
> +        ./ci/run-style-check.sh \
> +          "${{github.event.pull_request.base.sha}}"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 37b991e080..65fd261e5e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -123,6 +123,18 @@ check-whitespace:
>    rules:
>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>  
> +check-style:
> +  image: ubuntu:latest
> +  allow_failure: true
> +  variables:
> +    CC: clang
> +  before_script:
> +    - ./ci/install-dependencies.sh
> +  script:
> +    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> +
>  documentation:
>    image: ubuntu:latest
>    variables:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 6ec0f85972..46fe12a690 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -43,7 +43,7 @@ ubuntu-*)
>  		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
>  		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
>  		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
> -		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
> +		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE clang-format
>  
>  	mkdir --parents "$CUSTOM_PATH"
>  	wget --quiet --directory-prefix="$CUSTOM_PATH" \
> diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
> new file mode 100755
> index 0000000000..9d4c4089c1
> --- /dev/null
> +++ b/ci/run-style-check.sh
> @@ -0,0 +1,8 @@
> +#!/usr/bin/env sh

Under ci/ hierarchy we are very inconsistent.  Most use the bog
standard "#!/bin/sh" (which is my preference by the way), but
see what we have here right now:

        $ git grep -e '^#![a-z/]*/bin/[a-z]*sh' -e '^#![a-z/]*bin/env ' ci |
          sort -t: -k2
        ci/check-directional-formatting.bash:#!/bin/bash
        ci/install-dependencies.sh:#!/bin/sh
        ci/make-test-artifacts.sh:#!/bin/sh
        ci/mount-fileshare.sh:#!/bin/sh
        ci/print-test-failures.sh:#!/bin/sh
        ci/run-build-and-minimal-fuzzers.sh:#!/bin/sh
        ci/run-build-and-tests.sh:#!/bin/sh
        ci/run-docker-build.sh:#!/bin/sh
        ci/run-docker.sh:#!/bin/sh
        ci/run-static-analysis.sh:#!/bin/sh
        ci/run-test-slice.sh:#!/bin/sh
        ci/util/extract-trash-dirs.sh:#!/bin/sh
        ci/check-whitespace.sh:#!/usr/bin/env bash
        ci/test-documentation.sh:#!/usr/bin/env bash

Unless you have a strong reason to suspect that in your CI
environment /bin/sh is an unusuably broken shell, please do not
spread the inconsistencies.

I think the consensus from the last discussion we had was to allow
scripts that rely on bash-isms to say "#!/usr/bin/env bash" because
we know /bin/sh can legitimately be not bash and we assume bash may
not be installed as /bin/bash.  As all of them would run in the CI
environment that we have some control over what required packages
are installed at what path, it is OK to assume that "bash" would be
found on the $PATH by using /usr/bin/env (but it does assume
everybody installs "env" there, not /bin/env or /usr/local/bin/env,
with a bit of chicken-and-egg issue).

> +#
> +# Perform style check
> +#
> +
> +baseCommit=$1
> +
> +git clang-format --style file --diff --extensions c,h "$baseCommit"

OK, "git clang-format" compares the working tree with the named
commit, so if we have the tip of the topic branch proposed to be
merged checked out and compare it with the base commit of the topic,
that would give us exactly what we want.  Nice.

Thanks.
