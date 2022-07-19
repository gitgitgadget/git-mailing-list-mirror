Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED68C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiGSRb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbiGSRb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:31:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2079.outbound.protection.outlook.com [40.92.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077756BAD
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHwu7zWvWQpCxrylHE5CIAw1pje+svZ9jTdzpCnSB+VAz4GAER21iLNROOTHtKF/LcKGlMdbC3y2NjaUtJyUpm++aOKuhmj/SvdePA/9CqhGOPA2NQ2FRmfb5Uzvh0bPMYAgaIfQj77FS5zbfpaKRCljwrJ7ZWjPoTuYUNTAvdHL77W/Ws4GGofi4r6PqRu2Nq+0r/JCp/Qdrexbv3hE/aJAR5HjBF/L0R7E0S8y0KhqfJguB1sqyRqI9AGYbQxejX+AI3M+ri45QxMyfjOaXOTWxv0832dRbKZWMkga2Af4nX9YzNNk/AH9edT0M7u+ThDWfhqDPryuUS/AOdfjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ces+XFxTmUlama1b/Ki7892ybkXZRa4k/c2NKvx4lbo=;
 b=TG7P34xMWiGhu1T52bFzfTQFblzKlFaRr2r9eAnfzjzdAdPkBczjGI9I3WTilQaDivRTPnG/OD86Cvxzysm4dFobJ9syeCVJMMQBu74hWOROg/5js1yf2VJ0pGAmZvw5K57I1IyFnf7sOl+Qq+HX2H1eC/OCgo5ltonmvHlJunNsy5iE5QF8OC51JDtphlN/NGg4sKTyEAuriGoGZwdIeyECA3T8j64YAhgOay+3/X058LLawciE6X/DoC4ZOSa0ETmKzV3O05m9l/c/QwJ6Votzv1deJrpVkSQtJS8HOjnwbE2o/1lhbx0sOEE4vZCuCtefPpu8NecJysrWPXdFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ces+XFxTmUlama1b/Ki7892ybkXZRa4k/c2NKvx4lbo=;
 b=Bbhfc98mk17hFrqbjRLLyqyv5QbL8VTXvOQiOAoJvGw/hhJ8Jw83YgyOAT8Fjlv/w1va3k+8MrljygozO+oKgCCQbbIiYvpc/EqQF5F3PrvFZwQcz5CqMJNEGqd4Dcg8rAW+cK3US0ftNCtgJHlB5tCUHYdfh0sGxZ3LR5Q+HlFNru5jiPGcvzc3/Cz79wqfh4b+pJjZuCFKZLMaydF3IjxxurrCGvnE1tgc9/KOBLvZjGMWY0jC12IXXikv5xj2RwowgcDcikwGnEdt/k2u9ZnuSmkL9wWVD3wRMAtnulF7xxj+DIWHC/a2/q0qwafBRWQcapGcz+ioANyYq/YnjQ==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by DM6PR14MB3744.namprd14.prod.outlook.com (2603:10b6:5:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 17:31:55 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07%9]) with mapi id 15.20.5438.014; Tue, 19 Jul 2022
 17:31:55 +0000
Date:   Wed, 20 Jul 2022 01:31:49 +0800
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>
Subject: Re: [PATCH] contrib/rerere-train: avoid useless gpg sign in training
Message-ID: <PH7PR14MB5594F83B5CD207AC45D8A39ECE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
References: <PH7PR14MB5594D28D5CF94BD30DB9D3C4CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
 <xmqq4jzdcbmt.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njAyLtwflTOxzQQK"
