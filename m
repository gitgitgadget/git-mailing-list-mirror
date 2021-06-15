Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82021C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A6A6157F
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFOOoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFOOoU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:44:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BBC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:42:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s15so10566162edt.13
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=teJcGZciRDSOLq/GppFgWN6z8EvEGaZ+F5iOafH1koI=;
        b=AuL5Tf4Jz5F6guy+jzhN1iT/Eu9688311Rnh7ed+Jx8D7kxVjkgF6e439/IFYdb+zb
         FqpHSL2qVHh8HeN69YSD5SvkiD20+hcXJ2mqlIgfjQJ6p58WpG01HnQOYUlJGIALIiNn
         Q8eJWb6YxOvBCdYglMG6Y0LZPlQmy1taVdO39sPLqFFu6VGYxOp7oFlEKJGDWgW4iN/t
         TUM+vTUFP/70SjJHKl1MxoSajUpeRAaDOHybNNkOPKhog5+B94l6Iu5MjP0hlRwf/riS
         RwWebqScE4Ex8B1O6tVVR/aT2EFq51jT5w5Tx4eW9X8DlgCNHOFizAJ0auUNa/ldWMPD
         xf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=teJcGZciRDSOLq/GppFgWN6z8EvEGaZ+F5iOafH1koI=;
        b=HhfqhLZtVUHnhQM23N1iIUZ4Jv3JgaOCYiR5j54sFCoWYzwTi/spjzgX8S3hB+e4j0
         Xo2fGLOkTGUmO4D/ZcYc6V894eOYJhuuF81pUrSvFIQ3yRRSK/fnuzpZo12csryw3OXe
         +1NZ3qQWDvOih9yKRF3unTu2Pu5ySoDocce2/K1HHaBz54N0AjuhhEMgzp5R9u6E50x4
         WDj36NLFEGYd+opoVaakW7DQJwa++5nNDgWv/o5xBlGNlt1YUGoEUhBLsUX4l4uKPlrz
         hFYjKUEouGnhFmXL2fDxOYL08HC6Ggvm3xtWMkTTvzg+BVdnb5XfbH6cCnNYMto9VoAy
         sA4g==
X-Gm-Message-State: AOAM533NLZK7rzywxHcJjCpXodubdq9GmCCt6KriPcXfkVD86DlMMggm
        i1hF1jtIKOACc6f3EiSqu0I=
X-Google-Smtp-Source: ABdhPJxWHInfq8ALMCtxgKjpoXJZ0LmnyYt7fpGAdrRp3HUoS2hvt5k8xoFPavL9BEPZSPaNXp05xQ==
X-Received: by 2002:aa7:c782:: with SMTP id n2mr24196862eds.77.1623768133468;
        Tue, 15 Jun 2021 07:42:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf5sm12391148edb.81.2021.06.15.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:42:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/6] mktag tests: test hash-object --literally and
 unreachable fsck
Date:   Tue, 15 Jun 2021 16:41:36 +0200
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
 <patch-3.6-96520b3e89a-20210614T172422Z-avarab@gmail.com>
 <6148debe-fc44-67b7-ac9c-f27d376bc9f2@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <6148debe-fc44-67b7-ac9c-f27d376bc9f2@gmail.com>
Message-ID: <87czsnyyt8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Andrei Rybak wrote:

> On 14/06/2021 19:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Extend the mktag tests to pass the tag we've created through both
>> hash-object --literally and fsck.
>> This checks that fsck itself will not complain about certain invalid
>> content if a reachable tip isn't involved. Due to how fsck works and
>> walks the graph the failure will be different if the object is
>> reachable, so we might succeed before we've created the ref.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   t/t3800-mktag.sh | 48 +++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 39 insertions(+), 9 deletions(-)
>> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
>> index 951e6d39c2a..43b67a149f8 100755
>> --- a/t/t3800-mktag.sh
>> +++ b/t/t3800-mktag.sh
>> @@ -16,6 +16,8 @@ check_verify_failure () {
>>   	message=3D$2 &&
>>   	shift 2 &&
>>   +	no_strict=3D &&
>> +	fsck_obj_ok=3D &&
>>   	no_strict=3D &&
>>   	while test $# !=3D 0
>>   	do
>> @@ -23,7 +25,10 @@ check_verify_failure () {
>>   		--no-strict)
>>   			no_strict=3Dyes
>>   			;;
>> -		esac &&
>> +		--fsck-obj-ok)
>> +			fsck_obj_ok=3Dyes
>> +			;;
>> +		esac
>
> "&&" after "esac" got removed.

Thanks, will fix.

>>   		shift
>>   	done &&
>>   @@ -37,6 +42,23 @@ check_verify_failure () {
>>   			git mktag --no-strict <tag.sig
>>   		fi
>>   	'
>> +
>> +	test_expect_success "setup: $subject" '
>> +		# Reset any leftover state from the last $subject
>> +		rm -rf bad-tag &&
>> +
>> +		git init --bare bad-tag &&
>> +		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
>> +	'
>> +
>> +	test_expect_success "hash-object & fsck unreachable: $subject" '
>> +		if test -n "$fsck_obj_ok"
>> +		then
>> +			git -C bad-tag fsck
>> +		else
>> +			test_must_fail git -C bad-tag fsck >out 2>err
>
> This is the very end of the check_verify_failure function. It seems
> that after "out" and "err" are created here, nothing else checks their
> contents.

Well spotted, will fix this and any other such needless rederiction in a
v2 I'll send after any other reviewing quiets down.
