Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58912C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 12:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCYM7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYM7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 08:59:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2014.outbound.protection.outlook.com [40.92.41.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C8132EA
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 05:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds88P6FrQGFqDwHdUWjoKA8khkPRZInDGXIPN1liLZQr33aXi9SBPnz3QycTbJUYO8lfQg1XcaOr1nIjLqgpP2pYHd8E8M8L9cXuJxyLKZeWApxSm2DDjZkiuO8Sj6Bdc6D0pt25+6bkY8rCt3HXZk2g0DemWRE1VgBJYyfTnXvRIfNFDDc3QURWR/xtJb51pWLpVseO3XAlGIVqauUB4gA7+HH1SeFS0NE4cySjvLzMl75qVD/tqwbHoc3wutrDP9z+z40TxNI7fuziCcm7XaxYs0BsKfp+A5qViYrnEDxsuCh09thQfhqWbOk0qz3/FXk91Gna4xEd48ZtyNr1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqVX/Jn/4y47AqXSeWFZQi9S2SuhLc0V2VwagvXu52w=;
 b=cja8sIl8n0TTwnPjv17uCPIhqTRCNLH0QQ1f++vaGCqWVWL4qUtlW5Mb98qmFOfvbfJD2MmGCE3XcwuPltMCPcdlLBljB8R1pFCFBCLZYwCO2Vvsv3RtMdiw1Bnp44lDYD3zYhEuz61tzUO1r4r87ZYu+q/ZWXTBmUbv4obR5UfVmyqfAnhGJd7zQADokej4fqKO1615q6qQhfKZRU0TybYmiasR4zHq+42O2XT544U6YkDRK626mz/GDi/JSefjScvCprITmdwwXcD3XSsw2+00iRYXPGf6y0Nn4J4SLOKUyW6SUND4eWJaJZ5ghmpdf6wu0lDIm4EZp4elk5DXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqVX/Jn/4y47AqXSeWFZQi9S2SuhLc0V2VwagvXu52w=;
 b=DCmkr2kRvm42J4AjU5RVDZRTfkI5/XtTc5YHgBAWWqdPlfx4v3EkdxSJLZbXoY8RRt8WVhstPawBHdc6sVhR8UkosSV0pxgPinrMRC0wJopDdcoUT7v4AAIsEsITL3YGDYlhno5jFe1M3eHhsqaNXyOVzDVa4J8ucbVABic3v++dumISgumCUq9zXWL/wOJQ/hoUXOIX6EzX/BvXQeTfcbcCIqlXF0f5ro3L1PxGqDLcOgAqxIDtM8RhpmrWdzun6+lQFKBcyYu/o6k3NgHhQM4CA6A58zRjb2aSF6Pp/b0T8PfmG7BPEUdILtP39MRhjN9LuKpc9s+dswfs04qWpA==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by DS0PR20MB6440.namprd20.prod.outlook.com (2603:10b6:8:155::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Sat, 25 Mar
 2023 12:59:18 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7%8]) with mapi id 15.20.6222.010; Sat, 25 Mar 2023
 12:59:18 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
