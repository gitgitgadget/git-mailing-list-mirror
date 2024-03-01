Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0652D792
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 05:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269795; cv=none; b=Vg9cxVQ4x4UmurAbtB4zwAoMILO49Mt6CffGmSObLZePtzagP6NQU9mV07u3hbhqFxJIGEX7utjZw0j35DkS9d6w0mnp+0ovQ4D6o5PDotumtJjQnOcyHjG+kQ7recol1h8CcwWXDKKGw6JieoxTNTvEHwr2cG63U27u/lS7v/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269795; c=relaxed/simple;
	bh=yJSSLo9aZ7INsc2W/y4QyuHwKJv3KkkPvYLLoZ76gRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrDvdB+NlNMdFJI+yxFmOO4Vkogn/iaGqgeKr4qoaZ8f3KVjqmcizkJ1CTQpx8hhKkT622Yi5fKtiYo9ugm4H0nr3/rKlgFE64gNOk2kqALMZMNc5rJWzMT15OrbcbHkYRdkZEoQvk/oRCmeGi5mj0SNRU3VlzMAW+iHlydl0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WNRROH5h; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNRROH5h"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 989BD19A8C;
	Fri,  1 Mar 2024 00:09:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yJSSLo9aZ7INsc2W/y4QyuHwKJv3KkkPvYLLoZ
	76gRE=; b=WNRROH5h+opQBkA71Q+YCFGcvuDDo5ZBjoU6JhFKFbHHIcgFoPkrIE
	ZL+aCTJpd06UJElq/cMNfk6o6GlDJpI5moydfa5dEw26UvytixBWj52M8Ri+0F7M
	avoe4u2WjkRQdDqZIvkwqsfZQ+Zk/uur8sHQjX7pnOkHifPsnvCI8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9148619A8B;
	Fri,  1 Mar 2024 00:09:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F7ED19A89;
	Fri,  1 Mar 2024 00:09:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] t9117: prefer test_path_* helper functions
In-Reply-To: <20240301034606.69673-2-shejialuo@gmail.com>
	(shejialuo@gmail.com's message of "Fri, 1 Mar 2024 11:46:06 +0800")
References: <20240229150442.490649-1-shejialuo@gmail.com>
	<20240301034606.69673-1-shejialuo@gmail.com>
	<20240301034606.69673-2-shejialuo@gmail.com>
Date: Thu, 29 Feb 2024 21:09:48 -0800
Message-ID: <xmqqwmqm8rmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EE3679CE-D789-11EE-840B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

shejialuo <shejialuo@gmail.com> writes:

>  test_expect_success 'basic clone' '
> -	test ! -d trunk &&
> +	! test_path_is_dir trunk &&

This is not quite right.  Step back and think why we are trying to
use the test_path_* helpers instead of "test [!] -d".  What are the
differences between them?

The answer is that, unlike "test [!] -d dir" that is silent whether
"dir" exists or missing, "test_path_is_dir dir" is *not* always
silent.  It gives useful messages as necessary.  When does it do so?

Here is the definition, from t/test-lib-functions.sh around line
930:

        test_path_is_dir () {
                test "$#" -ne 1 && BUG "1 param"
                if ! test -d "$1"
                then
                        echo "Directory $1 doesn't exist"
                        false
                fi
        }

It succeeds silently when "test -d dir" is true, but it complains
loudly when "test -d dir" does not hold.  You will be told that the
test is unhappy because "dir" does not exist.  That would be easier
to debug than one step among many in &&-chain silently fails.

Now, let's look at the original you rewrote again:

> -	test ! -d trunk &&

It says "it is a failure if 'trunk' exists as a directory".  If
'trunk' does not exist, it is a very happy state for us.  So instead
of silently failing when 'trunk' exists as a directory, you would
want to improve it so that you will get a complaint in such a case,
saying "trunk should *not* exist but it does".

Did you succeed to do so with this rewrite?

> +	! test_path_is_dir trunk &&

The helper "test_path_is_dir" is called with "trunk".  As we saw, we
will see complaint when "trunk" does *NOT* exist.  When "trunk" does
exist, it will be silent and "test_path_is_dir" will return a success,
which will be inverted with "!" to make it a failure, causing &&-chain
to fail.

So the exit status is not wrong, but it issues a complaint under the
wrong condition.  That is not an improvement.

Let's step back one more time.  Is the original test happy when
"trunk" existed as a regular file?  "test ! -d trunk" says so, but
should it really be?  Think.

I suspect that the test is not happy as long as 'trunk' exists,
whether it is a directory or a regular file or a symbolic link.
IOW, it says "I am unhappy if 'trunk' is a directory", but what it
really meant to say was "I am unhappy if there is anything at the
path 'trunk'".  IOW, "test ! -e trunk" would be what it really
meant, no?

So the correct rewrite for it would rather be something like

	test_path_is_missing trunk &&

instead.  This will fail if anything is at path 'trunk', with an
error message saying there shouldn't be anything but there is.

In a peculiar case, which I do not think this one is, a test may
legitimately accept "path" to either (1) exist as long as it is not
a directory, or (2) be missing, as success.  In such a case, the
original construct '! test -d path" (or "test ! -d path") would be
appropriate.

But I do not think we have a suitable wrapper to express such a
case, i.e. we do not have a helper like this.

	test_path_is_not_dir () {
		if test -d "$1"
		then
			echo "$1 is a directory but it should not be"
			false
		fi
	}

If such a use case were common, we might even do this:

	# "test_path_is_dir <dir>" expects <dir> to be a directory.
	# "test_path_is_dir ! <dir>"  expects <dir> not to be a
	# directory.
	# In either case, complain only when the expectation is not met.
	test_path_is_dir () {
		if test "$1" = "!"
		then
			shift
                        if test -d "$1"
			then
				echo "$1 is a directory but it should not be"
				return 1
			fi
		else
			if test ! -d "$1"
			then
				echo "$1 is not a directory"
				return 1
			fi
		fi
		true
	}

but "we are happy even if path exists as long as it is not a
directory" is a very uncommon thing we want to say in our tests, so
that is why we do not have such a helper function.

HTH.
