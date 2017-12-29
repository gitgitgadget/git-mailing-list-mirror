Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C91C1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdL2PWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:22:45 -0500
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:32317
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751020AbdL2PWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sAJJVDkmTlfHyy+Jd5icfVpYn6dtdU0vqD+1mQad0/w=;
 b=NjrhxukLLHt3NFbifnLHS1vLEolvwk6SLOuLuS1eHjt9piAACjJiITpQuKY7aHrrZXmfpH6RTi5aO8lU+93SVxjEr3k/3ySERwIsnmhXzJueoVthZa64lL+Q4theJIZYBcUCI7OR6lRDlCB6ouH3VUq6kpLuHCzdsLNTH8oP1NE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.84.3) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.17; Fri, 29 Dec 2017 15:22:37 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 1/5] strbuf: add xstrdup_toupper()
Date:   Fri, 29 Dec 2017 16:22:18 +0100
Message-Id: <20171229152222.39680-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.84.3]
X-ClientProxiedBy: AM5PR0502CA0001.eurprd05.prod.outlook.com (10.175.37.139)
 To BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0aac68cf-4ba8-4db8-5885-08d54ecfff7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:lni1iIaFfAoOKJnFn4gT8bJwVzOz1gZ14vFnx5+/nwBZ9ahW/ureWdLLQ+zD3Y+TUHTdaAQ0uKOM2Opo7r2rq7jPUiAEW45adj/jV/DVazbhRwhKNzMxo745di2fsBCp6z/AMX0lKWtZwS2VGa8Q9kOwpUlz7zeuxyrlgUoae+B4fQujNDrtUxpSLSO8nNRhO9X4vr2CVa5Xap1J0MdPM3Tm2eTlyyBNNBlDV5DNL8L+hW7A95zpaSJzX2waW8Qk;25:6BDVvyDp0En6Ce6lq8oXYbtSMrWrivKnXsD1i0bHM+4UuedqYJ56gID8BpdUeD/7MxUgMIbQ/RtaCt2l0nmMso5zfqxO0BUvIZ5YK+Uk80N5GLwgGboQQaSUjfYYeCm1C6IqakCah+f2m0hBo4cIZnmuulIIFtV8PNdIftOtLCatFZ+mBktt+IOpPSrzKzGjR3LvM+ZkPUxylMoVecKIpR68SxQA6Qh9v2T976KKUA6Fi29j2v9lVicfQoQMLr8sJ2ULFboRUuC9/UMtRI7Zcynl2oDnLMIo67NUwoZ9N9Gcw2NZy2jBfXG0KBLd+mRXrxbLEe0404hELg12xiOKug==;31:fBYBMoFjovKeIqU1RdoL3C6vYGwBLSOksFwMol/r6FX4n7FexcQpVQDLWQI5Um3MlOOj0gsrx29VrQ7mt02yHa5g+RDWrdbndX4aQIsHURuScaGZgcQc1tK9wlKTlBzt4EmMF/77fjg6IhyvHTOW8oJxlnUKAWc+19swxFwAb1Uf4QrhyUO98jg17ckH0BNsDy3JT7+xxmA5Wsx3SKLAPzjlvAz8zSkkoJih8h9KFAQ=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:YJSlb3eE55suPINPnawl4M+EybHL2uY+LysPLT2qS2maX+4IztB/TCqRBWqA+7Q6rUWFwYb4KfA6sj6N+5zkAIAaUBll1xgmX9HY9f7SSo2tg1U0e40o5mVeJsxVKta+YrHDX7Ekz8i068MOChREmUAeZGKZ5DIke36WxbcOG2LInYEVLVAgTUINApGsLc5bAuvquPBuWT0Ei1vNC2TyDyJ3sBTvVjYqz0tXPcBBo9g8/TC8dCjdTX4azLHZofgwbIwj4+X7dSYhH/w5qIGcTBF00JPlq+JbqTLCrcmreNTbPLeKGNu/5PrXM89Pa99CSZrZ7BfPouq7wwHC1Jp/IFhW52TcQRo9EIQD6N9VGcAUN/7Cipgu92ho3OjWsGu1kv9w+eWd8KllynfsjtARyIBRMpSK/LKnxOGK47F6K+BwBIMi6u4ccFjZUEjKQGdtok9Q6KIHMDe5tIj+VplrqNIys/StLyrCmyZtdQolRdb8PGbImqVR2W9rM2+amh/7Ott4TvS6uub82p7MC6n14eTiygRPO+3sIWwYmWo+i2sD/h/IGr8DMAv0WuEw4vRJNJGbpUq+UBKPUh3KQJmafmPMf5IV0KsSQHKKF3pyxYA=;4:7thDup/3jaO5n8xLdaGG+HbDGindttXRMwi9Vbz9e7mWP4m2tXTLLE0Ji+ALStkX/tTYpPyrNZSLVhROP0It8ExNXHekxA1kButucUFyW8a+00gYZ2pe9DAgo+zTC03ksLuMXlm7Rwrzz2N4MaFB1s/9W9TIU67rodKfj2nRbx1oIM+B6Ts29ubSqANk5kuUDHOfJE7v81MnMm8e1MY5NGrlF323ZIGz+2I3afRTpkLHGdx2HPEQ4084BCF4IRROEUEQrs/Nhffc+1N0g/OlMA==
