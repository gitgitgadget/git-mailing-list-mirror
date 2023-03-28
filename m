Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058DC76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 08:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC1IIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 04:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1IIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 04:08:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235144498
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 01:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPbEMriWIYZhYlFgixo5rVUBmTZ5FWz2gdUD3g2/rJ2MNGZOFPmWaX5KcGio60t7dd94uyKSA0mMV4iPEMKOhTsgwcMRIGqPz+i+k6iTBzIZUsLTx+mxf+mx0Ui/sOetVoplomqxe3FZo6L9Kbu0T3qORBpkK8qK6a5mCFhMp3wMC9nl7+gxwjNdVLD9ENAlM5gaKQ4nhOTvf1kbBVrPypPoJ/kFew5e9FNXW7Kt2TkjyudcgAxfHnm5my6eKUT+mBDrbE+vH6ARLcOezqhG9GR5oq8Raz/onidEzIDj+TcHC/kt7O/vroHCEnCLnbGRtzxCifKaUGjQL71lzDjSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAmlBal3rrwkxzm4H9njvoa9HMFH4JQb56v60LQ5WWQ=;
 b=CIEYV/+zlaPMw1jFQdpuItLaZTTSjnwfnyGNdpv2u6oxXudRr9N/ml71zw+zQ4YbnVVLs3+HIfK2W0EWwSPAfZ2hHYrLklLjvfGPXWxzrSkzG5dvW08qMX+j1SkfLTjrjw45ZKzMkV254msshfGiJoxAcV/clLmqfz0FPKyHrOdty4j9GUTc4oCiWtLCE77YAsDc1XbyxtKuos8JjWbkItEesFdjKzHzPZLL2TfN4cebQnmha8d+09Wnzo1uyYzzkwxuV5OT/LflvRni/dfX3fLfLCYXkjU5BN2eDYjC73pQOz2gQJpIXnvQ0tk3adktP4yh1iSltHVb05e8kttxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAmlBal3rrwkxzm4H9njvoa9HMFH4JQb56v60LQ5WWQ=;
 b=a4PuA7ewnTIVuHCg4W4cKBxFEXhHn4Babn3Flk9daO2uGMkgKwyi43QUgEBTT+8kHEmplfMw+v6H9ZrvyiGX2fKv7yW1HDaNKfhjMbLAXnijlLJ64aIqQWwSdAMUU2FgH9Vttkn7Rz3BioTZNg8zwKiK5HuZ3islMRIneoC5p+AlZ3i+GAUZZaPZ/d9AM+qA1VJ4qzurU0T29PvFXQkv0Nyxx8J9OcmWeND3HcsRUEKE8xUPCumDsmkdLTt2mcwGNZi1wOHuAKW14nSYHxosKdsG22YmcS+q1YJlDVE4Wm61JcsNPZxMgP/gfMT02r4GuUGiEiPNi8VORKK6sXDvkQ==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by AM9PR02MB7202.eurprd02.prod.outlook.com (2603:10a6:20b:3e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 08:08:02 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::6cf1:746f:8bbf:ae7a]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::6cf1:746f:8bbf:ae7a%6]) with mapi id 15.20.6222.029; Tue, 28 Mar 2023
 08:08:02 +0000
From:   "Baumann, Moritz" <moritz.baumann@sap.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Thread-Topic: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Thread-Index: AdleZgb9LbFh6JNJTEaFo9PrT/CbJwAINQwAALA030A=
Date:   Tue, 28 Mar 2023 08:08:02 +0000
Message-ID: <AS1PR02MB8185DF947EBC583318481E1994889@AS1PR02MB8185.eurprd02.prod.outlook.com>
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
 <20230324192848.GC536967@coredump.intra.peff.net>
