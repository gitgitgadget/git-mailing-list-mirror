Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD741F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755008AbeATPYw (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:24:52 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:63120
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754240AbeATPYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ym9OZjNTApThVpE6DlLpOKqtHGvjbcdB8Afu3WWcvYI=;
 b=chyghC5PPZq1qNO8+41NdcSRncd3tv1EWirh2TijZElZT20t0U/tV3cOQr4gI0xg3BAlMT8Jsu5k+7lpwe2jmAZl91nUb/FyTBcxhgVmgHNE9ayjRas67IsAwe3NOERnmX4P4pqGj0GsE3kzWjkFEqHrDg6hz6zQu3gsW6x+0n8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:44 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 1/6] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Sat, 20 Jan 2018 16:24:13 +0100
Message-Id: <20180120152418.52859-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180120152418.52859-1-lars.schneider@autodesk.com>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [91.89.52.221]
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5e6685-5cf1-4ffd-b927-08d56019f043
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:XbVG4+ICx7QYXH0AJblWRTkODNmNVZe1beLQJCO9zi4XD1cijZrw2ck6xvHEtjhHXNC0FzLArvs07OzFuNyqdMxjxrkwoBoTLrhS1RxMQ4+WMw9FkEg86R0ghJH/FJveosHi3XLAP4M/M317klaop1GMDS4ZBuaMxHpSJJ7aqEWVn2M6p3QeitAXZbqIqNhhOmBugVuzKnhRItv4cjQbdpUQom0YNBwr8hhYIUQjNv2YwOgi3IfsE0f5lOt1S0NE;25:IddXKleTfJaaJ+0MmEDT1EVJYzTEVJblwtDnlll7+tzeVEKTuWr88bm+P3iTGLaQNJTACDf0p3pSer8q99RHdshzWMBx7/INb4BW0Empm7bE7JUC4UoqBu53sw/Vh46BCIDrAkCH3/+3paz96yL0g1sjKBbwJ23Veu8x879MH0AOFpYwsh58SyT/c8s5MHVIewJiPTy/ioyiEGUxgaIvqKEhVE05e6vAnYyT9Dw6vSrVNKtaViSm8Bhk3LCKWE0HF5VxhUueXcMV50HgLW4kxhAHfBFgnXi+/6OyQHh9ZOrN6T6zPmqkU8zKs79G7RC0sKSZ0YLCeZSxxoLNwkGeHg==;31:SRMNQXfBqN1vrk3YMUvGBy0s/qVFNvnAk/XGU9uZ1lNR1v6k1Fn5aGuT6bvDSR0hw3O591R0aHUKPnBns3yPn/4hIVerL5CgGEcu6a5hfifgH53zKDKwW4E1VCF2NJ6J014apRumI5QFM9QLUk4H/wr2EBlBHVSxygxaMWM+CZMNIiZ23joC7BYHAgRoQ1clZHVpEcQwyotI+AVoePWf7f7msL4umdPiG77mKx1fvZg=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:XHYe5I5xbUYyEL2y5UhKiNypKw3ac4qXfiBcbl8dnPXFESXWAjSO+cnBfHu9He/QtDUaGb7DtC7XnjTGRnClr0wrCXzgwIrZ5EJ09kxYjXSS8NtI9aEabga3uaHPdC26ZKNjWio76HjjGX5VWPhMSnCERW7DWN51lEiaGXi4nXYwGY/o/qKGNosTwalb9gopABuUf2m9FhUR/jsOEsnXx7otOt/XFoP6TO9sBVd+68gOxC9lYCaVhUfo4OcGAL+6PneQpLkqKa/Ip04r5fTGv5hrI6QoMQgelUQug2HuvPl3fqRS3iyalg7FDE6vFSCi7Qrax1dWRZwzgZmY/bMoDBtYrB1e4yG7tqVOnHRNvlsbl6n5GH3dhjmR7eBwRKfS1wrqV6vTrXNehla91eJXKC4ASBUgLL7xByLTSw4QuxIVlO6L1we58kuDs3x/gy9LYkxzM6r7KqiibRVlKpOsL7PouiZ21gruJ7OT7yY9guuj/AOHfjb0ZIjxPQmNZPDe+ql6hr4dLFao/9Vh+GLw3ZTFn1vdJqVfniH5bPSmwGnCKHzEh1I5BVVAtMkQkOIeMdX9n46fc1gpgaBLWkW7HhVR879Y9COz9oIVaqCIJ/I=;4:8CbyI/etcvG7nyg5D7u1bDGJj1mx1mL3fqWWZHrBy3KLSQ5hACZX9isf8ny2UcFKYymJ4wEP9tyHYMXRALB4nb14fyhA8EpJwUGG1kdgd3+UFjur3uhIYdAqFOvlYoOETFrzkdFHWiAVOeNN/L26wVzNGLrtYuKoRzbKxT8pAj4KKlLwvXHRCV9MSavX+OIQjQk8VAeXFYYr8Wb/nn8uuaGfAnEqZuaOkvGlVKbELDmJkJ8mrlN0sHfM2fa2RM5VR4gMcfDEW+GGPnlFqMCikEclgqCjbKD3U3LOnmmcnA0ktOs4vcydzI/3E5JMAAae
X-Microsoft-Antispam-PRVS: <CY4P136MB0022C3A0E278749DD52A23E4E8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(377424004)(97736004)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(39060400002)(3846002)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(2906002)(6116002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(59450400001)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(2950100002)(105586002)(6506007)(386003)(51416003)(6666003)(76176011)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:ZsdnzGSBLkE6mgV19ksaRbB1GJdaqtoYdze/qoQop?=
 =?us-ascii?Q?Eu4412HnwcN0uIfA6xidgPsWgaqqcxtp0tBLSbHEYaZu1HylGfsD+j2VKUGW?=
 =?us-ascii?Q?9rkFw+REfuQCBVnL1MdN3KwuVXRjLFTRiKba6Nqo9SdhtbCOoGklpgBfrAHx?=
 =?us-ascii?Q?ROk8xbH4nHBLtqm75ltwKxFbeGctyV8RvyBKShhbjaCdGjqeyHy/38HvC/Qd?=
 =?us-ascii?Q?E1Rm3q1+e+qIFxcPnIbcJL4rqgqRXSlP0wyLvfIpPzdY2JVTnftCd43KaqHV?=
 =?us-ascii?Q?iGSxa8Y73sj5v4XnDz2VAO4vNMPhLgcS2+YLoLwiIm42PfzQcm50WiLLrFMp?=
 =?us-ascii?Q?ZdWO7kqSuryghhtaLhUjEz5I+TE3YrqhhcSzF5p6jw3ejrTYGsdUGEGNuzT1?=
 =?us-ascii?Q?3m9rqMRrOgPbm4IeVrJ9lGYJJEp/MpjCwN7kwdszGpRiWNk+dPI1vceqk1zz?=
 =?us-ascii?Q?iJv9m7b0gpavHHW2BDYVyGhlr/DJz+v8gl6RPpjzprwBAimTL5xAu0Cj3As5?=
 =?us-ascii?Q?zfuWw6y7t27PZumI41VanWkG8TU9vYgr6zkO2uhBXHGZCgO1LVLt4iwbuxFC?=
 =?us-ascii?Q?iDZAyv8cPxw108sEXaW81ZXV4nAGNhaxU+6bmystQOqv8NUiwvLVuCxwBbpx?=
 =?us-ascii?Q?pD8moEfNcdRBDoBFZzIX3smLrRsc1uV7bZSkJDPGegGVwnR5RMs4/6jaB2ax?=
 =?us-ascii?Q?QokP4C5HUgeP/OAhxFttnbMSAl/X4haj+p3mU6jXebdQKmVtEx5Gg5uALkzb?=
 =?us-ascii?Q?dMCZh6LYc4TR12JSOt5i/gOLTlLzTwexHfXm/SEZQEOukTDF5Zb/jzuV5bvO?=
 =?us-ascii?Q?eCbWpn+Qq9ptFMVTP3pCqckTKNuzNjRaGew7ZlFVnSw2NR3aAJrTwecMTYA2?=
 =?us-ascii?Q?A7gZt0vspU7Kr9MmtQAbAZKSxdRq7g0OJGUE2BY2tEKarNrRifPRbRCA6dUX?=
 =?us-ascii?Q?zm1NBKHCUPx1P8dPYPByworyteQ0acVx5r94Adj6K2h5fpItEbvy5OffVw0/?=
 =?us-ascii?Q?khnjJDaPrq4U0gq7IRCRvQAvSCztlCF3ps1UYdpz8FHOLOG06YUfZ2q+Vx9B?=
 =?us-ascii?Q?txDZ39iPgC3l8GR6GFuDEoC89G9h7W1bXDi7YSbqlxMZzDBGU6qZvgnLls82?=
 =?us-ascii?Q?OqFNCyHeENHVnYMXwFSzKfTetbEIU1ImJLsEhai3S8RaXRiLjLntGybou5Vn?=
 =?us-ascii?Q?gn7OZBGkEnMAzRwIi66Q0plNxupYdGLsXCNbNzoTTW5NcCoSGeWUd19rlXHK?=
 =?us-ascii?Q?gdPg2GMfIvKVkLKMjZ8oqYTJQdc4VMc68QqSeoQS46+N3LZL0y1GSyG/gn/D?=
 =?us-ascii?Q?7hVCsSSPaU8kktTpk0CSftLjaxgCQdLnuZ4ODZL9H7goNmu+BJQZBtvr+fwa?=
 =?us-ascii?Q?Sf1dq5N70DlBvF57wnJDASN4/Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:atVBxvbK3jpanOkt49PXPo6pbhB5URGjFI79VujBnegK+b+gsr1uuzB6CS2AQglW5CNDpToeNYJYAgT21byiG0kObeSCfS05I4DpfmMI6MD5WkWK/uF9WYkFlIriDLN/cjWRQyRGb6EuU2oxtsjF/CxnZbZI7gSkOC7xArZub9MjfoE5wV+gp1zRZPAIOYlPkreQBtgCBu8nnlsEBava1ggxwBITa5h2wMZw0pNTiOOE1ltjBEtE/TxoVzgFrqs10D6l08v1e6NRRZ53fiWTtmxUo/5szVFUEIlSZtF73LhrCrOl/2SoY2t0pIr4Sz9/yvPzNPEFIhRG4aZaeDvPA0aSFmT4iaUtfXSL47qJA0o=;5:Anw67b5EuxfDQVIOqLnAl4PjN4eRuult56ow20rVhVqZ7lcx4twjnvcfWl8lhYmjETNtX026r3ie5BNLxw0zGnDkdF9WwHxY9dVPNfspM+GVD36NBj0Rxj4hrxB+3vPPHDvaf8mrYVwqHBZZ+kTRHgx9cXltX4liZ5xwUFTZrk0=;24:5vz5F0L+YzFZrRPHRD6aNWIXHlx2aRiJ9jVDFQP3aB5B6IGObyMIbVWUo7T9NReDnKKCjkTi1IhVWd39LpcthxdWRY45qulcF3PFwgTkgI8=;7:On2OvVU+tqZl/IzOW6F3LhTzD0nqZGs9ziY4tXkcsNJ6ELPuQ1rctyxPXMwO2YxlYAn/6lkTKpCKFIJiftOaBVscJ76ZyhRwi1R5L9RPyAxPbF/EPul85hjPzZ1j3MnydMyEEphweL6GxZSs/bw/dZ/IDwG/gHF2Nz/PdpGWZuLTXVn7B2ZBAiYkU5k9YCc/J5ZtyMHBTGEmG+6bl8+Qc/da29IlbZKoi7R0GluaK5aYyiNdfVthj8bxps0C1Fdx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:44.5462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5e6685-5cf1-4ffd-b927-08d56019f043
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
allocate the buffer for the lower case string with xmallocz(). This
already ensures a NUL at the end of the allocated buffer.

Remove the unnecessary assignment.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..55b7daeb35 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -781,7 +781,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.16.0

