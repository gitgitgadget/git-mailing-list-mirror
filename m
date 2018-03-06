Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6C01F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCFXFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:05:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32826 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932078AbeCFXFh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Mar 2018 18:05:37 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w26N2NvZ021200;
        Tue, 6 Mar 2018 15:05:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=content-type : from : to
 : cc : subject : in-reply-to : references : date : message-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zg38L8HXqApaFyhVyuL6SqwQ55KftrnVuDoJe4uPPZQ=;
 b=JExGLQLqBCgWLavsuK2A73rTDvL85WmXITXmiPxWR9HJ1qw2Iwwqyos51JknrQuG2wuf
 jqy7SAoJQ+TBa8v51upUyDWR1ECH9JjyyQF397vYmfhiJVnpLBSWOy4gsZRSFOnfIrHh
 Uw8SYbUhAQTMVPY7aTOM2gEucWkP8Sh8sK8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2gj1n7rpx8-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 06 Mar 2018 15:05:32 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Mar 2018 15:05:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zg38L8HXqApaFyhVyuL6SqwQ55KftrnVuDoJe4uPPZQ=;
 b=EcViOWFwThHgl4NBB1Oo4rzqqtztoAuqyYYGNx+EnU+UWwnPjqh9MsVcBerkh5EkVjI/plNjCYXAf4Qx5Qm5goLccoCSY82TAnto/y2mQfg1HUmNcafb1vbdFV0TjIy9CTf9KHSdOaa+OEdGzFsvxeZKDxZr73lT90IWYAAmARo=
