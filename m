Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFEA203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934569AbcLMT07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:26:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933420AbcLMT05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:26:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90F09550C8;
        Tue, 13 Dec 2016 14:23:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yi06ZIIiu37hjVb+ZiuThk7uhWk=; b=l/541m
        fVesGQMKKCYzpGubL8VwrMy7Z3YLrQKI6bTyY54VqVM0OrDdiz+NTq21OTaKC5js
        XrqDFTJD/nzA+38B3GHfjF3ULcOn5gkBpVNYab5Op4Cj0L85DBq0xPByBo6DxPnW
        NThxfGHGxKwL/YKT4W0n7JDbPUC9iTGyUmJz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vLswLxco/3A0Wiy/ePRGj9HBW8V6ZJPQ
        6QhTqmvo1jd3BFhrY6AofiyWFQYD1CmxBTB0j35+RikQzRlXcplzc/xPOdoJSxtV
        QcWfSRvDTPjjRMfuIf8DG4TxeT8DWjE47zQqG5gv4hW08M4HBJwLbfgi/vQdaLdq
        GnifhKouKJ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8904B550C7;
        Tue, 13 Dec 2016 14:23:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F18D3550C6;
        Tue, 13 Dec 2016 14:23:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/2] t5547-push-quarantine: run the path separator test on Windows, too
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
        <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
        <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
Date:   Tue, 13 Dec 2016 11:23:39 -0800
In-Reply-To: <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org> (Johannes Sixt's
        message of "Tue, 13 Dec 2016 20:09:31 +0100")
Message-ID: <xmqqinqn3a6c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7AA1EEA-C169-11E6-BD58-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> To perform the test case on Windows in a way that corresponds to the
> POSIX version, inject the semicolon in a directory name.
>
> Typically, an absolute POSIX style path, such as the one in $PWD, is
> translated into a Windows style path by bash when it invokes git.exe.
> However, the presence of the semicolon suppresses this translation;
> but the untranslated POSIX style path is useless for git.exe.
> Therefore, instead of $PWD pass the Windows style path that $(pwd)
> produces.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 12.12.2016 um 20:53 schrieb Jeff King:
>> Johannes, please let me know if I am wrong about skipping the test on
>> !MINGW. The appropriate check there would be ";" anyway, but I am not
>> sure _that_ is allowed in paths, either.
>
> Here is a version for Windows. I'd prefer this patch on top instead
> of squashing it into yours to keep the $PWD vs. $(pwd) explanation.
>
> The result is the same as yours in all practical matters; but this
> version I have already tested.

Will queue (I would wait for peff@ to say "OK", but I suspect he
would be OK in this case).

Thanks.


>  t/t5547-push-quarantine.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 6275ec807b..af9fcd833a 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -33,8 +33,7 @@ test_expect_success 'rejected objects are removed' '
>  	test_cmp expect actual
>  '
>  
> -# MINGW does not allow colons in pathnames in the first place
> -test_expect_success !MINGW 'push to repo path with colon' '
> +test_expect_success 'push to repo path with path separator (colon)' '
>  	# The interesting failure case here is when the
>  	# receiving end cannot access its original object directory,
>  	# so make it likely for us to generate a delta by having
> @@ -43,13 +42,20 @@ test_expect_success !MINGW 'push to repo path with colon' '
>  	test-genrandom foo 4096 >file.bin &&
>  	git add file.bin &&
>  	git commit -m bin &&
> -	git clone --bare . xxx:yyy.git &&
> +
> +	if test_have_prereq MINGW
> +	then
> +		pathsep=";"
> +	else
> +		pathsep=":"
> +	fi &&
> +	git clone --bare . "xxx${pathsep}yyy.git" &&
>  
>  	echo change >>file.bin &&
>  	git commit -am change &&
>  	# Note that we have to use the full path here, or it gets confused
>  	# with the ssh host:path syntax.
> -	git push "$PWD/xxx:yyy.git" HEAD
> +	git push "$(pwd)/xxx${pathsep}yyy.git" HEAD
>  '
>  
>  test_done
