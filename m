Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04C51F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeHTVlV (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:41:21 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:36896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbeHTVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwonVEjKd3mzwLj3bHbF052WQuSFuRd1lOWS8cVhxNY=;
 b=IXfNcb657elsEvEt03hNj/eFSYsfCTpxf1+PEbHYHtvWrw9WfjAzGltqwlZqmzRMZlW+u9BbQT2RoXTSg47TknstfqZNxblAo81to/kWQ3AScZQ7x0iIe94Ma1Czg7NGmGVQGK3RtXbMo4F/oxxnkKfhRDSkQ16sIDNaSakGwL4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Mon, 20 Aug 2018 18:24:35 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:35 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 7/8] commit-graph: not compatible with uninitialized repo
Thread-Topic: [PATCH v2 7/8] commit-graph: not compatible with uninitialized
 repo
Thread-Index: AQHUOLMKqQN1Y9klkE6m+dsr4ZehMA==
Date:   Mon, 20 Aug 2018 18:24:32 +0000
Message-ID: <20180820182359.165929-8-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:isEoVRJbgbWFgOkV1zFSy2Fr3xn2vkEK0gY1FyDeAcI7SQokS1tyyJneXYpMVQMUZIqrrAgZFI5wjkKIfAc3nANFIAaUenb8kW5rFT686OCzVv9rjCyIHqla1AkUdUEM1MPZw7Qno23+Ike9HjL4waH6ZoaS3ZAcVA2C+hJt7UVN4E5G8AhSHjRK6a6q1TIMQDMAgFW6d5c4NASSl4MAI3YA7Q4UpbLGT59Ky8iZi1WITMfWpnx/87KCX+Ex7SfAu+OFbQt7XwpknJ7i5lehzMxRnlW0umZrqyqKikmSmzZYs8lYkYeSdNpOqISYo0NKyOhf3OtgWvl8aeqUU7GqHyrZZzjVYkRNX2o0xtxhAYLSElJcYg2VoiS2fkR8HlssL5Qi67w4Q1JA+Y/I3oQBpLTPbEzeep2WZE2/7uBxY4g65LO1uw+5oH3pQx9WuhWVTyoudSXqWop/kj137StzqQ==;5:uL3VbUQR42uPnppWLGl8qIsvRMklwDMnbMQH7idUGYRLlxoB+fKQEMBMz+KjcihAnqMtA5DBIvKBgCifAGjih9TWzeTHLnOZ6X/E5ZDyFQwNljozpXXmh2VmVtIs+8gU9xiA8VN99rhH8VoMdYSnXi6KeH9gvhXuKVJK9jltSjE=;7:1wes0lu0vYSiTpUf4wqyrz0iypEUyKHhiIGdt5DTyrWox++cEvy//xguZxv50ZZi8M8IS9zOrGXbui0PjQAnEL1QMO29/eohXutqeXOgQyL+LD9SIMAmG9d8OreYYDFSMD5cvPwLx0In6QC7ZXXNXaKjJgilPZYR57OUgXxPx6w4sw/Fvi2qxFO/c1kwjSb8R0RGKNBc7XtfpJIfwa7Rbjy9MUJf+UcTh2uUv5a1H1f7i9BxW0fe6phiovbpnYr7
x-ms-office365-filtering-correlation-id: 3f266feb-f420-446b-f245-08d606ca2c94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
x-microsoft-antispam-prvs: <BL0PR2101MB09294D9E0D11F69BE1B9FA00A1320@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(2501003)(6666003)(305945005)(6916009)(256004)(86612001)(6486002)(14454004)(86362001)(4326008)(25786009)(1730700003)(8676002)(22452003)(81156014)(39060400002)(107886003)(316002)(76176011)(7736002)(99286004)(52116002)(54906003)(81166006)(5250100002)(478600001)(386003)(186003)(46003)(6506007)(102836004)(6436002)(97736004)(10290500003)(6116002)(68736007)(106356001)(53936002)(1076002)(105586002)(5640700003)(10090500001)(2906002)(2900100001)(36756003)(8936002)(2351001)(446003)(6512007)(6346003)(476003)(2616005)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 6ufecNsVYv21NFL2Et60CyLM3I7XCT+BT+WAWUAxY8YU42hdNX6bG3epCTHdx2BBNKgq77YLZ/3KqHxrVsZ7LJNUlXEpmqxehViE7mklEHZ1ERHueCuGt78/uRJCIb3deY8sjcF+pcumUhT9+mRYI2Lat0MeQ/WnR0xxuXIXXbkc43ohhqG6srLEgEc5MAU0FzYGN7EhfgasL+CyV7qAyJMY0IITipB8YjbJ0jTFzwMCn1NhwfLmO4/Htw96Pn0HAaGKNXuz9QkV/wU98Y1gwzi5jaivolq2ZuO1rAIZngI00MODxVsG7uHiRqul4f2pTIncxyhbQu11IMT4Oui07lOUFnczVPIDB6LC3HwMfVI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f266feb-f420-446b-f245-08d606ca2c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:32.5947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index c4eaedf4e5..cee2caab5c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -62,6 +62,9 @@ extern int read_replace_refs;
=20
 static int commit_graph_compatible(struct repository *r)
 {
+	if (!r->gitdir)
+		return 0;
+
 	if (read_replace_refs) {
 		prepare_replace_object(r);
 		if (hashmap_get_size(&r->objects->replace_map->map))
--=20
2.18.0.118.gd4f65b8d14

