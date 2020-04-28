Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DDC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99943206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=imperial.ac.uk header.i=@imperial.ac.uk header.b="whYwoYmk";
	dkim=pass (1024-bit key) header.d=ImperialLondon.onmicrosoft.com header.i=@ImperialLondon.onmicrosoft.com header.b="malhOWE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgD1Ox4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727775AbgD1Ox4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 10:53:56 -0400
X-Greylist: delayed 1538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Apr 2020 07:53:55 PDT
Received: from smtphub2.cc.ic.ac.uk (smtphub2.cc.ic.ac.uk [IPv6:2a0c:5bc0:88:101::47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D2C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=imperial.ac.uk; s=main01; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N0ueONDysUtmBqleSZ//Mo59hSDYqz0iqGawM0j97Tc=; b=whYwoYmkwfF08NNCFbzrBX7uGr
        Goy5iRglWNDbsF4TbXuXJwHh5eF0JW3YeO+cCbZN1LCP34DMTm5nFaBoSjzQcs9yTvKErVj1UB1CL
        1Roaamw4E55xjUhdScu91QEDPTEoRPOJfkocy27Ch9T2M92BNIja3nuUu1uvf0CWUZ+8=;
Received: from mail-am5eur02lp0206.outbound.protection.outlook.com ([2a01:111:f400:7e1e::206] helo=EUR02-AM5-obe.outbound.protection.outlook.com)
        by smtphub2.cc.ic.ac.uk with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <francis.nixon17@imperial.ac.uk>)
        id 1jTRDb-0004VK-VK
        for git@vger.kernel.org; Tue, 28 Apr 2020 15:28:16 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRdTetIn9tj/hvwfGtZjfvJKIPjBEcNlKL2lRKrvL7h7fRS0P0LiI+3CoSnFXZQBtVXXufUCmu70UGvynaQJpXm6J5ls91LTHU4vvPSQMxkVqWmktL1ZCLbyGp9n/8Rbkyd9vWzLq7lJ7SvnBLCbk1C2fYIl94tmgvinE4ubV40d1dYJxqo7iJ9/qwgel3mueLCIP5GeJiBFL6vhPe2+GPoclcFGY9mnrTrePNOJSj3BpmvygHfGlRAyuzI9lqZ+KCq4IDfF7E9d3cGbTBXMLZpNYAqYPxRs4PasXPOj4Nbi/jZvdSIuX792y1WMjXS3ZPDVZjB7Htb6oqPSNQdqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0ueONDysUtmBqleSZ//Mo59hSDYqz0iqGawM0j97Tc=;
 b=P/TekZth91SQRvNk1wB/Id7iLmjxoYhtsjiJW5JE5zCfzVY8CiK/DMS2Znj0uwhaPgmK4pERgaOLLsyR9qbJ7DhUHFhAmw9s3TD61MAqlRF5kThKjERlTBaCLdZ9oS3/mftL6QDlUI6cb/UhCdj8r1lB2JL6Teh70TvZmhOncuzZR0lV7DzJXGZ1eZELqn9edWxaQbJwlk0v5oQnHAk69oKDLHz9YhZ15s8lSL7o98vDhW6593bAVdnnYCiRf6IblsZcFk2CoZYkIDF6Tw5bTVRT/ASwY7ibVWyZlfh/QVTv54wVjdU1yeWc5OXFUvxRm2YWZYZwLIR9oa0RDns2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imperial.ac.uk; dmarc=pass action=none
 header.from=imperial.ac.uk; dkim=pass header.d=imperial.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ImperialLondon.onmicrosoft.com; s=selector2-ImperialLondon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0ueONDysUtmBqleSZ//Mo59hSDYqz0iqGawM0j97Tc=;
 b=malhOWE9gCKMfocPIvsWHBxU3M0cxe85qyTYYd9BBMl0EBYjqFz1NWfbyOKt1Z3gMphCMGHUMStX3oj8dOr2xEUdKIZEjJnxaJHqgnlH72Sby5QcB98Q9ox4N8Ewn8iYBbLQuCiQF6e3QyLAvBqw0gQMsFSlWF2+849nUQZgfik=
Received: from DB8PR06MB6218.eurprd06.prod.outlook.com (2603:10a6:10:10b::16)
 by DB8PR06MB6188.eurprd06.prod.outlook.com (2603:10a6:10:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 14:28:15 +0000
Received: from DB8PR06MB6218.eurprd06.prod.outlook.com
 ([fe80::c860:167c:ad2f:e815]) by DB8PR06MB6218.eurprd06.prod.outlook.com
 ([fe80::c860:167c:ad2f:e815%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:28:15 +0000
From:   "Nixon, Francis A" <francis.nixon17@imperial.ac.uk>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Log ignores --oneline and --pretty=oneline in combination with
 -L. 
Thread-Topic: Git Log ignores --oneline and --pretty=oneline in combination
 with -L. 
Thread-Index: AQHWHWkbezrumDC15kqmMLxNyW697w==
Date:   Tue, 28 Apr 2020 14:28:15 +0000
Message-ID: <DB8PR06MB6218D1398300AFD016D0B804D5AC0@DB8PR06MB6218.eurprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=imperial.ac.uk;
x-originating-ip: [5.151.181.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69135da3-8c69-4f9d-7955-08d7eb806354
x-ms-traffictypediagnostic: DB8PR06MB6188:
x-microsoft-antispam-prvs: <DB8PR06MB6188B04CD1E0048DBB516F8BD5AC0@DB8PR06MB6188.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6218.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(478600001)(86362001)(52536014)(71200400001)(8676002)(6916009)(81156014)(316002)(786003)(8936002)(4744005)(5660300002)(186003)(4743002)(66946007)(6506007)(33656002)(2906002)(55016002)(76116006)(26005)(66476007)(64756008)(66446008)(66556008)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EoR4F9uh71Nuclz9R8zxWRBLw0FK3nc1O6C/Yg6Tdxa7CuWXVt/mt+ewXArKZBp7H/zECzmQUTCQA/1AyqieuewBhv/oR7129nrsYtzCd7cUUq6vHKde3a+1X76hM5N8cs2UobnsWOA2CQhDQxbqCCeydPYWlLi2rL2n39P9z+Ywc7dloN4if+VQhe0IcUz/qb+ZSfrjDFL/pkgbkj85F7KSQkhfYfGROk+p/a9Ay5TZ6NI1gzKeeP0T5X31OS8UmcFE1E7xMteR9d73ErbH/DlVHxbu9iZHhmQpvQumYzZuAVdxl7Nke6exo/adZ3hh+PTCvrQCCIEMROC39LpmCqE4d2j/Dorhxeth6y9lDwSA+XgLPEcynTkxrnEoMYxxDma2wLuGWce7kF7ysp0yQOi244XuXMnlyCq21WS3rWGToFG89mYH/1mire/+BDMr
x-ms-exchange-antispam-messagedata: LoBOUe94qs4nGRyMPMFRQ+38MlT9VtbWsM60ysB0u1k6E1dah24gcaSoqcmOqaI9SXPAqSfeEy/cYAMD1fGrFJmySA8SWr03vGEKUk+zD9jGhS2Q6u6JlrUSsXrTgvERPy6juF94MiZOpQ1ojV4/YMdClwcENPJeHWOwrxTytS30RzUZer2WY894l3HFUBgtE6PtWS6VOeWONmo4jLF9FjlaCd5BXm4Geqd/euktzDMkZEH81VpS22X9MoeL8AQe6dnNJLm33DqSDpkUtz4lpI8j1/65cEs0e0vm3YlLd30QI4DYqyK6IecK7uFeD3ldgSuE11XFfW64+UMxr5IShZQYLtr+v02jwOlbWhDJZI1D+GcitCUsPYdm7HqRQKE7nA0B5s5Ru/GngzWYyYVw3zZkl/t185arVo8Ztvf/qBJlivUxz21xzyyh4Y+509td6cE+KGMV/oPtez6Kx/JPVbPnpJOLz3CI3pfP/wggAXqjEH4bS1+jAVZwoaTb4fBXkRX4SCqe5vlVC1Q5sKFBCl+co5Od1sPioEaegxH5ToTwPekzWc/FEYObrD+LknbkDBahr2nbMWgg8myBJS5nPg4JvBir8/Woq5MHML0xoNzK2G9HHvZt7BTzNRz9iyWPWX0ULemfvsMXz6o5zAGsVW1j6uYYrm5cY0fvGfryXj3QCQhdX/Qi/6Ihz5dRS/+xyXjuCUWlgrrDeVCMul08X+kysKQIqttg35G/Vd912ToB0fP72iLJ7MlyybDbZOdj/RD6J9aLbVNEMhDSaT+gX0+2trnbOvvosvjWwE32+G4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: imperial.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 69135da3-8c69-4f9d-7955-08d7eb806354
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 14:28:15.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2b897507-ee8c-4575-830b-4f8267c3d307
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5nfUTxcGtImy2POM/mDQqdI8lUSPpSXhj0KBvElTXev5ah0gsA/WhnvgGN209Gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6188
X-IC-MsgID: 1jTRDb-0004VK-VK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Running `git log --pretty=3Doneline -L:get_stack_map_frames:stackmapframes=
.rs`(filename/function names as an example only, consistent across many fil=
es.) results on in correct output but doesn't ouput in a oneline format(sti=
ll includes the full diffs). =0A=
=0A=
Occurs on `git version 2.26.GIT` (e870325ee8575d5c3d7afe0ba2c9be072c692b65)=
, as well as whatever `git version 2.20.1`.=0A=
=0A=
Francis Nixon=