Content-Disposition: inline
In-Reply-To: <xmqq4jzdcbmt.fsf@gitster.g>
X-Operating-System: Linux Coelacanthus-laptop 5.18.11-zen1-1-zen 
X-Mailer: Mutt 2.2.6 (2022-06-05)
X-PGP-Key: https://keys.openpgp.org/vks/v1/by-fingerprint/892EBC7DC392DFF9C9C03F1D15F4180E73787863
X-TMN:  [HamLX2ycnQds1OECtbSDuFzgZVcqEWe9DZa4pUSZ3Ja4bhD+l3d0+qYMPDyBkgdM]
X-ClientProxiedBy: TYCP286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::18) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <YtbqhXuGoa3huBKa@Coelacanthus-laptop.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476fdccf-c58c-456b-537b-08da69ac9384
X-MS-TrafficTypeDiagnostic: DM6PR14MB3744:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3jv2Ww78wgZb7aVylXM8+k8KFcAFcrNGprV/nhnNbSmjGdF0MSkQUZqaWmULclryhjBCeV99U2uOOoLuQPbSoDgK0aorOIfQK+CLDDMoGXSp/iMx2s0tem7RgjmUbeRAskmyoNcbVJm/e7kkrmdfG004Rdw89lnjTQB7O1+j0KrUoFQzTTgLPcGXaR2m/aocBhLH9wezY3Jr1eQ4MB30RP8S76RqTdc93/wXB6iYIpCy0sodcr46I8iqCGEQcltmkUQ/dC510NoZnbKWWJdqS5dWuck9yFFx77XCR31spkvsVeYpVYGQxL8nY3Gh3QNyaAaihRQYx3rrJXK8thvk6xCu93rSxDb3zQ3zqevPWzGz5d8s2iNm+zqf/C65HkG/OHPkO4wyF02oI5rCXszlZ0Bk8FmBAf5Qg17k6ePodvtX5H3+pG2u/EF6C3aQbN99/aTld58tuPxcznBIaLHp+eprCjk/A5Ot340/hgfuuYrNTozSoz8CdgNmBeTf2JWXixxjO7u8vtykCFdg11U6nRBkPK5ud7IL/awrg1K9gG1357ueitf1dJrYoVyzJ9gLsCOZ1Ai3imZpT2sMxpKP5be65nZ8T/iIivINYY5YQXAR+7hjehHiYAEnBadZ+m3aqPnnlWKOKGfkdKvCjWdRnHrXaJLe96ByK1ZJhQxEX+UmEnToXMKnurTqG+v+G4f
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PgeeRXC8jF5MtGZG8ctTA1rWbu+7zHO4DmozqKeVFk343/QReM3SrOa2EaDI?=
 =?us-ascii?Q?IJCQXWlTZFoSHUIOzMsJo92FLELxrHSvvYM8QveANkF4RfOKE8nNteCAfgGo?=
 =?us-ascii?Q?lVoi/zuH2S7Z1+/fmZBh3ud058nUORRepisGIITWThErhA0cQNM8JMaikreF?=
 =?us-ascii?Q?EN9jfaiL/JYgqEsfZkx0cnObtKn0R8u8xZPCgesFzfjtOakIx9ccRZF8Kl0o?=
 =?us-ascii?Q?CgAJWmJl/Oj/k930jqdGDSkJoUkh3hmID7+uaxRioNVcgW7fzEuolloNXoBs?=
 =?us-ascii?Q?p+kPqkD/h/OrZSQhWDm/kntMgkXNijOObFkTz7ZGEDS6pHflQEZVJ/nXZavb?=
 =?us-ascii?Q?grJPxtN0+j/qsBowq8nx461mg1FIiIaIghV2OseInmouY0BIyg3vlcyjRMwJ?=
 =?us-ascii?Q?aBLvQi5CypdwqY6xdzKvspNiVyw63Q+gM8Cr8dFm5aYMb/J58UTj6K194S2S?=
 =?us-ascii?Q?nLKMZDuCy4MQ2IVrG6N6k1/Hur3n+qCyNwrlcpnYKluSIoFNPIjk99KUEvc0?=
 =?us-ascii?Q?27Y2ZMgnJDQjrptpEd9YyCVYVS9HiVjS8sNgbQFHCWq3GQ3JTQpK8O++7KY9?=
 =?us-ascii?Q?JuoTn1MkpuODje5a+oaPNie67VoZX+hg7n2cjIfFiIOciTqxu/QQkNIaUsH/?=
 =?us-ascii?Q?36TBbvMF/e7VOOw1g7q957sqiQzF4YYGCaVZzlcb8UhXT13YWLINVBtyfdf8?=
 =?us-ascii?Q?mb3/3FENoRVtAX0c8YSQ9wgvH/hwbDeP3bQxGC1/1s4u8IHZKVzYzToMZKVC?=
 =?us-ascii?Q?vKjBIY53Dc2a7lllzYtQiPFIOmHcxhWs0vg0gHIoZSvht1BRcREx9uq6qG2E?=
 =?us-ascii?Q?68cHo1H2scohQnyz2aU0B7U2WuB8tBfYWP2S+dRtezEXWJqjILQrFhR1QY5C?=
 =?us-ascii?Q?5XEKFSnIAVjmMk8pZ77g2rZdarISPLPJriifQ+UnY9hXY/FWKS4EMt3MtKul?=
 =?us-ascii?Q?NGoWXeMgCL2r2j92IeBM5p9Z7WOGhuEOSlmC8os4F0aaatCslBLWHCeRgVx6?=
 =?us-ascii?Q?iLJ4jM5Oiot6TOjhiNCNuZi2TzNXD1UR7WdDOGWNFbbYn6nK4N0jHdMrDxOn?=
 =?us-ascii?Q?id4Y21+X/cfyDBh3EzLATAKFN33La10wSgdcLWsAKOSenqG2xfSbft0wgMOQ?=
 =?us-ascii?Q?vvfuzYxYR1Bst7HAMSqleC7Sta5SzA+w5QfaxNLYaoGM6WmabTLAgMKvJbqE?=
 =?us-ascii?Q?ZgYn3sEhXQhQXwh/TcXgkcVIwablHMhqtch1gTJNWAz1dVKZbSKfT33kEtmc?=
 =?us-ascii?Q?VUp6oJ0wGAT0Mhe4HyQQFOPhkrgTcg6GxHhPp4qKg403h+diouMhB0zyehu/?=
 =?us-ascii?Q?QWZ37bOd0l43/n8OG3badjKPnme+rm8225gEqRoJulHjXudPmKzFMOA/IEAN?=
 =?us-ascii?Q?mf7ev9k=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476fdccf-c58c-456b-537b-08da69ac9384
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:31:55.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR14MB3744
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--njAyLtwflTOxzQQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

at 09:26:02AM -0700, Junio C Hamano wrote:
> Celeste Liu <coelacanthus@outlook.com> writes:
> needed.  Write something like
>
>     The user may have configured "git merge" to always require GPG
>     signing the resulting commit.  As we run "git merge" not for the
>     recreated merge commits, but merely to trigger merge conflicts,
>     and we will discard the resulting commits, signing them is not
>     necessary.
>
>     Override such configuration that forces useless signing from the
>     command line with the "--no-gpg-sign" optoin.
>
> perhaps?
>

Ok, I will add in next verison.
(Sorry, forgot cc, resend)

--njAyLtwflTOxzQQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQWueXrpnXi8KYNNJjjXInkWGeuNQUCYtbqhAAKCRDjXInkWGeu
NRXoAQDCj2377GRDuI6DqBhYTHttsfFdfE4ZwZ6++u6/DvpFDAEA7jx15XDcorGM
yX2Y23nkTFa7+YL63g7w9jp9H3eRbwk=
=YqBo
-----END PGP SIGNATURE-----

--njAyLtwflTOxzQQK--
