Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C20C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 07:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC0HDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0HDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 03:03:02 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EBA130
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUIfj6FldS018EoOiNowabMs41xM5DZUrI/PISQG5mEsSN/uKzTtdSpJrAlXIXBOSmq9E+E30MbJBrKxHI2TDb/x4oXn4SXtrYjQC8R//sbclqVIcYNLKucd90KBk4daNY1EBSorYQYGB5c2e/sX2HTjfBJZ4x10FW0LTdIseLcllUgUcq9YJJO7CUS3k6TCGETqF+0Vw5GPg6fTxqd2Q0nyXmrotzNaIbu/2icYReBsB7JmbTez+eYPgZnKsg76XWD4CN6BLxIXuIM3QFcRUjpa2qGfKMog5brZT8gFnAFgSs6ZN6z1zv/4xZl+ZuiEylG7hg/220s1WBr5+SypHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwJI4Q1l2zuePnXxW5aMb8jxl/t2ecYKzvomM3jVbQw=;
 b=iqkMGn6VdsiTjfiWB2V1WqHBbVVdCLF+np7pUfW4Pz7dSxhx5sKxPT+rGToCDhWhwu2st4Ozx+BHD1lZammUjxmC4xj7YxTry9GCGXSwQnk/9sADvovR0JHoKEE79WcKmIifXdT7eKtHteKglpCcRimtlDPOAkAkh23czlwFuimljedn8DrVk1VSNewByaWRj0hsnhQXF0SPyuYQAkLdCfP4Qx8XDtaaUQ0l7hLuVkr6O8BLilVc3WMom3N7gDy+tJYhXOWWCLeXcnoG9duHXDa5Z3lJgJCVfRpqFeP1Zlt4b60rWs3wsbTevW13yW+FIuYrex+VIni5USyR09zhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwJI4Q1l2zuePnXxW5aMb8jxl/t2ecYKzvomM3jVbQw=;
 b=CA7JlO9U3wpcoGbfW6XmKwMIN53w0els225Aa3CghdxEhcJ50ZQQ79IcPX/sobw0Lf9RvIkoRzuxvnOxO5KN8oeCzlNCuMr0Xr7GW23lEGtinOEiFwM790kY949hJuCgM/riunAlNYjP5vK6MVxnEdfTzrFXUN/srfwQ2rbG7BnpwUX/1OfdTdoDriwoah6x25XbpAw0QN9sumhJ2Zg78UF1bxkv17Stkc8Q0ROv+TaTvjv30ZTYocsRk5wNLi93VdqY6pmxLhGkofJQtB7R4AoazicTcjW/HgqKErKhgwPOk516mr4qlogncnYPolcBfR7OSpamojKf56/dUJa5Pw==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by DU0PR02MB8899.eurprd02.prod.outlook.com (2603:10a6:10:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 07:02:55 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::6cf1:746f:8bbf:ae7a]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::6cf1:746f:8bbf:ae7a%6]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 07:02:54 +0000
From:   "Baumann, Moritz" <moritz.baumann@sap.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Thread-Topic: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Thread-Index: AdleZgb9LbFh6JNJTEaFo9PrT/CbJwACr1d5AIFn6UA=
Date:   Mon, 27 Mar 2023 07:02:54 +0000
Message-ID: <AS1PR02MB818545E563E40C5E31A02D1E948B9@AS1PR02MB8185.eurprd02.prod.outlook.com>
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
 <xmqq4jqa3xgj.fsf@gitster.g>
