Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622321F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeCOW6E (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:04 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:18444
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932537AbeCOW6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yw5Cre1wefirxNri6ORzCepBwKORD3Rrurh/nB5Yu1o=;
 b=pp4iSckn6w3/L61L3v0UYH5YTVYqSYMKYbVnSmI1IQ1liST5J5+E5KigaY8A63kZHWsUofRFpIWB9FvHMhwNI8+bG4zYU9rjvSh7rAwjTbvBr4x55Ko8LnYXuONeioproSKdqdJKBH8uZhL5wDlGKgDaKMlWKM5FBF5Cf2NPVs4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:57:57 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 01/10] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Thu, 15 Mar 2018 23:57:37 +0100
Message-Id: <20180315225746.18119-2-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e4bee3d-4dcc-48d3-8c21-08d58ac832f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:w2qPJK2wdypu5dxJgawiDjBc/cEfOGvysYBnq1/g2izP1+BQAdzFGkVjygc/MkosCy4IoDo588Z2X+KBx0Y80Lv7HcxEKrY2lIkh3eeCjXKqPauWr5rfUGcRAq5VCgNzAwfcIWMBvmvoZhu+iGVZ8LjmH8DLo0TK2Ec4ytzQ+/CTd8TG0ext7IhhVQzDPVgijdldAE5Oi90qMHH2DdMcGcLzrtb0tpoALjcJJ71NWbyNebyrdFhIKyqSnOcrRBdj;25:711bUAxkW9kOkWakSMPie7mUpRYXOw0yxX7rCp6X+tFXpYjzyGk5bTO7C9y81C63s2Uhis31jLg28rY8Eb72+X+qJvzSdSfZbL2LEGs/attWdQaxjegb2Cj360PRTV/dbPvSchkn6lH6/f6m+g/+aGMVMI7JZJPrhqwUHYQVS2RnQjnRjMSkgviB1PfXAgnTsllSYSI9S/BgTm6eWPGqoLWhGGVv0U/1ONkhy5uoKiVM4H2pFxh0ZUusNDIzHPJWSWxiNZJE7qheS8MEfehTw5W0GSm7LwCxKt67SGrKOu0DHzbN4I5WnHD008tDHxKzL8kdbzhiYP6Skpxt0+C/Zg==;31:pNrVnxVvS9FzT/YJvCzedARgzUSaKxbvkvOoipLVzy1ZGpUgE1uhSGgaPbXrqkqe5pmf1vGavP3YyOtKLVSDBtt5pXJ62iljvrJxhJJ/evYMxVPOM4phza9+viNCa0bHgOoLg2//bhvdEQc+yvep6i2tpS0c1May1FYPFkJGeStyZc4KBn9oJMCsRUPBMQ0iIlfTjnMQbiY2mlt7e8T3ssQZcDUafqBhwBnluhJTJG4=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:LCsTLR4wmcc6BPdavUsY2WOPOclbYohDxg5i3VeGb8iL578ralTbyTs4uB67+mHeVll2q+1KiFZK5LVmsUXDA6oVuyKxbfmsafYPWpc60zPWU6Mp0aJBPhetrrZmj5JyqZ0x1PB1L5Pi9bcSQiBHnIwZriAxsOAubCydPlxhA2MT91E73E9FcFCmgXhb8gV//MBwT7ATNL7UUNMg3IKsen+wrw+8C4vk/Z6wv5ulBF7h4rHHtdh3y6LUgNfD29ixqRQwXY3cr11jqMxiD1A0SUkTxRxV/uQS/YqFR2tVZS7UaFU2MB8VhFlGqt9hFRqursLV9/6rQochPNbincIXVI6xB+tJ8flO0jV14QacKbusXB5iLvUVM9KLEYxZhhgXuvlj4NAoOLYXyb7H55XfJrODaXYgjScXEmiShip7PQN63PLQLs5I3f9DqiCnAZzXaSRXT42FX/mtPHg12gPVOm7ovOq+9vuMHNnBvMFMs1573HzplVp9UAdt1gL6WRwtdpso1ez6n0hC9rCbaoVAVP464r1tvq8tjiIGivjn3u26WIdWI2LmbRTkR0fUJ80+oY/HqKi4QHODm0IhrezHqKqJkttty4irhQKQDRyPdG4=;4:G+Ehd0iveBrdQU8zaTXCGF1duntuCs4ZqqrX892njAyzIAbJgir9Wka2xPA4UbPh57u53qcxqMGCHZnn4QVtumSD2ZdI6OzC369k0aVV5iIfgkQlx7k5AhcDWAw33HOJsWOfp8YnWBDHffDJ2ku0yWwQkx20ffyB4iIiCXMUsbYVjgox9sDpaEtcdbHPyhge+itX3fZsXxu5BLqIp4z+sBIb50xdxz4J72FLxosmzsBoX+TeorhyjXQa1Gu1FCQ/+iOMUqZtBPhs4R5+BtAnL6rGJyy+JVXva8Qne4m03/ZOkwTNrg+1isP+I4C9Gjon
X-Microsoft-Antispam-PRVS: <MWHP136MB00142BC51606FC3DEE71CDD8E8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(377424004)(199004)(189003)(48376002)(386003)(86362001)(8666007)(25786009)(59450400001)(36756003)(6916009)(7696005)(6666003)(3846002)(68736007)(6116002)(2950100002)(186003)(66066001)(9686003)(50466002)(8656006)(97736004)(5660300001)(316002)(16526019)(7736002)(7416002)(305945005)(39060400002)(1076002)(16586007)(53936002)(76176011)(51416003)(2361001)(81166006)(85782001)(52116002)(4326008)(8936002)(47776003)(6486002)(2906002)(8676002)(105586002)(2351001)(26005)(50226002)(478600001)(106356001)(81156014)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:5lsj8//QzB/QrOjtGkDccCZPyRraWwZfDcFRhklZo?=
 =?us-ascii?Q?6pSgcf8DJENXnrWo2E8o+H0WGGabqyPT5WrTRNDPZO8CPX8rrTANBKdI5Mty?=
 =?us-ascii?Q?awE4bm1t+ihqaDKNih9a2fSDvIJYS6oqJ3zIe7T3EVrKjcKBEoFcWOhIUTOb?=
 =?us-ascii?Q?LmHt/ZaPmFOe1ZM+v+hOMXlZYGVul1Z2wcMCSl+GxX/O5lfMPRZ1h0y7aEtm?=
 =?us-ascii?Q?i3e6kkbPX8IHltxQCl9LfWyFvC/kr8ABtJL0DxbGx4GSv5hCY6qqq3OiJ89g?=
 =?us-ascii?Q?5TLCFfIJYCFx7hZfLoxjwkZelFmMq5nOR5Feuagnl0yEjp4YFbiLuUQ8Z6d7?=
 =?us-ascii?Q?0pRv44Uj7MNxOsqg8XiKIFtiUxXIo75JVL/lkoxSwjtNQjbWSioKvIOXfAVz?=
 =?us-ascii?Q?PBjUyXhKhyoQtnj4btAgjVmCiqlajLKvABrhukcATdFmhGmHY1eMZ2hsUqBj?=
 =?us-ascii?Q?1jY96hEmk5HTa0d2SAN2y1hLodIu0T/StwV98WlJwB+X8z3hjg4Xq6VtLyoI?=
 =?us-ascii?Q?rqUfd5DsGZGnaYqY6NJdmF+s/QJVoEZcFZpgmyBEjJLBHoS0kJ+PfN1LQ54m?=
 =?us-ascii?Q?j8Ig8TiUmxVZoRZAtC5ZberOPmtSWKfGgv0fuOhBQZgvvr7ABv/w4cfwN6mp?=
 =?us-ascii?Q?f6/QeEoBUcihvqrmSgYBrI2MOu2igdDHwB0S/vuAoXDsW0eUHKJpgD/Dcn++?=
 =?us-ascii?Q?2okWwk/thzi9iRjZxcUvOP24dpQMmuegkunq2490lp9j7Nk316cjAWKEYJSd?=
 =?us-ascii?Q?5zos2G0wSJ6gvqgUgzrsPn/0oFLmGapk5S9i7ZAjEEeEMxmHVLcj0QJ84INM?=
 =?us-ascii?Q?3ioo49+wHzJ0mCLEeyzU75o/zvV6Ool8jvfJqd/xRl+xDZsp942yApsOI6qC?=
 =?us-ascii?Q?AiDlLlHB0qxN82GKmOfRPDbhBN8EelZhSQQ0+kAsJu4yNqFE8T8rQWC9DVVY?=
 =?us-ascii?Q?SxgNyJhGx9LaTngxgEdWksOsjqLxBmsZ9lDD+XJRAE/AAX0B5zjlY8XwCjjf?=
 =?us-ascii?Q?hvp5cObSZTgn6ChcLV3zTLH4noNp+NViV2ydeSoN/hfO/weiFZXuWdF0Sq3x?=
 =?us-ascii?Q?croGsr299SwyysU53toxJAuzl+2QlEMopbc4yuvZSnstdts6zhHsSwC5FgZ0?=
 =?us-ascii?Q?Iyg8T5sm3Zy1wAH8zMAstIY17fB4UeyaoXwdXCP9SVLKq+EdXA+My8qnh3DX?=
 =?us-ascii?Q?4oUzQJxgFtBZJrarBZDSIIEnJeuQee2ouSid9+ZHdRQsUfVXk3x/WdjkSvgv?=
 =?us-ascii?Q?FXRyZW8SHuk/B9XNmAr002Hxs0MhWrKaYXjaUsu0B15iJxMx/V0qq+UafoJD?=
 =?us-ascii?Q?cXima/fUM1wq5/PXd6MXSpvbez8O11zaLrpfh8n/cjC?=
