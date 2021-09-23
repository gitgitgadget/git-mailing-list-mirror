Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394FC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA7461038
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 09:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhIWJIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 05:08:00 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:41724
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239137AbhIWJH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 05:07:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtqlxESr5qrCrkm/q5yq5lt0WFKi9vaVk9BUebI5rGjCpBOh0PGe3UOTgdc7QRej24zoJo5ga9dsh6CxJ4KJdwOJrxcxyXX4NQHfae4V5h2OhpdauFww2KHGYk1Jowi9JbhJ3G7U5L6VEMnInDnOGRe4W/isffKSPZAdk06GSyuQrrrTHdQ8Xb4b+S/5KLVV9Nkh2xXYx7UQCzc2CztoIa7KaLrJ93WELwHYtyUcKgwL3nruzxn3KNtbgQ1mvPX0xJ+OidvJv3xTlXkh+PAjYPz8ELqgHcITbRw4XW0c9I+NDVtD064OJwd+D5yY22M/IUQ6k87Ho0c3yYhA97gUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Nt6Nf4BsV9+RUGNWdJ6vIVn07cpLOHTYeKyI+U7ZiDE=;
 b=KPgC4KBkZ3nZ5jIfB97m7uOimkYaPn7tYJPcTspcbuRe0/1gSBPf0ynMUgT8Ade0I5uRfc4+EHAJjq9MK5uDFaFfXDBexAYggIgk2XuEb+WYnvCwUWO44ZLcsBikVxv3MudQ0Rhlj23ugNpb+B8Mk7+r1l6JE274ZdGu6Z7llEe/DsoKsS5iweZ1Bxjd9iDZFgUbOf7VYc3k9t/1AGL+RseHRK3B8+AfmtYwWEz8K0M0SB3iWC71h90nqGKpJCKr5zsR2hWyGWb8CHv82RaIdcfGaOmCFbFvq8IrRqpe6cMCITfQZSpc/mK5BRtxKT4riau120B9d9Eg3h9OWtTkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ikan.be; dmarc=pass action=none header.from=ikan.be; dkim=pass
 header.d=ikan.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IkanDevelopment.onmicrosoft.com;
 s=selector2-IkanDevelopment-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt6Nf4BsV9+RUGNWdJ6vIVn07cpLOHTYeKyI+U7ZiDE=;
 b=nDmUSYF5sk/Oax2kHlD0lgb9bvoLz1lnxYN/i/pwicgVcJ2DsAdytXRjIrz9fPmIB6f1YkIkwc6SGvzYMx90bXJzOclQHeBo7Zjz3aeaQT8B925g8xpR0hKsCSHhXGh2jI68TH2WVf7mRG1pluQ65u8NRNQZSFIB+GiRXOxFSiQ=
Received: from AM0P191MB0804.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:156::23)
 by AM9P191MB1427.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 09:06:25 +0000
