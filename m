Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B1C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06D120774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YFicAEV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMRRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:17:35 -0400
Received: from mout.web.de ([212.227.17.11]:50299 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgHMRRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597339040;
        bh=DZFV0esfMz2ZmPI9cGAo1IFlCNCfURMtLZI2D282tsk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YFicAEV2kkyS9Cfqas4RvBSgUsipqb/nroqnZP3ahuLypW0z//K4zYs9MNOThMU5X
         YeD0Ldw2JbKs/9DBPMkimN9rou+w7TlrTnu4X2sB1gG5Xsc5bFDEP5DgdGhZFyJLsz
         ZYvnTZLbFPDLZoWyGGr86I6Boi+gFToIiaOAlMjQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhUfW-1kJw7B3ieA-00MfAo; Thu, 13
 Aug 2020 19:17:19 +0200
Subject: Re: [PATCH] fast-export: factor out print_oid()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
 <20200813115815.GA3098633@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <153a34a4-f0c9-6105-75d7-68f940a1cb39@web.de>
Date:   Thu, 13 Aug 2020 19:17:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813115815.GA3098633@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZUYwBp/otjw0wYzcbhAUpnFzqACEFeLvhYYGjk2LL24tBv5sWBF
 8HwhxdIkJS9OLmP/GlF1zOOzushYOWCPO2QrSPVdDVTx7gmUx4wAhqEpv0Q/BI/TQTb6ASJ
 nz72GlgOUSXnmpHEaazhdvBXHsHp7jofTl4EmulkIgnVDuvcoQHTb8UeoPXIt1iFEqq8DOg
 i+m4kCAgXpL2Ccpy8tREA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mdsuc85Z9aE=:9rLuH0V21IelDVaFKP4jth
 wlaZp6mbkDShEiCrgsHCcbbIHhXbKuOzfc4SUWG2rz5Sv4XaeQ8Iwj2VNCK6U3nwM6N6IqgLl
 anqdDytXAp8+aAoXKZxqk3r58fLSsJDjllI2if6QiIiHEXvvk7XpDvFjOj0rVhf2FF9jHSlH4
 AoU7el8Sn9/IbJu2wRuilIFCnYfQcbBafIK9t03UEEJ+a5SUGNMGAhstMvkSloLwZU4PdA0w7
 gXe4Q5HPWMEbdF3s8UZVwHhJTNZpBA3hZLB+meoh+NJpRWfVsxqi+EW4xnw05VEdDDum5labK
 RZwiBi1VSl9LFaljPzORUim31/P2oNBuH+8KdTdx4J4KZ9D7pN2nS7btAvojal1AKl+/ckHvh
 wi6K+xQ8UptC0qE7lQh15kc5buzOd0YhRRPY2BXSWjtBku0Tb+M0dLbv0BMb9mqy6ISnroikq
 o+6YU3DTf3aOIpVLRH88F7TZC5B+HEqVgXlfs2q4TX+7RVIksU4vtmDO554KJXwWQzUPbUmv8
 SaFGXAKIa3Rv5153MyoCZBanbM6iOX4pxIiSJNRuZxo22vRBJ+jdHRRcTAlW7+Jk8zyA5HrDD
 zhfe66FUNl8l/tz+c3GF/pBa/vWl3HuAjek4AFzKBNhKlsVAB56syfCw/TO9iFU5BJXxUTrHQ
 jzKoIh5jQe/UP4LHBzwj9jgpKGngbvrmdwm+r9m/HAIZ/WSgPWAwQeZDd2sh5o9y4JlhcePZN
 9/gbiI9LdW6ff1ecJzF8ZgEdveezmZlVZPfIthR8lvhthswnioK+/Q6MKqUDOzF2yZF51+xht
 kORAV3HK3DEmTBS7ytF//JqRQZMtcgRRmtX7GsD7C/hpzhyBk3C3miCTI/PriuACEwU8HIHFl
 +1S2g3s8BcduZmaruWY4Tf5cPFQG8prT1eJyJxghGTVVc5oPrEZLxPCowZGfnABr9hWRGJvsk
 MGfQw9+ffDNhK/+1TxEhN/w6kzXDDEbvnDhcrcBsshKWDWnRvctIsXZnE9CLId9l4XV2Xe2k0
 zPIyPgk8aTDMGmYrjJJK5/qGVP3jaNw4ou9cN7Xbai0OwxPg6GHU8vzyyyckp9kSg4wOflZPX
 7A8Wpp5Z4iXmfvU5te0EjmyjjP+gCG6pW3Zi+VvD/DOWXmkNryHM4cNM4fFcf8Xroid+iGc9t
 Ag5QK75VKeIYLZ5UnymqpiRQgRMU27OkPlvnfqdKOnL+gZ0aLBUAxvW3AMu5h+st6RHw2pz3b
 Nz/nZzBxCw15Dr4Sl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.20 um 13:58 schrieb Jeff King:
> On Thu, Aug 13, 2020 at 01:11:18PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Simplify the output code by splitting it up and reducing duplication.
>> Reuse the logic for printing object IDs -- anonymized if needed -- by
>> moving it to its own function, print_oid().
>
> Looks sane overall, though somehow we added 4 extra lines while reducing
> duplication. ;)

Yeah, but they are shorter. :)

>
>> +static void print_oid(const struct object_id *oid, int anonymize)
>> +{
>> +	const char *oid_hex =3D oid_to_hex(oid);
>> +	if (anonymize)
>> +		oid_hex =3D anonymize_oid(oid_hex);
>> +	fputs(oid_hex, stdout);
>> +}
>
> Would anyone ever pass anything except the global "anonymize" into this
> function (certainly neither of the new callers does). I get that it
> takes us on a possible road towards moving the globals to locals, but in
> the meantime, shadowing the global name just seems more confusing to me.

Good point.

>
>> @@ -470,21 +478,19 @@ static void show_filemodify(struct diff_queue_str=
uct *q,
>>  		case DIFF_STATUS_TYPE_CHANGED:
>>  		case DIFF_STATUS_MODIFIED:
>>  		case DIFF_STATUS_ADDED:
>> +			printf("M %06o ", spec->mode);
>
> This makes the output a bit more lego-like (i.e., hard to see what the
> full line will look like from the code), but it already was pretty
> bad because of using print_path(). I think that's fine.

Yes, it was almost halfway to all-out lego style before, and the
patch moves it further in that direction.

>
>> @@ -724,12 +730,10 @@ static void handle_commit(struct commit *commit, =
struct rev_info *rev,
>>  		else
>>  			printf("merge ");
>>  		if (mark)
>> -			printf(":%d\n", mark);
>> +			printf(":%d", mark);
>
> This line gets repeated, too. I guess we could have a print_mark(), but
> there is really no logic here except "put a colon in front of it", so
> probably not worthwhile.

Right.

Ren=C3=A9
