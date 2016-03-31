From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] recursive submodules: test for relative paths
Date: Thu, 31 Mar 2016 09:33:54 -0700
Message-ID: <xmqqpouappxp.fsf@gitster.mtv.corp.google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:34:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfXl-0003dU-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbcCaQd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:33:59 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757485AbcCaQd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB4F050D58;
	Thu, 31 Mar 2016 12:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CU1gCqUxsP8h12UrO0a9TPgT4aM=; b=N6GRHo
	ifhy46R9zEB81ke/mBiSiH1kgrttHN+AW1b6IKJOxBJjD/WkX8CaSIB7abNMI7sT
	l+Sn+BZn+LdGkgUtCAPKHWhtLxPJk46GEZMFyC4D/hxzaYVGqDK62cg5ybcag33F
	eQ4CQpNn8iFIiuro1bEv56o0aec4E2dPRJzmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqDvSIhCXGAc7uBOFSknD/w2U2z9EcFF
	UkKnWJgs0lk0KeSAILHKzoEkjQ+6n9YnMrFfLj2EsrupzQ/6vzCRKCwQpLw+DTMf
	llHj9XDvLfBisvyJ6wYSQ59Vl/0KQ3Kq9edo/1m2Pyp/UFKlBRy8Pmr0YfN+TRuU
	V82cxzqbs9c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2B6950D57;
	Thu, 31 Mar 2016 12:33:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4919550D56;
	Thu, 31 Mar 2016 12:33:56 -0400 (EDT)
In-Reply-To: <1459383457-6848-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 30 Mar 2016 17:17:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CF41E80-F75E-11E5-92A1-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290413>

Stefan Beller <sbeller@google.com> writes:

> This was reported as a regression at $gmane/290280. The root cause for
> that bug is in using recursive submodules as their relative path handling
> seems to be broken in ee8838d (2015-09-08, submodule: rewrite
> `module_clone` shell function in C).

I've reworded the above like so while queuing.

    "git submodule update --init --recursive" uses full path to refer to
    the true location of the repository in the "gitdir:" pointer for
    nested submodules; the command used to use relative paths.

    This was reported by Norio Nomura in $gmane/290280.

    The root cause for that bug is in using recursive submodules as
    their relative path handling was broken in ee8838d (2015-09-08,
    submodule: rewrite `module_clone` shell function in C).

Thanks.


> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7400-submodule-basic.sh | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 540771c..fc11809 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -818,6 +818,47 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
>  	)
>  '
>  
> +test_expect_failure 'recursive relative submodules stay relative' '
> +	test_when_finished "rm -rf super clone2 subsub sub3" &&
> +	mkdir subsub &&
> +	(
> +		cd subsub &&
> +		git init &&
> +		>t &&
> +		git add t &&
> +		git commit -m "initial commit"
> +	) &&
> +	mkdir sub3 &&
> +	(
> +		cd sub3 &&
> +		git init &&
> +		>t &&
> +		git add t &&
> +		git commit -m "initial commit" &&
> +		git submodule add ../subsub dirdir/subsub &&
> +		git commit -m "add submodule subsub"
> +	) &&
> +	mkdir super &&
> +	(
> +		cd super &&
> +		git init &&
> +		>t &&
> +		git add t &&
> +		git commit -m "initial commit" &&
> +		git submodule add ../sub3 &&
> +		git commit -m "add submodule sub"
> +	) &&
> +	git clone super clone2 &&
> +	(
> +		cd clone2 &&
> +		git submodule update --init --recursive &&
> +		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
> +		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
> +	) &&
> +	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
> +	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
> +'
> +
>  test_expect_success 'submodule add with an existing name fails unless forced' '
>  	(
>  		cd addtest2 &&
