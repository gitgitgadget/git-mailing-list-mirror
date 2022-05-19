Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB0C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 16:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiESQTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiESQTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 12:19:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2035.outbound.protection.outlook.com [40.92.98.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B2D028A
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWoCB2Nr5N+RNJ0WdSTE5PrTyl8dI9Ej+t6+Nl8O2pYkerZk9NK8c1x7fPRfmrGN05zXkuIvfcUgvgul+MZVgb1JBh0IW88Hscv1MyPmYAmaEyi+P4dWr6H2+3OHurSzYzOAlMBfjEQLrpPa4Gg/gUDu4liAC0S8kIs/whGRZPhTLaitEi+2ESjVnBtzgj2XNlBqflF2xuT3E0n8voZo5YDO38l/k78xGa6k8uSqlNXHpcA5JVYrF3qY3XzRzzpV+M7318fHWuuXQtnFCAHNTTCyiVV6GQ4ZiA9AKKs99XWiyqrsSW4Yn1l3W9s25VxbEMuR+7woivgbqU6ts+9/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ScVg8DxHp/lANVH6ArkI6bSyJaK7R4JvRlQv5LZryg=;
 b=MatGtnvJzZvp1qBehvfFKbWBvsa/T1puR53bdJdKBMW/kLCIInmZsS+NvqWFujjtZa+VwY43Skg4PcZ2ucq3TLN3in/wczD5VNY8U+hv+e4SHsPKpRAKzadWB4pflYoERys5JfDTnjFLKRRfXnP2a/Cl9SYJ9t+F2/vYqGCu0qtjK3xjv7A2obnv5Ro0hSUnOsooZSRuBmFrIXw2UdYyPPZncnf/E+jno5qimP4Zrb77aQAImMHKU7eOOhmClOfw7Eeg5tKVQQS2IP30LvAW9fAfeQlvamqUqIJszbA+CVmXsHVdoEoIpnfzQk3goh357gCz7k9c148UEdavqPnoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ScVg8DxHp/lANVH6ArkI6bSyJaK7R4JvRlQv5LZryg=;
 b=WHPVwSLSVwJPAq/pqY0XZgVPgxlCYNurENQEAs+idHnDATOLT9LhM51iXFb7LqFgO6DSsQ/D5QVrMDToV6dLt9xjGPs3IPzVNSvgD6BsiJ5vnauZGMbLZ4fpyQd0llfnLV1InG90Anb2HWFVPUmwxlbeLKQOauUTs8nZJJKUqAQPlcZUTN05MGcWrFV6qfkQ2+cu8JhoWZD4/ylG/y+kO4sWoa2IY2yYAO1UYzHnrHY8c3jsSJa9dcWHMLpEf593l3xJGej57CO+DN3fZ1pVWkU2CehTtUZBn/f8GWxP1BzXpdhmtucQACwxQPVuLVyLPnzgpYoYHuG0ecUF+t/NAQ==
Received: from OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:88::16)
 by TYAP286MB0009.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8030::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 16:19:28 +0000