Received: from localhost (199.201.64.131) by
 DM3PR15MB0816.namprd15.prod.outlook.com (2a01:111:e400:5ab7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Tue, 6
 Mar 2018 23:05:22 +0000
Content-Type: text/plain; charset="UTF-8"
From:   Jun Wu <quark@fb.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
CC:     git <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff: improve trimming preprocessing
In-Reply-To: <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
References: <1520337165-sup-4504@x1c> <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
Date:   Tue, 6 Mar 2018 15:05:18 -0800
Message-ID: <1520370729-sup-3241@x1c>
User-Agent: Sup/g7607543
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Originating-IP: [199.201.64.131]
X-ClientProxiedBy: MWHPR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:300:103::23) To DM3PR15MB0816.namprd15.prod.outlook.com
 (2a01:111:e400:5ab7::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 451ca86b-b7a8-4cbb-3841-08d583b6bd70
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB0816;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0816;3:YtmU+aU6NTS5XyYMUgLTOuprshlINxgTyMkfzspIvYQaSp5hcCod5Bxiz0dqNf51lD+SeRNC6MqOx6FoqBnmrFriE7BX8jWia/FvUPJrjJgqYoLXO8JNjrXboQy5tpYvVCaeG/QEtjJaB7wbuDlQyXA2AkqgMEdnsISUaR1gnURqaAv8+66OPt+1L/5bWQ7Al7RQX0oti+QiphikJtBV8ORJTUWYtVl4jWWQkSjaCAQP0OTx93BFR55TtGCkOHxR;25:BN3Gd/rPUjXMegSb49SULQvt0C7KfmEdJsBEvLwOuCGRm7QYZULxVVHoibbQM9c1a6z2Ps/NLzAbY5NzdgXIwpDFHAyuQfEEHVfnbQmgmTwFnhdDMDN51Jl9uaed8t69DlsB3WrIGM2Iq0KB7VCmTuudNYy9YCYf7bSlZjdW50QtJtCTPXkNAw25B9IDSejo/Oep8SGX1HgUT8H0YUthIf+5z1VJy3yuUSWwG3up/tgCH2MctQv9wc2Zkw1e2RVh6wXoAF9+ehXvQ7ome/cHsxxJmlG3NTTdlPgwEpI0kCWqrv3wwFhndtuts+nMVMDnnJOLi96FyDpwqZ20qRZ3Eg==;31:a69oBAjjViiVv5b1PBFrpjGoYH6UiyNbB7J00OE3NTxWf2dNRSp3S85CcS3o8HogcwRv3D/JdHloP6ga/kyGN7CsXY19cFN9IsSxxSDvIRzqpVUJ3G29tdKLnBloEJbNJKaUyXGMnE1SPGeJ9TQPBvCTtpld+MUn+eU4EouilaScZNypXlZjme7QJ3BXE5QAr0UL8gHDcb4JUHmCEbT6xxi0k22z7VGAZrSPYR2XIqk=
X-MS-TrafficTypeDiagnostic: DM3PR15MB0816:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0816;20:aFjSrDHnSLXqnIJsCa2A7HnzqWCgsdxvJYe+xj9hgn2YhI9jEfEJG8VF+K0/OsC9WruvH1PyPjed40UG0SUqjD+h2J2zj49DEpwgCWOeZzG6H4bGOPIHqfkl2w8hq7U7z3Awc8U73L+39cUEGdlCzjev1adzbG6T2FJYrwPQLgO3oPNBnL695BrfKc0fz4yeiEWpphF12Vluj44n50yAWa0T7/iFNl2JgLH84CpUBPTtfXfp3DpceBwdDC+82qAbfV4rkUtxsQlE/xxajf/DDTu0aNOmCTk3jY7IoqAp6kDZfiiMBPMEIFKdt9ffknKgDNd3yPUtAQAIlbh5ISRxZZZPFUf+LuRSX040+JfpJ0IHyrEVvZhVXbNr4hiOOFXEV95Hddv7nXxWWv1rI0igXY3mD5KW3vDYcW9GfzRE/5FGRpmV4GD/z4KcxuqRGhaEl5sOu6OFFqmr9M/452uC6dGFLoS4EVufwgjgDGishNBmMv+gxifybmfE+C/nrc1/;4:pa6pr+C1v5+B/uXg6kYp5BD5OpQUEuH2dCE4A2VO3/RBBL/3Br5XQk4gvChZxrfhXGRputatPrVvlBH2g4zjzFCKhKfB/95adnZDbnShTwiY+lfU74UsFKTWW6aN/hpr3LGX6/mxXNYRluyc+FdyxsIIEr/sso5+l3RRzw+Ffxf78pZmxDVwhbYbY+Vk05jGaJd4g6tl12Oc5BgYKUmFizSEDWz3FW3u1utA/RMnRhXGGIo4uiKZ170TAeqHe0/cMFfLpEEhG4taL6IvEShCwJljpIYrBG8WYctrkAgQ0oMYTugLC7vItrLVw/IzLpcK
X-Microsoft-Antispam-PRVS: <DM3PR15MB0816F2543A7AACD7255C341CCDD90@DM3PR15MB0816.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR15MB0816;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB0816;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39860400002)(39380400002)(376002)(346002)(366004)(396003)(189003)(199004)(377424004)(478600001)(6666003)(50466002)(2906002)(2950100002)(3846002)(5660300001)(6116002)(76506005)(68736007)(81156014)(26005)(81166006)(386003)(53546011)(8936002)(86362001)(229853002)(6916009)(97736004)(186003)(16526019)(2870700001)(25786009)(8676002)(58126008)(4326008)(6246003)(66066001)(33716001)(53936002)(316002)(6496006)(9686003)(76176011)(6486002)(305945005)(33896004)(7736002)(23676004)(105586002)(47776003)(52116002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB0816;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjE1TUIwODE2OzIzOi81bTB6OWNvS3Z4RjVSdndhb1Rock02SlRH?=
 =?utf-8?B?WGEzeUI3eVJiVHgvdVVqNFN5enFmOUJUZkprS3VkQzNWcWY5N3pBT2JmY0Ir?=
 =?utf-8?B?anVkMHloZGtZV2dhTzdDdUdQcmxlckNVWVRYeDQ4Y2pHWG40N1c1ODBKYUJs?=
 =?utf-8?B?UDhuNDdsYVBCQ2pVcE04T1p1em1pY2hHL0pDSFUzMHRmQ0tGTUFPY2Z5WDh5?=
 =?utf-8?B?QitEbGZ0YmhOdzdGZml3N3VJZFR5bWhqUEZianNhZ2czZWZqVFQzRHVNS1hD?=
 =?utf-8?B?UlRnamdQQkIzNDdrMCtNMjhsM2J4YzU2UXZZVTJRclRhcjFwald5YXRGQkNW?=
 =?utf-8?B?UDd2Ly9xMm9MNXVMaGNsRnZ2N1FYRHVZdXd0Vm1tYWVqVm5TcDNhMXJDcFFE?=
 =?utf-8?B?WnVnNWE3MGowc2s2cTI5cjVjU1RYaUsyS3BVYmpKUTFSNk1QRm5COERIWFBn?=
 =?utf-8?B?V2tjNnZjcU0yZlRnYjJKQXNLYTlWZngzZHhrbU83dDlSRk5pMDkwWlM3VHZP?=
 =?utf-8?B?d0NzaldXc3poZUlPRTY1U2JsSkFqUU0wTThSN3JBakJIQ1VtZEs0RWpUbi9F?=
 =?utf-8?B?SGF0Mm04RFJYSWp5TUZLYkhMakVHbC9WbzhrZG1zMXRqVVBMaW5XMHBOWUlt?=
 =?utf-8?B?UUR0bDJIajQyQllSLzhoOHJRc0dZN0NzbjhhaVVwWUtnRm1xUkVuVXRKbUgx?=
 =?utf-8?B?Wit5Z1B3ZlBIVkFQWElBdW5wQlNOYWVuRmJSZE5FUW0zNERrSDRYNE5KYnYw?=
 =?utf-8?B?c1JGK0F4dVBYV1JjaUNXTHV6UGRwQVpXcTdmZVRpdUdWN1lITS9NU0xEWjRJ?=
 =?utf-8?B?T1hWbzFrdElQdWVwQk9QQllRQzUvbTVVVVNmWkpmTmJGLzhxZVJMTFk2OWRq?=
 =?utf-8?B?NmFDTDNRNm5VVDdSdVRTYW13bWtNVzFrZXczYWZabHpQZjVUSkhoM01TVURz?=
 =?utf-8?B?SEs0ZmEwSjg1b3JlOUNBQ05DYklycHNsTDBHbnlFaG84MUFBbWppRjdJSjJu?=
 =?utf-8?B?VlhmU3ZLbzdyMU5uMjI0L3JMS1U2cDkyVW94Z3dwY2lyQjdPbkJFMUtrMXBR?=
 =?utf-8?B?Q1NjUmNoa0FCQTBCRThvdVdFck1yZmJXdWdvampoM095clBxMUZsckdKY1Fj?=
 =?utf-8?B?TGhTVCtXNnpicUEvRGUxRWJ5WGtPdS9JQ2RiUmg4dlpvQjNVbWdPMjFPTm42?=
 =?utf-8?B?bW1hUnVqRWNMSnNPRUduQWxtdnRBbzRQS3psMlYzazJTZGhiU25rSXl6ZEJ3?=
 =?utf-8?B?M3o3bmRpRXg5cncxejQ5V1BXMzI5RG5QbVZSK21QUGVnNmxYelJwZ0tBcFZz?=
 =?utf-8?B?V000THQzak43aU9GUW9mM0RncHFtdGE3aUZ4SjlqSmZxWExMOVZHTGZVRjl4?=
 =?utf-8?B?WDBXT0lhSHVrWW9TL20vbzdES1gzWUh1RndIbWRrODRkTGVicTZSU091SUNl?=
 =?utf-8?B?SWROak02NlhzemY3OWpJRmNTMTB1MCtpSUtrbTMzWTJiSzRvRDNjVWoxT2RD?=
 =?utf-8?B?aXRZdTZlNTREY0hpSlgvOWZXRXhNZjhJaFoxNVJ1amFLbVFKaVpGTm10akls?=
 =?utf-8?B?RmF6ajFIMzZNcnF3Vm1xdmZTV0t0ZURMUVpmclV1ZUx2NTZwek56d3hFR3BU?=
 =?utf-8?B?c3FyTGY1bVlMY0FUbjZiWnFXK3cxRUIxNHh0QUpFMHhrSzN5VHJuaUR2N0NY?=
 =?utf-8?Q?sSu/ZNadd7vcaS18Z8=3D?=
X-Microsoft-Antispam-Message-Info: KcTdWqq2Qp5dsQxwnAYENgP1/1HpkT8Pcs7o1H0tLorOdX/3/+i5i9BlfCee51dSlQ9FORxF25mADU+cgzeIA1qCCiCZQi3Itjn2A+C8aX/0qvrucefOoOOsQqMhIQjONe9WGVTmkTLP8DAKq8thLVlcli/D80aHNtfTAmqzJNO0BckpV71BIe8Y9nTm6HkA
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0816;6:Fayv/nq8+NNI6571wLugYEEqTYfhTz7OWK9LdbQbCxYNBHRa7GKzam+XH4hDxbzsz6+8YqTJJLQWfBW6NIhJUoMQ6hIDlAPJJYFUKopnJDT3aLC5pY5YTj3lvwfIXZnH8YNoW3gX9zLvu4fXPYIiQNjNsggzuDzIrbj8yDpJ2tYcHHTfuRkXgtwcTjngx8RFtZC8EW4e0ZLhMhKKmTKLzux8pxcHVqRQRoQH4DCbAFxQuvj42j6aQgaJKQ18XKJy8mrk6F9xQxGbSaeSNvbJYdDx6hGMyyL2pocdLF/L2arW+4qVfbVQ9gqy1LZ0GjiNaxUN+PJIZhwsr7BHCBhTercfFtRw9+x/NHVR/IFA/ek=;5:Z/ZY6+5sRM9F+yjO+6DfylOL0yG7aEnBcN3FwlZVfWP4IZ+6LiQPg8878te+/qC+UBELFox65X56j0vpmMN+YKebRmyv9CCrHgqLCA7FruLvIeMevcnR6TahlRco4OdNs7uE2uGHD1qHe7yIMz2axvfBKpETI85A4Zr+oP52YXY=;24:X3lr2AMKVosucIX99Pu1dF9g1aofqWXaF/PC3N7hSksUfH2dyfRagK3DBvR6sZgLwNBPQP1Mr9aXV4fdWw515/rQXGVv/stqcxXegX1Vupo=;7:MycxxffkO3v+RewOXRPTOzP4Jtjb4sQS+fsdo+D6JZmribvmZAdP+GZprw4QizOZy5iJlgafbvEXrKCMQwgY0FCn9Q9/N594YD97QMiFgUVoINqzjzf4VCKAplZwG41DThP216ZyyMrG3tRTaSPGde2/BigABrmBbt02E8VW5AeKpsLJfXfzgvY5KWprfQMN1dHRCQctEtPpA4FRtq/Nzb5Km75z2Hni7F8LdPkEjZi4oRTq2u5x0QuUcJSMZl6K
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0816;20:vHk3qNJxXnZ4Ah91e15Ev6gt52d/cu0t9Ia108/z5iqF1znavcrrHOavNUuz3vCEn4mbB6u86E9kZUmjgI5zYxpWZn6+LmZ09isX+8xn3APOd1T4B9uWZrIkRXkH5Cz/jOUid+k78NwQq+P1kX30AtAKgVLCakz89BmHUfmbaBk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 23:05:22.5671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 451ca86b-b7a8-4cbb-3841-08d583b6bd70
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB0816
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Excerpts from Eric Sunshine's message of 2018-03-06 14:23:46 -0500:
> On Tue, Mar 6, 2018 at 6:53 AM, Jun Wu <quark@fb.com> wrote:
> > +  printf "x%.0s" {1..934} >>d # pad common suffix to 1024 bytes
> 
> The expression {x..y} is not portable to non-POSIX shells.

Is there a recommended way to generate a repetitive string?
Maybe `seq 1000 | sed 's/.*/x/'` ?

> > +    fgrep "@@ -1001 +1000,0 @@"
> > +'
> 
> Style: Mix of tabs and spaces for indentation. Please indent only with
> tabs throughout the patch.

Sorry. Will fix in V2.
 
> > +       /* prefix - need line count for xecfg->ptrimmed */
> > +       for (i = 0; ++i < smaller && *ap == *bp;) {
> > +               lines += (*ap == '\n');
> > +               ap++, bp++;
> 
> Is there a good reason for not placing 'ap++, bp++' directly in the 'for'?

"lines += (*ap == '\n');" needs the "ap" before adding. Alternatives are

    for (i = 0; ++i < smaller && *ap == *bp; ) /* 1 */
        lines += (*ap++, *bp++) == '\n';

    for (i = 0; ++i < smaller && *ap == *bp; ap++, bp++) /* 2 */
        lines += (*(ap - 1) == '\n');

Maybe will pick /* 1 */ to make the code shorter.
