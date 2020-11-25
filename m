Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C5C5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EA9206E0
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CYU1iYNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKYIGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:06:01 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:49395 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgKYIGB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Nov 2020 03:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606291558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBoJ1GtP7bnXOQb8QGuSCGMIJ/psOPRsTq2WyMdd6oo=;
        b=CYU1iYNTPiY4GC4Xyx6IJoSPHnQfXu9Osqk7CXEHJvwahCvSOCkkziTu9HSurOoBit0L9X
        HsvAKTlCSQinJtE9EQ0gZG/GahHD/sO6QjyIj1nY9l4QVkzWGLKpVY4SPwbkN0FkzMQFRz
        aWHo+iBpSP2BIFi1obI9R2UI3Hrw60I=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-5-xGe8qXIcPRerBVF-EcnPdg-1; Wed, 25 Nov 2020 09:05:56 +0100
X-MC-Unique: xGe8qXIcPRerBVF-EcnPdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0qAThgPEyfakHN2njQ3u+ldhA5CDdFFu66B/E6zn17dSRgwfVaLf4bRCUdAb5c6SWgDlKXa+KTCjFH+aJ7poO3O1+S4ht1HZEprpAY1KGakG/53me1fph57mKHtQXz8rNWRLQ2EH6gpYN8HxcAbH7N94IJ2LUkoOBZQe6DJLPHSCiml+XO3GfCedBS5aHp7RRHUhz0uJ5h9zouHR6KUOJfxZrEoEEtWUVVqh09DyYsBqOeB1/vvyznwH4EHGuKe4WfICaJiOlJcjupozgJlpOD/fUbrWPpbexYHKJfmAYDizyse8jTY+txs1iWsHBfYZGScLyWobox5U01PPLauGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBoJ1GtP7bnXOQb8QGuSCGMIJ/psOPRsTq2WyMdd6oo=;
 b=MKRL+aAnrm3/Xe08cuPOtJuD1erW0vA/zYJLiemqN5xUhntw+kPYOnkKtqbkfzHqCodQE2XqqDiBKV3xGAjs1nRjjQWdZaFqjqGEW/LxDPAR84CQ+t1wI1KlrkXq6rOfGTCLBtGe/qeW8PFAIEB+4dXnlH/96uQS9fGNuO9d0KOYXFAMdns9nyiC25S4iH+UDCW3FbEKH+l77vMckA2fEzsPVHTBLm605A811+mA74Z0pZ1I9skwJuf+CJRvgE8B9NeXHqzppG50ZVK7EV15hjH/xC19hVcMYoUJyk3ujBx4O+JCwM/LgCvLk/yP67dgax2YTC4ib3ehTEX/GGD1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 08:05:55 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%7]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 08:05:55 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH] imap-send: parse default git config
