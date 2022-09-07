Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23433C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 12:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIGMJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGMJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 08:09:36 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899B167E0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662552568;
        bh=67FudR13GbUZN3LgB5qiO88kjRCHRkLgdFtWGVfWLzA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SREayenk93G30BRI7g28bFV++7Dtt4pcyW8anBe2xuhepuSbjf9L1667K3682HcUJ
         u/Hok69vebYsZyPe/Tgs37GX1gxU6IOkyGtmGoVvlWGwC9M+VIHMwt3siYB5/PIz83
         Gdarv+HCKmip3+WVIsWvQXJRd/pH1hEZqAtun8S8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.158.123]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIgY-1p3r6q12R2-00cohH; Wed, 07
 Sep 2022 14:09:28 +0200
Message-ID: <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de>
Date:   Wed, 7 Sep 2022 14:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
 <xmqqwnbv7trp.fsf@gitster.g> <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DEpV/j+F/iOKlQYiqylXMGQetfUHD38Z81TpdBglw9MN0sGvkGs
 taSR4A30dq9il70uu0ArETimhTxktT34o7zlHDmQZTRrm/3VcESPKPV7YqxYWndX7TZFTlf
 AUtQVDKstsGcqxUzcCRCnso4JqqpPlOBulSeoRJVS1N3WLZxY5p68IwotTQvYfLcZNaK5Va
 m/b+GOzUvGNUyXolE52gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14XqvIBiydE=:t/OXzVEoKjXJAk3DX+Nptk
 RlBPVmdQ5nzc1SWE75uOyuFrnnMRs2Hc7vgpM6zQboOM9mqR5GSEz11hTNVEw2yxMzNWmiPZM
 aX+D2GGHUaWonBPbm5PGJZvtg3AOd99o7o7tEhk0grz0FYoL9akoBKqtVThTX2WLGARRFsvJb
 t47bh16Xs7+H5UDWJxzs9tK0/PGdZZIYmx0oS12bFMVr1ZofUsz29e5orBidm0/RQ9WrYWNeZ
 U8KEJunZD8CU4G5JPuRBU3XbJCp520cBqpuTcJCkfGXYid++WRzxGIOqNZtLN2hUJXCq0lnnT
 45gBka+rlar8gmEQNmzs0edkOOpYwvPKKEluk42AJZ2RA0W3892iIuXW4Qadds31bGf+ErtTC
 r2ob1Cd+u8qqpTsQsccCGD7S8Ry+lxkRZRP6WAueLEjf+S5mTjrL8lcv3bgAeIht7PQO/Z2aN
 ztMe3vGJcosu+PrGohfO8TAgpRiyRh7gIligVkz/GKcPv2RKKLfz6T9ApT3ixnLOdK5ncxXHJ
 +T3S1X9pgPFfZWQMMVgQOfrz7MjFP3zQGuYLsD9+FWU1ClAH9xn10o13PxeNiJlF9cowL72Cr
 8CvkN8ZqyK6JZPznGRYfKntlrsp+UbPF+V+7LmVrpLiYQaKv+YctTBu34N6c125j8T229ViA6
 9kQn7S1Ip3tAJFIEdEM6C46BlSp1nzwX3llp95EPOn4VVRlUJwWIA0XejEo9XMSlSV2WYS5tN
 k0jS36Mipfqwedqpd4RMscTfuuT8pRiVM3HgL3kVD6DvxXv8xeHUuOeAG9BPSrrlM17Uz5hvQ
 ryOMX1XXCNJBlt9vTCewGm1tVKh6U9c0IIYs57m7WBKjkPMqymsPlEYDH7KTp8/zU08A9NZ3U
 by3hZwp7tCaO8M1CanOkNouJnZs3QxCVrGSnx7pdGRSFipLQIFmxCcbRhbPQuaVk/yuSsu8AL
 7c/SGoMnGzkBdXQQMkM6J6CQzWrWW2bbCn5X3mHElHXwwuAKi/ZHKqDsM7SPyyDWxrOcKrmr7
 W+FpCjaSq7bLPGr8f8wUbXBCyth8Uo36c0f4oIy9z2X8a7ZyN+456XKu0WFXH8o5JHPyD4pZn
 1+whklBfJcBFSANhucD5F2EYuV4qF8sGX1nUUxwDn3N8GjnT4ZZk3jukFEi2QibGfIJMbKsax
 HU0AU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.09.22 um 15:10 schrieb Johannes Schindelin:
> Hi Junio,
>
> On Fri, 29 Jul 2022, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>>> +	const char *argv[] =3D {
>>> +		"diff", "--no-index", NULL, NULL, NULL
>>> +	};
>>
>> Don't we want to have "--" before the two paths?
>
> Yes!
>
>>> +	if (!(f0 =3D !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
>>> +		return error_errno("could not open '%s'", argv[1]);
>>> +	if (!(f1 =3D !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
>>> +		fclose(f0);
>>> +		return error_errno("could not open '%s'", argv[2]);
>>> +	}
>>
>> It is tricky that you need to take "-" and treat it as the standard
>> input stream in either argv[1] or argv[2] (but not both).  If would
>> be a different story in an end-user facing program, but because this
>> is a test helper, feeding wrong input is developer's fault, and I do
>> not mind lack of attention to detail of error checking to make sure
>> we avoid comparing alternating lines of the standard input.

"git diff --no-index - -" also doesn't complain, by the way.

> No, you're right, I've added a guard that prevents `test-tool cmp - -`
> from failing in obscure ways.
>
>>> +	for (;;) {
>>> +		int r0 =3D strbuf_getline(&b0, f0);
>>> +		int r1 =3D strbuf_getline(&b1, f1);
>>> +
>>> +		if (r0 =3D=3D EOF) {
>>> +			fclose(f0);
>>> +			fclose(f1);
>>> +			strbuf_release(&b0);
>>> +			strbuf_release(&b1);
>>> +			if (r1 =3D=3D EOF)
>>> +				return 0;
>>
>> If both hit the EOF at the same time, we know they are the same, OK.
>>
>>> +cmp_failed:
>>> +			if (!run_diff(argv[1], argv[2]))
>>
>> If one of argv[] was "-", then this wouldn't work correctly, as the
>> other file is read from the beginning but the "-" side have consumed
>> the initial part of the input and we cannot unseek it.  This bug
>> needs to be fixed only if we expect a useful and reliable output
>> from the helper.
>
> Right. I've added a clause that says that we cannot show the diff becaus=
e
> `stdin` has been consumed already.
>
>> But otherwise the idea is sound.  We compare them line by line,
>> using strbuf_getline() to ignore differences in CRLF and LF that
>> originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
>> random LF <> CRLF conversions, 2013-10-26).  Only when we find the
>> input different, we use "git diff --no-index" to make the difference
>> (and unfortunately more, as it does not ignore CRLF <> LF
>> differences) visible.

Why not use "git diff --no-index --ignore-cr-at-eol"?  Do you even need
to wrap it?

Ren=C3=A9

