Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F591F442
	for <e@80x24.org>; Thu,  9 Nov 2017 14:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbdKIOSP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 09:18:15 -0500
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45724
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754955AbdKIOSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 09:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ON7UDTgyOaTOFfFW/ZVUGRL1ZEByLY2l2bVWn8Y2zJw=;
 b=L2b7WLC21415tsD5GMaLD8vibPOTxxnRE8Aav/cAA9RdruiCCmYVH1MffuLBs/4JM0j8oMSmRdr736IdGzHElebqBnFpLoLOXdeXFaqxViwiMytvrWQHZyZ8GNTmsMDyXxVNcwy+MbhWUSgP+6BB9ldxAYy1sLjJRkAbJqBsClg=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Thu, 9 Nov 2017 14:18:07 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 3/4] fastindex: add test tools and a test script
Date:   Thu,  9 Nov 2017 09:17:36 -0500
Message-Id: <20171109141737.47976-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20171109141737.47976-1-benpeart@microsoft.com>
References: <20171109141737.47976-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR13CA0015.namprd13.prod.outlook.com (10.175.123.25) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9bf7502-02ae-411b-e28f-08d5277cb3b4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603249);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:VWXJ8w57JRq6WNrQbtilrGOZI77L9PfCTcITfkZfpGcN+K/J3PZnRMkwP73Zo1N+gO15AqPvABR0QrqfNnxjzs55Y8K+04ydsGvdjdGL7ETnNn6hcvn5RSkMCPMmpgABm6k9/Ht2ZgNqgeqrlgQTjwNZ8wjuJ+7JEwG4Wx+jchNjFcZGLE8vQSjFaYHhh1Kr/7aYYoc3j8oPVAAu6Yq+jSYSARt6Mndm5Th9gGfvYlsxss2ggoYGGpkDqE6SsS8p;25:fxLTA3DAcAXRSH9IGeOoLpnXJjG3KTrjHOQoATR6M0VwFV1O6PwcRTW6X630DWlnl0hXon4HF4dqxZRfCuclNk67Y49WtQQozVVAungA4YA9QVVT/lzjRBrh1iDBs21TdtZQn3g4ZVe2GlrOfQNAouSGLFCKig7lgFatQW6CdAVPqbB88hlte51IBtOt+2zc0FLBZNuMFBdnFQ84GIe2NUEuaQuFJHv1nZ/bqpvGlNdvQ+H2J/hVfgMUaVS92F/AvDawUM3salt0OEp2jBFWaVuSI9fwXQwDx09HeJ+jOmWxJjKq0ks8jSMrhgBpnZpdxpHXc0gE4DmuDOXvz+aMaA==;31:OedjbRT+2dzNbUArUJ+jyqmmN2PJY3YvbFutTWzm+EsH1VoAefmsbFgAWINzaEuZ+dLdHmjmw6jWos65FfL35H0FF+M4uZs+BeGUsztyI84kTvMHcI9fE+0RT4Ijtiel6Be71Erdk2nYLLrZsC69mFQKdkNI/go1tnEv0SIYcRidjE8uJy7E4nOPXCk/bXgAIrrm0Tncz12GDtjPToxoFSYqOCqEZI046oIsBGBFiTY=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:VRDqq9yWr8HgWP0EnRiRf94HaZiqGktOtSBBH7iqGrj1eengJWKEzvehRz4wy/hI3hJdAIKiDCB7mIC4hHxIR8BHScX1HoFipTVu5Db1ZXM52XllWQ+4eo2PLKfeuRoFuNx90AjZwd4Hl1Co1NkTZYTSXNsZqPTSmZmCey0JQF4YFErhGWecALibE1QWJggnZakmzVtykjAVhyvsxVqWLC2TzUEC1FvB/OsfUVZL1AGDMKjSIu9qAicblzFX75mLg9h568fjXi6HLehiKPCrtTKKv6gIDtdNI95IR9ByxkfBCj6m8YrFHSBHTLKxaSHt+PCb+u5OP2h8cFZhymom/OVBc8mDluHdi42Je0Doo+qrlQGj1uZCRq8NJl08VaSIw+yXqk/nVP5xx/0hlMIj/vEYwhYW136qixSYEjxNZkh6ZIojB/zZCS3oxcfEcU+i/1vGyc5XxQZcM3XOPoNHjjsfaVEl6hrOwv6vE+I+kiE+leWzNmXZd9+VmXcy2EwV;4:EDZbrhxxmKHKh1I5dhzyRWF/rZwsAv03kE45eRd7GKj0gJYsXshrmNuaArCSjEn5djMCx1BFfaP1vv8gAJQ3pVPCCRgJIcTMRKguPC4oJmiPX4C2yPwxu7haFyeHMaqD5vcmYDQQ8xNdRRANLFgBw8bcoKwEepXqhI3f8ht25mrbV+fNdqpWpFqAV5vJBDdVNT3vLyGgClIaac/ZGJSY+z/yWWtoVv2Q/64bF7hXEZ0TjlUYtYVes73S7TfkvequSee0BPqjOWJqu/L/V0IRHAtNZpm13Bfdx6lTgrtQJq/DqZCXM45S+WHtdg2odwiD
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04713763CFFD8A9E0D89C926F4570@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(3231021)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(47760400005)(199003)(189002)(5660300001)(53936002)(8656006)(47776003)(68736007)(66066001)(48376002)(107886003)(101416001)(50986999)(4326008)(6116002)(8666007)(39060400002)(76176999)(81166006)(50226002)(8676002)(7736002)(16526018)(36756003)(2361001)(105586002)(1076002)(305945005)(106356001)(81156014)(6512007)(2906002)(8936002)(10290500003)(189998001)(10090500001)(2351001)(3846002)(478600001)(22452003)(16586007)(6506006)(33646002)(316002)(72206003)(6486002)(5003940100001)(6916009)(97736004)(6666003)(86612001)(25786009)(50466002)(2950100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:9VldyDj7Yg7/evCUGkH3A9Tj/7GZAMaiu88uVQxMH?=
 =?us-ascii?Q?Wmjs1+pE+j0H3j+21HFGUKODD8mqJuBhhBulJPahNc0cdhMH5+LNGTnz3ikm?=
 =?us-ascii?Q?jNiRmmRNCIOkCWKv5wBJbdx6WtXd8xcZCCI1fq5ctrYVce7dPxpkpf5NY0O8?=
 =?us-ascii?Q?LLwUS7n0nKEhXNju8XQ08HQilqnAtJewKSZdjbAggHn4osX/jkisTFTw9cuz?=
 =?us-ascii?Q?OAMpAUuhiATEhahZyKcIHtgFOTLkQU1AgpHZ8YEvqMzr/lLmjYuJd+b2woru?=
 =?us-ascii?Q?P3+Jqa1LnCogQg30vJfUsqTK8UEHM7Ty4pdfUgmLbZ2WzjCVQv4td8xBsUBP?=
 =?us-ascii?Q?8FA1diwe4hhYRLi6H6ALPF7sPGqpFbqVQVWDGsDHePZZjBYmzaZG2eROsaJV?=
 =?us-ascii?Q?1NGnOI233jC2QUiPdjdjOpo5ZJL5hGar09z/Vo+1xb/AEz5ftEUVeUdmTNzY?=
 =?us-ascii?Q?T8EtFT+1U0JiXko0vjdZvEIUuDiVSh0z/MH3hvyw1Fe0qRryZvU++P6hMZTf?=
 =?us-ascii?Q?4BK/EArKsoxJPuS2gvoBpRCm/Wg7OQ+cS6QKdwWEEvVhjx+accC/EkQJt2TI?=
 =?us-ascii?Q?ipzxa2Qm9cfATpK+OKQBS7rWqZdUMrQpJf7AUMGo/TpqZsbfXEHAjaKGUD1P?=
 =?us-ascii?Q?YHaF53fnRELiqZI4BtDbfQVTcvfhdPO2vMMiHDcXn/xVgye6eo39sZMsOoAH?=
 =?us-ascii?Q?h8tS7ZI8WLl7gRAU8lnauLns8ES0ZysnWJqoVVRt5+Q9cjJDNu2oTskoucVs?=
 =?us-ascii?Q?hZ9IgFI7tShu43y8a7El8Pl66KCIahzFg4A06j0FeZR6Jon2zWU94Zrpz1VZ?=
 =?us-ascii?Q?eN14M85i8Yd8wpMzRrmn6EJhxrMpyDOcxOCPRPPGyVyLtBhm/KhcvKVpC/IH?=
 =?us-ascii?Q?+i4v75ujQd+tWP2Rp0C9Z8G8np9mUPzrRHCxp2hAiveSVmYjO5NWQoaVsZlA?=
 =?us-ascii?Q?B1Sv04++LHwxaW3XS3eObVN27d4SGS6qk0wzwOK6zONc52dPK4L8k3sUvARF?=
 =?us-ascii?Q?yoiV2nM4uBbPr1ZXIahbsz0AxazAxqdmSdGOc1inwCGu2Wugfzkb12lZ0WGz?=
 =?us-ascii?Q?5jifygpe9YP98X0ixakRzxBfoG6BY6zrbnMHAsp2Xts9nA9/aI0RiPTOS4JY?=
 =?us-ascii?Q?IGbWhebdPKYFh5zfBQ5yXqz/HdPrk55O0pC8+Vo/Ifq4ssD3o/2uLts1mtB9?=
 =?us-ascii?Q?ZMCae7cZgwbXX1r1+5xy3IdmZ9SxZe5MmHRY3aGtsEZTXbXUnZ03/DhIbmEw?=
 =?us-ascii?Q?SukN0elPUHpX8F5mPxGdGLAIHr97n0zB6VSphPT2svXqxtBrvVPwggbW2cza?=
 =?us-ascii?Q?IXEiDS4hfg3f3Y2n7oPKr0SUJJ1ljTTH1vqtkAcRpTcR5Buzsi8aIDQ1u6u7?=
 =?us-ascii?Q?pS2khnwYYDpMYz0PCqL2pOhPUxVk5FGUHhJiEJg4KxZpkSS?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:M5/R9BzfgHCClqsHCn0CUaETdPMA1dinnAOYTsOzAaAyC2lRzeLZjza0CSvCnA4WHm0xFj0S+ghSuaeKxFXUMIICuKbVYW7l/QvR8+pOBT709PMEV5F8cBGp6EyoQJNhXadbroPu6kPm+g00igsWmE1cITevJY7B/4w2Lp1Qf4iMV+uLk/+0RwIYZay3EcB0IR1EBzKQsaKiNow0o7vPzDa+CJt8+hPNIvo8WyTtdPhsEHHSKfN8vGw+D965iYJFvliYsekRRhTAXRPu8bWmo74LbXTpJ3X/HhnZp97bwB7mLVWNL5ZftwniMqMTP9a11VK1WG1mifN8YtmZBrQXcW1iXGsIQKjFoSSMXaxKqo0=;5:jwobdYnLNaJidTwTuBCo0AROtFVElQiGuIozbspsa8yn1nrEgPH9V3g9gPVyT3job9iDmAuNBZsHesZW0i+2kM6STN7hf0xxuLGo5SXqK0HO299Mi6N/gvGZxnQFddEA0Wue00q+3RkmL29wc9dGVNDwdjPYS3eonwsACRp2Vug=;24:aTFOjCdrtOFj/UHJjCrv8O8MrYhBdmAn0AR8GgYl2TYRC4GHpkYUhcTdGXfiWdTBCMIyoOC+GZMMyg3SmXpvYCqKQUaAqmPHINAJEjHNCWg=;7:E6GabXz/Qf4tW/JGz1cHhM6TttOYbSX8F/xLJnUDbozzdAKJcQmXz7EF6TXztCzVvplyeHlTBETSf5hSdmc3UOfxebOjawvPJGBx8JM2Zh26fmsnHIQ5PUhUwIxH9dV2QW1/EV1NFl9XvOABjlRAnGf3iMVD7ARRaq8xI1nVLM92X/QLNznbOaYIXxVMFcNcvlTk/7wkQ1x96p8wap6xjvj7sAZy9EifC5oCoXTv1Bxw+6g8nZkNkjmTyHvzuBSF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 14:18:07.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bf7502-02ae-411b-e28f-08d5277cb3b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test utility (test-dump-fast-index) that dumps the contents of the
IEOT to stdout.  This enables checking the existance of the extension
and the ability to parse and output its contents.

Add a test utility (test-fast-index) that loads the index using the
fastindex logic then loads it using the regular logic and compares the
results of the two.  Any differences are reported and an error is returned.

Add a test script (t1800-fast-index.sh) to:

Test the ability to add/remove the fastindex index extension via
update-index.

Verify that loading the index with and without the fastindex extension
return the same results with both V2 and V4 indexes.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile                        |  2 +
 t/helper/test-dump-fast-index.c | 68 +++++++++++++++++++++++++++++++++
 t/helper/test-fast-index.c      | 84 +++++++++++++++++++++++++++++++++++++++++
 t/t1800-fast-index.sh           | 55 +++++++++++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 t/helper/test-dump-fast-index.c
 create mode 100644 t/helper/test-fast-index.c
 create mode 100644 t/t1800-fast-index.sh

diff --git a/Makefile b/Makefile
index cd75985991..a7df82721e 100644
--- a/Makefile
+++ b/Makefile
@@ -647,9 +647,11 @@ TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-dump-fast-index
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
+TEST_PROGRAMS_NEED_X += test-fast-index
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
diff --git a/t/helper/test-dump-fast-index.c b/t/helper/test-dump-fast-index.c
new file mode 100644
index 0000000000..4e6d28d660
--- /dev/null
+++ b/t/helper/test-dump-fast-index.c
@@ -0,0 +1,68 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+#ifndef NO_PTHREADS
+	const char *path;
+	int fd, i;
+	struct stat st;
+	void *mmap;
+	size_t mmap_size;
+	struct cache_header *hdr;
+	struct index_entry_offset_table *ieot;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int err = 0;
+
+	setup_git_directory();
+	path = get_index_file();
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		die("%s: index file open failed", path);
+	}
+
+	if (fstat(fd, &st))
+		die("cannot stat the open index");
+
+	mmap_size = xsize_t(st.st_size);
+	if (mmap_size < sizeof(struct cache_header) + GIT_SHA1_RAWSZ)
+		die("index file smaller than expected");
+
+	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (mmap == MAP_FAILED)
+		die("unable to map index file");
+	close(fd);
+
+	hdr = mmap;
+	if (ntohl(hdr->hdr_version) == 4)
+		previous_name = &previous_name_buf;
+	else
+		previous_name = NULL;
+
+	ieot = read_ieot_extension(mmap, mmap_size);
+	if (ieot) {
+		printf("IEOT with %d entries\n", ieot->nr);
+		printf("  Offset    Count Name\n");
+		printf("-------- -------- ------------------------\n");
+		for (i = 0; i < ieot->nr; i++) {
+			struct ondisk_cache_entry *disk_ce;
+			struct cache_entry *ce;
+			unsigned long consumed;
+
+			disk_ce = (struct ondisk_cache_entry *)((char *)mmap + ieot->entries[i].offset);
+			ce = create_from_disk(disk_ce, &consumed, previous_name, 0);
+			printf("%8d %8d %.*s\n", ieot->entries[i].offset, ieot->entries[i].nr, ce->ce_namelen, ce->name);
+			free(ce);
+		}
+	} else {
+		printf("missing or invalid extension");
+		err = 1;
+	}
+
+	free(ieot);
+	munmap(mmap, mmap_size);
+	return err;
+#else
+	die("ieot only supported with PTHREADS");
+	return -1;
+#endif
+}
diff --git a/t/helper/test-fast-index.c b/t/helper/test-fast-index.c
new file mode 100644
index 0000000000..fe63130ba0
--- /dev/null
+++ b/t/helper/test-fast-index.c
@@ -0,0 +1,84 @@
+#include "cache.h"
+
+int compare_ce(const struct cache_entry *ce1, const struct cache_entry *ce2)
+{
+	/*	struct hashmap_entry ent; */
+	/*	struct stat_data ce_stat_data; */
+
+	if (ce1->ce_mode != ce2->ce_mode) {
+		printf("ce_mode: %d:%d\n", ce1->ce_mode, ce2->ce_mode);
+		return 1;
+	}
+
+	if (ce1->ce_flags != ce2->ce_flags) {
+		printf("ce_flags: %d:%d\n", ce1->ce_flags, ce2->ce_flags);
+		return 1;
+	}
+
+	if (ce1->ce_namelen != ce2->ce_namelen) {
+		printf("namelen: %d:%d\n", ce1->ce_namelen, ce2->ce_namelen);
+		return 1;
+	}
+
+	if (ce1->index != ce2->index) {
+		printf("index: %d:%d\n", ce1->index, ce2->index);
+		return 1;
+	}
+
+	if (oidcmp(&ce1->oid, &ce2->oid)) {
+		printf("oid: %s:%s\n", oid_to_hex(&ce1->oid), oid_to_hex(&ce2->oid));
+		return 1;
+	}
+
+	if (strcmp(ce1->name, ce2->name)) {
+		printf("name: %s:%s\n", ce1->name, ce2->name);
+		return 1;
+	}
+
+
+	return 0;
+}
+
+extern int ignore_fast_index_config;
+
+int cmd_main(int ac, const char **av)
+{
+#ifndef NO_PTHREADS
+	static struct index_state index;
+	static struct index_state ieot;
+	int i, err = 0;
+
+	setup_git_directory();
+	ignore_fast_index_config = 1;
+	core_fast_index = 0;
+	read_index(&index);
+	core_fast_index = 1;
+	read_index(&ieot);
+
+	for (i = 0; i < index.cache_nr; i++) {
+		if (compare_ce(index.cache[i], ieot.cache[i])) {
+			struct cache_entry *ce;
+
+			ce = index.cache[i];
+			printf("%06o %s %d\t%s\n", ce->ce_mode,
+				oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
+			ce = ieot.cache[i];
+			printf("%06o %s %d\t%s\n", ce->ce_mode,
+				oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
+
+			printf("cache entry %d does not match", i);
+			err = 1;
+			break;
+		}
+	}
+
+	discard_index(&ieot);
+	discard_index(&index);
+	if (!err)
+		printf("Cache entires are the same\n");
+	return err;
+#else
+	die("ieot only supported with PTHREADS");
+	return -1;
+#endif
+}
diff --git a/t/t1800-fast-index.sh b/t/t1800-fast-index.sh
new file mode 100644
index 0000000000..b3460f1698
--- /dev/null
+++ b/t/t1800-fast-index.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git fast index tests'
+
+. ./test-lib.sh
+
+GIT_FASTINDEX_TEST=1; export GIT_FASTINDEX_TEST
+
+test_expect_success 'setup' '
+	: >tracked &&
+	: >modified &&
+	mkdir dir1 &&
+	: >dir1/tracked &&
+	: >dir1/modified &&
+	mkdir dir2 &&
+	: >dir2/tracked &&
+	: >dir2/modified &&
+	git add . &&
+	git commit -m initial &&
+	cat >.gitignore <<-\EOF
+	.gitignore
+	expect*
+	actual*
+	EOF
+'
+
+test_expect_success 'fastindex extension is off by default' '
+	test_must_fail test-dump-fast-index >actual 2>&1 &&
+	grep "^missing or invalid extension" actual
+'
+
+test_expect_success 'update-index --fastindex" adds the fsmonitor extension' '
+	git update-index --fastindex &&
+	test-dump-fast-index >actual &&
+	grep "^IEOT with" actual
+'
+
+test_expect_success 'update-index --no-fastindex" removes the fastindex extension' '
+	git update-index --no-fastindex &&
+	test_must_fail test-dump-fast-index >actual &&
+	grep "^missing or invalid extension" actual
+'
+
+test_expect_success 'verify with and without fastindex returns same result' '
+	git update-index --fastindex &&
+	test-fast-index
+'
+
+test_expect_success 'test with V4 index' '
+	git config core.fastindex 1 &&
+	git update-index --index-version 4 &&
+	test-fast-index
+'
+
+test_done
-- 
2.15.0.windows.1

