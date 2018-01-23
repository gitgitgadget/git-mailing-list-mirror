Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480BD1F576
	for <e@80x24.org>; Tue, 23 Jan 2018 10:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeAWKTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 05:19:10 -0500
Received: from mail-by2nam01on0139.outbound.protection.outlook.com ([104.47.34.139]:44180
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeAWKTI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 05:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IIf+Qpr8X8LmkZhU3//+JjawGNAw6LNz4/UPmPtJ8sk=;
 b=OFl7lSsatGi4v+sVge7cji0V/mnBCvR9tqYzVU5rNGJk2NWw+BLR6O5z2YmlpYADPJwOwTqmcnMnsPQdVBWcL9rMgE0srn+wUO2549MSeXUkSPo/M8CRG4FJcVzxSOFbOAJlYyE4aIvDuk0GcRQtqzNS5O3Y+pbyvUPzZSZ2J9k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.428.20; Tue, 23 Jan 2018 10:18:04 +0000
From:   lars.schneider@autodesk.com
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        simon@ruderich.org, j6t@kdbg.org, larsxschneider@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        sunshine@sunshineco.com, tboegi@web.de
Subject: [PATCH v2] SQUASH convert: add tracing for 'working-tree-encoding' attribute
Date:   Tue, 23 Jan 2018 11:17:39 +0100
Message-Id: <20180123101739.72232-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180120152418.52859-6-lars.schneider@autodesk.com>
References: <20180120152418.52859-6-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1P189CA0033.EURP189.PROD.OUTLOOK.COM (10.165.188.46) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b4942d-7234-4695-078e-08d5624a97eb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(48565401081)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:LpoD5jhA0B44csq6/4rrVjSHwD6x+i/CqyEjy0BsQtD9fnnZ0j0fVGbErhz7j2LwUY0pQq3czfSR2h2I2bjv2OUeiw4bMYkVMSa89ZNxlhtYYrcP9z9HFJxk2erfT28SsCRd12a427dBhfwv4FtTcAw21RH25UyFl++AJt9Xay7G9S8l3zrYLyQLrdm6hgmGisetj6gM46oW75cWrFRVQPKDG8gA1e3fdt9y+oYH7HZhBN34u5RTAvfRJzkwCG9N;25:DNR7VK8uqZlol4W/cvOk1DDafuQwJL5CH3jyR7I22KAdxTDF2nuuQ1GvpzWdn+SDUkWi6s18i87oTRrWmgH4kuMI4aSKw0e/gOm56ifBUUPxnj3JAmuSUDDDsJtMDms13RGwifyne2jkEp8JrgengNGwc0pcUS3KwVAIEAkhfbNLxit83c3ZHFXVgIbHS+meecWWLv4bLGRrpr4DQ2+SrSjoo4A+eiGsbwSALMmPO3bK0b7snRcVnASNT1KIXo7oozjS4DK7r98L0xAvGWLP52jhwCPk5/f5n4jg969zVI0TuC+6mBQuJmNZA1taoV3Z4qyXSKRFjLfrv2XNcpSLMw==;31:iRpW9YTMDJ2NlEv8k98nB7DqKDQNsjndXdkq6a9u1q5GVMwQB89JVKvGFrtdMfAQupKm1tIEr0IP+OQXIeBnCkHyVzThU5uZ3QIEEJ7qoo/6jRS2MfvLfZfaG00iRuQ64x+JpB4LEsUXEgKvcSwPKKDPXjFpCKTpQRH9dqpjte7anjKs93qYhsw2tdwGM7Lt2l5iTl+6UDX5Y96eYYGa1qYJ59Zx+WrrEI9fJkcDh9U=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:J//CPu5ryVNFROLbBJTDIKBS6KMJ6R/m+un8VhoVrmUQKw/iBtDZVf052y+1p3dZ86NxEcCYR0fli+I2KMEbsnOFpeusRplSbFhcKS4CQkTgJ/qfk7PKMwYyReHz4xDqaNAn7pCF/f/A9r/ttEwVTyhv/lBe3WPDTUBEJjuXStitP8/7jeE0pP+zk93lrwKJ4S9Hs0tsO2wncDZzgUAN3NH294/zcWC/hLa/1gEhexstMW3cT2NopaMRBVXR+qGod4+8iSVpMP064+yZ2N41+NItOfpwMXS9+eIYUnbIaFc5FMqOXhoPQEZ7LkkixPEOgTtl+LKZZiyMI7+Mji2xf7T5TC91BDxJ8sGobpJE82FvYr00Y/7rV7kBZ1swEXkjoE9Qs9S9KvSBQrJPr7IdhTrDqByyCMs/1VQdS5zP/814bsIozCP3us+akUB2y1wmkhj2Ly1eRnsoayEYdC7NrlEpvrH/ULHt94c7AK0D/aMiOWRV2wU+xIRLwFQQK1Rqpry303dz/py0emvwPTzA6TjWbu9e/bt2mf12Y6A/I+e8aYU+O1ArblfpX9y4dGoA31WqdYZXgtcdSTgEYed9Fuoaom9INSvGmJb2VkUGphk=;4:72EXkrnSptsgNix/0zkUYFNfXamIMpNuBcHUmENuL9sVSpV1VfJZBVcsDsMaRzYkh48z0f2C/NKgVkmbPZDMIGHTmOGGUBYdW4kNsAfR/KYTSY08n8f1c4eanqIylhIhRKehd6j9DUqAls38sQa1K/y/EeELmOrK2OqJrMajaLrYNpNYbEye7urzWbNZ/5q6zrhh1CYNDDa7YE8GGMGla6dWDQ3okmwGV6altgvxPOQIXlnXqhcTJKvvBF8s6N2CgspHhAFliqM0IA+dIfrI3GiAVfdwIaji1JUx7YvUGC6P3nyJFeN1MGXeHnmRduZQ
X-Microsoft-Antispam-PRVS: <BN6P136MB0020E4975DAB84A7A49D8D62E8E30@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231023)(2400081)(944501161)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0020;
X-Forefront-PRVS: 05610E64EE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(199004)(189003)(8936002)(2361001)(47776003)(7696005)(50226002)(86362001)(8676002)(7416002)(5660300001)(81156014)(81166006)(66066001)(106356001)(39060400002)(6116002)(3846002)(76176011)(8656006)(16526018)(52116002)(51416003)(386003)(26005)(97736004)(316002)(16586007)(6666003)(6916009)(7736002)(2950100002)(1076002)(4326008)(2906002)(68736007)(478600001)(48376002)(230783001)(36756003)(105586002)(50466002)(53936002)(9686003)(2351001)(85782001)(8666007)(6486002)(305945005)(25786009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:xC16FR+pjSSdhPY50Et94ckNrXisUuj/xcl2KIm19?=
 =?us-ascii?Q?4U5PuxPzc5Gsi6Ym7L0uui0Hy9Nt8gkb+FV0H3dZQTuJX7Sw0Ac94IkLrXWA?=
 =?us-ascii?Q?ylhEGHpD6YbUh3NeipukA2lRGeWHybaHhHpS4RSnOjx0badcM9ttHb08jTOS?=
 =?us-ascii?Q?r+S20K6sNJuOyOmj10ZHAhyARIeyHMK/jdnnXQziMlMRr1vEeemUv6rD836+?=
 =?us-ascii?Q?iIjkG4BMXLIecHlce2sF2/WZHkpSQHOjrejoynBjLQBV9yYil35ldQ9xV0my?=
 =?us-ascii?Q?LdndslekgO6PEWFp74T3xDBaAOkDApM8XhOgwHt+rXvz1pdfFjm1/gyuGJs8?=
 =?us-ascii?Q?bEak+7GWZo4t+A3cM+scZjUEzVEoJwu5N/JkPnMNFCWEskobNcCF0gOiO40o?=
 =?us-ascii?Q?ZI+7oSOKMnd2trv2J81vNfNzJTZS3vTEVO33RskZo3ev79DMLoGu6M9KOAXb?=
 =?us-ascii?Q?83LZKRKTO092aZJMUstMC0SKVfol8IeEmwHVt/B12BnUrgRtl7rUuOQnATdX?=
 =?us-ascii?Q?r+8gAe9CLPTGrFK59K6b2KdhOrHtaQXT0bfWMTruW2ooPCMNnX5WvJCHtITK?=
 =?us-ascii?Q?n6WD8ec/9L8GlHa+uFiI1n7xb4Ndg7BYknUcsoRuY+Ku75cDR+tntaIRuiHI?=
 =?us-ascii?Q?eFd+FY6osaPiDAlJBr0GOl4CcRpgv0eNevK35fW5yokYHp0SdEx3DbAi6Ng3?=
 =?us-ascii?Q?FGJilloosqzi4eFCoyfmjXGnklqfycI+0iF7CGr4jtFJ1JRnBRQnOS4gD323?=
 =?us-ascii?Q?b5eou8de5EWOpRK6G30uXlTlVAY+FJ+OIWyK6Hix+fQVxYU18LZ1TWvmcFlP?=
 =?us-ascii?Q?OAksZ2i6FRFjgCgqSTfEHisnbxF7rxmAXEA/tUd7lpgLrB6v4cU5wtV+A+6S?=
 =?us-ascii?Q?vbrt5PagMihtCCp01GOh6IDC+twTIrLwo5v39yEgzAQX32Ago1wm7JJpv364?=
 =?us-ascii?Q?d6PzwFH82KvbIHt188X90A7Q7p8A/K7PUYgoSd4qvE9qHhhstiXzVRYU68oV?=
 =?us-ascii?Q?PSA+k/4RPxud14/8zk9Bq6zRO9N85BMCmHXciI5u4fGpVaumkjd5RSgbTnl9?=
 =?us-ascii?Q?20UDH0NoobqiSWCkWt6UufYQu7QQS38Xg4wWtebzfuikhqoemqitzoidTkxN?=
 =?us-ascii?Q?PJy1N0bEvoxJ8V8hz8vdUSKqoPNCLKm/XFrnoQj2vuynlfJMXVkREbYHGL1l?=
 =?us-ascii?Q?t/3grXy8i7tRjb66k4H4R3EwUyxgtHKe/z23NMnXdJCPmCkV5R4c4UlG4eFH?=
 =?us-ascii?Q?B2viDvrBz0v/NK54rBbnTJmkdQTkJGnqx9UJA5FbBU297Y3/6t+gjU0C+Hnj?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:w20hX2onQuTKCk5eLkXxU5vhu2qI8RvX7gcmda6hffqF3IIMy3dMJEY79o7u77aCZ8A6eub7NvlC+eXbzqzcPpGyxIPyH1HbY8JcFixW8ei8w1ekTs9hG1seqQiul+hYN4HbnLQq0d8Db3ORoXvnhmYMq4EmBXeaRRRNOzU9K5Tt/Y2TeWm0MRkiOr6bd8CgovmhTG51knZGYWuGWirmIM6nMLuMwjwwr7Md8b8PA0RQEwy/41dqELpHUHQnx0p0UGvacXqZ2h9oAlHMYkFWnkHJYqCygl1SogZBrz9BUge+aAUOgs44AZB36lOZyGNpcp6avuTI2oo3eRiC67mqbJjf+E+ITZT2JjXMbV9NC1o=;5:tHzkMR9ctFEUPkBMgsO/W2OPc8U+h6uA70xvqh15du3+35tS6gvdSsapeW/5/LEv2GMEjKFAyLQOuEnTDBQw59MmFEFZf3xvH6VhtyWo/udTYlVUYGn7bkymA4be2bkdTplRwkEC9C6uumCE+oALqwHdJxWPo1Xn8EsDqPTrdbo=;24:SNeNwhlHfcGx34TH3MOWgUUA6/nm8IUUIgfRxAOc9tgSIHjFIohLos1wQGMmTwl7S2McZwUX+UKjjOr6CLG7LwvJnXQmC4IufaEKKLR1MmY=;7:1LmaTX4yMvJfYz011UCyus8NzlnJv6Tngu7v5lzX9A0gJKNzIIef9qaauvMXF1Cee2nGLc9M74EdKMntvpVcE6etKnW6AaRBkezlss0I2NrFfxSyjzsJpOeAhkHx7umy8/d66MNz6oFoydPwPBjB88hMjg44HQI7tlR4KqLp7QYHiHntISz2CJUG3Nz4lJFKlPZHfwcRehnYeTUEYCMi+DeOqnrKNlJ+/oZ+NYxDEPGdgxNXSrguJcki25oA3dzi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2018 10:18:04.0688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b4942d-7234-4695-078e-08d5624a97eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi Junio,

I overlooked a typo pointed out in Simon's review. Here is a new patch
for squashing. Sorry for the trouble!

@Eric: Thanks for spotting this!

Cheers,
Lars


 convert.c                        | 8 ++++++--
 t/t0028-working-tree-encoding.sh | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 13fad490ce..dce2f6e201 100644
--- a/convert.c
+++ b/convert.c
@@ -1165,8 +1165,12 @@ static struct encoding *git_path_check_encoding(struct attr_check_item *check)
 	if (!strcasecmp(value, default_encoding))
 		return NULL;

-	enc = xcalloc(1, sizeof(struct convert_driver));
-	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+	enc = xcalloc(1, sizeof(*enc));
+	/*
+	 * Ensure encoding names are always upper case (e.g. UTF-8) to
+	 * simplify subsequent string comparisons.
+	 */
+	enc->name = xstrdup_toupper(value);
 	*encoding_tail = enc;
 	encoding_tail = &(enc->next);

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 0f36d4990a..a6da61280d 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -22,6 +22,8 @@ test_expect_success 'setup test repo' '
 test_expect_success 'ensure UTF-8 is stored in Git' '
 	git cat-file -p :test.utf16 >test.utf16.git &&
 	test_cmp_bin test.utf8.raw test.utf16.git &&
+
+	# cleanup
 	rm test.utf8.raw test.utf16.git
 '


base-commit: 21f4dac5aba07a6109285c57a0478bf502e09009
--
2.16.0

