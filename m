Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB743C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED88613AD
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhFXWpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXWpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 18:45:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D102C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 15:42:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id he7so11912415ejc.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WZ4Y/cbxBYyMOh/yJOTpzatX2N041Wr82R0soVAQ4a0=;
        b=RwqWGgbDhQ1MhwOfB4LKhxh0gSwZIPTA9g2VnxP+TJGP4Vfb3IuxLDuNScxKYCL/DA
         0wCmwDq/Rh3kq1+m79IqpmvFymnSnFTWpJi1XQg+jpeTkcKVlwqH4FuSPh5eoP9PKbes
         h8iCMJhi0JQeVPlvJG1A3Pt/Js7k8xyKO/Esg1rdPhs6Z0XS6qSoquk4zCqqh+H5EVzb
         InwL0nkj/eG1S3yKHgKZ0GAkGbW/ymTQiT/t6K36uj3q9Wa2Y0S40i1llAAGu5nUb2AV
         WpeRRu4JxI4aHASMZc/JwiCMoUahX/GryeCYLcAWCEEvM+zWCtUD0NVR/TfpUeRwGf1q
         BeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WZ4Y/cbxBYyMOh/yJOTpzatX2N041Wr82R0soVAQ4a0=;
        b=RrqtBAKzHi+TcQ1YmTM0VtqH7RXciGtN33O3Z0GpAyRJTzA01zHKO7/fqPD8YTrdSn
         emTrCLB9sFSQb1U6JLWVLT94B4uGdQ4EAxjNPi57ePH5t4GldRnRD1sr2+M9nzIegOtf
         Wpxr1+2tqx7p8TUgNoIA5Q+Q94U/8A+K7t4A1C+Tw0CEnwXSj+B+Ju63Hr/uIYnrQ55E
         xacO1lL0MKupsgxQ76+aGMjmGy0VrbgtWg5EBGjJFJLkrNdReoHZEOxHK5PYvV+4UPm5
         iRlpCxtbk7/wF7+A4MLBLr/ptwhu8BuGYtNFbHCcInHuGzx1l0AuD6vS/XDyEdcUroLd
         Zf0g==
X-Gm-Message-State: AOAM5319rOmtFJ5cmTinl90SN8SEvKywbRNL7JQ56c3PTzcjPv2VbOei
        NdaGBPLmdjIuy5ZvAsvag4UOVt9O7X/mDg==
X-Google-Smtp-Source: ABdhPJxLEkvdMF8W/Pkv4yTwssVCOGk67DpQKPkAlDZXk/Ppt935/Ph3npJq0i4ozMPks6B6ayFDCw==
X-Received: by 2002:a17:906:2582:: with SMTP id m2mr7465974ejb.97.1624574127394;
        Thu, 24 Jun 2021 15:35:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id em20sm1811204ejc.70.2021.06.24.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:35:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 01/21] fsck tests: refactor one test to use a sub-repo
Date:   Fri, 25 Jun 2021 00:34:31 +0200
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
 <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
 <patch-01.21-2e37971c016-20210624T191755Z-avarab@gmail.com>
 <d77583dc-5dd6-7992-bf48-456f14e36207@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <d77583dc-5dd6-7992-bf48-456f14e36207@gmail.com>
Message-ID: <87mtrezya9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 25 2021, Andrei Rybak wrote:

> On 24/06/2021 21:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Refactor one of the fsck tests to use a throwaway repository. It's a
>> pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
>> teardown of a tests so we're not leaving corrupt content for the next
>> test.
>> We should instead simply use something like this test_create_repo
>> pattern. It's both less verbose, and makes things easier to debug as a
>> failing test can have their state left behind under -d without
>> damaging the state for other tests.
>> But let's punt on that general refactoring and just change this one
>> test, I'm going to change it further in subsequent commits.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   t/t1450-fsck.sh | 34 ++++++++++++++++------------------
>>   1 file changed, 16 insertions(+), 18 deletions(-)
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 5071ac63a5b..1563b35f88c 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -48,24 +48,22 @@ remove_object () {
>>   	rm "$(sha1_file "$1")"
>>   }
>>   -test_expect_success 'object with bad sha1' '
>> -	sha=3D$(echo blob | git hash-object -w --stdin) &&
>> -	old=3D$(test_oid_to_path "$sha") &&
>> -	new=3D$(dirname $old)/$(test_oid ff_2) &&
>> -	sha=3D"$(dirname $new)$(basename $new)" &&
>> -	mv .git/objects/$old .git/objects/$new &&
>> -	test_when_finished "remove_object $sha" &&
>> -	git update-index --add --cacheinfo 100644 $sha foo &&
>> -	test_when_finished "git read-tree -u --reset HEAD" &&
>> -	tree=3D$(git write-tree) &&
>> -	test_when_finished "remove_object $tree" &&
>> -	cmt=3D$(echo bogus | git commit-tree $tree) &&
>> -	test_when_finished "remove_object $cmt" &&
>> -	git update-ref refs/heads/bogus $cmt &&
>> -	test_when_finished "git update-ref -d refs/heads/bogus" &&
>> -
>> -	test_must_fail git fsck 2>out &&
>> -	test_i18ngrep "$sha.*corrupt" out
>> +test_expect_success 'object with hash mismatch' '
>> +	test_create_repo hash-mismatch &&
>
> This patch was originally sent to ML on 2021-03-28:
> 	https://lore.kernel.org/git/patch-2.6-3e547289408-20210328T025618Z-avara=
b@gmail.com/
>
> since then, however, commit f0d4d398e2 (test-lib: split up and deprecate
> test_create_repo(), 2021-05-10) has been merged ;-) so this line should
> be:
>
> 	git init hash-mismatch &&

Thanks, you'd think that the author of that code would be in a better
position than most to get this right, but apparently not :)

This series originally pre-dates that work, I see I have a couple of
more test_create_repo() in other patches here, will fix for a v5 pending
more discussion on v4, thanks!