Received: from AM0P191MB0804.EURP191.PROD.OUTLOOK.COM
 ([fe80::9c88:26f8:5bfb:c090]) by AM0P191MB0804.EURP191.PROD.OUTLOOK.COM
 ([fe80::9c88:26f8:5bfb:c090%3]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 09:06:25 +0000
From:   Nate Kerkhofs <Nate.Kerkhofs@ikan.be>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: potentially unexpected credential-helper behavior when using Git CLI
 from Junit test started by Ant script running in Karaf environment installed
 as a Windows service
Thread-Topic: potentially unexpected credential-helper behavior when using Git
 CLI from Junit test started by Ant script running in Karaf environment
 installed as a Windows service
Thread-Index: AdewWkUcrGorm2klTJKVuy+sa4NaVQ==
Date:   Thu, 23 Sep 2021 09:06:25 +0000
Message-ID: <AM0P191MB08040357C47BE834BB3EDEA5EBA39@AM0P191MB0804.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ikan.be;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6a33a91-9b1e-4a98-e04d-08d97e716c10
x-ms-traffictypediagnostic: AM9P191MB1427:
x-microsoft-antispam-prvs: <AM9P191MB142726B7C3BB67A01A1E29D0EBA39@AM9P191MB1427.EURP191.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBnN9cznr4c3P2C/HupWEOjLXCKrWQ7Q3J1IERGiARglzICXHhc8sS/kRTy4+ZbsRwVf+VVceH3dSRsLzwO4TrOSxy4hM9VnqqEWZP7run4N34O4KV+lxFI3M1qiAlDzIzNpqOeTJyURG7Scz+2kqdPKxn2J6zTy0Y5XOx6SI4aaVP5YzWgrgLVbGL1AJyV4IY03xK+5fmQ4cEiv5uj57ZxOSVbuV+rCYOt/Hhi34SSsYyYN/nl2dTvZA8jK9DBv+O2wPaLAVg6Yf/Yw87dbxrp+hgm0LIE2DxKEZGaT7pmW38b8t4Wu14840ZPy4+Cpkl8PYPPpEQewd/Uss4J9FzPWBf4eeAyO3fUE7V3U6ijY86BpdYUMOUxppQekCW2PPvGS9muO+dOn+oOU4kHVf1ZTae8RljhJ9QlhZ+Si09UaD4ndENI8u4HH7H00lQANevBiMbuh6R333EFGg2T0Lq8TUI9xy8QZMFrZuLFaO8aRtfwVhPkZf8pvGO+g5wh46I4israb1pzCWBfikSPI9wi2XbePof0I4VPrwDPWTYrs7qd+fZcJ7bS0kGlIstCm/tS2qDg0vXFq72O22kQNdRRi6g36AHnQNSZhNbziEeyWsK9AjzkGtHv8WbgQl8scfS0W9QSzrjahSTOsv46bT8H144AlgO/FrxojHBdjdmJgaynKRx2CfAx3jf9oW/ueTqFpZDYKdxI3AFfBfyupf8FUZlO6QwfPFMOKxD9tK68=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0804.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(136003)(396003)(366004)(376002)(346002)(71200400001)(38100700002)(52536014)(5660300002)(122000001)(66946007)(64756008)(66556008)(66446008)(76116006)(83380400001)(66476007)(7696005)(8936002)(186003)(9686003)(33656002)(38070700005)(316002)(508600001)(55016002)(6916009)(26005)(2906002)(8676002)(86362001)(6506007)(966005)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZO3SR2OZtr1kuKOlcmC8lB3XA10qr2NasPKD+E2J1BOhVH5210080xrAleoS?=
 =?us-ascii?Q?sfWaAiU7WbxqDXU8J/mx0bKHeyppcbAYLT9bMKf4wyyYt7IfMAfPKbZqPUHH?=
 =?us-ascii?Q?c0EptFpP9ZsbhiSDecWN3mNeJ/u9G+vLPHnJqljh+QABf2wwKkePtsdavBE5?=
 =?us-ascii?Q?Cz90+5Zs5pZmkPwkXzlsrPUE6CoXyo0yGoB4hD6bMBIXxP+7Q2uBJyqCHA51?=
 =?us-ascii?Q?cW0QUmQSbZG2HttejfWca1jEKrYUrzD6mfS9KYCiu2/Pc975NSmt+ftLYK5H?=
 =?us-ascii?Q?TDFM3lC4i2Yq0jkTn+uN/+piwoI2iFqt78/W/fDPDhi1RzOMIzawCGEO7YW/?=
 =?us-ascii?Q?LfLBaDGXUFQyoNVqRWRqqQh1uABQjcIjJ+iZFeVpm1tPasmr83R8i3G11FzN?=
 =?us-ascii?Q?pgA4KkJuHSokeG3PCAPF9+KQNxPI+wToYr+zL6eiGoZSTHeJqoamJSgTglqu?=
 =?us-ascii?Q?m1xJ9RoKeKr6kpa5TwAOhS1mj60Kad4beQq98NmpMlF9qduDaNgdW5TebL2I?=
 =?us-ascii?Q?Yyq3kfR5kbzK6nRVgqSLnzMN5kp4YnLGJfrrb0/O4fNE6z9xaqMkL/0BSCL3?=
 =?us-ascii?Q?L3w2u5Qb13YU8aKh8uXeyVQRhB5RVnIyhKcfX8OqtAiVsRzexIJqkmi/Hy24?=
 =?us-ascii?Q?UnORipY1AieQ+gkGDZ9Tn6HoH+E2lVXvugzfrXLzz9qShoXHS/nWXN02CjdT?=
 =?us-ascii?Q?Rtdw+dsNaYx9f6xwf4epMIVjmV88jnTrjFFhPQ5U6ZOhEo0MZhwlkuVGFh0p?=
 =?us-ascii?Q?7PWyE7gXG+laGKgknrl9voeNjzGdOFsEg8bZFhuEI7LbmsPpJuu+j2sN46v1?=
 =?us-ascii?Q?h9c40SgSvGvOJZCe8s5LMvFNCDomb7FoNORqQ9wg72d9KdFKhtSlWmyGliXc?=
 =?us-ascii?Q?hYqEbecD21YyyxFS0IVgXbVJRxdcaxW1o90+GDCkb4HMlBvucnjZPdOf1MAb?=
 =?us-ascii?Q?EcwsPBc0fUdDMSIVtrLzkHazJuEl3Amok+4gOjCz4DrzctJ+l9V3x4Qw1BGg?=
 =?us-ascii?Q?T09sKLsHO1d8v3eO18lIThwbKDjj7cL6He3te5FL9yYhwajttPSf2i6Iv/X/?=
 =?us-ascii?Q?BA0pBUxZMdS+H5hPVvkr+wfyf5SVMoN4k27P1JykZW86hA8wP5eLfLMeW46s?=
 =?us-ascii?Q?qfLaDxWPfkQqzCtz8Obqq0jk4Z86j4leB3hdqq41YIOfrphNH1A3aoGnh6d4?=
 =?us-ascii?Q?AYU+NNLMygu0x/Y10V/Z/EaFhvhv6Lju3ulniXHprrcaHF8q16zqLTal3BDV?=
 =?us-ascii?Q?+hc3OuhKmYeBTqnDXGbdGjIgZ+RHxPJXSscz/ntdHf8Ry7Qc+hE89yd9Sh1R?=
 =?us-ascii?Q?YJyTjKvITsnfDG2s4DyTuVB8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ikan.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0804.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a33a91-9b1e-4a98-e04d-08d97e716c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 09:06:25.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b00beb63-affb-4a0a-bf41-0329b15f3a07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoGXZV+RI6tjDQX1L5Kl39snHWr6qIqz2HhMKZ51181/dEW58jrUUaW6D4Dk0e8+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1427
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We at Ikan maintain Ikan ALM, a commercial devops product that we use ourse=
lf. As part of this devops product, we recently implemented an option to cl=
one a single branch using --filter=3Dblob:none for performance reasons. We =
had to upgrade the Git client we used for this from 2.26 to 2.33. We did no=
t uninstall the old version because it was still in use by older scripts.

After installing this new Git version and configuring our test scripts to u=
se it, we found that our headless builds on our build server started freezi=
ng, completely stopping partway through our tests. After a day of investiga=
tion, I tracked down the cause and found that the new Git client was instal=
led with the credential-helper feature enabled. This meant that as part of =
the clone command, Git would at some point run sh -c "git credential-helper=
-selector store" "git credential-helper-selector store", which triggered an=
 invisible credential-helper modal dialog during our headless script, causi=
ng the build script to freeze until someone would accept it, which of cours=
e no one could do because due to the headless execution, no one was around =
to accept it. Weirdly enough, when I manually ran the git clone command whi=
ch caused this dialog to appear, the clone worked just fine and no dialog w=
ould appear, which lead me to believe that this might be an issue with Git =
with regards to running it from a headless script. It is unclear to me why =
running the same command from a headless environment and from a normal comm=
and line environment would have different functionality in these cases. I f=
ixed the issue by disabling the credential-helper.

Some details about the environment these tests are ran in: our product uses=
 a Karaf 4.0.7 based agent, which runs as a Windows 2019 service running as=
 an administrative user. Karaf starts an Ant 1.10.3 script in a JDK 11.0.7 =
Java environment. This ant script starts a Junit 4 test suite, which in tur=
n starts Git 2.33.0.2 from the command line. The command that was executed =
was (some details redacted):

git.exe clone http://USERNAME:PASSWORD@GITSERVERHOSTNAME/git/GITREPONAME.gi=
t -b tag1.1 --single-branch --filter=3Dblob:none e:/ikan/alm/test/repositor=
ies/git/workdir

I executed this command with the same user outside of the Karaf environment=
, and it would clone the repo without asking me to select the credential-ma=
nager. When the command was executed from the above described environment, =
it would roughly start the following Git Command tree:

- Git.exe clone
- Git-remote-http.exe (unsure what command)
- Git.exe
- Sh -c "git credential-helper-selector store" "git credential-helper-selec=
tor store"
- Git.exe credential-helper-selector store
- Git-credential-helper.exe

The last 3 steps appears like they should have just configured the credenti=
al helper selector to use the store credential manager, but instead it woul=
d show the git credential helper and ask which credential manager to use.

I'm not sure if this is the intended behavior, but It feels somewhat unlike=
ly for an invisible dialog appearing like this to be intended.

If any more information is needed, let me know and I'll share more details.

Kind regards,

Nate Kerkhofs
