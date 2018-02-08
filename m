Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8FF1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 00:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeBHAmS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 19:42:18 -0500
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:49184
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751186AbeBHAmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 19:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=x5gLiGG+gUdyBK55oHTgPZLl8cGGRLja8y/G1Ay3GuM=;
 b=Nr8S4RomLIjrIZS6zpPtiSeIrflOe895gWHK2ZxNXeVL2SFy3niCZqk2g0l9OFp7CES9Om7dgY5mQvu9oYjmcxg3yblR54rd6r2b0+uVGyVWPrNxzTHzP5mk9+iZ1He3CzUisa5K1eBXW130pIGZMA7v5iXvlldCZMgHVh82rI4=
Received: from localhost.localdomain (70.33.148.227) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (2603:10b6:805:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.506.3; Thu, 8 Feb 2018
 00:42:14 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     prohaska@zib.de, gitster@pobox.com, tboegi@web.de,
        sunshine@sunshineco.com, novalis@novalis.org,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] name-hash: properly fold directory names in adjust_dirname_case()
Date:   Wed,  7 Feb 2018 19:41:56 -0500
Message-Id: <20180208004156.36224-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.33.148.227]
X-ClientProxiedBy: BN6PR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:405:15::19) To SN6PR2101MB0909.namprd21.prod.outlook.com
 (2603:10b6:805:a::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4271cd73-0bcf-4332-50e8-08d56e8ccc9d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:SN6PR2101MB0909;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB0909;3:CIS6sqamBQA2TQgI8zP3VHr7W09het4xwvadOhmNFP5soOF7cQoa01DVEzwS194qgw/0Qy+fELMfCiVMyYqc8KIYMOVh9pE3u50xMbeURnuKuRB6tLhzwBwG1xJrUiQaLWqJkw/C/cQniXLSxju7UAxOR5S0FHLBoGM8nZQunPjHU1SOflSSxGjJtkBAcouINjsRquJzMBqfQ2MsCPZ/ATBa9tItHKoN0zPAILuWf7PewiPCvHEyaxwDYNPqFp4T;25:iBhp6RdosXrvWp4nRv/bMkdZHmHCDAdfbDcpUsm3ycTpXAqW+2Za16ZqMUqbfUC7u7H4siM0HZ7+DwonhZmleZqB9lXJym77F3ASpFTaaJ7wLrDiy//q9BNxP6OQnG8PkM4CGB5azf5RjQVVwLEAbxrMwr7dGWcxhAzfOsrMO6ttBk7qXPTqug/ueSGvZyPYvNwQSup4J/ZZqVNFmzq9vqvRhiJtZqajDyoaEVFuSp1YJbNKTfGlzE2KglIG/xAnEjh5MLtnssKYLx6iSmVzoYHl2YpxQ8Ulcayc8aLAUzQO6C7OmQLhKngA2noxH5B3A+ustAiVpWlUHkQg6IVU5w==;31:PKcuNyunEi4dAjvCATLs4bif568DeIvFmup/gymh9R8i4eAsZo5GfTEU5zoQVIbVbr1fPzrta2DH+k+ARGvdFzHV/BZOvRzhIrnv40BQrX7p7vR6A9A3GAy2MWUThYM+pkyagKMLKikO7wrlSr2Hm/E0p7rPkV4KSTNxU9lONuRsTJhw4XzmZy+lQ1QSNs4J4IOkFK9mTZlzQDBYgG+M7kPtZru4nKXOqdxlHrwq1Rs=
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0909:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB0909;20:Z8NUZuGcM5JM3yRie/XJq+p0lm+0lAYaG5xs2iSQ+Nxptvn91ioJ4XjDh/RWfEAyLU8pxU/bHWSzkj1pNT0rfewRGOiv3EsApPnD4bzOUkJ7eiaelsFyslFhgUd48gbOurm9rafKV57wBZUxpho7eqoxpkP9/GrbKAk2M74BRlwG5yKC4zmimGd2UPNhKhK/GFWD60XhGW0liLfrcfa2EtSg4xjHh0gArI1U6TI0H/spbaCNgblpVDTek7RwRpKLCj7PTuOVBOGuC/oggwvCN3bUJN2KBo+MbXGm89YgxHcSqD0YQFAK+05nICbQpymXZZzaPtC6nSI0+OCmL5PnQUPBtJwhXC7TOWRff9Okboe/fLArQtCcMFscbE2aYGiuVJPTEalsInfi9GushcbnRc6JK6uLTampT2hHoZNuNN8g9hb5O1NOeZX3H2cfMnLvvu3/ZExa4UCoeGIyfEL4cxiMw9+xBaRH210wwWhrvp2jyvaDiJOwPFgJ8iaN85qD;4:fOxKT+fxXL9hUrALtiL2is3A57c+4PuiO6R6WU+ICA7RvIoRuPTgrIkLn9EyvpM8536DoOqWoM5GPqFyGpoUbPkhJOT7sXEP8yEcxdIbbFuNU8+xCOd75X90EGDN1oDVMM2b+iCO90I3MzcJ+dqpHr2H+PDRYt5aQEuafOjiQyJS8zImTe7+RiEh95R+/YXRiPTg1G4CFrI/ygW4mkFE9qJQnkWZSvRKRGWDgtXTt1gZdf14rM/Q7TuArUL94+kOmp/VyuqWokOK8KTV/Tc1Gv/lz9ZumCBdo0TLkBxgG2o83aKuKFsNdUu5IKlZtEGCvHgOoPPzJrcQCtZNkvz7voZFFigb/twJd5Zgsf/QO0peXyeVXC2Mc4fmzpufI5QG
X-Microsoft-Antispam-PRVS: <SN6PR2101MB09097A3B62A0445C8C236C06F4F30@SN6PR2101MB0909.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN6PR2101MB0909;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0909;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39860400002)(366004)(346002)(396003)(376002)(39380400002)(189003)(199004)(305945005)(7736002)(16586007)(47776003)(22452003)(72206003)(8936002)(25786009)(6666003)(105586002)(66066001)(50466002)(97736004)(6916009)(5660300001)(4326008)(16526019)(26005)(81156014)(107886003)(81166006)(6486002)(2351001)(2361001)(6512007)(50226002)(966005)(6306002)(53936002)(186003)(478600001)(106356001)(316002)(51416003)(36756003)(52116002)(3846002)(6116002)(1076002)(10090500001)(10290500003)(8676002)(86612001)(575784001)(6346003)(68736007)(8656006)(386003)(48376002)(59450400001)(2906002)(6506007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR2101MB0909;23:9aC6Uryw1BaIq53EpBl2HyGU8UHDKCW1K1ix+jk?=
 =?us-ascii?Q?3J9dkYelubGN6q4FCumkhFWAllQpxk6x4wroRsOr/6rEkGBiDH4KaBJHVU0X?=
 =?us-ascii?Q?cJDFHSNpW+QlZTSPPIfb5qxGpuKeO1wZ9M/iQeKlAUBlK/29buy0Y6p5/mLT?=
 =?us-ascii?Q?m/r7jRbIHSnDGd70aXGGJmuHSgVrN/iOwK7jKekBOwko1GuWdgYrwBlqtOQr?=
 =?us-ascii?Q?BpiOet33v9YaetmSatvPYPYxvbMW0u3vi7yl3uV+qOE9mSB9HajzEVPOiutX?=
 =?us-ascii?Q?PsNrX0J8JT8KJ6lFPGQc7thgKPm3Z2VMYnZljs+ym2Ju7gOPGpsmlfqznulg?=
 =?us-ascii?Q?y4fhymnU673xlzHWldO7W70m4bdTqASwwQuQgNiqIz536yQ+XJ4lDzeROp3U?=
 =?us-ascii?Q?N6XppBgT/KOktp/K7DGfl+xKPnH0F9ao2jzKZEuoWb+LXPX/B19djp9P1YEg?=
 =?us-ascii?Q?FMppxZ4RvDgw6xbaXTEwynAv4sBFVl6lpaQD49zNW27se2zgLUKmr3nS9yf6?=
 =?us-ascii?Q?CzuLs6GTq2uuLei0ove3pyBzvusMLkxE3Izl6Iuf1DgfvKFcLnivcBYxZiRY?=
 =?us-ascii?Q?M7z50u00lvQKqeKwOBY/RHVkOklRvoI7QLs4iM05T/VdEqMK/Gf3V8qqqaQL?=
 =?us-ascii?Q?fuTCqr1Ri7goxCgYKncTV81tjQaMT/tFK3HjxjZmn9mEhj1g6AEgTkwWASin?=
 =?us-ascii?Q?SP/Li16GaQsWKLLTB+3wXuZwtCf62RlR05VJY7awMy0rQkO0ZyD54gyWo5AP?=
 =?us-ascii?Q?Q+iNOvfkQ5VUC69vbPEwGew4xSdsTPLJKZYhjN/XVnJH9sqT2puAHYC5kgza?=
 =?us-ascii?Q?0WK4rizB40JOaP6c+BSIdru5tvvOauaN3fchWXJsRNXBAxhHGRPkzTi7fSrK?=
 =?us-ascii?Q?d/rKXHBcqrgNY9asar2WQidHBQYGF0OrD9bPFfcosUpHubQ6OCRp0rti63yk?=
 =?us-ascii?Q?GEStEuz+DN2q2fr5tCWYZGj362CLlyf3jKL62zBZk6kuSuw4lbwjNlomvmv8?=
 =?us-ascii?Q?/PfTCAZnruJipT8LkodyGmhOfSMChPSlTy8Df4JojRnXvCm0SYOgGYPd6jwQ?=
 =?us-ascii?Q?A7/5cZzPLIdU80ey2nYl5JMGSO2echG+AG4x7fIlPzX622oNZ2Pn74p/DV4R?=
 =?us-ascii?Q?5sPOadwAj6uWac037hBf7iRD495MC7A6QLXzTlRX6DMOP1ASu7G0Dz+/jdUa?=
 =?us-ascii?Q?KsRfFh9x23v/T1/SLevey06Zt8O/hCdMPb4aE3OkG9R8PiVBdjApb6EIKP2c?=
 =?us-ascii?Q?C5gOiE44xmYiFwSs73LLJUyEUtUJVxx5y0ct0qFcN5SRoEKT9fVPnVqHZRtR?=
 =?us-ascii?Q?2HtqXEqrSb1K89bY9aBhmxZSvmNNEQhpCZ4+oMfBpmrLMtcrOw/SdPvqmaDJ?=
 =?us-ascii?Q?c6w7wstJTrY84IMlfATKRcKX5hyguhDGeBJwFKLTkVDlNt7xZ?=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB0909;6:+dhRCkhEnUgnaU8V1zJeEgwDjzH9e099cnAjaTsSEmbKyQ5q8izfHAitfQuEOf4lEjdscufMtFFIyG/5Lgc7m34tkxAqfN1MTJBOPWFWqv9TTL0F94nggwRPxo212BZmiz/J8AFQJ7/TQ6Y0ZuSvcHDTgqZ2mYLNIB6Tm30K3rJXC3GSLlLcCo4MLvJW0sC4VUD6dNKn3FGPdmzaZWURFQLkefalCZpnXpN09CEJVoB5sPsZ2k9oJq/XbQG3mI6fuS88ZWEY9QRalE6AfYKdUXcDZsqehnmhdXw1NnwAQFHBiums69YMbX5m4P1dQ4PDoR+/2iYwep+vIJBcbECQrN2+6vUDchnM4Fw/Hc3vJrM=;5:d5eVP8cd3Bu0JgtT6dtBy8cQybvFF/emT+HDW9mvwdSxU9FN7DP6lJ907nn/sOlhRc8B8uMVJuIow4+Z+6ZDZuuxFOYJo68uOSb/yRfkoEyGiRGeYtwsy0D7Eh4zPR5ybSZG6bKnDqQoEV+MWI9eQtZXntZCYIcbijpKYdjuX5w=;24:Fn8hl4MSEguhJpDnjcsj2gN7VTJB5e6ZVnrjPA2cYULxFrxJ88OP1YD+upSGYunOHhTXvucD7Yg76eUPyBNmzNXtF6ioTMagjhr/ZFBgQWU=;7:/dpfiZ3JNv/YUwYKoBqzhsI8HnynDFUZg+lyo0EnHBdaFgT31PyTjL7S25gR7147bartYMWznssbmtHouLGVeYTPJ2VFVbn/HKLRstwzSZz4AWuDxbLeLyYLk+Azlw9M3ddnSuVYa1ULYPGHFSHRsFcOE0rwfkfaJJLVBlGeUzp5i8XgvocDwz1gHrDlyuW4AgWeO7Vx5Dog3c+VLRnL5NnDqXxsdHl/YRdDVF0ZC2ggmBAYwgdFQlSLpJLcYx56
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 00:42:14.4357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4271cd73-0bcf-4332-50e8-08d56e8ccc9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct the pointer arithmetic in adjust_dirname_case() so that it calls
find_dir_entry() with the correct string length.  Previously passing in
"dir1/foo" would pass a length of 6 instead of the correct 4.  This resulted in
find_dir_entry() never finding the entry and so the subsequent memcpy that would
fold the name to the version with the correct case never executed.

Add a test to validate the corrected behavior with name folding of directories.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: v2.16.1
    Web-Diff: https://github.com/benpeart/git/commit/2944970f4e
    Checkout: git fetch https://github.com/benpeart/git adjust_dirname-v1 && git checkout 2944970f4e

 name-hash.c           |  6 +++---
 t/t0050-filesystem.sh | 12 +++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 45c98db0a0..2ddbb72647 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -696,12 +696,12 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 		if (*ptr == '/') {
 			struct dir_entry *dir;
 
-			ptr++;
-			dir = find_dir_entry(istate, name, ptr - name + 1);
+			dir = find_dir_entry(istate, name, ptr - name);
 			if (dir) {
 				memcpy((void *)startPtr, dir->name + (startPtr - name), ptr - startPtr);
-				startPtr = ptr;
+				startPtr = ptr + 1;
 			}
+			ptr++;
 		}
 	}
 }
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index b29d749bb7..219c96594c 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -80,7 +80,17 @@ test_expect_success 'merge (case change)' '
 	git merge topic
 '
 
-
+test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
+	git reset --hard initial &&
+	mkdir -p dir1 &&
+	mkdir -p dir1/dir2 &&
+	touch dir1/dir2/a &&
+	touch dir1/dir2/b &&
+	git add dir1/dir2/a &&
+	git add dir1/DIR2/b &&
+	camel=$(git ls-files | grep dir2) &&
+	test $(echo "$camel" | wc -l) = 2
+'
 
 test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
 	git reset --hard initial &&

base-commit: 8279ed033f703d4115bee620dccd32a9ec94d9aa
-- 
2.15.0.windows.1

