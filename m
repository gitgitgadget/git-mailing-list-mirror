Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAF320A40
	for <e@80x24.org>; Wed, 29 Nov 2017 14:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbdK2OiX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 09:38:23 -0500
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:44064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751267AbdK2OiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 09:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=55Xwa4S83108Qv1L6FM1EZIZpNQKFd+jeQMxMDqi49c=;
 b=N7u/87rSsfioM6+/smCAsEP40R7/oNoxXQGA+hfpy1/u2j72Px9UgoOLdI90pBYRMMmRsbEP4lxK7niFz1XkFOce4rXemqy6oYkGS3a1OALHImjhae1+z3IX29thrrjru2flsAKN+br5yY0yETIUOk6uIrY16BkcGKgK/ZRTT44=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.239.11; Wed, 29 Nov 2017 14:38:17 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user input
Date:   Wed, 29 Nov 2017 15:37:50 +0100
Message-Id: <20171129143752.60553-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1PR04CA0066.eurprd04.prod.outlook.com (10.170.225.37) To
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a611887-0ea3-42b4-25bc-08d53736d533
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603271);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:sz2t5ZOKyFPyQYkh3p9HacAmyG2efs634bWBboBfRZYEQIDjoIMr4QfbO3TxyQp1rIa4mbw6wnkIVbn82uphEjonkHBk6KT80pqnPhy90CrgdCb/rMMWeplIS0mLfS1SpBTujM5qXrZt6hXa1JEr0Bv9WjQMRyXqzBz5RVj65rTg+zudYzExeQ5VX6D91GULyaBZ8EVXcTRcdYP0MHARThZzNSDykkYfOjLF9h+YjBylZhmTAN1NafkU+CvlC8M9;25:hZzhjUEEYsT+zA3O5S7WXZ28HO1/rvziSdF5a38VX4hHXICxeHeJGHxC/YJ9Dd/sSEFKcgJoSqzlmrlYpeH1xHsiogkL8m8SU/4MeOCkfnD8w3eM2D5VKxHSkz1vAqPf+tN8WJgw+o2slHjZnSGTEFiuil3GmizbjC9dZjpeoHyqBDT8GT7wDX9SK1gNfM7J1yrXUwNm3eqYpA2n+HONR7xPe4WTrFXFBvI77pHs6V81KZ4NkFFylhY8q9e2cdaPvz4YxwInVpX9DQfAkjkTRWqjfgQcpOQWFvJxsswoRtTHWt4rV/s3nHs/T17Yoyg3kmUM3nhqV1FJIx8QLjuIrQ==;31:4gnvOoleuO2TwUplwBrFcGt8PzVv6l2d+gTPDdXZyJ91uOmRqIt8SiX2erUsG9n3zBx4EbRp0lg0KsTZoVJaamnnxVYroyiLK4SF1JYyn62y98agNUo4egX0yXECio1/rvFtPJr+MztZ8bdXT9jB7w9kvaDf/LemNl3PrHe42WI21gLDzCcZ0FL26dJG/2lzkEZzhJ9NqBbx9z92g6OSALHU2NjQ2axs6p53C2F4NLQ=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:PMDISL2b14CCA+pXLwV87YqOoTuKQT3Ij8hKy0QyNkvWQroFL3c2BabkogXcVOHmjp0z5ltiTriqxCjX1GlRlobo1U9wrLOtx27HXJMX96omzG+g5OvHqAE9tfJtz/ieCyDihWO2gAf2g1mcsZp+vAQQuvMMfeWdwOOLB3TNx9lfUUucl8y/47rK3z1Zq/fUSp4boxDkfuqU7V4QC5nAaXyzUEpj/irdtChLDgcroxUAeP14b5vEyoLIBiX7E4yuB5rx+Zelw5ADGpa/bmBTaSkaSDXXLNMjzVleuefpEGV+7ZPvszfU5o+HNe8aFDkzBXA44vyhYjjbpmBENketEeBi/FXI2e7/aJMImvJLrq9M98xfYNqgNhMIFqAwzhaJ0pZy1y0eFXl1bWPBV1mLPOBODoyrz2o/bSvZfMzW2FEOda+Ouj93Hs5twIs0AQqTj5oepHgzr88jNZOipSCfq0Fe1NOxch/fMXIPsDhTiFLGa0Sd10kr1XNFt2S10Ag0J2UJzflIb2tJwXPAZ2/jSjZ1qSklcnR5y2Je/TIrPorgY/4TTEArwu8he8vOfiw8h2bndvy/17DXLzYCW1ZSeaxQN42mxAJPhqDnsZEdCGo=
X-Microsoft-Antispam-PRVS: <BN6P136MB001772DAAD62216B58B16311E83B0@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(211936372134217)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(920507027)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041248)(20161123555025)(20161123564025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;4:n3Wnd7HjFsD+tqP5BC8bogsGk1ZIWLlBlQwBT8quumI24J82HKqQxpunAnWKpwBJ3L4ADyX6EXSSG/mULhmgPzjMRsX8AGobIIS/TcScXwJqbHufreAu4DG4H0209X1HRuiSW5q4OK5JG1+F0eHwVb5vIlYtsu5LYBxuvn9WutmKLRl8Bp69oiNsy91iiemIa7IVqVl3nc8VXGLrxwemib6a+xPkSr3ElWaxcaLcon05+BsA9lIV5b1LKkFPbFtkUfpH5ZLhglrxYFmc5Qc1jW2woPQGUzBWGxbVlfHXbg8w9QhwQScCDCq8aCtgSxQAaV6nEszfFp7k0Dkj/mACwsllFPJdnYVgRAVEzoyBWn+v52IbWlXCmz7i3hZhy+23
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(366004)(189002)(199003)(5660300001)(53936002)(6666003)(6916009)(101416001)(50986999)(9686003)(575784001)(305945005)(8676002)(6306002)(86362001)(34040400001)(189998001)(36756003)(8936002)(966005)(16586007)(25786009)(81156014)(81166006)(4326008)(85782001)(105586002)(51416003)(52116002)(7696005)(6116002)(66066001)(8656006)(1076002)(7736002)(2906002)(50226002)(478600001)(106356001)(3846002)(68736007)(2351001)(2361001)(39060400002)(16526018)(47776003)(316002)(33646002)(6486002)(48376002)(97736004)(50466002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:EnRH2kNiIaVxdfRg3XKpI5MdF+H1vIzFQnSaECEp5?=
 =?us-ascii?Q?S+msMPmliIHi8NU3yTOn2Fg4AcLxX28vZHwSUg3XxJ4IHH/IVZn7u9GJhVcr?=
 =?us-ascii?Q?6BtS3xZesz3DHaqC6aWVHHfY6ZanJiQrTMwf7n+4rLHMoHFpk1iE8wGElp0Y?=
 =?us-ascii?Q?2Cg8woigKsXScydp4t23n5Y7VltfDWvUZAvDSADRuLVjbgcHBK2CES4TMOXd?=
 =?us-ascii?Q?JM0hpvV+fRPB9IY/YM2uXBhpvI9oNG4K/8A1rAO06ZoivV1VRZ5hpzct0Z53?=
 =?us-ascii?Q?96xJKPyNaIw8D4Nd7DzisB60W0F8Gg8yYYXKeGaCVgc/Zii656ii4CkBpr+Z?=
 =?us-ascii?Q?o22TrXTbxICZ9KAn0kexWR89PkeiSpy8vOJhhZ5mSsOBvMd4vEjYV4GI0rhh?=
 =?us-ascii?Q?KxrzRr5AvPDkYNFG2LvAzIXkLu2TJEm/N3TV/EGOKKtric4pklVN56reQJEc?=
 =?us-ascii?Q?klTelPFw+5QtUMuOw5yXnx/mYNoA8SQVwD6hNcJr/mwAhB8K0Qao1WmhEU3+?=
 =?us-ascii?Q?rddlf/nTm3pPGVko2HKI/odCOAbT/Bc1n2N1CDCZ2LLsvSl5U41vefSmGkjH?=
 =?us-ascii?Q?1nQ7viMogG67NwYwuTwL3idWkYHk1/uTA3AFNSwmozsGxMp0F02Fvp0jXCCz?=
 =?us-ascii?Q?WDEXIYOc4E0xA1qIjh+dEBticCLoL1fR0oH7ZQhtvLxk7dpL3EmoZFv6kXe5?=
 =?us-ascii?Q?pvMTjUBEMcb4h3tkCMr3EBjZ7cvC5ZtJRXdYcNAVIGUjmhmQmdEC+cg8OMMu?=
 =?us-ascii?Q?fQZzd7MpAZXTJdtXx11RvWKhvS8xytI+u1B2O3JJiT+iESZa5HRvvHC8RP7L?=
 =?us-ascii?Q?vHQCN2hHyah584Szzfv+ezUmXL6wTtWG1OOMeJCkjbNmclpdH+mF64QxoCy0?=
 =?us-ascii?Q?85L+CNMK6dv178tT73nmAHOaC0Tl8Qiimnvkipnxqhjv9sHgtLBIWtGFbod2?=
 =?us-ascii?Q?yFMFRsNdrsBjzNxG3Ia+v6dsijLx/BjgZ+ewpjT7Mti6WU+yzjmkURdgm+Hv?=
 =?us-ascii?Q?Pgfq5fKmQaun9A1i8bCNj8y/QS2q8vaQ35wpUFySFECP6CaLg5RlQs+hYNFT?=
 =?us-ascii?Q?DItNLNVH5GuWUDZHPnemHg1WqQcsOMKFWT5Yoq2DofgNTYgSGBTGBnzakXOE?=
 =?us-ascii?Q?77TidN5iohCCFvpZwAxTOLjai84XZkt0o27XjWh6CPQJjNkehBMiU9r10r8e?=
 =?us-ascii?Q?heuB/KFJVJ/dF3v/jQ0/sMg2Kn0aeCd1Kz9xpEyviAt4yy92YhVIcf9DlwBY?=
 =?us-ascii?Q?dNSrlmMQ4Ub+zcibKfZDHLltyFvYr58eB1fvMukdMx9NE9IgpxlAsUpLlI60?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:hWAKhz9WRNRAwuyZgXe5A0k0FjH8BCRhddjVl/A23MNN6w1h8QQT+AIFJwyPlkK44m/Tt3262eGAulm6qH/DKCUlOCi760MKPbxiEJuxiLKXAiJqkfWNh3W4f3bQo0GKF2R5l/RlVnGAvkuHC+Avc72LogB4PyDEwQkPZaJ5tSVjJropUgbvw/PNHKSq/P6Gdzzjy4oJ9gjJKL9LD8R/Jx420uEhK4xvCDXC1QaBnkmsVCskTyoFxCJbCYr3bo84jMsRoUDRjJzHgXCu+8csRE6mcWod+P0Ns+uCAaAFUMr/SfSxGLDDdD+Wx+DACkvs2hRhW7szCttWppMjo8WpX7QqSPvsjSlGnLezlCzlKWY=;5:99x3vAQr62GS602uji2Mpr/ySAjAa8xC4tSnCDL1H1LoR+6AE4KCKLdGENh5OwY2wtLfKw18ZoT213mrMOCMNZmIYMvCGquOLlwZJ7c92T0Is0yn6eS1nQIUP3X3CHIk4dXqGpFS2GebTcB1EST0Xjju3om6iVNtt7/AC5gm8nU=;24:iqfIrGzVBqpQvDzc1ZQOgjXYlA19JjfRRIflb77znnN86bgsSVAnFPSC4y/2PzeuWl/IKj0IvmQx8K3XS0V/W1GWbT/+ebKfxuW+eJcOGrQ=;7:8kvUxtml5OKfjzhPzWfoAjACmRtFmpjXKfmwebAEemXQaSdMBO9dxIv/izeOUMU5eHZIX6ZKPcRHYVg5brI7XTBqgJuwY9APc0I30sGcHg0drSiljWKd4xLUeMqfkU5X/f2SAhUsNSH0yFqFOXbB2jeY+F5SlO1hzUH6LqGb5F6OgdheS7gBxXmRN/2uvR+80YKSDTsuAmdKbJrQNzJpGxAve0RCAK8P3PL+SkCizAZu3sPfe+DFcDqZCjyyqTql
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:XMeHcym/zfigejmUaAZB6XlPusmAssgVVpRwVIExTwhY7QdFYvCZD0knFO235et2babrC2+qWc4chtitThAr0oAXaPvEmfDPYs8JWsvu85RdKcOOFSy8lOUQucnx4ENHjfM1XKXgdoDAyMbZeyO8N0hpClGiAuBFOS3T9fTnE3U=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 14:38:17.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a611887-0ea3-42b4-25bc-08d53736d533
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

I simplified the code and enabled the "Git is waiting for editor input"
message only for "intelligent" terminals. The rational is, that today's
novice Git users are likely to have an "intelligent" terminal. People
working with "dumb" terminals have their reasons and are likely not the
target audience for this hint.

In addition, I added "advice.waitingForEditor" as an easy way to disable
the hint for experienced users.

I refactored the detection of dumb terminals in a preparation commit.

Thanks,
Lars


RFC: https://public-inbox.org/git/274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com/
 v1: https://public-inbox.org/git/xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com/
 v2: https://public-inbox.org/git/20171117135109.18071-1-lars.schneider@autodesk.com/
 v3: https://public-inbox.org/git/20171127134716.69471-1-lars.schneider@autodesk.com/

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/9639e931bf
Checkout: git fetch https://github.com/larsxschneider/git editor-v4 && git checkout 9639e931bf


### Interdiff (v3..v4):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 671fcbaa0f..de64201e82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -354,6 +354,9 @@ advice.*::
 	ignoredHook::
 		Advice shown if an hook is ignored because the hook is not
 		set as executable.
+	waitingForEditor::
+		Print a message to the terminal whenever Git is waiting for
+		editor input from the user.
 --

 core.fileMode::
diff --git a/advice.c b/advice.c
index c6169bcb52..406efc183b 100644
--- a/advice.c
+++ b/advice.c
@@ -18,6 +18,7 @@ int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
+int advice_waiting_for_editor = 1;

 static struct {
 	const char *name;
@@ -40,6 +41,7 @@ static struct {
 	{ "rmhints", &advice_rm_hints },
 	{ "addembeddedrepo", &advice_add_embedded_repo },
 	{ "ignoredhook", &advice_ignored_hook },
+	{ "waitingforeditor", &advice_waiting_for_editor },

 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index f525d6f89c..70568fa792 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ extern int advice_object_name_warning;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
+extern int advice_waiting_for_editor;

 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/cache.h b/cache.h
index 89f5d24579..3842fc097c 100644
--- a/cache.h
+++ b/cache.h
@@ -1469,6 +1469,7 @@ extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
+extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
 extern void reset_ident_date(void);

diff --git a/color.c b/color.c
index 9a9261ac16..d48dd947c9 100644
--- a/color.c
+++ b/color.c
@@ -329,8 +329,7 @@ static int check_auto_color(void)
 	if (color_stdout_is_tty < 0)
 		color_stdout_is_tty = isatty(1);
 	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
-		char *term = getenv("TERM");
-		if (term && strcmp(term, "dumb"))
+		if (!is_terminal_dumb())
 			return 1;
 	}
 	return 0;
diff --git a/editor.c b/editor.c
index 4251ae9d7a..cdad4f74ec 100644
--- a/editor.c
+++ b/editor.c
@@ -7,11 +7,16 @@
 #define DEFAULT_EDITOR "vi"
 #endif

+int is_terminal_dumb(void)
+{
+	const char *terminal = getenv("TERM");
+	return !terminal || !strcmp(terminal, "dumb");
+}
+
 const char *git_editor(void)
 {
 	const char *editor = getenv("GIT_EDITOR");
-	const char *terminal = getenv("TERM");
-	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
+	int terminal_is_dumb = is_terminal_dumb();

 	if (!editor && editor_program)
 		editor = editor_program;
@@ -40,33 +45,11 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
-		static const char *close_notice = NULL;
-
-		if (isatty(2) && !close_notice) {
-			char *term = getenv("TERM");
-
-			if (term && strcmp(term, "dumb"))
-				/*
-				 * go back to the beginning and erase the
-				 * entire line if the terminal is capable
-				 * to do so, to avoid wasting the vertical
-				 * space.
-				 */
-				close_notice = "\r\033[K";
-			else if (term && strstr(term, "emacsclient"))
-				/*
-				 * `emacsclient` (or `emacsclientw` on Windows) already prints
-				 * ("Waiting for Emacs...") if a file is opened for editing.
-				 * Therefore, we don't need to print the editor launch info.
-				 */
-				;
-			else
-				/* otherwise, complete and waste the line */
-				close_notice = _("done.\n");
-		}
+		int print_waiting_for_editor = advice_waiting_for_editor &&
+			isatty(2) && !is_terminal_dumb();

-		if (close_notice) {
-			fprintf(stderr, _("Launched editor. Waiting for your input... "));
+		if (print_waiting_for_editor) {
+			fprintf(stderr, _("hint: Waiting for your editor input..."));
 			fflush(stderr);
 		}

@@ -82,14 +65,19 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
-
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
-		if (close_notice)
-			fputs(close_notice, stderr);
+
+		if (print_waiting_for_editor)
+			/*
+			 * go back to the beginning and erase the
+			 * entire line to avoid wasting the vertical
+			 * space.
+			 */
+			fputs("\r\033[K", stderr);
 	}

 	if (!buffer)
diff --git a/sideband.c b/sideband.c
index 1e4d684d6c..6d7f943e43 100644
--- a/sideband.c
+++ b/sideband.c
@@ -20,13 +20,12 @@

 int recv_sideband(const char *me, int in_stream, int out)
 {
-	const char *term, *suffix;
+	const char *suffix;
 	char buf[LARGE_PACKET_MAX + 1];
 	struct strbuf outbuf = STRBUF_INIT;
 	int retval = 0;

-	term = getenv("TERM");
-	if (isatty(2) && term && strcmp(term, "dumb"))
+	if (isatty(2) && !is_terminal_dumb())
 		suffix = ANSI_SUFFIX;
 	else
 		suffix = DUMB_SUFFIX;


### Patches

Lars Schneider (2):
  refactor "dumb" terminal determination
  launch_editor(): indicate that Git waits for user input

 Documentation/config.txt |  3 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 cache.h                  |  1 +
 color.c                  |  3 +--
 editor.c                 | 24 ++++++++++++++++++++++--
 sideband.c               |  5 ++---
 7 files changed, 32 insertions(+), 7 deletions(-)


base-commit: 89ea799ffcc5c8a0547d3c9075eb979256ee95b8
--
2.15.0