From:   Mario Grgic <mario_grgic@hotmail.com>
In-Reply-To: <dd473fc3-cd03-4ef1-9fe1-8909e30a0edb@app.fastmail.com>
Date:   Sat, 25 Mar 2023 08:59:15 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <MW4PR20MB55178582F83B537AC055AD5990859@MW4PR20MB5517.namprd20.prod.outlook.com>
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <dd473fc3-cd03-4ef1-9fe1-8909e30a0edb@app.fastmail.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [v2yciJK/7w3bM/7UGlUKti35OCJz+vEP]
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <DF8000F9-5B31-4C5D-B111-460503322954@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|DS0PR20MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: fb346766-51e0-40f4-587a-08db2d30bebc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcxDtaPBsBTaZLDwh70bswy5Xjhl0LTj9EP27CMxGxwZzkPRCVUPf2vDV95R/QKR2yexaJNVI2UpA2e0+jgt5bYEYyV5uQeqTWKOYO8jiq+MmBgQb1JU39vXos13QQoLaCIsQASKxC9PQIUAQlKEKMyU+5zZmDwoRnhGhaGn5ZXzkHUoxT5qPvNgJAMB8AlxnxGTkujJmICVAdYdMAJ1xkQeTKZMUsqWXnBYENStqpj+EeyYCSV6rBhXuekzLxGB6uvAg01Y5F4aj5/QFkJYf2nplehaE6YuhLjy3e/AOZleNHTPPlQWBMPc+QmxKzfdsnBVn0YOB0TC7HbfJ6D5OMKk2SZuQRpj0OmY4QQ53XzL0uFevQPTOmpkWleYeCvxwjcaWvksNTbRUejkS96rgNGVwu3ZdicRkO259dRJZjc+RvrsagfH70+Uk9MZUhwHpNUy4U0MI3hP1P7FfcAMAJTTVqY6eYl/qcRVtMBoYxKrsbsooA7/C96wz5v5BnqgQLNK+e9it+0VfhL8ynGfErVC8IyI8s3DsD7D4xDSZfKMEmhbUVbYUTngUiIBijfRlL0AIx3ImnRLxd0MzDAk8MfyVXlF/HLAjTtkNSANYdK1ZARKIwlY/uCLw6LqL47V
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tO2DF/lYPUpsBqpc9lro+sBz2VHbfp/h5bG6EhOonKZ+a3AMo8GrRlAufNXQ?=
 =?us-ascii?Q?8ADgyLbTpSpFG4biQO8QmDcHQl19umra7EyyruaXIHeftxFSoYr8NcScGImX?=
 =?us-ascii?Q?aktHyzJhnB+dSzNxcCFxD0sBKrIzfQt7/RWz46JHORtmfjrlnsNKG2C68yKL?=
 =?us-ascii?Q?2O+glTvuvcAp2tMAS25zB6JsrCX+1FxLkd0YwbdsCrgEVbOz0P4iNubv+oNG?=
 =?us-ascii?Q?u+BmUSgKqPNH/SOmsl+Zm43LzwX1dTklg/Vlp9qvgt2pfkZnqva8HjEZ5fM/?=
 =?us-ascii?Q?6LjaQ6vleEcwJ6EVQu3MdydXAGpKZ2OXdODuTDCM0bjjmrHI9yrMjOa12v26?=
 =?us-ascii?Q?coemhPX11IFikrOyGiUkLKxn4Zku2Cp4uQy2qEKUWcUb9XGU55Zacy2XBAlN?=
 =?us-ascii?Q?ENW2x6KWaYgOJobHN0h/Nc3GU1zv8o33J4ArchWia5HBJfKl91xeFe+BemQG?=
 =?us-ascii?Q?8E1j1kznL1ew5wWISS1w/ZqaVWAhGpetVXXobJZ5GuQ9shiJu+79O+kcLR3X?=
 =?us-ascii?Q?EYrgWNcVpRYPI11qJMdOXZap/ZPsxqOCR/s1owpKvziAlF8PV393r0FtPO/G?=
 =?us-ascii?Q?iR60sxLDNGFGdflCJ9jXHGpdGra4b19FOsSPHkI2fs8R+aLz7MAd+MDWoysB?=
 =?us-ascii?Q?lw6D/VbHzANFP83OfPXjKzT6Xuz0wjxU5YNFVIwGJWtuo1DaQFFtzmdqzAlu?=
 =?us-ascii?Q?mZJCnCxK9Ayc+Dr8wUbaOKkLcmdG9L9nzeDpGE+EsVkVqpxZ3CNfaRqmdsNG?=
 =?us-ascii?Q?2n91vGnwSNXky5LklHiunP2mRsBa2Vh/H75GZkKwz210G+UOi2Zk/vc2Hpls?=
 =?us-ascii?Q?JSV4fFK0JVx57OCxz5DWLUvuC/tTSKvbbQYRhZLuo+5Xh0yVd/auP01x15ZE?=
 =?us-ascii?Q?mehx8QkaJGmNqXhXtULovvW/VWJT1QnzrTa98jBjcST43MijEYofokcc6LD2?=
 =?us-ascii?Q?SHZsaqjgywfXWhcMlczaM+1q/V0QcNuhaA+NaK1Q/rpJx72uULJRP22Qtn/C?=
 =?us-ascii?Q?IKSo6dk5z2hVA2xTpDV3oF2i6ioHGhOWr954gLBFLNP1CYx28czofjyKBL+G?=
 =?us-ascii?Q?yEoagLzV/6IIrKfcFbcEVpOtUu56iwMYRxMfrc6q3iUYx60IjoTclsa6vSHp?=
 =?us-ascii?Q?pr0F8It4cwmwO+S/vWPnE9mZlojTd77JD8NdQiM+jW16lo6FwQP/jiC72Q2A?=
 =?us-ascii?Q?+pZyxHyoGeohUP7bOnQYfmzPl2yS3aUSLLHVHo8zr8Kv8i2O72fILBWO980?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb346766-51e0-40f4-587a-08db2d30bebc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 12:59:18.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6440
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did some bisecting and this is broken for me on git-2.39.2 as well, but w=
orks in git-2.38.4 and previous versions (tried 2.30.0 as well).


> On Mar 25, 2023, at 8:42 AM, Kristoffer Haugsbakk <code@khaugsbakk.name> =
wrote:
>=20
> On Sat, Mar 25, 2023, at 13:31, Mario Grgic wrote:
>> What happened instead? (Actual behavior)
>> Nothing is found, when in fact the search for term is present in the git
>> history
>>=20
>> What's different between what you expected and what actually happened?
>> git should print out the commit containing the search term.
>=20
> Weird. It works for me.
>=20
>    $ mkdir test
>    $ cd test
>    $ git init
>    $ [add file]
>    $ # This was missing from the instructions
>    $ git add --all
>    $ git commit -m 'added test file'
>    $ git log --all -p -G '\bmain\b'
>    commit 56fbac5e12649c4de95071cc1872569d7c34055e (HEAD -> main)
>    Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
>    Date:   Sat Mar 25 13:33:51 2023 +0100
>=20
>        added test file
>=20
>    diff --git a/test.c b/test.c
>    new file mode 100644
>    index 0000000..0bffa6a
>    --- /dev/null
>    +++ b/test.c
>    @@ -0,0 +1,5 @@
>    +int main(int argc, const char *argv[])
>    +{
>    +    return 0;
>    +}
>    +
>=20
> .
>=20
>    [System Info]
>    git version:
>    git version 2.40.0
>    cpu: x86_64
>    no commit associated with this build
>    sizeof-long: 8
>    sizeof-size_t: 8
>    shell-path: /bin/sh
>    uname: Linux 5.4.0-144-generic #161~18.04.1-Ubuntu SMP Fri Feb 10 15:5=
5:22 UTC 2023 x86_64
>    compiler info: gnuc: 7.5
>    libc info: glibc: 2.27
>    $SHELL (typically, interactive shell): /bin/bash
>=20
>=20
>    [Enabled Hooks]
>=20
> --=20
> Kristoffer Haugsbakk