In-Reply-To: <20230324192848.GC536967@coredump.intra.peff.net>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 7.51.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR02MB8185:EE_|AM9PR02MB7202:EE_
x-ms-office365-filtering-correlation-id: 8d17d517-df49-48f6-bfd2-08db2f638d99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHrRSzFACmHfIUKYU3S7TUoI7FRj/gYEfYSaTDsUcxeG9E8AxHkO4xwLT7qzaFddVGHLPsKYHzJ2ZVtVq2klOJ1bhwVJiv3Zv3NcxDrKo6SPTpBx5Qm7puFYHOBF9thrXP08YrxIJ8vEE0o2cDZxy3D7W1eqAi4cQ9KGZeOJY7fF7+qSsx35V0StibW1jwl1+UpdbqskYWwvwNmQTTbJ2elrjZ2XyoYQZdb2uoMJAkg7iTJClPYPKE0RQ1zNSE3XTlC36cWt19xrLPQAvJaUoMZJ21H7oLAkyKaGAdIxIZHlCCIYi8GZMkS6LwlVY8WETqknfClJXAuNP5WU4oioYklv9Bw//Qyn5VXw6D/rCw7PT5vz28LWtP1an4aOqVQ2LSpTyrW0LTCr9uPDWW0d2O1j+HpEVE132xBh81hJV02ndJLh8E10U/tcduVK69Vy6lwekqnxGsQUnVqnIF7TgImDJY6xKfnPLjAW1m9wLbg9zL9YqSW5VBqwGP5/oETQI14c8iFPMZjUGL6QkVQeyjSu9ghurTAqAu9srsIBW0ilA2cc1FI5E4Kw8AtM3D3pW1xbieKJb4LYkrD6F5mfrzhD7uF6vicvehDrj4dzhkXGi5jjgwhLFs99vAiDHP93
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(7696005)(71200400001)(186003)(38070700005)(478600001)(66946007)(316002)(9686003)(6506007)(26005)(83380400001)(8676002)(66446008)(66476007)(66556008)(64756008)(76116006)(122000001)(41300700001)(8936002)(4326008)(6916009)(52536014)(82960400001)(5660300002)(38100700002)(2906002)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?vM2Cc4m+MSRTR3e5Wof/7GGpEj0f9vSxO0dSVLDHtOfvu0D/3SWBOXEg?=
 =?Windows-1252?Q?ZnJ8HUhmrc8LAU8xGarOWk+glBuJq6vkAXt5rKxKGncvq3F3ddkjrpUZ?=
 =?Windows-1252?Q?5bzh9yklFLBeqLjDAdtkWD3xHmu6w0USYdRyifxsC8AuxI1Gm80O8RrQ?=
 =?Windows-1252?Q?fs1EUMxs/otS14xLNCfBOqUWwgsAzv8CNxOo9S52x6Ohvx0wKteA/skt?=
 =?Windows-1252?Q?zvbvmETKwRF2LTKqrmxez46s3J/J0cql1XI1pf4J7cz1uzbk7tt8neKU?=
 =?Windows-1252?Q?WrKKVj9f4dlVNv+xn8dVMhV4Is4iqEf/VlqilLSHwLjU316km1abh6Lk?=
 =?Windows-1252?Q?IJAJ9yddUYuc5/8MSPuUikRrIZh8ey43I1w4mgx0Y17XTRDG8pynM/a3?=
 =?Windows-1252?Q?0lKwzbRu/z9ygvhojuG3xA2tgsEbHmmzksLGF8uP5f7SoMOkG1jfLL/W?=
 =?Windows-1252?Q?5JHxCVQtEoUGd44oALM/QaXKySUcqSmr16XvyBo4evWEXSgMksTbeJMu?=
 =?Windows-1252?Q?688Rx4NWn7Ufj9HqFQI1lhMyMAf/lqwBgP41kiiEtzrieAnnVA16bvN7?=
 =?Windows-1252?Q?QhfcJ49ltXylXZ7chZ17Y9K0x76B74LM613ibEspWjGn5uW2MtbuKUJe?=
 =?Windows-1252?Q?OXsjCgpjG1Fojd/ruHweOndY73fwI65apdKhDipd+t62oq0olb2ne46V?=
 =?Windows-1252?Q?wqCAHVIzuUFp3m7waHvVUwmVcGKPEMWH7idBI6Jg9bXBTM2yRS0zIax3?=
 =?Windows-1252?Q?7uvZdz2zwyAtlZUpMvmAtVJNzjnDEaoMKh21oFton/R7h3Pe+Jz2qPUY?=
 =?Windows-1252?Q?NyUVCXfLY6DzXgGW4O3RSQFk+cMOHritcSkGc+aHqJzr9AGOwoZOAWj2?=
 =?Windows-1252?Q?SOCv6rb7kCHuf+49llVYjufWQ2PqnUyncC/FV84Kk/OxQR1n8jr4twFM?=
 =?Windows-1252?Q?ySIbAENFhq3/oihno3yKNx6TEVjuWVM8GLEDj2omsFsohIwqQx7xTYoc?=
 =?Windows-1252?Q?1s1cLpR1JZHjjQaPbuGJzYSmtUWVCZwAvoS966mxoVJCl0PoJBgJPPcj?=
 =?Windows-1252?Q?USCD2q1HMuy7UgBoHyLB9s3uKAKhJk6886Bf9K2EjF2At9G5V82X7Ktb?=
 =?Windows-1252?Q?3Bp6wP0jmtjTLHbD1pSpwniIRY8CRka5U7zcTHhpP7w1yEjN8q5kBXcn?=
 =?Windows-1252?Q?n+2hH2eUMIizTqS9WnhTffasnPQy4TzzHbPj3V7w3KHyQa/sKl+EUaNT?=
 =?Windows-1252?Q?4K0RPeXlvy1lr9phAbFrkP9HaWaZA9mKMtRn3lJMpXP5tud2wQ++M6UH?=
 =?Windows-1252?Q?tCbB05pXrbCEPQi9GeAcJU2TYbYCXADEftAVdPkNh1Or8HcotkRqXpUh?=
 =?Windows-1252?Q?3S13RtLY+i3OJ70RhALxSmCDzn3gyR8/1QjOOo8BJKwDg8i3gDdqPiZC?=
 =?Windows-1252?Q?Qw5yfqwRScYARzT04Aj+E4hus7mogwFHUEnEkE0hIPBAqBDQbSbmzlUk?=
 =?Windows-1252?Q?B1NvbW67NbXuxkta1+ZWLxttL+G4aVUQGEvVvR6iW09BRdzzGkRvHOzD?=
 =?Windows-1252?Q?TiMdtjZiH0OovbMQiyTfOHyUqTGRua3KSQQMiSakwWq4f86Cs0Nvi5mP?=
 =?Windows-1252?Q?d+81R3wYZL+e0YWkA6q3MWrKguQw9HcN78iAaVqV40QkYj5edKvy9nQ/?=
 =?Windows-1252?Q?ll2JleloSKvfLCs+tOJNIwvN/V9Xy2ME?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17d517-df49-48f6-bfd2-08db2f638d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 08:08:02.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZntSbSU8fmQ4PAnZ2t29qr5wt5kNkWDuhuwQjDZAC5BRaSFfKZDVorgZ3VlHiC5C5io2Wkvvz/VDf8E1DwjdRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7202
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Another problem you might not have run into yet: the names given by
> rev-list are not quoted in any way, and will just omit newlines. So if
> your hook is trying to avoid malicious garbage like "foo\nbar", it won't
> work.

