Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794D41F404
	for <e@80x24.org>; Wed,  7 Mar 2018 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeCGAAf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 19:00:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753466AbeCGAAe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Mar 2018 19:00:34 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w26NxYsl019750;
        Tue, 6 Mar 2018 16:00:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=content-type : from : to
 : cc : subject : in-reply-to : references : date : message-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yzR1ZaI80OsASuSW+BMNBBAO7FKw821siCswtLfHwkA=;
 b=WKTilxDlrWvPsmOaVi7pIaB/2U9K/a9cOP3JJHTdTK16dWu2MtRjPZ4xa1DQjrqEKk3Q
 X7tTcPqH9ULAVESjxZWTRVif3slQneedgA8Rk5TWOCppgxNn/+Rs1u/HAljqrxx/Yv0A
 wXEfullH/rDg8ESnuJ3oPH+U4DVUxzvb9Vs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2ghx1gheyk-13
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 06 Mar 2018 16:00:29 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Mar 2018 18:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yzR1ZaI80OsASuSW+BMNBBAO7FKw821siCswtLfHwkA=;
 b=EVucwAMHSCaTxc3Bx3lpvZtBpJo508EqgiGj5sKmLOIEGsH5s2PT445UMwAaKYkiG3p35I2UjuDslgeJnL7kjjfNXxt30+m+eJMLET1auT5xxoysEhEylVy+Dz5Shdu7aqX2UPPrTfAGcq46AGQgTfs0dwsCm++Rg8STZULs+KE=
