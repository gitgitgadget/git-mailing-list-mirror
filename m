Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0532AC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 16:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBPQJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPQJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 11:09:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2013.outbound.protection.outlook.com [40.92.40.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17914CCAB
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 08:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoFUxmM3QhoXCPOzfSLmVMf0u0upDr4VS56543ERvv586WMpHBMAW4yU7NtNN10P0PCEu7Q7w3fdUTnTd9AAbDV1l+moecRJJBchXNAplDA2M8r5g0lubHo2FLn500UOMCiW1WXE6uUuHITzqAV29nq4DQ/LRAfPYblOI5Ve5NKyMVGsktROdEYMCHWKbIPWOMBW/5tuASreAlGw0eNN0illh4YQfmB/i6hiEp3mmk9CsYkorVEVJJojtaJSVFg9FkLHGr3REA1Ev+k9mxlPs55IRAG58s4A7N40WX7unmpr+owaa1kMMxNvXtpkvl4Zr3Xu2xnIbv1thH4GMmHoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y38l8ViB0Klf5n7jIITYv833lJ4Iv7Bz+HuaI+Pscxs=;
 b=WixveDVltM8P0vwrk3tjX7MxDqHZfJcwNn4Vu39Z8WkwEtDEbEJrDfzIUbed/qNjQLnL1aEE2RLx636S9fHFhirHOdxEaSq1LtadlZVd4S/APZ+48w23cGXm8/Z9wCL+itT18yPGqlIralvIqRYsH7vZMOXSZ6GYyi+2IrvS2yI3tXlkdRRqewL2t921KBBKVcLIdTkxyZYOZTjx0HUzIItRQwcjzuSbF5a0frby52Jej2i4giNNSY5T1fM0/We0esEx8j0EpYcha8ix8WDrTsjWjvQSu1DQQWN0vbw36oZfgaK/6tiH09miF/cOLOAsz3fhBmA/1h9owMWvTMNDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y38l8ViB0Klf5n7jIITYv833lJ4Iv7Bz+HuaI+Pscxs=;
 b=HjfOndCxkM0ly2Sf0G6rNy9llhTCB7NPhl6Btyjudd+WMNF1CcNtuLH43YFE0hH+8zpoxRMEz+2q2cZoo0MVRqo5/LMgYjPo9ImA154e92BMK12NWjGMcvsJ/R3qNOLD2cfmXskw6enUO3WFbrKVZqdixc6Ol43UDPk2v1poDVTNoRqfoTPtiM0/jLYebdIVGlSlj/jWtwzxIV9u4PNP6s8VTpk/xYudhZnPqTFwgkZ2FjUS0XclffSydGKrVW1qNZHmUGMYho780QFU7dsGjTuxtlmP0b0e3GesvNPlv4Ena9VqgYdlFAaimaEu1EGAYPTnRVlYi3Vay895YFX7ew==
Received: from BY5PR14MB3560.namprd14.prod.outlook.com (2603:10b6:a03:1d4::16)
 by MW5PR14MB5412.namprd14.prod.outlook.com (2603:10b6:303:195::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 16:09:50 +0000
Received: from BY5PR14MB3560.namprd14.prod.outlook.com
 ([fe80::e468:409b:bfe8:4a00]) by BY5PR14MB3560.namprd14.prod.outlook.com
 ([fe80::e468:409b:bfe8:4a00%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 16:09:50 +0000
Date:   Fri, 17 Feb 2023 00:09:46 +0800
From:   "L2750558108@outlook.com" <L2750558108@outlook.com>
To:     git <git@vger.kernel.org>
Subject: When using git commit in a path with spaces, it prompts Cannot read "xxx": No such file or directory
X-GUID: ADC530B5-03B3-4DC0-AFA9-E6061E060306
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.178[cn]
Message-ID: <BY5PR14MB35605DDFA6C7F6CD9DF89202B1A09@BY5PR14MB3560.namprd14.prod.outlook.com>
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: base64
X-TMN:  [skKpzEfogplm6XpVJkQb1lTi9eJCNvkA9vdifnUKOsQ=]
X-ClientProxiedBy: LO4P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::15) To BY5PR14MB3560.namprd14.prod.outlook.com
 (2603:10b6:a03:1d4::16)
X-Microsoft-Original-Message-ID: <202302170009409521624@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR14MB3560:EE_|MW5PR14MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: ff24c83c-3c39-41ef-f173-08db10383a0a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01tBepZVY/DVW7Uf9gpOjY9FJQiGUino5WWDm5PN4yjQ4ejoNufpRR7fc0wDDLr45+wQSF/uCRBMR7EWrV3Y8RTX+PqiVgLRKmtw3DDoldCVz2szkm/Dyiw/7KCL+FMEkka0101tH9B4Jg6GYdC4wg4u+qkkXgvaQn6ikHGsKwnDhjuUWFFy26CxDhs46khGJCwvxQRrIfw7jgpcOUVv1T2bxFSlkocscEo3Hk45aTPPpv32fYULX0yiZBqK+CB/G5sjVpVSdM77BJb5BtvoYioumdRZoHZ597kd/PnW4gRIBkL0LBrrPpkKtyS+QjjaG5mYkv7W0jtj/uX37A4+qhxXRY+NYoAaoXuxd0x6365Wo+p62xVTALwTxKJZ1NINLm03SEyHtZJY0s+vfClapV2h/3SsztgELag3I0UGOLQuH4MI3/ekHbytMDcjtD/tQXZirjbAPyQZpC00QXtV2lJ9hsMUixEibZPdOTpaPcNuTnTpuyyPoR/8+i47ViVTeWDuNxL1M6uf3fcmjV4i9WMWJhBdRcvXzr15T6G9zN5Gm0xWc5icrLp8DtYSdcM9ZiF71Fm/HiNfKiBiGzXzwhVVJc7NvlPjxxQsF3PFYmw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vn33bftgX9ZehExsckry0bLFADbgLkv06aZxO8+7tXrdESSEto6khegZd/c?=
 =?us-ascii?Q?Ux5p6TWxJPoHyK4kXXePVAkH8xlTnwinqpmQYjWQZ/e0LTn6i43UZbEqIy9K?=
 =?us-ascii?Q?pNvtLUiSiHnaS4NoG7Fb0DBH2/mTkR1IVbt+fd0wuEEZm6tLxrS5Mv+UeNom?=
 =?us-ascii?Q?MHmWQwpLlBS7a5ZYYjbRpLfaK0Mtt0rG4WUcKfd67hRJir05PaMpdCZsLBkF?=
 =?us-ascii?Q?Pmm9BoAUr6lLcDtgnPsNmSYvf7vEyj6KitjAUpcb7qsa/4G/wpSXrN8YflSF?=
 =?us-ascii?Q?eHQWNEiIA3GUE6Vgxk/aNZyFBz2aOQGk7KYY2LedlUraEr+uSTjAoL/ICyVd?=
 =?us-ascii?Q?FeK3miKOqu9m8W4u96jb2ynYjj9xKGttNTTOHSTV82lARuU7Ii/Zm8jr/5ra?=
 =?us-ascii?Q?UMRiYLMQu58061kNOZuNU1jskL+ad250rac3qR3aLTs1KLDyVa08RTC4ZZhL?=
 =?us-ascii?Q?7QLvg8I0aiurx6AYPETTAaM9MAKRQYB83SlbjSKuzPPMwBnK2eGj+WLQH91/?=
 =?us-ascii?Q?TEUOb83dIVzokpolIDUlotdNH7g7s7qdJS83jPeli3J0RxpnWFIf1imgZA8F?=
 =?us-ascii?Q?M1cks3nt4e8uajXt+ZUgK7Fi0EicH5wxlej19YHCSIYG8F9lubF6kh2TcsTo?=
 =?us-ascii?Q?SvZn+rM0+UbM84+vIKzx5tqOai64A0XkywpLTexkqfM50JI3q7KjlDAFuFdL?=
 =?us-ascii?Q?rHJElB+kidNOfi96MrMf4V+pUMPs8N8bZ9vRHYIZFcPQZ0Mc4Sgip+bfmHV6?=
 =?us-ascii?Q?JBstte1oTY7inKK5IgeFWbHeWaWaqhujWAg3n6sr+S5OkbFxnC3twzaYQHzQ?=
 =?us-ascii?Q?XNiQ0ZgWBrwdY1kXyo6oToUJlD3VtW22LJhGCjmVUytnovadMqaLr9uKgNpL?=
 =?us-ascii?Q?OGUc1wTM9WPqVt5SE0foTlxSgXVg/NhX5kFYdd2kAsqDddNIUlASjzAxfiC3?=
 =?us-ascii?Q?64FVfQkkgvVrSSSItT2MpT30vaSSsy9yQuXLJC34hzc0XREe7pn949T+hnUi?=
 =?us-ascii?Q?zXSrNhevmKqGfZyY+Y/WYcuamnDwNjYDFPVbtpbROZlXcySaLX48fFSkTbYZ?=
 =?us-ascii?Q?B3ijPT4jdEruQLjl14iOm08PhY0x9QVesl0p89MuAosQL6Fp4gV9DQuRFBDJ?=
 =?us-ascii?Q?zsq4PVBRcoeho5rg7Ky5b9eL2apNu5X+fVYiXXDyaGgdsBegL0iJ8dAgah8c?=
 =?us-ascii?Q?wIAFXXoxngc8Cz4BlBVpPEzuEOPME3wkld2GuXgrBKar+5rHh3H+RuX4kVU3?=
 =?us-ascii?Q?8OXKfBRByuMgDnuVi1qGRd5JZkgybaLk3jDpmX0uHg2pALZs9gLAh2ZxrTTi?=
 =?us-ascii?Q?yH0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff24c83c-3c39-41ef-f173-08db10383a0a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3560.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 16:09:50.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR14MB5412
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SW4gV2luZG93cwpXaGVuIHVzaW5nIGdpdCBjb21taXQgaW4gYSBwYXRoIHdpdGggc3BhY2VzLCBp
dCBwcm9tcHRzIENhbm5vdCByZWFkICJ4eHgiOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CgpS
ZWR1Y2U6CjEuSW5pdCBhIHJlc3Bvc2l0b3J5IGF0ICJDOi90ZSBzdCI7CjIuY2QgIkM6L3RlIHN0
IgozLmdpdCBhZGQgLgo0LmdpdCBjb21taXQKNS5mYXRhbDogY291bGQgbm90IHJlYWQgJ0M6L3Rl
JzogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ==
