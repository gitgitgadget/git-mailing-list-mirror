Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931261F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeCOW6H (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:07 -0400
Received: from mail-bl2nam02on0093.outbound.protection.outlook.com ([104.47.38.93]:61157
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932605AbeCOW6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0FhNnc8vDSDGItH1ynWJkeHjAoBB3b49PCehSQPXGUw=;
 b=geRkLoUKnXs6tpp+Ae8N929l9tsXob1LFojxxSRpovNNKib3KYB8Pu51fhqtU2wxMzkQFd9cg9iuBFeWLpspS8GqAoOdbOeuqGm3GTqW2BnrzeKxWPBJMggkeJsIsnH2P+Nk3+GZGMyuC9xzUlunLalH/4s1dGd+rOlFwf3/Bgs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:00 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 02/10] strbuf: add xstrdup_toupper()
Date:   Thu, 15 Mar 2018 23:57:38 +0100
Message-Id: <20180315225746.18119-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eff947a5-0c4a-4482-2801-08d58ac834da
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:TVPHZHJBRPR/xZVNl+xLWkvtW1wuq5YAmPNIS6wtLzhjtf7ua9KZtclH2/rbXtKZI6C7HeqvstaFKYu1pfbAKWxfNv4gkJ+jCSDSx6ywSlClKPPdyT98pmKtQwAhY6o1Vkt7D/7nNJNtwAJPvlqR1O7fjRaTAM/XX1GpO7FUUQC14xn3aifqG9W1P+wuYzDz4FZgMbQmjlkxDtfGkOsnJn4HISmtfhVUVoU8F6eX8LfcYeF7k5SbuKvVwlas1Y7D;25:cxUsXIyywIY/nZRVeydT5Ri+Ge7HIrDFbpy4aXmdis0x87YNetbg53nkDb4jk6mQd2qpPngNNM0vrEBPSUNKI/68Zj4UWTHt5Nm1X8B2BGKm0LwjQb54QcbAVhPDZzpQs8CcQoiPlOGSS1wLnL0NV2PzMpCLYNihxiw+E9DMduleIltO0B4BhdmTGX0r958mAyiFUAYVi4D99wCWrJWF0gRIxPpikqFZ0CyGt5P7RnkKoECbd8dvWIJBhTCdERcIqPEH4kKF9Gq9KPgFDuwbNf+9IuwEoHOPzXzGDIsyCnpAIUw0xyjJK3Js2Y/Z6smm7cdZ9bsZ9O7xXC5c0T1Zkg==;31:fpChZQPShNBW+xeqfr7y0T7ff5PC7KxgW3tjbyYVp4z4lbRw18LGqm/FRdhLqJdOm4pQ6buL51bI7L/Q6KFVGDg7BmLhgEX7REhyUJfwvRqNPEftuqeKqaXi1nojYi7OCu+JkDGT+UcjfakyW/E95JGWqkY5fga170ooI/c7ONimwLzzYGOOhc865h8ibq8Rb7C8KkRGYTOLScNhie4klvi/bxgPIxHhd2chJ9j46c8=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:ifnGHtQJqQD6OCZ1OpwzUlxQJEaN7+MXzsBHIap5r8D2frboPx51Y6hxAKo4BnissuSmtwdolQKJDFcdm83HlAo5h1saV2Jzklu+el0AOvm1bTrKGZOH3fdwPnBUcpugbU2vRWL6VNTZQ7b8Tk8Nj9Vc/Jr8nuSyvgCjRRyJzsW4u6ttRqgaJEHNtn4aYQSE6U20fWQv7AClDJwq7CthBND1HKrO2Jm41g14aGCdQY3d5WD2PzT9RwA7gsSYtJCQzie2S18V1/ShZun4zIy9RlVI7pehryka76TEP8w0gTbg4ZUdPG7paNsYLfkHQgKJCZtwNOCDwD0zKSCdzvwBrmVzQMioKAV/aNOtZFtz3ppohBqsxwsOZniq40nR+7O5jqBnIg1widZqeK7mwbhuaZ9AAucpHLfO8Rdd7xPay4URKtHfcw4jdabqmEDBQzOr8BV/EUxx3Nv5zwGzWIuwvlPOAe4UDTNLUTUvE6tyN4ShxwyRjieRV+bVHqGdLr/3jOvtbUGV2WXPaV/qgPqnHDDeGLe3iimezZJuCbEDa5LErCWb5sz8bKAWOAucjUClysm117XvwX1xvhXpMO1uiFYNoXQgf1QmH0Eq9U3GuE0=;4:xNB+HDnyPGY2I8IKScvVJcBtwoAkMw498hVyb/aH15/6U3bweZBmYVKgQ4p8n8o5w5cEebg5nJ+SQA1vHWp94q/rUzR7jYC/kTK7hPWHgflP2jpl3QAz/Q1kfTDqPHdyBMkjWLSFGEB5/rjCp1KHXrkINIqxJEcHRwI2adB/LDBAwsJXMXud1JKBUUmK5QDLtmZnCHHypLHn+WwTdvlVEuJ8huUydDoYw2WXgdpuk3wS3PHMZb6/9i2cogQxEhvgV6Pes3nFyHFNOZzjP5BIuYddydsxOmjBxa0rI4Ze3nJsGcdOXqQRvU7BYKZYbgwW
X-Microsoft-Antispam-PRVS: <MWHP136MB001453FBA8C0745C4DA9DE0BE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(48376002)(386003)(86362001)(8666007)(25786009)(36756003)(6916009)(7696005)(6666003)(3846002)(68736007)(6116002)(2950100002)(186003)(66066001)(9686003)(50466002)(8656006)(97736004)(5660300001)(316002)(16526019)(7736002)(7416002)(305945005)(39060400002)(1076002)(16586007)(53936002)(76176011)(51416003)(2361001)(81166006)(85782001)(52116002)(4326008)(8936002)(47776003)(6486002)(2906002)(8676002)(105586002)(2351001)(26005)(50226002)(575784001)(478600001)(106356001)(81156014)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:NpSAvHPVbY79Ll2g7/K+VfwN7cMLAUkRY1zOTegBE?=
 =?us-ascii?Q?d34rQIr3RRXD5yXr8vTvgmrad9G9ItRSjTeJQAImM4Lgn7g1BIqjAod3rLkF?=
 =?us-ascii?Q?1GMpa8HiRK+eI8bta7S0APwzOtSzAjSITXiSPfbkcVdZUzGpGdPFPkvmG6eo?=
 =?us-ascii?Q?szjWmp+Uw07AWjB1L9zn+JhVefLA+sU+P7Av4UiOn+gd1NXJ8MMrqw0chMlQ?=
 =?us-ascii?Q?bHTEdTsDmnxhL5/WvFBvas8fdygNJY2iBL5KmSEiOCIub4+2gzXzpr8mGyqm?=
 =?us-ascii?Q?olVh4UbysANMTxCSSVN9qkAesOg2WnbCD4y8UB9X6rKvmaKpgEkBLwTigMt1?=
 =?us-ascii?Q?qTAD8AlMAk0LJLaK+AFFoMa7Fgg2e5NVOjKAFfKAy7dHi3LS8kn7upllGZ5F?=
 =?us-ascii?Q?yhB2AdBrpNs/bJy9uiFIC5iN0NG37Bit5jFuD9/V1oEunTFWOonEwZUn060W?=
 =?us-ascii?Q?ScekluRkZBtpcxDCdr9PT/DGg/0NxDFkuH9HcbiS2RInWpbX/2QjBeQ60329?=
 =?us-ascii?Q?n2agDLApdwDoco23QyxkRj4n+1a6FohG0S8qSDaM4MbPz53tezIANcbx+8XZ?=
 =?us-ascii?Q?UU3RCR7zcBje1nj7+Y2c44k6/ERRLk2zU+p58gJQbrLpWSmOqwuu4f+oEhRv?=
 =?us-ascii?Q?VGNNch+FCfOX3QuuG69pw316MhFRDapORzoiIlSB2CETKLLKBS+RMaMAyk7+?=
 =?us-ascii?Q?l/cjivtVrniT0cXNKD+y+PNOFVn93V4aawzfK5YPIaJxG9dceOQhePLDuX6y?=
 =?us-ascii?Q?3sNsQ8txfUiueU0L/87RDhHqd9zYTJDHdDh3B6DZ2393w0DUc0ztOo3XyRfA?=
 =?us-ascii?Q?kgzQmCDSqmpzVnO0vvVBUMPhlfdef8byIs2IVdtFr5YlYQjQi2k50vcikI21?=
 =?us-ascii?Q?rSh8FfHQRYqyyfuPjZxOCN1DJWfcF/1Svxc1CRC6uzz9roUW7Nee51dNAVUj?=
 =?us-ascii?Q?zt32opo+Jx3pKM/d6G2u2GMnDcCqeHi4odvyKR35OG7t2TMG8bMG4nNKMueo?=
 =?us-ascii?Q?tdeH8in8HVQus68tCWvpKCuSNjzhCRYMml3HhPNJ2tUZjHcreqGBVSnsJ4zV?=
 =?us-ascii?Q?g/sH8WRGVfiQRp3/n7B5dWtwLl3Nh0XFDvKKs1tjAHbfo+vZw71foK6VY9cN?=
 =?us-ascii?Q?+XMt8FbtDN26kRHhnqr+tXOsGb4c0yoW8A03KW5YRww0+F1Bxia2sm+AsfaF?=
 =?us-ascii?Q?I2bMFZi4EespwImO06XSuyhH1nFq9NdtZn872tgNAV/RM0i3MZVNASltxD16?=
 =?us-ascii?Q?eTUMBkhVcYCTEUKMcbmcLSuRFMk0cP/RdG2q5WecK5Q9OLmZw1ObBDfP4HSt?=
 =?us-ascii?Q?uJOkSp4D7QjHKbJCPYGwZc=3D?=
X-Microsoft-Antispam-Message-Info: 6Q/0cyn8ISBuoeKqjPy9nMc07UtPAyOkeV0kOrHPEJ6uReeN4SPCp6wGWVh0sgxGgy6LLx123m4wdi3qInHrQl+yFAD7Vd4cy6yNI6pdJsTIn2ijArs7GIUs9SaHr39Lp+rzo0KEwDMbAPsyLLTgo0SuqffL0Mrx/MLPHu7EuznNJa+1SE2Ku+Ag7IF0llrh
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:TK+PA79ikcqB3wzalx/Ai1+HedCDR8xyo0dTi2kD1GttDVjKbq1J1CsBbdsZv/zWTNNAUMxvQelkQVZYKxEm979Qi8oEMDMxpVerpQWW6U9Pj3LkEhKZr6SQgMImYM5+vtFigaS55nC2wkmBpk2ZQggB0PZtfEfXAW4b4r2v/vqkm+R/jq4CipduVm5oNAOjG3Y4BOR4wtcTHwZEga3B0PA7nANO7gmUpzo0/XOV0UG0b41kGWuukZyhQ6nFrjYewU7aD5WiP8f5bII+0qB9vtcH8gH6Fd0hF8l140Xu25CA2VYHOCy5ANNynwQNUdGMcjP0VTE/mtqXVyBbKoGuPqm/tb2CAx66QDqDku64L3A=;5:btuA0JlCppWdVMK0lSXTW10t9ZL0WrMFdqwqAK4Ear08tK+Oc+yS732H8cY9vNpgHt4sXo2lEcLViNDXeg9SBIcGEf0fdanxrh3P26DHkPEHOgAjsPgeFG7Ahujx4LSFL4CKpXMbTSV40XoixRD49qGu43osD+U3+o4nRbJEbFo=;24:4tp6X0pM7vl6UKrBfBy4lvwKQVw66Rlb3lr5I+mWrEIah5471iWtCh/t/xdyc7AtljMYV35n7T3qNRDpHS61FBN35CqrGHlo6hCjn1nEhI4=;7:chQbaRAG+1tAeT1NkU13+kwCYMe4Bq2RPgMMhtjn7S2vwnizFL4Ma1dO0dsWb97LyU9eH4c1bD/pe+szf1hVldGk7ec5vJqBVAqQdEWzEBbjeNLgSpTLdwGuJGlyEWaeI/dAqBQzY4RxJ2ZflmHdp6pOQKIlrLgQgx6peNuWmzugqK6coM99kIwZrIf1Wq5GqIZ/Wwv2+xGfI9WozsefWLg3QOMLMyrYAKBnZOlHvelfExBRPQwxnSchEO10xJmk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:00.2285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff947a5-0c4a-4482-2801-08d58ac834da
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 55b7daeb35..b635f0bdc4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.2

