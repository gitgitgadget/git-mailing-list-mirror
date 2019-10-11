Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4001F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfJKUKg (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:10:36 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:46982 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729659AbfJKUKg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Oct 2019 16:10:36 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BK7qnp003971
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 20:10:35 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2vjqj1suy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 20:10:34 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 47C0455
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 20:10:34 +0000 (UTC)
Received: from [10.33.153.10] (yehat.americas.hpqcorp.net [10.33.153.10])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 2DE5C48
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 20:10:34 +0000 (UTC)
To:     git@vger.kernel.org
From:   Brent Casavant <brent.casavant@hpe.com>
Subject: bug: "rev-parse --short" with "--not --remote"
Organization: Hewlett Packard Enterprise
Message-ID: <83e4f54f-190b-115f-b31b-7177c681128b@hpe.com>
Date:   Fri, 11 Oct 2019 15:10:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_10:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=638 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910110161
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I noticed what appears to be a bug in rev-parse with an admittedly somewhat unusual combination of arguments.

Compare the output of the following:

% git rev-parse HEAD --not --remotes=origin
3de09080eb219149a8596dc21915d5a496cba171
^4fb157bf360413fe3fad38d03b02ce7232d12961
^757cfa6938c3d510d1597096d9f0b6878b884270

To this:

% git rev-parse --short HEAD --not --remotes=origin
^4fb157b
^757cfa6
^3de0908

In the first case rev-parse emits the commit-id of HEAD, followed by negated commit-ids of all remote branches in origin.  I believe this is the correct and intended behavior.

In the second case rev-parse emits the negated short commit-ids of all remote branches in origin, followed by the negated short commit-id of HEAD.  This is inconsistent with the results of the (presumably correct) prior example.

I would expect both commands to emit the same output, modulo the number of characters emitted for the commit-id.

Thank you,
Brent Casavant

-- 
Brent Casavant
Hewlett Packard Enterprise
