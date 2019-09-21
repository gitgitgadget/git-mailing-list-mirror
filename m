Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E591F463
	for <e@80x24.org>; Sat, 21 Sep 2019 12:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407613AbfIUMhQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 08:37:16 -0400
Received: from mout.web.de ([212.227.15.4]:42533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407609AbfIUMhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 08:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569069430;
        bh=PKZadHBNUo/7LY8FF5iPoW3Sx5/H6URGm5MEe/5niCw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QzK+z5mjZRQjXjv3f0SHV3+bx9077SGWAqFm31Z9ej/DkUHwEgraCiVIcZ0oSC4Kx
         UNfezOmTc6+f83m0WB3NXKPxsx6Db3QoQkMO8gR93ul1ZF9zQyOXswM+rfQFTADXqf
         cXPJ44nTKPIeW1j65TZcolDVWFXFQazsmdqfks+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdEmn-1hlhbQ49hp-00iRvl; Sat, 21
 Sep 2019 14:37:10 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <813f9deb-4448-ed4e-b124-5b85f1ca7147@web.de>
Date:   Sat, 21 Sep 2019 14:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920181302.GA26402@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6172m/BFD7dQbmbrjjvkPYq+fUzqvnGTlr358sDBO24sWM36thX
 yDSXNZCiJ4AEOCwk22bdkNQSl/21elHxY1HaEJylRG2+xt1PlvWeTPdaRaazXw2JFrfErb4
 mgMgVhH9WHK9Nes3MnY3TzRRuoAOzsGYnqlHveOHTdG4r7PCjk4zhe8ufsAF2pFYZkskmwH
 vPIVOsfl2piwIHnaERosQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwnOzJVojE8=:aUhDp4hXHsGs09V9d/ze56
 zJIFJjabemZIWjFmQETK3a6kLq0cHGdg5Q5Fgz26EdHKn0+ZM1zqDTrM0qrEzLpYhHCBaPbzH
 fwD6HG1JTEIQ0xedlvESRHzXgN45PjY6M6rBe36/3amzajAd+mCw7CLQe9zVCKfzPPo3fabwU
 8WYsqlpGdOo/Wrr36mqvvsq9I827eP6bWFW0iGVRkJtKPrch2IQlEn2cDCQxAhr1uedoprZsq
 zzk/4KU5WU6kkCmaYYHTnaG7fHFACEdKm4y3c8RL6yq1/Ba//3P74EAMAw6l8a3+qw/KHynd5
 He0Bw97j7s/LeoAk45rrekgpITeukpjgdT+RGBOk7LaRKPk7n16gyBmpO4L4vw+GqLNwaQH6J
 sHdwmey2XzgYyw2mC/Oj4pdDZ9Q+FQ9uUajIoJa+/4SJtHAWG88VjwvP43FcngomNpXlMKR1h
 6a4AVWv7GNu5gjKolGZG+pBs9X9m1lTSdHNgvvHTx3QBbsea+nFtpLqYcKwEBfdiMsmAbCmPo
 HoQQ2AlSlKreh38xYU59uMdRnpnZSh+nx6LURUCtFHE2nBDi8uoPHhxl4jepfJIdNZdgwXTPp
 sNmVK5b6jDF7O1PI8exUonMzaNXlEGtj9LKMMVOiCX++4Q8Cz2KHPI2H6qbgMX9x9DsQvb/d0
 J3f+FNEjQnWAaIAyHT7hMSmFlE85rz3Ppwq7xpc+GdFjiT6lQonrFIPnWOQ3Dmf4EJfsxMjbK
 rwb1DUIIjiTjSW1FnK9Zd8GF2ps1GvPh0qfDUxtr0PRxlR+Wi41IMvjlNqwGHALQ0EFMX1kTG
 ORZBULxBnsi0Vzbp6m/UJ0aUlrHG0mgZsE6JgBIlL3cqcTGsfnZR94gHhWYBIUH9iAcyA/IE9
 +9U1EQx2kzRQElHu7l8w+RowFEWo+VAXtlbdTygEQ6OGKlilb4ma+7axMS2Eyn7522yVsJbHw
 CMMZU79KgALt3OnX7tgmpci5iJwwidcvTUMc0mzBqqwF3cQ5KraA+PqUT9Oa9z83EBTzCED0+
 fmQNl6LBdphNNVC+I7R1U+6b5vpZNAPa5YaUupxyCXGSadHeQn2QnhVQ/6avGKxLyrk+iREt9
 1TS08ifC6f2px4AKkvMDE3peF1t3Az8ess0sTOpaoJTqVQrxZPXGsxe18XKmen80uZWhSSe4t
 l5B2hA+QW+o/fOKy2RN4HQaloNgIkHHO0Yfh2wJXhtf8+uXijKJxF5z5VA9y3hgJy6XTqeZLl
 k2BKzKG9O3nhPDzFndqWSQvdQgkJmHK/97Zpxhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.09.19 um 20:13 schrieb SZEDER G=C3=A1bor:
>>> @@ -280,12 +269,16 @@ static int name_ref(const char *path, const stru=
ct object_id *oid, int flags, vo
>>>  	if (o && o->type =3D=3D OBJ_COMMIT) {
>>>  		struct commit *commit =3D (struct commit *)o;
>>>  		int from_tag =3D starts_with(path, "refs/tags/");
>>> +		const char *tip_name;
>>
>> This should not be const because you allocate the buffer it points to
>> right here in the function, in each execution path.
>
> Marking it as const indicates that this function doesn't modify the
> buffer where the pointer points at.

Right, and that's at odds with this code:

>>> +		if (deref)
>>> +			tip_name =3D xstrfmt("%s^0", path);
>>> +		else
>>> +			tip_name =3D xstrdup(path);

... which allocates said memory and writes a string to it.

Ren=C3=A9
