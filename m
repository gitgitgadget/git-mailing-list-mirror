Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94636C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE87613B0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhGNMmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:42:42 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:25060
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231391AbhGNMml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAzzBwtCbqozGYmTUYJsGDj5ON7MtGljqo+RzdWGrD/zhXywB4Qz6kWAcEIZPJZNSGyHA50tsfPgy9d642qZGMW2zFPe6vpR1UFj4d8QdKD45mSv03rO9gDTliKGk8EXCHKeUwOxM28YC3cWcKPH/Ph9DHR+6ya4Yc71LUw5eVXx9R0tAgN2fn1HqjtURKQsoUgESlOjSJ08qc9U0bYova9HLrXNApZ1/C/ImyRPlVodVs7R7I3qqlSTKqGuRxrwL1WkK5O8J+kU045CANVoBLgo4HIHKekFw3u/xFs+3Uo0mZI3D8Ist8G7rVmvRw+AhLJPzaHO0vvJsKVX9uCqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKWjt1r9QKwRjRWmn2x0wDQGwm0ZdZz5PZqZUVGVyIs=;
 b=KyVfFf347ln6R3h/v/qWkGjFCrQE8p2xBlPV8p93G0ZWpOEvzsT+dTTWDga+wsz95qQy1v57ZK5y3/o3/BJ6q2CB88Pz/emjK8JnJAeVcmwiis9QBO6kfO7dLnJZJIs6SUKawwXry2hg86S5LPFDsUEap6ZTjt9n3ozHJd1ptVa57SG8phVmAW3kal+seQJd+P3qECs3gSCPzhucfoGfzHiXIx+G2e3+zPCrXRtdcFoslItx7uGT5eL5bsCITp1kvWHTY2nExoIrrYOqMJUfwhYWpgRi/muM16IFfiqeM4z5+9LTmRlKVXbbhTGT7VvbIYhsSgK5N8gg4Iblt2jJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=campoint.net;
 dkim=pass header.d=campoint.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKWjt1r9QKwRjRWmn2x0wDQGwm0ZdZz5PZqZUVGVyIs=;
 b=l5rpc332K9DpQAqcICR7t0iYaEw++uYlsUebRk128LD+hkRqLvDhB5ukvlAJ5YF82FKUYIDroXeNxA1fTApXJvfPaGPs/Cd9e+wpRvllVcL7qppfa/rLsDFlQwfMV2+SIwZEeOdfaIcMLrtGF6gXsvmhOZgKFxPmGYngB2juC/k=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=campoint.net;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 12:39:48 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 12:39:47 +0000
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Fabian Stelzer <fabian.stelzer@campoint.net>
Subject: progress test failure on fedora34
Message-ID: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
Date:   Wed, 14 Jul 2021 14:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0128.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::25) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM0PR02CA0128.eurprd02.prod.outlook.com (2603:10a6:20b:28c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 12:39:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055bea6d-4165-4cff-e744-08d946c4772b
X-MS-TrafficTypeDiagnostic: PA4PR10MB4589:
X-Microsoft-Antispam-PRVS: <PA4PR10MB458902E8F0E86E807800AE4CB6139@PA4PR10MB4589.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:41;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfjHmD5tdS+3ysV9xNOcUyhmnkOlrZIjgFPmXbboaWY+OHqxGBsp09J6GreNsAzYliMJrXp0v/HczAO/mD0p4qiqxZRl+nZro+73e2YqpkUUXUO5N+ZIYuStht/9pKNucj9aSmFo7DH0dCpDyAarjunbRICWG2qPfaLbubs0OVOloRHJXKB8cq3g2ASvb9pAlOSRfI6WVGqlP6pjOl8F+MpiVDnaScoTJmzdeiYUwEeKyEMlUtpB86fBdifeughKI1dd8hsMV0a7NRABJEvFpLWbIPZ0g1QPJHw2jbq8hcej4p1sEdhLPBavqvkQdP298UeGvG+3pWOTK1ir4c9Cb3/+IfFi2HiymQOEyFIcZbyddj98j9LTIhVJfi1+ss7CDYlNiT3giveLVp19fJu4wlhQSSpmjBdRnMcOhN4bmtUlzn+KqkhFAgWgkBtTveAv4P+9gosLSC95YgCk1kRfykiqREthUEnRFyOQ56FNub9yDUJTf1Rwkh6zTDF7uPNNz9YVRqjcfhRKoJqsIz9PkB9Kwqiyr73IxiLaoxVGWiTd1qlxlmhXudxOk4ND2yjm/TLAMWv6tIu94Q7X3iyVEi6FFKCfM+eBEon2zUfojGxY405xNqVg5Ihz2NEvxTo5UJtAyZbJPyEqwUwjSKpmqCeWG2fKxw5iY9WzDGN8F5naNACI5bUk4oipLmYTm+CgESE7xVJFqGhV+CyLJkBz81cophrKYBxFvL1nTZJtEEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39830400003)(136003)(376002)(42882007)(31696002)(52116002)(6916009)(38100700002)(2616005)(2906002)(36756003)(316002)(6486002)(66556008)(44832011)(66946007)(186003)(66476007)(5660300002)(478600001)(4326008)(8936002)(31686004)(83170400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9iMUF3TkFEVzR6RS91bmhic3ZPTGI3TUxlMmZsNGxBY24xMXo4QVNmdTA5?=
 =?utf-8?B?V3NSbTVvSURBME0zOFNFVnFnV0RjMzNuNUl1OGxqcjhDblJ0NFZocGprMWFI?=
 =?utf-8?B?cGt0MXFseURKbGV1SkRPbU0vN3h4SzEyeXlBOTNTNXp1SUJzMDJDcW5MMDNE?=
 =?utf-8?B?ZTJmMXpqU2JrdmVFR0dENnRIZll1VUMrQ2ZXVzBVYTRyVlQ5TUZhOVVIY2NK?=
 =?utf-8?B?RE5oeW14N25OQ1hBci9GbjhHd1Q2bW54YTE1QllITmw0eDU0Y2pxNjlXNlp0?=
 =?utf-8?B?L2xCM2ZMMVVtM1pma29HcWVwTVpHMHU1Y3JHcUtMVzJxVVNiL1IzSE9mQlNC?=
 =?utf-8?B?KytDOUFDTUNTcU9aTzZ1MjV5VnpudFRjOTFlOFFLNWRnL2NRS05aV3ZFaDVx?=
 =?utf-8?B?cEl2czlISm5henRiR3ZWSytYL2JRUkZRVU9uYzJFR3JUVzI4Z0JkVU8reEpx?=
 =?utf-8?B?QXRETG5nTDFKU0c2Q1NGMndpbGRESTBhR2ZublpPekZMSENrNkZGS2RYR0th?=
 =?utf-8?B?aE5sQ2hhdklZUG95ZUthVGFqSWZlZENvaGkzY3hTZ3dZeTkvTUJZM3lXOS8y?=
 =?utf-8?B?eUkzanc3Z0E2c2RDUlFNb3prRDdEbGJZQnArQTY2cmY3S0w0dmVVU2JwNWR1?=
 =?utf-8?B?Q2FSRWlFbHVnT1k4THVtMnFTZnB6TGlJbWtnWStIL2VCTE1uOTA2Tk4raXdD?=
 =?utf-8?B?U2lyeXV1YXlENmdWcXdROFV0K2VyWWo3YURZUWNZZko3VFMyMituRlhEZUp6?=
 =?utf-8?B?aVExRmNibVZZSEdUQ0V5L2N5ZzJMZjJzUlMvTjA3Q2lSa1VZdUQzRmNXUmtv?=
 =?utf-8?B?T3hZaUEwNU1zelBSOGtVa1dTOXc3dEdSeGxhaXBFS2U3ZGl3NCthL2t2ZDZX?=
 =?utf-8?B?TThnZkJNaS9ZOVZsd0gwUnIwK0x2L3V0NEhndDQ0Y2FDemcwVk1SK09sNTcv?=
 =?utf-8?B?TmtzUlRLU011emN3UGpyZXJGTjJhY2MxemZWZGx6TmpHUWw0QXNaTEo1cm9o?=
 =?utf-8?B?QkdEYVR6MXFsN0NyM1kvcTQ1N3hCU1JRUm9wU2RkSVEwQXJnTEY0TkI0TWJw?=
 =?utf-8?B?M3BtWUd3RnBRRjZPQVRFMW9EMkJwTHU0YXBHazZxVmNSNS9lNVRsTjZ1dTMr?=
 =?utf-8?B?WnJSZVdTbHI3bzV6VnIxOGZKdEVOWEF2N1RpMi9qZFRhZWgvdmVCV1pxaDBG?=
 =?utf-8?B?VzJERkNJbTBZQnZlV0pxQy9FdWg4MHRyZml3UVg3L2RZWm85bkNDYklxclRx?=
 =?utf-8?B?Q0lMTmg0ejF1bHlGMFhoWkI5bytSOUVScm9XYWkvREkyQXdZZ3p0QVBuOFVu?=
 =?utf-8?B?dVdqU0xBcGlZaVRzaE15WnJiZHM4bEFHK0x6UlJSZzh0R1l1NlJoZW8rV0NI?=
 =?utf-8?B?OExrcHJuY0hNMXROUG9rRWkxUHJnOUZSNUd2UEUyZ2tSMG1kN3AvK1lHVisx?=
 =?utf-8?B?NThwbGI4MStzS1ZyYmlnT3Zvb0pIQVpvV1NWT2RLaGFUbnN5TlJENVRLd2ha?=
 =?utf-8?B?R1JRa3UzMTRXeFZhQnBpVmZLZkNFeHY2S0Y4U0VVVi9IRXBVUXJKZXRBK1I4?=
 =?utf-8?B?ZW1KMmVnR2FXTzNJZ0VnNjMrcXJjcXVjdzVmT05NdWlDMW1KQ0p4L2hFNVdv?=
 =?utf-8?B?bUNnNVYrV0wrOERaWHhCcTd1aGM0cHlEcW1JMnR3dXBoK3NEV3QzTzdPUUc1?=
 =?utf-8?B?aGg4OFpVU2duSDNBUWExcEY5aGNvTEpieUFwNzZSN3NnYUNqU0hMZUxPMkJt?=
 =?utf-8?B?STJ6SFVNeVpLYnBOYkVtSGNxcmVRV2s3QWhEN21DM1hFRnVzOU9DcWdrQW9a?=
 =?utf-8?B?Q1cvSVEwaUcrNHZEanA3YXcrWTlPbzkvZUdGNVhHU2xpaDIyNEhtN0VRajVt?=
 =?utf-8?Q?CQmL2i6BzIaJK?=
X-OriginatorOrg: campoint.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 055bea6d-4165-4cff-e744-08d946c4772b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:39:47.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFUlp2nv5vo8b287UkCQwaq+SnZuJ9Jj1GQH1zTUY2gCX/m335QwIHeVib/ju0RJn60uOWVHHeehijRgcLHtnjbvczaVAiDz7igrT0LlkrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4589
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
The test t0500-progress-display.sh in current master fails on latest 
fedora34.
The break was introduced with:

83ae1edff7ee0b7674bd556955d2cf1706bddb21
ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit

Kind regards,
Fabian


expecting success of 0500.3 'progress display breaks long lines #1':
     sed -e "s/Z$//" >expect <<\EOF &&
Working hard.......2.........3.........4.........5.........6:   0% 
(100/100000)<CR>
Working hard.......2.........3.........4.........5.........6:   1% 
(1000/100000)<CR>
Working hard.......2.........3.........4.........5.........6: Z
    10% (10000/100000)<CR>
   100% (100000/100000)<CR>
   100% (100000/100000), done.
EOF

     cat >in <<-\EOF &&
     progress 100
     progress 1000
     progress 10000
     progress 100000
     EOF
     test-tool progress --total=100000 \
         "Working hard.......2.........3.........4.........5.........6" \
         <in 2>stderr &&

     show_cr <stderr >out &&
     test_cmp expect out

++ sed -e 's/Z$//'
++ cat
++ test-tool progress --total=100000 'Working 
hard.......2.........3.........4.........5.........6'
++ show_cr
++ tr '\015' Q
++ sed -e 's/Q/<CR>\
/g'
++ test_cmp expect out
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect out
--- expect    2021-07-14 12:29:49.576970165 +0000
+++ out    2021-07-14 12:29:49.580970145 +0000
@@ -1,6 +1,5 @@
  Working hard.......2.........3.........4.........5.........6:   0% 
(100/100000)<CR>
  Working hard.......2.........3.........4.........5.........6:   1% 
(1000/100000)<CR>
-Working hard.......2.........3.........4.........5.........6:
-   10% (10000/100000)<CR>
-  100% (100000/100000)<CR>
-  100% (100000/100000), done.
+Working hard.......2.........3.........4.........5.........6:  10% 
(10000/100000)<CR>
+Working hard.......2.........3.........4.........5.........6: 100% 
(100000/100000)<CR>
+Working hard.......2.........3.........4.........5.........6: 100% 
(100000/100000), done.
error: last command exited with $?=1
not ok 3 - progress display breaks long lines #1
#
#        sed -e "s/Z$//" >expect <<\EOF &&
#    Working hard.......2.........3.........4.........5.........6: 0% 
(100/100000)<CR>
#    Working hard.......2.........3.........4.........5.........6: 1% 
(1000/100000)<CR>
#    Working hard.......2.........3.........4.........5.........6: Z
#       10% (10000/100000)<CR>
#      100% (100000/100000)<CR>
#      100% (100000/100000), done.
#    EOF
#
#        cat >in <<-\EOF &&
#        progress 100
#        progress 1000
#        progress 10000
#        progress 100000
#        EOF
#        test-tool progress --total=100000 \
#            "Working 
hard.......2.........3.........4.........5.........6" \
#            <in 2>stderr &&
#
#        show_cr <stderr >out &&
#        test_cmp expect out
#