Received: from localhost (199.201.64.131) by
 DM3PR15MB0814.namprd15.prod.outlook.com (2a01:111:e400:5ab7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Tue, 6
 Mar 2018 23:59:26 +0000
Content-Type: text/plain; charset="UTF-8"
From:   Jun Wu <quark@fb.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff: improve trimming preprocessing
In-Reply-To: <xmqq7eqp3suv.fsf@gitster-ct.c.googlers.com>
References: <1520337165-sup-4504@x1c> <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com> <xmqq7eqp3suv.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 6 Mar 2018 15:59:21 -0800
Message-ID: <1520378039-sup-4143@x1c>
User-Agent: Sup/g7607543
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Originating-IP: [199.201.64.131]
X-ClientProxiedBy: SN2PR01CA0007.prod.exchangelabs.com (2603:10b6:804:2::17)
 To DM3PR15MB0814.namprd15.prod.outlook.com (2a01:111:e400:5ab7::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48153d8-1e1c-469d-9289-08d583be4aed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB0814;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0814;3:M1TEPa0GzR6HAukXfgm/IIJhqj6C73nu4deB4CFduKVQLHuOEmK0Xy83P9ekinCXyCAi/tKxMBXk5itArJl5WQqq/iojqZ7eSkg0EZaBaMleWl+rCChKx5q2r7zLs/RNdDKe6t5ZF5kw02zM7NUtrTjGIxCzha4SzzWDyWpfN3EyA8C3BHkV1HembCsTVCCB0HtbeokaYHLlcyYBW++N+FrC/Fa54+m9HVUoOOrwrvSo3I90YfPWB1nT9U16c4IQ;25:2/JOf4+aFDenmgD/IzRJPmFTIc/qx1BuMnHWRV0EIP3RSCoFZb4Hq4IxQjR1UCCsKWM6YCFFVHFTKLapWzeFCjSmus/evAEtBull1NJWY+GeZ246vt6gZAmjkENrDZFVcoyFbf2mIqwtg5k40e2dQjLkJDD9eD14L8S9HB6L5LkkdScnpV9AQe4Bs7oZPrL7RTDsgwO5P9PqQBiTJf0zke13Oe0aQobsmzQanlhirrI9FxayGoIAQxMbv7fHRKvzKLlRwGKCywCOERkIces8vq4DEqGhxQwnywxVmLo9I5GbXRzDOOuN/hRGNRTu/VkuEIvKRDydL50mmXtR6jLfmg==;31:dOMksMAMLpwRl4tkLfARuWzIlRUj3R8WOV76kj7ss0mU62c/eZxLJ+dMi5JB4PMu1L5BpHHPz3VR8LtKnHsOjL9EVWycRw7SP5iiSV4oDJinQ7aXCmjkQmTqOFvId64B1SHzWUdKn6xsv5fKDWsPE/r1DUdquAFkFXHEVpgN8ggi3LPzxFAjmwA6tfUXfc96JsGNpv/Uw8ygHRG0293ubuqE9dBRE6MxOma/yCeFcII=
X-MS-TrafficTypeDiagnostic: DM3PR15MB0814:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0814;20:dTxFFdcwbxz4WbMIVLgaTH4QeYz0W4ZEdRp3V0q/Yi29m4yMlehaTUxvqIzWdGbUtiBpN/0lOvR1/0mZmBJrM5f24hdeXEq6FmWEw/LbVa0ynI1Hz/ukfFjRkYUEyiBlS6oCngcA+et+Dce++26G0+C2DdwRBm9Pc/EoLYsDlj2tfHzmzGk9HbR56YCQHsopgu7VL+qzjmyfsA0klr/CKRa0gnqIrD1QU24quz6YUEX4IpL40C5OIC3b1UZAc8pdM37yBhzbZ1jj8p4Q1SSIcN6nr6ddSq4sbDeNEr3g6QE/lGZJgmweYEmEycH3/3xgUcSU6kq2v63pztQn5H6MEf4GZWcNd2yfByKfaPvXuPibGziWBE8ctQxjIMbhj0sW6pizo6crflJGjUVvFCC7b3e2TGxCQSn/1+NjyJcWNCgQkUhKFFb94YBMQprpD8eD3uTVvlSbyEF08HS/wD3wElvkAmxqq6+5oRqpAXy8VOd3VaXIEXLtETfjGpTqmQOe;4:dsenMLa0vps27Jwliu4rAZmvSzDX36p0nFPLXlA2WxUlxZhqoNTmE25OAKCdAaIgmpcKcoRJpFBO1OadgJF6zcvH9kT9tPEIIQi6fNU1VsbJ1eJLaSD/SBElntrivbjXoKah4SzbiBTLPmB5axGfGK2dBbZs1JAUnvTd7VLh+Zbm6lKS+RMt6hK7EdcOss6DjTfPCggVvDexPq7VRrmmeFrtF4JOvBrKiAWVjotrEQoyJL0R7dGgz4uHFhswqDH45/hH3Q6GdJAXLQ762RDzXukXey3qC5CwIVqDBNM4NNf02iTgcGsSounAWHncPjP7
X-Microsoft-Antispam-PRVS: <DM3PR15MB0814DCBA13C938CBEBBF803ECDD90@DM3PR15MB0814.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(11241501184)(944501244)(52105095)(93006095)(93001095)(3002001)(6041288)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM3PR15MB0814;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB0814;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(189003)(377424004)(199004)(33716001)(3846002)(81156014)(16526019)(386003)(6116002)(105586002)(54906003)(50466002)(8936002)(97736004)(53936002)(53546011)(8676002)(86362001)(186003)(6246003)(6666003)(2950100002)(58126008)(6916009)(478600001)(59450400001)(81166006)(106356001)(4326008)(47776003)(316002)(25786009)(26005)(66066001)(6496006)(5660300001)(229853002)(68736007)(8656006)(2906002)(7736002)(76176011)(76506005)(52116002)(9686003)(2870700001)(23676004)(33896004)(6486002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB0814;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjE1TUIwODE0OzIzOmxKcHhxSmhWbHFVZCtwTzZHQTFIN2oxMVJl?=
 =?utf-8?B?RHEwVkdyUlV5SWdDakQzOVE1QUR5WjFXb2lDMkx0bFZkamtqdVE4c0pYcVNK?=
 =?utf-8?B?OTNrZVpVMGZmOEVXdlBoU3lmclc3Q3V6aXV6ZDRPcnhYM1NIajczT0djSjhE?=
 =?utf-8?B?RURSMGNBWS9XSTBwalZjMVJtckppTStCVURUdUpDQ2RzU1RFVlhKRnBCYUg0?=
 =?utf-8?B?WVhtRFp5b05XaFRJMTIxS1Y2b3pZZ1pFYU0zRFZJdE9ZK1JENll1L2JwQnVo?=
 =?utf-8?B?WDUzSlRHK2o2cnJzVWhDdzNTaVVSOFhhaEdsNkF2THIyMTZRaHhuSzRoaXFS?=
 =?utf-8?B?bWNzcjNLVHlaUi9LWFN5V1Y2dWJaQWRJckliVVZPTEtQTTY4Z3p1VUd4dWFQ?=
 =?utf-8?B?bklMeEJCYWxGcmFwVGZ6NHBWcGk4alR3UTFGU3E0VGNWNFcyY1M0WVhBNURo?=
 =?utf-8?B?ZU9SZnNQRERPRVM1ZzkrcjF1ZTJlb0kwRkt5M05leEEwc0hMdGFSMUFYUEdW?=
 =?utf-8?B?V3dWYmJPS3dvZ0ZSZVNYVUQ0aUQwbERLWlVxRlNKdWRCT2hxMVdGek1WSlBy?=
 =?utf-8?B?K1dJbE0vcW1EL0VOZHUyS2dzK3FiRndFeDJhREM3VmhDR3hLQkI1ZlBIOHBN?=
 =?utf-8?B?Z2MrVkRGejE3ckd4aFlpYU9Uejk3Q1VBbHp5cWJwd1UrTC9MdEptdE9yOWtF?=
 =?utf-8?B?UE8wNVF5aTJ2Z2RsVXRuN1VZYmpqdTFEZ21KTmRLdGJmUC9jT3YydHN0Vi9O?=
 =?utf-8?B?SkV2dWFLYlFkWEpvcDRLcnBuZWtuRVhJRjEvZkJEWkVZK25kM1czQWh2aEM0?=
 =?utf-8?B?T1AzaWVoaXFCRFZJUWhTNzA2V3VXN1RRNnh2WEJyS0p3RElPK05xTk16dG9V?=
 =?utf-8?B?UEYwSTMydjdENlhmcmpFZmVmYVIyNnE4Ym5RQlJ3T3pnQmFRemRKQ3hLcFVI?=
 =?utf-8?B?SlNLL0ZNdWxQd0tjNDhTZWVyU3JZTHAyOWpldmRhK1RJY1dGaHhkM0QxMnlN?=
 =?utf-8?B?NWExT2tTblR3QnBxME5vbXZnck9SZDJvMTFhcDlWSUVYbEdQM3I5WG5pYnVC?=
 =?utf-8?B?NmJ2Vkx3eFBGUUR0c25UM083eVpINFNFMEhEUWFsMVFjUHpWQnJneVZzOHJU?=
 =?utf-8?B?aEZZcG5BU2wyd0dONWJRc1QyU05SWnQyZWtORE50Y0tDSE52VXBwZVExRVVv?=
 =?utf-8?B?eTdtNThhRmRmeDhTUEtKWXpWNHZzT0taeHhPT3dWUXM2LzBJUjIxKytTdm00?=
 =?utf-8?B?RjVSUzNIdGF3amNBV1FMZXVoN3NOUi92MUk1OW94S3g0V2pZRkVrOCtyL0ZH?=
 =?utf-8?B?OUI5dEJPRjlpMmxxZ0VqdFZCbVlJTm14SE13M1NRVVVIcEFGMHptOFc2cUNZ?=
 =?utf-8?B?VjdRNFh3Q3lVUm9ITlZCVXRhVUoyUnpjUDQzUEhrL2NzeEM0VkxKMk82Vmln?=
 =?utf-8?B?YVVoejQ4TURtb3ZhbW1zNm9tUXlBUklraHdtWkc5L3p4SHFWQVNOZzB4MGk1?=
 =?utf-8?B?eHhmRFJnUUdBSWo2R3dOMFppT1BsN29vYUNiT1RIRWJRNnlwT2tTTHVjdGVw?=
 =?utf-8?B?LzhpTlozMGR3T2drM01YNFZXTkRTS2R6OVlvZ1BqYXBSZlBhMGJHeHdGTlJu?=
 =?utf-8?B?a3BpWFlDdEJPY1d2cFVSbzhqS1ZYVkJhQmhxTjlBdDNqQmc0eGlUQmI0RGVi?=
 =?utf-8?B?UUE5ZGNuUjFJWHZvcFhncUh2VWdVdVJXeFhlL3k0NGNPSWF2UmhiMnZTNmgx?=
 =?utf-8?Q?nzrx9qiT7qDuPIeTBZKbvCkQ08Jie2vOaxCEE=3D?=
X-Microsoft-Antispam-Message-Info: 7njHDRIn3NO7EIpWukYMaWvrYO/WTy7ETtnXHtIi3/rYUFDmfqT7BgojDIllOFbwmyOqiJ84b9ik88X2lqT1QEmTNeAtj5Hs6NStLZnzCWFegd0n0XYfgmJmVHeuNH51tWQorqW2y7MfmI0yVV5qbFah7cejoEGn7WAsz60z0/j0goHgckkQkEKL6WlD8m/f
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0814;6:SiMYmVaaHjo98Lba+4Vj7K3mTXrhwWt0a6NQr3IN8cGFUbV34mhkyDv4vop8H34257nXzKcg/CVi72zojJqy9X8Wbaj8ZxpAV5PigycQQUlNNZL0RrtyEQ4A7hNRlGsy7bJtAem/4FlhY8RsqFysMNovHwwuYaaSZMWmUDvbrCsfTcVWFWHMH0CHuygxUtugnxcjUddU67xjKOiEPIsNGJcOqXLfiDHED54sp/wH32WidyK/SdbI2CBOkhfWEKKw2thUwP8N03uYVNd1omaOzMMUqMIxjKwuCvrwV4H7WNh2VS/kZVYUEvQLuLzEeE2YLmcXoqPvt4nCD8Eqchx/8j4J6nwsBJysY72KL7Hviys=;5:Lt1lE/tPXVhqE/mmTcSUCi0sMK++bpC1xA4vlobCWL3WXgWVjWTJGOD4MP9gOJbKT1yN+AnFM4qxTB3KACUH4gg33zOUD6Qby6NyYFHhDoL5CqN2w+N9Zqq7VBTh1ta+abKRbE7qo7jhqEa/ebmd6J+CBxqBVCGoApWPJEtAZu4=;24:YHkBKceBRk0mZ+8wEmqmT2+tMjd41OkvORUfjbTtFVTktFdKW1Mnkj6LCjfskjTufsLyC/pprH4RT4kIY/J1O4ZPkZvNkDSkg3GitP1LpMU=;7:R9DoWhYjublibFZXYdAh3+nJf/D88bF5dXxamfOVV1+wp7US/e6Vll5JcS+Nca4cFLJBnSNwQh8DaEirLi8FQ9t5wpnuNB0pa1JtnGDX1keMV6BkGEnroew4kKxQzK3F0hEGri/+h/eoO3BmQN47BYkXYGi4HVs9rgojx5H1NgGIdFSYx7qx46JFMyV2nC60O4JoOZJAfG+cr4aWKGabZ7AU5EysI58l6sTCmVpFL9Ln/UX7aE7Kny8EPN4AEqom
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB0814;20:Lj2ubSL6tqeV5tswBKun4g5ZwzU+lSUHfRFhTOqLYY8MigQjyAx3UTp9Xl7s3X+oDttEFfkhEapxxqRx30/npiPaW/M0OXmRn4Ej1uO2l7GLLHaSLWru4UW7w8C6pirXtVrN3p9ON9Qpxf1AT+HpJCEM+GPKbv9EQLmH1C9uC08=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 23:59:26.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48153d8-1e1c-469d-9289-08d583be4aed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB0814
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Excerpts from Junio C Hamano's message of 2018-03-06 11:29:44 -0800:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Tue, Mar 6, 2018 at 6:53 AM, Jun Wu <quark@fb.com> wrote:
> >> xdiff-interface trims common suffix if ctxlen is 0. Teach it to also
> >> trim common prefix, and trim less lines if ctxlen > 0. So it can benefit
> >> the default diff command, as seen by profiling: [...]
> 
> I vaguely recall that we have tried this in the distant past, found
> that it produced incorrect result, and that is why we limit the
> optimization for no-context case.
> 
> Does anybody have an archive reference?

I think it's d2f8295 ("Re(-re)*fix trim_common_tail()", 2007-12-20).

Yeah, this is more complex than I thought. In Mercurial's use-case, ctxlen
is 0 and context are added in a higher layer so it's fine.

It's clearly hunk shifting causing problems. I'll send a V2 to forbid hunk
shifting if it can possibly lose context lines. That implies counting suffix
lines, which adds some overhead but the overall perf win still seems
worthwhile.
