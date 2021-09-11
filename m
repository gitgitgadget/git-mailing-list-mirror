Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C887C433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81834610C8
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhIKUc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:32:59 -0400
Received: from mout.web.de ([212.227.15.14]:36743 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhIKUc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631392295;
        bh=flu1oStVUmT6/rsQ3aBwb0l9IktdrDJKqab9tHHwrlU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L59u4LI8YgpqYISbapDIJV4usnvWptI5+Rj6pJ38f5N/x8sJhQ36SapLMFHnoERDS
         dqzGZ86GD9XBZEtblGqUpHrBfXQ4FPRnHA8/EStINfxUay6DEOGk01d4zBo9xeEh/Y
         yHCgRl26nZfXoTDsPbruBRl930bV6j/m4Cf3OD9U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MdLsp-1mh63A0Uz5-00IWka; Sat, 11 Sep 2021 22:31:35 +0200
Subject: Re: [PATCH 4/3] midx: inline nth_midxed_pack_entry()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
 <YTziaNywmCMn07IS@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <120ffa79-d3cb-2e81-1da6-358e7407ec69@web.de>
Date:   Sat, 11 Sep 2021 22:31:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTziaNywmCMn07IS@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVq87VqVogPDodwXlutsNOLXnqH2UTY+HC4Ep8q39DHlcXPJLgH
 +J5pR2IVPE54u6njLkPcMkoe5epotrjVJwTk6ErFBGdWpS3GLXNCAZdlsUGZQu+kGdf7cLd
 yJW8DoQ0HwExYEs5MGHMij2OTZ5fAR4IIAIE4K6nu9uFshBe+694ksYq6qAaloJAPkRQ3MQ
 08mpLPNc21IxvaSjDT8pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xTWtSmVl8MM=:8UGQ5ApXzFz0fsy4W6MlaE
 4GTCVqUTdB77L10Q9ZGJStiNPEFiZ4QGpnbDki4RhXUsdt3ipdVeqYgsP6a3e+BhSgk7WtHc8
 SuKrJEjl85m8xWm8r9Yry3E7BFdr7jDQDCl14yVynY1ghnmQ1Z3cmsc8akRB15LrSCRJCnZrI
 vVVRpE2wFskkP9mHED1lBEoJdEhl7I3GaLEKo5brh3VX7hsfzfQ65P5kZ8GMBbV031E6QL7pM
 Li2MOJ8rCPOXe54sH1mI1qLzbcRI71f29HkE93DKs2t6AADl8kUxI/qhgdarf2mY71GfJ4Dhw
 hw4n2mFjIhG4+7+wSvF2f7DldaEIRgLScck+GRrMoArrBWpULdWLjn2OukG2zJePolX+veVVl
 lLgd/CzDc//3aSv5DBXg4tSYv+1i6OvmwiDZoOWmfPzdLEtdl6I/MGcXBPN9E72mqQ4N9+jhJ
 titBIEAzLnc7l1vToWCPfyKxLCwLYWx+Ve73R7VRSxQNLMdGDtwFVMgr0YXmvrPqbaLjQ/Cat
 JvTIRdCpINFdTI5ENALmBNEl17XlbPJ9hM0IAOxRdblzaCz5uG/2Pblq5CLlR6AiBaL/3YsdS
 TYqnwmDIzNCe8BcL0UI+iAtpaySqhhyTv4M676XICV/i/YPqaPRclG5sUMlbKeLgz+pHOx49T
 9y3F645DM30Y+ZPHQDadgpTxN2MUduVNxwXPRtHmMAQ1LhMbdQ43KQ8BkmYAxwCLCphNgn4iS
 m4gFTPnLJkPrlyDcGTJPS6QQqX19tdCtzs1Ljr956XynbKGqAnapzlNGsiLORpSoQj9JkDm/q
 UZzif6/B0X4Ll0YUeqzGu61VPYrsPOVQxk1LQEX9+VEVSbe7+PRctJwnHEw3oiKnkHg+B1cqR
 B1ny+nTYD33RQTLZoYl0ixFHOjeRxW0nlGbEU19hT3z6evsHTFwJ32OkANsd8epNzuqr3JtEy
 q0jC1I9kV8SPNxOhjyShVtrs332oIuu2yLcCtBUb6mcxlmAk7y8Zj6vJ85FiNdgVduVhB1gyT
 C02dfsUZs/B/3Mp94nW6QYcEMxtPShBm0l6AowTt1yMqqdvq7/eaAtEBbQQ8xu77jg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.21 um 19:07 schrieb Jeff King:
> On Sat, Sep 11, 2021 at 06:08:42PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> @@ -304,8 +307,7 @@ static int nth_midxed_pack_entry(struct repository =
*r,
>>  	if (!is_pack_valid(p))
>>  		return 0;
>>
>> -	nth_midxed_object_oid(&oid, m, pos);
>> -	if (oidset_contains(&p->bad_objects, &oid))
>> +	if (oidset_contains(&p->bad_objects, oid))
>>  		return 0;
>
> So we get to avoid the nth_midxed_object_oid() copy entirely. Very nice.
>
> Compared to the code before your series, we still have an extra function
> call to oidset_contains(), which will (in the common case) notice we
> have no entries and immediately return. But I think that's getting into
> pointless micro-optimization.

Right.  I measure a 0.5% slowdown for git multi-pack-index verify.  An
inline oidset_size call avoids it.  That's easy enough to add, so let's
have it!

Ren=C3=A9
