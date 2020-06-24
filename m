Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6712C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956C920706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aero.org header.i=@aero.org header.b="qohIQAjn";
	dkim=pass (1024-bit key) header.d=aerospacecloud.onmicrosoft.com header.i=@aerospacecloud.onmicrosoft.com header.b="yGDrTsb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404387AbgFXPtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:49:47 -0400
Received: from email3-east.aero.org ([130.221.184.167]:9361 "EHLO
        email3-east.aero.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404230AbgFXPtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:49:46 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2020 11:49:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aero.org; i=@aero.org; q=dns/txt; s=mailhub;
  t=1593013784; x=1624549784;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0zSZfhd5wpei7YRNKllxLi399lykk4BhO/5ZPbJmVYE=;
  b=qohIQAjn9cKE/wKm6e1Ft94iX5zgNrN9kMYNuVwD2+iG03IucSHO+zjA
   0Klx5BSF5pO2K1OKLN0SjfRdoGG/d2DWH5JJFKN8mGqNCgC0h8sSidVSS
   Rq8LlQRnPNIIPbIkW9YSwCrjg12eaCAoxT8zGaLidJQWcvpqPTp2jMsaW
   g=;
x-SBRS: 3.5
x-SenderGroup: Inbound_Office365
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="3100494"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="3100494"
IronPort-PHdr: =?us-ascii?q?9a23=3AFhfoURSZq1pV4AOuJdTOkRE0kdpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQB9iJ9f1JkazVvrrmVGhG5oyO4zgOc51JAh?=
 =?us-ascii?q?kCj8he3wktG9WMBkCzKvn2Jzc7E8JPWB4AnTm7PEFZFdy4awjUpXu/viAdFw?=
 =?us-ascii?q?+5NgdvIOnxXInIgJf/2+W74ZaGZQJOiXK0aq9zKxPjqwLXu4EWjIJuJ7x3xA?=
 =?us-ascii?q?HOpy5Bdv5Rg2RyKgGe?=
X-IPAS-Result: =?us-ascii?q?A2FEAgDpc/Neh2lAL2hmgQmDHFGCKQqHYAOFOKM1A1ULA?=
 =?us-ascii?q?QEBAQEBAQEBBgItAgQBAQKBUYJ0AoIXJTgTAgMNAQEBBQEBAQEBBgMBAgIQA?=
 =?us-ascii?q?QEBCA0JCCmFYgELg1V+AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQKBDFYoBgEBOBEBPkImAQQbGoMEgkwDLgGsJwKBOYhgAQFzgTSDA?=
 =?us-ascii?q?QEBBYUcGFeBNwmBOIJngkwQNoZ6gUw/gVSHSoNFgi2PDB4XDYIhh02bBygHg?=
 =?us-ascii?q?l0EgQMEC4VnTZIFgl+cJJE5mi+EHAIEAgQFAg4BAQWBaoF5MxowgyxQFwINV?=
 =?us-ascii?q?o1ig1eKVkMxNAMCBggBAQMJfI8+AYEQAQE?=
Received: from mail-bl2gcc02lp2105.outbound.protection.outlook.com (HELO GCC02-BL0-obe.outbound.protection.outlook.com) ([104.47.64.105])
  by email3-east.aero.org with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 08:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiyYa2IdyQ2jK0DnypCeA33hivlOcdXgfTojTVx2xr+VMT7I0OohOEFY9fawUSltydIZKo8jfT3Mwldjf0+skqd71AE90JxoUoW8EL1YvrSng8mapIboemERri4+Qk6mv/L55K3c8ApbWJiro8cqG5HELrZoFf2otZf8PJRIZ/DV+0IvvGBONUYtLGqNDoVI3e30H7H4PHYqEvxjNb5MZAZFXjZ4JFZX2Htuye0YO0tGyZVGXM0jIY4QcfehV3ZtAkC0Nb6xM5VP6MfRcTGBiiPs2BP629iZ7jrl7BlC0Lrd+BKaBvAShAFpiuAKL1ETp/TCCPuatRYGjQHEZLaaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zSZfhd5wpei7YRNKllxLi399lykk4BhO/5ZPbJmVYE=;
 b=FgvK8d4+6QEgSrzJkHE6d+0NzkM23+BLM8xAbwq19L/dB8+yUNsjeB1asySOo3nHOOpsEkWs02BszSfvStvu30HieeNvj9gJ0YwbiExO2kAPVAyjZqZRYJTU/X9Mg+9cRILcS6XXNaXqTMjsBtlBTX+43zJdwM/4xWiuZAGoSx/9qjWSFvddKhKeIbDzZqp1cA+CMPBgEG31Gvn44/n73qaQo0EyxSq+cWU0KAhGGfgOEUd6yJTnI3MUdJKfqCqQ3A+B4bhtkkGuaEejak+zjWXuzrWQq9Xo4eKe2sBiSrZkA3uupclPE97aBR9cZJQAP8hwolOOubuZwXY4xgclCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aero.org; dmarc=pass action=none header.from=aero.org;
 dkim=pass header.d=aero.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aerospacecloud.onmicrosoft.com; s=selector2-aerospacecloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zSZfhd5wpei7YRNKllxLi399lykk4BhO/5ZPbJmVYE=;
 b=yGDrTsb8+TqD9zBsAY0G/J2+STOmnOXf/ql9TwRoRG82v/Cz+B1voj5ySV9ifu0YyDgrWDnxyVLi1HCV6NmzLrcyfvSxdlQ6dz0GbORoIDhgAjQWoxeyEoOAaBVhRI0xNqRp/yaZLQevGF5C/R0Erxrdi9VkLPs5ItrshqHP8vw=
Received: from BY5PR09MB4504.namprd09.prod.outlook.com (2603:10b6:a03:1c5::8)
 by BY5PR09MB4755.namprd09.prod.outlook.com (2603:10b6:a03:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 15:42:34 +0000
Received: from BY5PR09MB4504.namprd09.prod.outlook.com
 ([fe80::4c31:8bb7:a776:c4d3]) by BY5PR09MB4504.namprd09.prod.outlook.com
 ([fe80::4c31:8bb7:a776:c4d3%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 15:42:34 +0000
From:   Jesse Earles <jesse.earles@aero.org>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Are there MPU/SKU's for these products?
Thread-Topic: Are there MPU/SKU's for these products?
Thread-Index: AdZKPhATvPNGMKdcQL2gbx9ha4MxrA==
Date:   Wed, 24 Jun 2020 15:42:34 +0000
Message-ID: <BY5PR09MB4504218AEF2DFD593843A41EFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL1RoZUFlcm9zcGFjZUNvcnAiLCJpZCI6IjQyMWQ3ZTRiLWZkZGUtNDZhYi04Y2U1LThhMWU2YzRlOGM4MyIsInByb3BzIjpbeyJuIjoiU2Vuc2l0aXZpdHkiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5vbmUifV19LHsibiI6IlJlbGVhc2UiLCJ2YWxzIjpbXX0seyJuIjoiT3B0aW9uYWwiLCJ2YWxzIjpbXX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxNy41LjEyLjEzIiwiVHJ1c3RlZExhYmVsSGFzaCI6IndNTHZScysrV2IwT0k4N3Z2TEwzOHpiVDNYbEhXV3p2ajI4a3BJcDhlcW5JckFKaVwvQTNLVDJMNVRoOVRaYkdZIn0=
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=aero.org;
x-originating-ip: [130.221.145.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2fc838c-afe0-46ac-8e1a-08d8185536f0
x-ms-traffictypediagnostic: BY5PR09MB4755:
x-microsoft-antispam-prvs: <BY5PR09MB4755BCADB85991A58380C9D5FF950@BY5PR09MB4755.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cz9wR2j30fEvqiEmnyqK60gUkMFa+WdZTHNIuDZOPp/dyEbUJsE1TJcYBd8cQjUhGQoqS/omczRfindk4b9rHMGTbZrGnYivpspNsw/uDdvkblvsNgVEZ1d/jTGYAwcyjTre/YFiHb+PH489W30Syn/OghG5hnp1+KJam8yyJCxh2I2qFb/oNJ1rc4QE/4bcPhdvx6iyEXHmHUUsHOWqYy61biv0eXcZruAjXwHDRJr1cAIiRsqKXRuGws2U8R1lgqizA71aP0SP3Frl4xpuKw84XutYaV94EtsaauMQaeM8qPqdsn1XnUHnV6Q/ggkP9GqCgZrKQDzxcFaudJa+PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB4504.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(346002)(396003)(366004)(376002)(136003)(83380400001)(5660300002)(44832011)(76116006)(66556008)(2906002)(478600001)(66476007)(66946007)(64756008)(66446008)(33656002)(71200400001)(4744005)(55016002)(9686003)(6916009)(316002)(186003)(26005)(86362001)(7696005)(6506007)(8676002)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MgrwgnP0SvdvVHQSDz/YCgIZPoS6Em7t21nQ7LxrMgtcmyaKTcWad3uTnnf/cyNguMWM+v+UabYrq7f/Xt55DAJMLvL5/pGEKO4vx/Y8yXzBBVdB0e6ZzIF2JrZQfRze7bkD9u4RH1lmme/FH5Ba9CLgOi3hHGYgc5hqwm+12c6usX8mQ5ROC7b81XmmhHt/qr7u8k0BBDv2xnbdI/bZsjHJVXkQ6eUyliLlHqcvpFYX4qXQaQ/5fsz/gxe0Ztm+/vBs8Efpx+qQiIQij/SiH8PNGZrM/FuxItncPXGOmu0EjW8lmiivons15ioOmdrG3r3rpS0aF43ZLADh1a4eN1Dh2eclDRlL4iRjgE3XCHErEM/S9pFQBEuX+hwHAJucGWPQ7tvb+pXKaN+R2gWN9guFOpiKXUGJ6RCTyxF9AFy4KDwIAmoL9IZ+jwi2rzBgvY77IGvyjOBlURQwcY3Kh7tNhrTv3SRlB/bfDuHp1wQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aero.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB4504.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fc838c-afe0-46ac-8e1a-08d8185536f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 15:42:34.4493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8294700-c5a4-4ca1-a876-1457d39899fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7m139M0tpSPbng686C0A2ymos8MaZ1XNlOX7rvDOwl72cTAx+g9mqMopiT5OsJUFGBaeusXSMdUiukUPHKikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB4755
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am working with my software team on updating their internal catalog with =
current and accurate info and am needing to find the MPN/SKU for "Software =
Freedom Conservancy | Git | v2.12.0". I'm not certain if there even is one =
as I assume this is open-sourced, but I figured I'd reach out to get confir=
mation before I make an internal SKU for our records. Thanks.


Jesse Earles
Desktop Support Specialist
EIS/IT Operations=20
Digital Intelligence Systems, LLC (DISYS)
The Aerospace Corporation
14745 Lee Rd. Chantilly, VA 20151