X-Microsoft-Antispam-PRVS: <BN6P136MB00171C9E56D79148F1FA7CCDE8050@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Forefront-PRVS: 0536638EAC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(16526018)(4326008)(6666003)(2950100002)(478600001)(6916009)(9686003)(53936002)(16586007)(6512007)(316002)(6506007)(68736007)(386003)(86362001)(8676002)(5660300001)(36756003)(81156014)(76176011)(81166006)(39060400002)(8656006)(33896004)(25786009)(51416003)(53416004)(52116002)(6486002)(50226002)(3846002)(66066001)(7736002)(48376002)(2906002)(1076002)(105586002)(50466002)(69596002)(97736004)(85782001)(106356001)(2361001)(8936002)(47776003)(2351001)(6116002)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:OCLB26p5dcdqIhIgesRL+nvfBaL9/4dGzpWp060Ec?=
 =?us-ascii?Q?pClfkhX2qsmK3NO9ymvH6FYZXEA3YoKVzzS1zl11ejAgucV9wVkahmRs9Q9U?=
 =?us-ascii?Q?pvsSlqPcoHADpKkGj2KpmA6sucPji635o0bPfziuQMt90So8ZYlFu4H6OTAW?=
 =?us-ascii?Q?u5UPJ7Iyw8VAh3wjzgsbO1vShfNUHxn/RQwBvpDmWyNld8EPDsDb9HSa20Ds?=
 =?us-ascii?Q?k89XXCBjDH2GawI1WXsBbLu4ePzneiwYe/weXCk5D8Lxm8wzm9C4hwjHhC2a?=
 =?us-ascii?Q?t1yAn9pmZWuBvSc6UOiAQ9PSmeJTlV4CgcjolQiMfAKy8VS2kimCcAKxGB3R?=
 =?us-ascii?Q?aeREHBgbaI58R14iocTzmeA8JQXC3nr+rAuznz5MFuLmRHIhjd7L4I9RpE3/?=
 =?us-ascii?Q?Jzy/FEWb+w38ydfbKbdeSbhpTTFmF+2+d23orf9Yvm0XgtTI17IlkHLps1cH?=
 =?us-ascii?Q?wy/WwrDNNLm7cjXx4+lS7tfxXPJxsPqCZGy2A6l3AUJJa8MFkEbSGaq2owgp?=
 =?us-ascii?Q?el6hzPi6hscy87CFcFtdF+DYSKaXCQKlJoeaShP+CWrRFVAm6Bz1GqCa8CKe?=
 =?us-ascii?Q?6y9kr1ROGR1H1SfFiSeY18D9cRNZ+o35xoyafo5LukNEMJDIl0rAYKU9uvq8?=
 =?us-ascii?Q?m3uqWIWmW7ppW0xDgcFRKGUobxOm9PyHZ8XJGzkw3gY7NNcA9KZGjCGDjBLs?=
 =?us-ascii?Q?dSUybwzFA+WABKqQmqqXSeA6ZzBt/v2rz4f+vmg3OoGn4v980H5n9exTFmp2?=
 =?us-ascii?Q?08txCR99zTFYTtoyi1TdhiFcZaci/oEqb4xDvWs3ZUthA7IzbFFjIahzOTJg?=
 =?us-ascii?Q?rWwhGZzvuKwPT79s0gDs9tXbqIKWlYi8KFDTQeRmEsydkZ5bn3AmVz4Dzy/Q?=
 =?us-ascii?Q?G1tTC672D7UW9LCTil53HF7+9N9Xyj3iq+STEScY1wGBQTnV02KWluVhRZiZ?=
 =?us-ascii?Q?t3F+rP2tXyUBglNBIjJ+OIQY5GwJoMd85mM1hsKJvhHDme9emMlWcTv5kVAg?=
 =?us-ascii?Q?Nz04WIXKwpuLLLdblA+GFWc49XbR01hd9UKMYAmeRJGFawq7Pvr4/W+pmUsw?=
 =?us-ascii?Q?b9mZNIXfkDbGfveTrvYUlu0O/Ulrggh85nIb47l+NRSCCMUGBQKdgB+06SPM?=
 =?us-ascii?Q?3eW9IOA/GfjULciCCdFT3viIF6jo0yY1Wuj/0L+GiBYcghMBiJ69bmiyRHH4?=
 =?us-ascii?Q?n6rOkO/kIAdC1pP07+rh57hTU04nSY4kM8pD0HwIYygLyFaeHGjIcuFnUtMr?=
 =?us-ascii?Q?EiIWC1t42OnjCXRPEjvgxMyBFS/QsWyR6Qj06SwASozMUwq7TyMX6kyAJtQo?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:0xAAj35cIMVCIMCT8FCQxABO0H8sSCeZ6xge3+CBpm0J7NLb0EisHK8iXF23g3eovt88nB4GJIAk7hBt5+qRoE+tzEyJ/hUt2UNzd1YEs3/J3ZUiZowlL90CkCyxJsGCo893cFWn5Sv//O15ORBSDOHgdOg319r3QuLaRP1h0qJrj/qg4tBZZvl0iDvOVb+D+4AJ0qSVNzlTtgNiaUPDNXUZED5vIvlHFwfGQcfekXNSg4Hw2enG24UOeji304JOYJ0V1UrAL2NOOH5rOO+3HUE2VuFplVIK9QD8tXhmq/qhOTbQ9L/u/ndWnKbxG0DmqKrkh1OZpYk5GjU5MiC4+q7kyGYBQ0MgnYXww9kGD4I=;5:VeYBx0TAeF4XhCzPrr07V4mtiVs9A71XS9qE+TYI4uwMOMViSjN7wYLkku9Dq5jYYqdL4uBiBxiMpOMb60WX7QFA7E1r6VLskXQae3aNWZ6Vffs7l6xhFiLn/N1kajImP73AVmrJgOWNGUXlSGTZroAeLeqVSU7tjhfcHY7mHsE=;24:RdNyuaNywaTB7mQZ+79seVW3uaf79nzMV9dSiG8UqYY7mPVgvs+7e5tKWHUFZERNtYcK0qfQW6rQyDM+uaxl1gSzOwyxt5Dzsq9q6vGtbIE=;7:kKHK2NyCkAgOoNY0kLEnQKSJfKJfMncsD3lrx+wyF4+kLi0+72mEnzBNVeq37O4OMtE+/XUNIduUHvaVt6KxmEdkW1zQh+ZaKwb4JWo/EpD5Fkm60cPE/GhzMvzw/W/QxdkoH13/lfZ+hc28j1XNIgKRG86pkjvIiFSxj85LMhtHVgUv9igX32zjiFzx9895ZhoNhuBwwN5PeaY4hHh+j8QrKMMFxPg+I/xOUlwXTnqjKmOWVmEfn1h3btndxYpH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2017 15:22:37.9056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac68cf-4ba8-4db8-5885-08d54ecfff7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
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
 strbuf.c | 13 +++++++++++++
 strbuf.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 323c49ceb3..54276e96e7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -760,6 +760,19 @@ char *xstrdup_tolower(const char *string)
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
+	result[i] = '\0';
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 0a74acb236..2bc148526f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -616,6 +616,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.15.1

