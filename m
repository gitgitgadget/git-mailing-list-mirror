Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9E71F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeDOSQu (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:16:50 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:46560
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752892AbeDOSQo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0FhNnc8vDSDGItH1ynWJkeHjAoBB3b49PCehSQPXGUw=;
 b=UagrLrYJ2VvjxyvCtKPjrjKmfYO2J06xWFO223QG1Q3kZrIKdT38jjE4PD/NkAP/N43Hd218e0zEakqwXnUgSibwQvRsBGs8JvuU7kld85FkJH0cseE97oIEb/ZzTMBchC3ZifzP24FVkFPHEeyYoE3bTHtuT9HWDXBog69EK5w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:38 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 02/10] strbuf: add xstrdup_toupper()
Date:   Sun, 15 Apr 2018 20:16:02 +0200
Message-Id: <20180415181610.1612-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:28kewfH5gre6uvy4upRDZW0+hGJEHHceryfAaQaARTNnLnnyWXftUNkRUHnfUxSZ8T3sywq8v8LwcpFH2c+vj1U5k9QzlKduTl/oAekgnQhYOLOomZ1dWTg2TDbvkYWhRs/MWCMU0N5riZl99X3d07JOez75iTg3sBXjyWMx1C+vjxjCsNj8GbZzs2VzZD7yjhSPoteOR9vsqZqMl/pyi8386hG6r/Hv4BcwtitcwrYrFHqfP/lNvCKE1uGYe4Ut;25:4TkYNyPmv56wLN2AFEztO4FCZq0cpsSMeZXo00ChOzJn6SM7d3ejINrHI8xa9GW7EGOHcPl7AzvnfVr8V3yYitIAsnGoZsvbWOpfxQJOveZae6lHD8HSSK4bHeslG0BtbUgBwDTqCvXlSKdOOSofPKhkEC3Y5xC3tmya+d6qNUqSdTKpUZB4/kTQAiweC0JKFxITVqc1hH+xYo2aOKa6D7qMGX00UC3zaGB6j84XJFhKCSFmhKE470MKaYOC9XIQAVobBtPYV+x62RnbFxpEMcnrjjWUB+FAl7g4K+cbBorHsElKDhT96m5GLI2LYAlLNVpvvebSRl2sWZ196uPnmQ==;31:Z3iqKSl0TtC9N/2smyFtOpggcBFC7u13L6XsLD9gbqBGX05MfYSiks/OFlNP/cgQleE2FG2VNAgWHO75hhuLEDLcGZuB0HpZBZBqpHnBjkwjlsX1AhB9eiEjlfg/7iT2an9aE7byOrIjloghGMuScR7goRMHc0bcdSmz8ZwwXUQ+YQF1NEtchmV0TehhjymPvDlVWooHx///VQMZfYyQ7CQDxdD0dTF/NeIzn9z8uMk=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:ChMN53Tk8OklUF9oth4csfavu64DOFQISWbqxX0KlmazEuo+spux9K6pvCNB8YNg6RfMMutZsZnDTYGYnxtP6rzaIVV5y5kXkSbpmQ5t15CdisNrpO+LdQWkxgIpH5S6x6eq1lxU191eF3St67zQBdJ8q2a3KmQzF1Pmap0TDhiDJ2InVvwGcWPjapEdFcOJklREKbhk05y1/S0/dieXjalBF2JwtT3jGJNXe29hn4l864ZT52AMXfw7ISUSI2tAa0tuiz57T+IFJ51JRLd9hFh4cwf3M530XZ9lAN/9R+xrkr55EnmpLlRUn5Y3iFmHvqpvrpx/ilyrG5CMUg2bOPyL4AlFw0IrISvBVzbA+za2/vzjL+AqBHbPeEbKEWpbi/JuC0llG7iSXZj+gwkhleqbmRUdGlJvfNN3odRWPUoGuee4Mudnu0a8IIA1QivuDIH+7ng0z7sjI4D+jkAvkLe6B+W7+SEKcG3JNycE+yTLZbZEHlg3zDhATk0VA2eilSoWV09E7qfBBiW6v2jEcafxb1+5UYljbuWRJ+v0VK1wwDwE8+Z7fBRfKVgizi2GgJEkqUl1PqhKdVt04R8ivdEk6WUW4kFlJdM02yk76KM=;4:W8dbEtghTLXhwdLpIs+spazkCpGoGbbPFvL2UWtE6JsBPZSE9byFOIg3tFtym3TBr3SfonawZjnX3rYh8ZT7JsFadgJgETnrljFtar5QDwxKdFhzLPDZQ3TnPXYRCGIbwtPjAATxrcNmxRqLTxntvKuL85t3rt9REvspf1y7PNPr0oh3G5Y++uGboodu7308MBQHAGTpNUoVT+rXEA2ukKDG7l7FLIzI782yU0pzricMu7CgtLOfhD8dKfY13q6qIq4S406YRbVn3sGiKtlSFuHJ57qg0kp/VRC2tB0SoSNhAp5tJfw2kOmb4SBcrINb
X-Microsoft-Antispam-PRVS: <MWHP136MB0014168C68CF3B0831992E68E8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(575784001)(68736007)(16526019)(186003)(85782001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:fDaZTxW9hjkxAwj3FyWkVkiPSNLf+0qj4lILewrz/?=
 =?us-ascii?Q?OGmhvZw5VsH52cDV1O01xuUlxzTHtnBata09/Wg62YZm7b62dm12Rsh3iu1d?=
 =?us-ascii?Q?UGXxNcVlE0lggk/l2EVTDraUohdBUSD8vhroFz02xt79Q51vjfSY5XBJgUzn?=
 =?us-ascii?Q?1kQDim85n/XjlfEWOhJyDLhzBUGZ+EsPOTFNvqze5wGmC7S+9RGEepCeEMQL?=
 =?us-ascii?Q?liZwBnnAcBw25WGojJ+Cd901tDaa7VkreqSXmuyWFvCYVyn/osUZG35qj8Sr?=
 =?us-ascii?Q?o0IjcXQMuMVG7wuaC6xMaq4tEFqoZQTb2c28Co+Wo4m0spc3lwp2+eG+cPVi?=
 =?us-ascii?Q?DDXPue7MhLwW89iv3QG+Fb00SKpjMEwrpkqeAyh3siyr2kXZ37mHvKQKOLhH?=
 =?us-ascii?Q?XUfCLQvUIQAr0MEBmdc4k4o23yY6aeJOd9Jfb51IB6eyN4vaZ+mG7YJ/m1Bz?=
 =?us-ascii?Q?yx9Rhtve+5uIu2uckeIh1BUKfRBdwYMhzZkg+bdRffnUIyvNHfsAAw6Qyeq9?=
 =?us-ascii?Q?AtLE0M2MgcILhPwUBtJO+LotdlIvCGuNYb1YTPBuUexaKIstTRgYmmsXtSiJ?=
 =?us-ascii?Q?jccGkVsCY917il/x2OTW0Fz1mAdYan32PjKDdeI2q2Gc55HOnJScMvkiomGQ?=
 =?us-ascii?Q?OkjY6KUkF4KVZDAkIdCU22XdCWi2Y0zLCcM2PEcoI4l5kiePI3c64ClMFQe8?=
 =?us-ascii?Q?zgbgsZADSXcl+DybN0O4KdTq2mAo60T2Ff0bHqf+JJqPwxmWuA+ZWuyAA8OC?=
 =?us-ascii?Q?zZlGTv8Lps9SXaElkKGPARe4hKTaS19WKCJswJTQqat98jSS7Ksw64cjvHzU?=
 =?us-ascii?Q?Aym3ukkqSYWH4GV2n18njAhn0LDqJlqXakPRe3DSffNTVNoF9OrVGBz/0Idl?=
 =?us-ascii?Q?cabIWlbG9o1mYHrUX5ODaDvWHijR/6nqIvtNh+495K2UQE4T9jAdtZJCOUJA?=
 =?us-ascii?Q?wHO2j/DyXlZRygh5wVX4RwDWW+CnJt6Dyewi/L+BIXL+dZZgpVJ/rko7X8Lg?=
 =?us-ascii?Q?a3rTu/1eBjWREnw/YTNwb8ggULA5thaffJzaZaeH2LGlodCIvnFzfgVXhb5Z?=
 =?us-ascii?Q?wHal1LdgfGcclY397fQq9cua7ClAchY4Dwg6gViHEhrXGA3j1lNqBzYWEv6M?=
 =?us-ascii?Q?kyb6iJQJuDlULaetUjirgj4DU59WZTBOLERC34VFaafq6xwl1ffgHpwzepMt?=
 =?us-ascii?Q?sfkEFYYd/kqc8WNOZFMFU/Dp+f3vpl8dHrS5bvbqPgagjsTUExoGp+SzYgJW?=
 =?us-ascii?Q?G9wRYf0o8OlHqD9yK+BqWvd1l3VBHPcybCiggorYt9zjsIcq8xbXsiPMgUdo?=
 =?us-ascii?Q?zUWvrXbxToAcHwT9JRPZ4AkS2PgpoIw/N/Sd7/9bJSQudM4EQYY46CRx68yP?=
 =?us-ascii?Q?Pn1tFzwncx901n3PPGV45HzRpU=3D?=
X-Microsoft-Antispam-Message-Info: Ar2QGPvGjA5f5TDCwl0hxXNJ8D5PU/TsJhkYg9jDPU0LPRBDRL2bvHPw/XATI7AdfOWEOq2ysWH8bc7hpbWBnyskSyKGlUq7dVAv+RPrYNxBcclXamzTW7LwAyl2jw5Wyis/5tpSVj1XfwX8ujOw7FY0UvpNCSpUVqc7sy92oN5tZOE5gR7EVQJO/wZSSdkW
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:4fKMPEE8fXkVIlOZsgWWDAJKpWK7wbKzvbkfN77tnC18MSP7NCJ+VE5KpUk4NgGxJBMyDOOLsaVIlO4MajxiSLdLjjjRaT/kJVmW0Bp9AD7GIjVJvDOrO6XiVpx6gZWk/V4doYvtSCIs8zxPQlHHQXiO1FFCYHwYtJs7ggwO7PhjZMFELV2cUaCYnozIr26HacM1Q+ePEgz2ylFD4qmZ0RyPPJdvbhSUpWFZ+OSUUsPeP/8uZGMMV7sp9B0ye1lrLFUP2j4u6aFrLBicRD/ce/sk92QFAtmXMu+wOs0UTEofsNqwHEsNrxGmsRJr9/tJGbnOeZ/upafJGLe/itdp5d3uxDn0qvQqRzmFBmgz9EaMF7l7Gqm6MIlwQ3ie1WwHSCHMg2evB1GVebK7mBZizAV02I18KK8cnWv9xH6/kD3FIDXdb5AZ2Etw12VohmD1IRwB/kltK4UYelOgXampeA==;5:ghNL7CMxv0u4tAxfmuCftAE5v1l9QHWNfFyrVV8JmlX6CZ+EAJhsrZEsO5CaDzIMbLxT9UcC9wPAUnU4JsSgDsxjmRpCUuIVScWPzmu9HeOjpFUhJP9dqbv7D0YkkVh20V8VCS6Uraa1849eVMCP63rgPOUdrqIXdQosGljXVWY=;24:GR8HfSWHkXnL5ktCzdCt4c7w4Q5aQ9dEnaiFXRfM9QG4JTL6f45TfnpMj++53HtdkslvoBwYNMYH2DxoGEM5zdq0rc0n8E607Lvq9nPDafI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:JzT3cBYiJniln/I9AZjqRQekIs3WxLoRzIkEUKc4VtgfXNyyWOW1JS8lmzAdmNiJxAvJyLItoaE63sa5WGgYZivDPebbZHmLUy2/5DPSJIumYP6lwVq6WC4Aowdrd0EL+wtG0Pp1Nc6Ye1qcXBuILu/jTYbqomk+MGy1YhhGBAOVug6rRy5gxQK+2rNsciwYIy/TXbphUlZATrTFlktaXPCxL9cZUuF+6C/3LZNCFe0L33i3wOIdPpMN5f6aTXmu
X-MS-Office365-Filtering-Correlation-Id: 7d5c4ce0-fa6b-4537-021e-08d5a2fd09bb
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:38.8812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5c4ce0-fa6b-4537-021e-08d5a2fd09bb
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

