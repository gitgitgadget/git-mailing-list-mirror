Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74AA1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeCZREt (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:04:49 -0400
Received: from mail-by2nam03on0116.outbound.protection.outlook.com ([104.47.42.116]:31648
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752560AbeCZREY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UIAjKZP8k0nd1HXzDBz7ag1hSuO1iZyCCnp3mDonJNU=;
 b=OjNzyzcgowVVGP3E/SxVuDvRtdCsgtWccu5sTm83w+2FgAr6nd752NIGo6wmShHhZ3eEL9O3QGKso7wTFlmVxqOvWXLdVe4WEAl2fftAK3SE+LdJyYofZqSbwBPwRipXvapKhIW67iIUiSWN+Q6e61fv0kzBAB979P5hi7Ydm0c=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 MW2PR2101MB1115.namprd21.prod.outlook.com (2603:10b6:302:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.653.0; Mon, 26 Mar
 2018 17:04:21 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 0/3] Extract memory pool logic into reusable component
Date:   Mon, 26 Mar 2018 13:03:48 -0400
Message-Id: <20180326170351.197793-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1:1060:bd2c:4297:50e]
X-ClientProxiedBy: SN4PR0401CA0030.namprd04.prod.outlook.com
 (2603:10b6:803:2a::16) To MW2PR2101MB1115.namprd21.prod.outlook.com
 (2603:10b6:302:a::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a441d903-288f-4296-42f1-08d5933b9f2c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1115;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;3:VJ0tiELSpJAo3gMjLJWrp5SdfO+vbLopnqngTuePxTIhDV0xw0Yq+0pk9NPo+hlvu3boNQT2rOly3RTV8Mwol0JqAlTIeECmgl/R2ZaijRh0Kt0PW/L8MHVr/Y07DR47jv4HxhGisx6pH6LB3WIc6Yzwlr/lRhLSHBN3IuWefi8/nzqMZDqUGULe4xTprfaW1m5DTr6JbMRpX0WJ8S+VxhkU6pPK1tWR2rF4xxf1bMrYWJki/WD2X2cQ0shR8b7G;25:Roy1KQl7xWos/wZo3084lOrIE/USQOAOmTybBzps5G164yyp2tdFsB98AQ0wlhFZmMgx5Y3qgS12j6Y0fqelKTX60XlcNhrknR9Q/UUI5b8ljCPir+yp3UUCM1mVpVGj2mMSkoa381VgXFP0SeX8xXxSA+JxKSqo1V5DAjC/zrk40lbo4k+FLbz+2pLxirlqJE/Wpo5uX9oE+F3/wjKXENySi3h3DK84Z2N6mRTW2Nqr5NMmLziHc5xHPNC2AY8+Cz+DhDckHYYaoPfEbE0yq3M5yVZSHOuKOU0r8Rnbt7KLMlj9eWtIcSPbeIITnYzaIurHghA2JvKwfBsV+fA92Q==;31:K0T/aMV3EV+3lOfaUP3VPOJKigHAQLFZr+kjPANH0+ZW8xsxDViPn+FZ2CmYGQ/w0GKHv6LaBbxbNkPJredr/gdWTlRkNgVMuMLh6y/CVrntWrZUxYb0B5eT/dP74/P101GNdL/ASC2hy/lsDwFZ5p3xj3rtRAf4WE8RdvKY2Pb4D5NKUDRK5oTkH75RHYv8GuM3T/yrMqVFxxHX3fkqT5vv3snGItb5/fCMb674SMs=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1115:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;20:oD1Bp9wMvQ6AcegV0g2uI5YJcV+OyaNJBpGQ5kQwF72HXLAuIJ+/mq/jcpvg351cSwjgJlbyb2Gc5WTs9v3YFsPigmylCO6H+iu5UEtEZD3HSssnSgjDIgtRxv20YcfJ0GvoVadyZgTFsY0VR6/Ay51qF8wx5IVXmrSQI8FrnU8d/MPIfqwGs8Ppx8iMjuSQldEipLpS92s4vrCZysMczDodn8QsGnhfkRS5+X3ZVK0qR2Sud0+ecycDu6nHfwXA4OuC1yKO/BVkjaliNJdrfo7ZceLf8LR5DqDbdxeV1xDENIBEfUmwvNCAa2J6uoLmw4CRodVTTa4/a0OIpQAAd6SOAa0xXxlWt2xs6Y6K1WZ+RfORIeaGCYvH0Yb7aWS9hkBuYzEB59spmInF5Tjf9sc/LUiJ9xdjqXOWDkLPpu/C3wlJrUebp8b/5A93Cd0gECIncUDYzs5rfbDDfp1TjCQqPH9uzwctg1DziqEx8AFv8vBgvPhgrQaGXiXTQBR/;4:rAiJ2MoU9+JP/1Or9hhc3/m1O6tvUw3Jqk1CBKTz4YIQ4QAM8cwCI/1zOqqDPP1efR07IURNvH92iWc1HLgpXuPgDVIr0MxMIAjCEeNr9HOYUP2+fIPhfIprndcvpmoPAUQ9RvsK+b5TjOMgmh7l6BFaT+gkX8x9HhJquzt/c0Sl8Ul7sy+gpBhKtdIc6wImFfcz6dFIrQK1TDTAQ8S4V5VYuakl5DeF8dqbtgiqxi9ABtCjBaVluLnNvvWdo/RzbVO/63vqVbTANlZT3r1jHuaUT49KisASZFnYmufPTisr7oY/sKO308zBY/vt4sBM
X-Microsoft-Antispam-PRVS: <MW2PR2101MB11158AABC9D2C44362283ACDCEAD0@MW2PR2101MB1115.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(316002)(81166006)(52116002)(4326008)(8936002)(50226002)(1076002)(52396003)(6116002)(48376002)(51416003)(7696005)(81156014)(386003)(16586007)(2616005)(446003)(11346002)(8676002)(22452003)(36756003)(6666003)(486005)(486005)(2361001)(25786009)(966005)(6916009)(5660300001)(2351001)(106356001)(8656006)(6346003)(68736007)(76176011)(86362001)(53936002)(107886003)(10290500003)(105586002)(186003)(6306002)(6486002)(16526019)(478600001)(46003)(97736004)(2906002)(10090500001)(305945005)(86612001)(47776003)(76506005)(50466002)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1115;23:wiuJnny2TJuPQ42rc5VBaV2BCFlug817YM4OR19?=
 =?us-ascii?Q?Yx4UO/xjFBZGp3rY0aygCAXrayTmD97LI91Ltt+YCc0/SA+BE+DVBuPo0Vdt?=
 =?us-ascii?Q?jipf6N0BDemaFrjSWBhWVxFvw+OVc3xsgL/DoxNVj+mWLlLsfj/sqylH+YxK?=
 =?us-ascii?Q?GW38QUjXElLEENQgVrVLyiTi0eDCH3LyLMTk/Lpe93tpz58RXAqzTG/Nn6fd?=
 =?us-ascii?Q?Qp/GJ6DFDc4FqoUT5V2qN9BuHhe1bgkccJ/NgnP8Dl3+Ze15MhHDHJzYu0y0?=
 =?us-ascii?Q?BnZttETHTR0h6rx9wiNWmpkPVzYxfoxqa5wu0MxwO+ll0nvDHZWt3ICjf3DA?=
 =?us-ascii?Q?wIu8Px1iqO5HzciaByMZT20NKgwJGFX48EesHej05nMgM8EkKGLnghxdtHrM?=
 =?us-ascii?Q?m6DP1vYTQh3p6f3vC8SP0xr0GWORYiggNnYNNzzi6SRAzDZNapAez4WCX9eZ?=
 =?us-ascii?Q?TOIwRXFLU1EyNCBNjSpBsLENABFsvj8r662svWXgnvZs161FnkHBKCSBtNvd?=
 =?us-ascii?Q?/zvB4S7NseDDe0UcWrx1A4c/svk4xd95ISR7zkLARW5FQZHKZfLxFR7xCPJP?=
 =?us-ascii?Q?BEbh0u/JKQEMsN8YhVlHs4+YMNhiPlID/c0K9BHGzuGfvIL5UkMNHho98jL3?=
 =?us-ascii?Q?Eux5PrrI4C+TuVmYz7du65QD+83e4/mnZDQEYdzjp/lLrkxu/3G7n5E+/lPk?=
 =?us-ascii?Q?JerqWgXaDnbj5wpdbGbsOc76UywJJuOEOPeehfbj0j9UDtYcDA0GnlkbEUCF?=
 =?us-ascii?Q?+IqZpe8AzV3COSwRSBd2iuwR+PrEqHh3LMZiCJvbFUEKplJRh8wXo/Qm1mfU?=
 =?us-ascii?Q?pqg9qbC4u4LYsh8x8xE2f7881VNFpgv0dvARTjJpAD7ACy1sapb2gwQ7Q0+v?=
 =?us-ascii?Q?5FDNyETQrXOf+A18inKFJECwUcsYmQXZ+KdgNqs4UBvCr3iQ52IfXMTywO5w?=
 =?us-ascii?Q?K1wcdymldapZJT7vjNwAVYFeS2jAFmIlTnVVqFqIy+n13/hO4Sv2gQ2LPZNM?=
 =?us-ascii?Q?rqj1mqrFNXeljm1q68jNUppvpnposgrJTG/pJhxwzCc7a0rioNQ5FA5inpKw?=
 =?us-ascii?Q?pnvBld+fjTqmnsGxgGN/Y19KeeVVODD77gGWhq6MSfPXrDVJRGt0Bf5+8H9g?=
 =?us-ascii?Q?snibOrf4ebyfZms3iCh4WwkQsR6fERjo6pDO9C2AYGjeIfDe9IFK/pWDHGts?=
 =?us-ascii?Q?ndQrHKluftuMRjjsHyWOskkD7gyczgQpyN5onfQ2kuN469fDf5z+N5PcbWHt?=
 =?us-ascii?Q?0ASpZAXW+FgTbPNnheC2Kx0jL7zIe9Aa+DdHoTdJUWKRZMEcwWW/sOup1vdO?=
 =?us-ascii?Q?zh9C0l0mtZI4/mJmSTbFIKkRiNpKW9ZEzv2p+N20WrKmAc09E4xUr5P2MYWD?=
 =?us-ascii?Q?hg8JBZ+jCjAWB86stoQmCF99fC4jSc+GOGchoZsDehf2jbLW2wHKdBvp7zsh?=
 =?us-ascii?Q?weGOFgBS+9w=3D=3D?=
X-Microsoft-Antispam-Message-Info: mZ4wRv6rF3r+2DPNDtlfXpi4FBiUJ+BGI+b5i0gqzl/mI9NER1UZm3zIpHsoaKPVK4Vbc0ovUNAAmuybUh4hhHUqyESoLEFjCGUTzctVj8do1mjE1AA5R+CYa7tum7RgKM5ASc1J04790eUrm1ugTNhwult2bBNNGLVw6Rty7jD49ISDEJ6u4hBJwWfJnDOt
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;6:NPcvUpJog+qH16J3G1AMZbLx7I8rwxbT9tkmEJKLHecXPKzqhxZXlg4wAg/3DB301QmoijQZvSWJjt0QoSHtbrafB+AagUpruFss6OkR9vpnzwBtweE6HaNpm8uu6ELBjMtxRWbcgtSOii0AONHZ1BeDDuCsjXrFPlWq4IR1twxA23qeLQhFBdjOlZLww16MI6M7ENzr1QLzQlOtoWRM4kjNqPh8vJZ89i3yUS+7YzEalE3WMwtDhuh64B4kimrJ0+jn9ElEJHMHYO1R6yr42UdACg0HZsIetOHYaN3Lfk0bDxxPSvxZYkItvADPG6nUbPgn67vKZQkykCl3H68TN3kRCkeMQPtctPQkzwQPKQMdSc6d2YZZMN36pUoNo5kk0RzgjpnY/bjBGHlljUcqD9ixFBZ4naOUEQTKuUV0Y3BRgeZjaI4ufA5yrwy5QtnhC5g0QRnJyzbUOe81WbjoWA==;5:EBu0oPwNYyj2vRHX3IewTN0atcg0Mbkn4DFPkB6DscB7SC+IJU+M8NfhSjnZ+YjefO4Gi/+vbxhNyDPQzdReeZupuzV1DZO2oW3BjNXk0iafNmIY1MWV+IcFPkWrMM+mv+DDIfBx0uoE2ZNDHS0A06NZR8oIG+ukCodilL8BpfU=;24:7XutwzQcB2r4eM0Z8XKlA5nPdZzPY68CzmrzJwvjSfarUlLAKWk3IjBCm6Pnf8rqYoaVRfxCuTIXyRNNCCGzqQp0tnmWW5zD6moKrpY7T30=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;7:axcUAdmu1ScCTsfZkkF7xHci6Xk0wkJcGE/Flkph8odxzOjNc69oxaKL5w4H8j97z4SxD2uhb2jebh2GFi1jKmYIjUupDpTOQyNK1F1jBE6kNzpVQ6A1No4pwVx+k2Z9ynBudhixT9iDKRetHVOSDp3peXaoucQlRCHsGas1Kw3gI1QpNZg9f0Zct6b1BEutrYlBfM/CvVYJlCQNREHXRRTpa5RgGLL2lVNmiXQXe+qsCmZDwBiZlOO3Agl0lchG;20:Qez2PTCmLVckroBxMRKAbZnNFnl74ycApsCNPCgV2vtxK7KLPneSfHmwWIGEEam2eGQfejtFK+FJ9IK4+GV7Ip58VIVqfKryg0UooIcxLLCGoqNDbBwJF43wtIW2QJjhDBOh+WV5+idV9YncVjO8g9e/lPkyrfW4zuaD8VxqLko=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:04:21.9570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a441d903-288f-4296-42f1-08d5933b9f2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2:

  - Code Review Reactions
  
  - Lifetime management functions for mem_pool will be included in
    future patch series

This patch series extracts the memory pool implementation, currently
used by fast-import, into a generalized component. This memory pool
can then be generally used by any component that needs a pool of
memory.

This patch is in preparation for a change to speed up the loading of
indexes with a large number of cache entries by reducing the number of
malloc() calls. For a rough example of how this component will be used
in this capacity, please see [1].

[1] https://github.com/jamill/git/compare/block_allocation_base...jamill:block_allocation

Jameson Miller (3):
  fast-import: rename mem_pool type to mp_block
  fast-import: introduce mem_pool type
  Move reusable parts of memory pool into its own file

 Makefile      |  1 +
 fast-import.c | 74 +++++++++++------------------------------------------------
 mem-pool.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    | 34 +++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 60 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

-- 
2.14.3