X-Microsoft-Antispam-Message-Info: BfrRyyun7+Ar++yjowxnW269Ihw3/4iCupeBOX/+BnfzQID4Fs/qVhbefPNqQE4hmWTzCqctaQGjSouJ6EAhFiBDR87VZyy7cFYwCyXciqrKuwFMsN2eSXKp3hxgZqdcIVF6H6gBDV6d5P+Vz9ex7s0CURX9wILOs0Mz1YoQTxRUhyoqsOWE8/Osudwvgv+m
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:K/WAYE0ncHisyCJK9Fz/lJkDlAj8UxRHsKHUZZpOc7od+kwayXrDybM1ffdv9SY0BEobTaCDvwspPk5zPXxJ68LolBB8vtfdCrdmMGsbqr8ba+gSJRJIGCId157twZRGG5sGynnHXLonWMe6TDMMSNoD68amvTd12qDfqR0+3cUbMKkOJWU214qbkdpt/QimKtEElT6lBo14xpzPCSLePsQ2cwkO7CCX9aTll/NjGY18EZl6f8OnzyRg6skkKOQhFF0mGYOsK7yLn/kT8atOBWHkQKjp/8eDNy0jYkmRm25WGrxWgcwedwulPIShZCP9oBCIRfIKObSJlEgDnNTwjz22/b/dDfVLxK42tUag1d0=;5:xMN3oY2jJ/xvQ0SRMq6bewSucnXIUdzp2BiYhC0nxVYCc8jpcoQDrrMyeoThh8qmxPibgjUI28bLsjH6ECyQocwRVOGvml+9wxTM1gd/UrvTAbgzKi7YoGko6PpTixpTASS9gFKPd+i+rC98/W4otOspUulQ/zPYyAyiUWrpABY=;24:pjDmYErjhocmT9G5Ub65/jDxEIFnST7VqmtDOZfkYRaudu1Sg4C5/uuvq3+wJrrdTHzRYumDHZdMzjAHqLiac4bAHu02UpSUtu5VZdvDJnI=;7:45khtiuH/xf1XFJ2YwMNMgMN1hijQ8x3dLU1r9f5yiZgAFExktOguid/m63HRH+1oDTnZjqz7LHwUlVVu6g+WqFFWpHrdG9Oj+bzoCxyTAW2KCKl6KmuNcVON9zem5j5oscBmb1laNsiopCitPDnHKvppvTt32QeDfZ+QeHDyBybMmT9MtjY4l4maRKtvy9E5ALaxp6MhWVD223K39LxSPIyBrRAUIG3o/wfFMDZnV4UqNilw4cn4oqmQWTSQb0E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:57:57.0722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4bee3d-4dcc-48d3-8c21-08d58ac832f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
allocate the buffer for the lower case string with xmallocz(). This
already ensures a NUL at the end of the allocated buffer.

Remove the unnecessary assignment.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..55b7daeb35 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -781,7 +781,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.16.2