Received: from OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
 ([fe80::849e:40ad:6c61:7ed4]) by OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
 ([fe80::849e:40ad:6c61:7ed4%5]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 16:19:28 +0000
From:   Yuyi Wang <Strawberry_Str@hotmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH] Add pcre2 support for cmake build system.
Date:   Fri, 20 May 2022 00:18:26 +0800
Message-ID: <OSYP286MB02627C53ECF2C03B397556E3F8D09@OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <xmqq1qwqts6w.fsf@gitster.g>
References: <xmqq1qwqts6w.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [n9JbLEf6v8FQwJ794paB2jcyDAvEmerz78+WV/1DKotsn70CfD0qlwSwOENnQGaM]
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:88::16)
X-Microsoft-Original-Message-ID: <20220519161826.750-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd21cf55-f249-46c3-e22c-08da39b3589e
X-MS-Exchange-SLBlob-MailProps: LzDHi3doVoKUd4xFeXOdK2ytir5Ckb/8MVFj3FAPrHNCz0qbESQYUWFv90K8FElfrPrEfYtxDSTU2ymAt7Xk/z8SCG43Yv1zjedJJPukOBIKgsjHjefkCur+AYXu4P1I7tSigX+rP/1zSiPq80X1VbUymnU4HbeS7bT79f3E+6IebnAozqBVqZ7+z9L1rDwsWnYhrJjpdU3i/sjoQ/ShHNQQhh2HGBdk6o1ToghzU5yS3x7bm3ovCSq9fb0O8a3gtYXGSHSX1pfT7DJgs0KaeFJrB8MsKdjM3wS24YoDRkh2dlWxJqBSo+VDOtkuEERM+KaoUWeA1lGy6aDOW66Gp6CT9pacLgZdgS0euzNmRBdxZHNXaBNaRgrpuLnGzvxYmgQzX6vAu6g0n6vD9BcLHd6rdOI//DiUVpCrm6D85mRYp7hyyLWougsNSJwl1upNTS77yeSzuujwO8k2Ix4Ajj9PVMVbmhkXbZYQH+aCZLbJ8x0N1u3nZV14AKrs7hGNn4ag/IxdwdzwOzEx/TciCZt+1GhLDh2hi07Ssr7Qb4nitLtsPygOezQRNSr2kjncfJ7UaSC7yezKXQ8L7hy3RnnRyNivjPE4wV4oVZHQhsCx/FSONf50C0TK1ND7zedU6PHFKDFLTJDPZlBLb66Mm9SH3cwWjlJtP2le4XyYKpUpgEq97zbydFvpBaPGywGVgfN/OP/OvV/uEqXn1CNt3sioBS1cXG57UImtK4AZDjY=
X-MS-TrafficTypeDiagnostic: TYAP286MB0009:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILZjT/nHpAj4VhApaYTS3mYof2IJnHtvgwBPUMXIa4zvBB8CWR/PQDtxn9zbgCslk/GqvN/QclNWdG+phOcRX+3EuZAOTJM9GfCocTH/UpU0JuLik5SOVbPY5BNNN64fTBnjEFqQLMRcnjiagi3uPbPN9Tjs9A5iu3saS/DtofqygjrHtvITQFnzP9t6XIpeS60RNG/TFjGgsHX9bhcb3ddIbnxdshVUSF1k9GR3wBlM8OPaJtR2Ctvl/phq+8s3KyLCD/mmbx965r/rXjD7uLO9ML4K8zl4vvHtBVZcxmCShYos9yMKPu7nbKbDru6AN1RijEvC+Ak/87PByI9o9A6ubWLRKZt2QGcZMpDZAFGwvXGidRx+n1GaUc168WsgXclI63lUZaDyHRJMrmwkJcPXk458oDDRM4/7X4wD38lxtZpjTdm47Hj1iybec+A9Ys8OOdhyLWK70Q2hDMRYbE8pgM6ATpAxT9d501/SVzkhqCAxcWrXuwm3OwzyAMC3VoARoO5vPXyOYd2awBHlZkXbLpd9+MntcfPFviN+G4cFQrfgZvCoe9EaFykjSF/R5efCRBdV38swmVEvHLKK0A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wrIGKsoSHu/r8eGWaWs0LYI/DjQihGD41EO+K2O5f2mvnKaQBld7+tg5lsq?=
 =?us-ascii?Q?Zn6p5DUJE+LubeL7XfVaP1ErHtuQO6RktOApNghYsKOAIP+T33PYAAoRfr5T?=
 =?us-ascii?Q?En4kdx3edG54QEvHVcJju6YYOfMbLoWTvLygKmSpbw8/XoDdJh+5MZK1jKpx?=
 =?us-ascii?Q?bpzwBfA213V4FJvOn0Ya3+DetKH169Vl1B1RMNqDCKqFST+KaeQyKEP6ghCw?=
 =?us-ascii?Q?KJqQBDr9crfIBeq9yNZHaPvjhk7hvsEnlUhVY0m59ySDDPbK6baGovwBGt0D?=
 =?us-ascii?Q?LFcPGBSMArDjtfCJ61gUYPZBRG/Nyh0aGplmpKEl3Y+qKrSONrUMs/N6Bt+N?=
 =?us-ascii?Q?p1N88JIPp0+ph6WGC1ShL1o5hYeaYU+sJ8P2yRHpOuqLOlTQ56HoVOZIr12s?=
 =?us-ascii?Q?NQkizOhqn7nd5ReL87kGEYbQmPoTo0IhTAveSJsXL+KfVPVJyg5NnshQqfOw?=
 =?us-ascii?Q?NIkwqxU0aLJM+sAgL3USLW4N68oULqFkwjx/35u1pBX2II7pNTtRY/aWua3n?=
 =?us-ascii?Q?C65dSjchGCWyJY4Ms6ZZ0iNg3PS8L485sPAnu5akfAUxQABaGB3njOHumiCJ?=
 =?us-ascii?Q?03voMSPmM0yLQA7Q57Hc5IqiDJxbn6oAwsUmh/8+LfB7EGvHhhC0+Fx82i/g?=
 =?us-ascii?Q?W6EsQa52OfhjBvpdcEmYtXx++1T3L/6hfPdFUG9L8z5tct9c2rfrtmKJaivc?=
 =?us-ascii?Q?Q3sPtfTQLVe2o4x6xDzMLB/6dqDRXc2KI/gdhBHXT+c9kgRRrxzB3diL+Ozt?=
 =?us-ascii?Q?h7rf7b0i7nfXqgJg8Sc+ZbrvvWiSFoyVOldBxMkbfK9hMapXQFO96tHmrOXd?=
 =?us-ascii?Q?F/pqvlFx92kTsTIGUa1ShADYmqpwQrAygKr1UBwhGMmIZ5FhIxaChXttpXAc?=
 =?us-ascii?Q?23393x60JvrHftdPyyqfJ/kDJaJ4R+AQEsdxIcCu7tYqp1LLFq27XdeNKyWW?=
 =?us-ascii?Q?Xb9TuIT/JLr0wIzCLwacEjriiHxsllFb8XXwquPFJLyElqVqxoF+HXwS7iqm?=
 =?us-ascii?Q?AyIoSaUNC4qr49lJislCn2Q9bAh5tuAFSQnV61aVkiCaG0DjFJE7NLLVIkAw?=
 =?us-ascii?Q?5pM5V/rqeeGGuIlTcuZMhR0/YrURDTQHqH2EoKDwwlbwNvxh3UehbqXtYmDX?=
 =?us-ascii?Q?Mn6WPMEpRXq3H4tEcRFKhcwCBNqsIrve2sYupKyPPb1bkeNSkI+Pfv5l+qKx?=
 =?us-ascii?Q?4J6Qg4Dv8SLj8KiWycs1zYh8cj5gE5Jofjpv4CcCPPw+zpyFG6w2stIxNHWV?=
 =?us-ascii?Q?AX4Nbc0dzCcB6KL8qP5BJA9uIML9aOG7Si20HU6gStlraI3pC27BZ6GvsHZk?=
 =?us-ascii?Q?q968AtWO4QY8cB9Qq7GcAvPNtpl/JP3OjmFz8rEyVg5cDhYk3vW7pBXm2vKD?=
 =?us-ascii?Q?31bCkO7XUshS7hAh2mnXWq2cx2R6TdQ5PQQmWVAw33Ax6JXGuy+sQkE8P7Ys?=
 =?us-ascii?Q?RyTyeDG7PswRn+JrZb0YIGymLobjMQxytB/5ApIbu3Nu1EdLJxXM3lcw3MU0?=
 =?us-ascii?Q?LOVsucmIO6Aq2J0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fd21cf55-f249-46c3-e22c-08da39b3589e
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 16:19:28.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0009
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Is this "small fix to ensure it builds successfully"?  To those who
> do not need/want to use pcre2, is this hunk still needed to "build
> successfully", or is this something that becomes necessary only
> because we have other hunks in this patch to add support to pcre2?
> 
> If the former, then perhaps the change deserves to be its own patch
> with own explanation why it is necessary, what breaks without it,
> etc.

There are 2 fixes. They are all needed no matter pcre2 is wanted. I'm
rather surprised that no one has noticed the CMakeLists.txt is broken.

> @@ -54,7 +54,7 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>  
>  option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
>  if(NOT WIN32)
> -	set(USE_VCPKG OFF CACHE BOOL FORCE)
> +	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
>  endif()
>  
>  if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)

This is the first fix. The original line didn't follow the grammar
of `set`, and would simply fail.

> @@ -277,7 +287,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  
>  elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
>  	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> -	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
> +	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
>  endif()
>  
>  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")

This is the second fix, to solve the linkage error on Linux.

You're right, Junio. These fixes should be their own patch.
Should I remove them? They are still small fixes, I think,
and could I submit the two together in a new patch?