To:     git@vger.kernel.org
Cc:     levraiphilippeblain@gmail.com
References: <76d2be10-0c42-70f4-101c-ee15e3039821@gmail.com>
Message-ID: <8a21b031-fbfd-81c2-1f91-eff8c03bafb7@suse.com>
Date:   Wed, 25 Nov 2020 09:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <76d2be10-0c42-70f4-101c-ee15e3039821@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.157.137]
X-ClientProxiedBy: PR1PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::38) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.157.137) by PR1PR01CA0025.eurprd01.prod.exchangelabs.com (2603:10a6:102::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 08:05:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05597cb6-b806-4bce-c813-08d89118ef65
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4858B2C99E65992B941A8A13BFFA0@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qG0xhAwCPFTQDriHoCx9r0otXV6emHrFhj0/+Q6nTsnokcD8atsi2uvnSpozcSFax2L/V9TnsBcBA2IM2yIOpvKXXXy6EYg4ItTDE0htNv82MzeF8S5NamQJukA31+IPRZeku4jOfz8TR+UZaAfRnqQWvaniEpbTLgsI/BJ8YMSGt5Tn0O+vY6wryTqeKdOWjUt6iiVUC/Fg1mOv1Kscje/G6CgaRjNIL/K/+wlsMus24dQplctyhkBin5FKfHyeBsJ2G1JJ+VcBbWo2pAA5iWcFN2sThKSS9mSSslpeeYhsqmg1lHAvfw1bQjBwGk00B/gz1DW4RhIcldV7z4uDMc7j6a5nWypHzmFJCyszL7sU4DQbXQOqGxU9XF1YnBCK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39850400004)(2906002)(186003)(2616005)(31686004)(36756003)(8936002)(478600001)(6916009)(66556008)(5660300002)(26005)(956004)(16526019)(6486002)(316002)(66946007)(66476007)(4326008)(4744005)(6666004)(86362001)(31696002)(8676002)(16576012)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?8qKH0wjdv4kZawTsmElfk4H4Dp+TjkGNTF4ir0GDTz7lLRYM0rxY7ysA?=
 =?Windows-1252?Q?aqArFV9ZuJhmqqouMd2gHPNtYf8SUNE+aM5PxMupII/+TmXrawU+3rNV?=
 =?Windows-1252?Q?9TlZYv9N0IMYeXdk90JlZx3r6FnPHDl/MRQV9d4+8Ee5GldlUl3qw+n8?=
 =?Windows-1252?Q?DWKRCCi4UidXYrWcrgWAQh/q0TMQbj/d2HISEuszt5qtJp3MpOItDTVl?=
 =?Windows-1252?Q?AGQJ/ExbbHQol4coFUpWUFlfmvwOKoHc7VAIpLLuirZIhkyhcBQ6a7FB?=
 =?Windows-1252?Q?zYmt0/sPfrPA2uQAmfTzYxVrZJ4IM4duRrb9m5/sRBaMcIGh11TED19P?=
 =?Windows-1252?Q?Ib2HNgfRKeODF8zMdEnPOnNHSK3UfzKyVxuei3rTyiAHmA8V35NZBHmG?=
 =?Windows-1252?Q?b053rcOfbD7wLDxr4MIqfaaG8h8jrHafofFyK3opPk/QRqZiswVznlqA?=
 =?Windows-1252?Q?SCGnHi6a07tIfcyfbbN2o0bdZVYQ94oZelTVrebn0hJ5j9MD0U3FW3Wt?=
 =?Windows-1252?Q?jx51lLwKseRjMn1FBoSPsMwASxD+uH06/jCVxp0DllTUnOoad3HQqQlv?=
 =?Windows-1252?Q?jO5T3Qb1nLLEnDuiQ6209gGgX1FQypSIC88JfepRCFNUSV+SQk0enaff?=
 =?Windows-1252?Q?57JCqQ2cLbxRxuafTyWFTwI7PptLLYRoCe4gCQK7zYBTMwSAS2FR6Y4q?=
 =?Windows-1252?Q?dWxXhIh+61OJzPzQQX7pR2nbYYsI+SQBcDOUtjh+jh9tzZCkePSNQRD9?=
 =?Windows-1252?Q?C7y3VB295XCBQXoIbPtnttAoVuBJg0HIpvoOzXpNOHzOvZwQPudhCpgV?=
 =?Windows-1252?Q?A+j8FYSwsM3Tbq5cYuPg4pUUN1YIjOda3rOWVNgpMyTih4wqw7dqWWc2?=
 =?Windows-1252?Q?x+Pb0TSZVaFynfOVmlReYrXZYSGl8hY1x3/F+wrGJXnAalmZrLY8w399?=
 =?Windows-1252?Q?SIpDhsmS+QzZqtiOwSiLBbo3U+wA5/4PmlZFFjyI/FZ4cJuVVHKiEI/Z?=
 =?Windows-1252?Q?V4OjkT/cXJm5ing+GyyBE4eiIKqtBQNedrGYcIy2Gnba4SSJWE+QRIU1?=
 =?Windows-1252?Q?nyaxol7Xo39w0388?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05597cb6-b806-4bce-c813-08d89118ef65
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 08:05:55.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snIxRKD74Phc7mq0hVmWIhgUmFLTf2xLHQ5ESRVeOHaPO50DFSRP9BVW6M9bjBjZrVfve16IyfUPI3t0KjcxqnBE/DAa3RX2/mi/xaFWGvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git imap-send does not parse the default git config settings and thus ignore
core.askpass value.
Fix it by calling git_config(git_default_config)

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
---
  imap-send.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index 5764dd812ca7..790780b76da2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1367,6 +1367,7 @@ static void git_imap_config(void)
  	git_config_get_int("imap.port", &server.port);
  	git_config_get_string("imap.tunnel", &server.tunnel);
  	git_config_get_string("imap.authmethod", &server.auth_method);
+	git_config(git_default_config, NULL);
  }
  
  static int append_msgs_to_imap(struct imap_server_conf *server,
-- 
2.29.2.366.gb291b0a62802

