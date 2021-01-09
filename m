Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFFCC433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BE72388E
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbhAIWob (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:44:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55462 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAIWoa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:44:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5CB8110002;
        Sat,  9 Jan 2021 17:43:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kwSb7QwDcnJsO5NoVOKA58B1k4o=; b=QAOZVr
        t/nM5rVnPoF7OoOXjvXZ3z57Kxrsv9sJTZtpCUcteor7AfREoSjXuh+EDYT6yylS
        r2bRVuvrCln6cXpgljHCCmo7JfzF+O3McG+ZW4bGQhwQceFs53WN0O5s8bcIwrpv
        16FlHNJ9l6lwsigTFRFDml6VOITXxjNr9jNEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tsGB5YNJrKLmvXWVVXDVAW7eD8Y2MFNT
        LSTpQIwPlfSsNfVKyKZhT4Xe0hEynvrUhov3SM+d+ZEZFKoYneoAbyNT1DJXacqF
        NvhKZDf55RAj0xfwIOTb5pCaIV9oNxb/sb6jrijU1gv3lMZ7MyRL99BTdwlwoEyD
        YjWKtAFHhQo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE18B110001;
        Sat,  9 Jan 2021 17:43:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2468210FFFE;
        Sat,  9 Jan 2021 17:43:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git <git@vger.kernel.org>,
        Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH] t4129: fix setfacl-related permissions failure
References: <CAHd-oW7XJL_a1zMAUetHzvrh8DrLT4g2awv-fjbTdeLVLKVsew@mail.gmail.com>
        <20201223114431.4595-1-adam@dinwoodie.org>
        <CAHd-oW7r9D09F7=3JLTiQcbRDXyXhkYY3FFuRLbR9vH=p4M92w@mail.gmail.com>
Date:   Sat, 09 Jan 2021 14:43:44 -0800
In-Reply-To: <CAHd-oW7r9D09F7=3JLTiQcbRDXyXhkYY3FFuRLbR9vH=p4M92w@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Sat, 9 Jan 2021 12:06:55
        -0300")
Message-ID: <xmqqk0slenof.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21F7FC24-52CC-11EB-A2DC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hi, Adam
>
> Apologies for the late reply.
>
> On Wed, Dec 23, 2020 at 8:44 AM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>>
>> When running this test in Cygwin, it's necessary to remove the inherited
>> access control lists from the Git working directory in order for later
>> permissions tests to work as expected.
>
> Nit: Although this sentence is correct and the bug was first found on
> Cygwin, the test may fail in any other environment which has a default
> ACL set. In this sense, I think we could perhaps rephrase the commit
> message to something like this:
>
> This test creates a couple files and expects their permissions to be
> based on the umask. However, if the test's directory has a default ACL
> set, it will be inherited by the created files, overriding the umask.
> To work around that, the test attempts to remove the default ACL, but
> it erroneously passes a nonexistent path to the setfacl command. Fix
> that by passing the working directory.
>
>> ---
>>  t/t4129-apply-samemode.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
>> index 41818d8315..576632f868 100755
>> --- a/t/t4129-apply-samemode.sh
>> +++ b/t/t4129-apply-samemode.sh
>> @@ -78,7 +78,7 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>>         test_config core.sharedRepository 0666 &&
>>         (
>>                 # Remove a default ACL if possible.
>> -               (setfacl -k newdir 2>/dev/null || true) &&
>> +               (setfacl -k . 2>/dev/null || true) &&
>
> The change is obviously correct, thanks!
>
> Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>

Thanks, both.  Will queue.