In-Reply-To: <xmqq4jqa3xgj.fsf@gitster.g>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 7.51.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR02MB8185:EE_|DU0PR02MB8899:EE_
x-ms-office365-filtering-correlation-id: 85a2b19d-6be4-4c06-29b4-08db2e9149da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qs0iKw38h8JVwlKvYh22ijEXNKxrLSE+m1wY3yV6XjctVcom4YbZznLWGdgHQZijY+9mZj0fJjUkGDqxbDabQUfTclWEl9MxxzQ6rQeHVFexk91mpWOWGZyNFdQby1DUe/bSiM4bye1KUzlS46AKdTv/+XjMv1flB3SdJ5ZNQlJ0HPnTUPWnyQE2hwtoN2hIn05A4l0iFnLVN6XbaKmDrIVeHlCAt9+6S6AxgyywGYZLTeoAk4u0juZuYluFR7JHObMX+X+L+JkE5GGohRE/KqEsXXvrkxXo6PWz47aPAQVHMI3qaWyPa0zjVLLGAGr8xNkYVu6W7JE+euR7K8qK56iFioMJDpyKP2++Q+b52iK3xvM255UoVb9LimAf2CauRONK8V2SMMzQI29f1wW58xCe9abwCMur0BHKHWYRJhS7b7HL+NKWlUaXvmB7N+CaMn3Fp8SbPRTgUfHXPrErnZ/ZS58kHo+UosBqawgR8pe5vziZF5MUndkr5upOrWuUTrA3QSYTjW6H97iJigUremIc0xUo4G/PeoxeMPNG16/wJAldwqI2e6j3SF2XFsfOejaIO3YKllTmJQcKvsCJaz5wxrb6Zz2JW5Sd6BAl1FlVCyniVJZ1KXakdWWuiHvQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(7696005)(38100700002)(86362001)(186003)(71200400001)(66446008)(478600001)(66476007)(66556008)(76116006)(66946007)(52536014)(5660300002)(8936002)(8676002)(26005)(6506007)(9686003)(33656002)(38070700005)(2906002)(55016003)(41300700001)(316002)(64756008)(82960400001)(122000001)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?j+OoKosc4vSPyPnwchPUvReWBr0g2oHV07uZVGqGDsp8+8UjOA50793M?=
 =?Windows-1252?Q?6YzlM54V0t9rsUjGrJ82FhzQR2SenvgKTdOWCzRq+V094l/jpRa3xjwI?=
 =?Windows-1252?Q?kiunta7dLXKHzrsbwtkGrj+dlvE7rE4T0Z23OPSn4YU8zzh9W3wFPfG5?=
 =?Windows-1252?Q?1iCEuGIJf/ia4GMoZcHaWn+W6jblLHDfeZcxGRKoFJ09Z3SbnmRhRZcN?=
 =?Windows-1252?Q?C4S6ukn5BQctS2iro5vVzhsNuRDW7nkyVF2GpZA2a6XqqOUlv9dPlxMe?=
 =?Windows-1252?Q?LgWw/PHUtIs56ghWytbHcuEke/U1boSq3Dkf8CbOHk5+5rNCn6WdyBJh?=
 =?Windows-1252?Q?dYeHewGLsluAuExF2w4e7KVETQGxPMQTNlVMWgkDRCKEDkQ87+NgS8Zw?=
 =?Windows-1252?Q?pDK2cR1D+DfKtEToZQMzpoo9+nZGkmpORILoQlFtDJBN15VObpv5agZt?=
 =?Windows-1252?Q?Fl6UfIlPB5XKrZtLxRMsHlnn4TI5y4DrGQ2DfYsdAdyyaYw/+iWWUbza?=
 =?Windows-1252?Q?0CxiOwRqRuX1UgyWM8r2wrQCfngD8SDXVmx+5/3uvx8mWroT5GS3eCnz?=
 =?Windows-1252?Q?Mpr9D0FoA50b/qGNp9oYC/iroxRztQqOHoSsDIhymhfcQyZXA5DzaTPw?=
 =?Windows-1252?Q?WVwE+kgMbrTeiUIqSAYEQZwWMqteDVPIvOD47XsHv49WisCgt1VZ5fmB?=
 =?Windows-1252?Q?s9pzQFFGWgOKnBXpacx369Eo0ocwAXa3zjIivIAsRD5oF1Qo0KVUlupm?=
 =?Windows-1252?Q?hdTAgzMjFqree/JRC5gKMxsQ6EiW/XMip6ouHzFOwkox4iNOzSP/IiWk?=
 =?Windows-1252?Q?rFTkuG6idG+4X3S2Qv/lNxQvAxbrYQp8IFN/hv+eMyXfuxL5MVApnuLa?=
 =?Windows-1252?Q?tF+P96aAy+jJrpU8e7wpTt7hl7QSK8rzRnXlX/ZJFSIAUgJSU1YPxdei?=
 =?Windows-1252?Q?5+smAt5ekhg3Eu6y1kk1e8q5srvxykrm9HVHxNynYNDUgfLK8xUBVbjS?=
 =?Windows-1252?Q?ACnaOjlilw+CsDTt4zFlKHojgAw5L2Z/UDXYJ6cXludHjnYVSFbbS/jO?=
 =?Windows-1252?Q?8fM3MZoELacMIpDA6xrPcp5u5iGQswnTXVN8Ou5TsY2H7XYYrofSPpoh?=
 =?Windows-1252?Q?bK7k8X8YCl+dQ61S65xruEoX5AnEA2gbG6eLoqWGJ3TqqcI57OUw6aMS?=
 =?Windows-1252?Q?kIf80OPjFue6sp9gpY1n2kIPDJOzWoYQWxvVLstXbufQA7fzRlxd9krJ?=
 =?Windows-1252?Q?YJKbO5Z8aRjaEWeQxX5t5ya9lcQITTn0XF0Z+oQ0RllKiGP/LhJg4BWC?=
 =?Windows-1252?Q?hobzhUCd/V4ZqXZ0IumBcixDSusAw/skGzVpYN/453JDccI/Yt9q8TV4?=
 =?Windows-1252?Q?hO+Vb71mXOo0om9rIvOhpe75LWEGOcwC7y8bFejio2QyCRNu2M745r5B?=
 =?Windows-1252?Q?HNa881e+3BrIMGseH8ohNDwYhcC0r+T4C0w0nXdJ1rQaRcgNSSaxbXnH?=
 =?Windows-1252?Q?vT3fyTHI8rhQo+Sl4SmBh/T3lX0DRZbuU66BuWZIicLvlWyR+lvEubTz?=
 =?Windows-1252?Q?UI1UV42lvhOxRD6aDZBNeEbCLZPq5HlVLrVmBc9Y7/CWWeiaXf/iG7pz?=
 =?Windows-1252?Q?1l5YYyD0pl93FyxYgCT8XGoc7lj82zmGUxrhErfcICORNlbZO/WebbWs?=
 =?Windows-1252?Q?LAa5Re6pG0OIC1kmR10T/IyeU4WM0N7A?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a2b19d-6be4-4c06-29b4-08db2e9149da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 07:02:54.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpAC8hMol8+gC7v+I7dMkBX7fUjlmO+g/bMw3PKfypWxqGZ4RuY8IWg/EWzC4hhzl6Soa+NO69G8TsKPHzmOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8899
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I do not think there currently is such an option, and not showing
> the same object twice is pretty much fundamental in the operation of
> the command, so it is unclear what the new feature should look like.
>
> Should it also show the same commit it encounters during its history
> walk (remember, a history can have forks and merges in it) in
> duplicates if it encounters it more than once?  Should it show all
> the subtrees and blobs in the tree of each commit, even if most of
> them do not change from commit to commit?  How does the user control
> which ones are duplicated and which ones are to be visited only
> once?  How does the command line option used by the user to tell the
> command to give such a choice look like?

I was a bit brief in my description on Friday evening, due to the day & tim=
e.
My na=EFve idea would be as follows:

The option would be called something like "--include-all-object-names" and
belong to the category of options that only make sense in combination with
"--objects". That name (hopefully) already explains the intended behavior:

 * commits are not duplicated
 * as before, only changed blobs / subtrees are shown, however:
 * blobs / subtrees are duplicated in the output if they were previously sh=
own
   with a different name

> By the way, "rev-list" internally uses walking the commits
> one-by-one, anyway ;-).

I really should not write emails on Friday evening=85 What I meant was that=
 I'd
rather use a single call to git than one per commit.

(The previous implementation of my hook then also queried all blobs for eac=
h
commit, not just the changed ones, which contributed to the bad performance=
.)