Thanks for that warning. I was not aware that rev-list didn't quote file na=
mes.

> Those names are really just intended as hints for pack-objects. I
> suspect the documentation could be more clear about these limitations.

That would indeed be great and would have likely prevented the obvious
misconceptions on my side.

> I'm not sure what you mean by "one by one", since that is inherently
> what rev-list is doing under the hood. If you mean "running a separate
> process for each commit", then yes, that will be slow.

Yes, that's what I meant to say.

> But if you want
> to know all of the names touched in a set of commits, I have used
> something like this before:
>
>   git rev-list $new --not --all |
>   git diff-tree --stdin --format=3D -r -c --name-only

Thanks, that looks promising and solves at least one of my use cases. The o=
nly
minor problem is that there seems to be no way to pipe the diff-tree output=
 to
cat-file without massaging it with awk first.

I have three uses cases in my pre-receive hooks:

1. Filters solely based on the file name
   ? your suggestions works perfectly here
2. Filters based only on file contents
   ? git rev-list --objects + git cat-file provide everything I need
3. One filter based on file size and name (forbid large files, with excepti=
ons)
   ? I'm guessing "git rev-list | git diff-tree --stdin | awk |
     git cat-file --batch-check" is the best solution to extract the necess=
ary
     information from git in this case?

-- Moritz
