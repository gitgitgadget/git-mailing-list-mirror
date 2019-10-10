Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778291F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 21:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfJJVN6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 17:13:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbfJJVN6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Oct 2019 17:13:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ALDjp6147334
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 17:13:53 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vj96cdtgv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 17:13:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <ajd@linux.ibm.com>;
        Thu, 10 Oct 2019 22:13:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Oct 2019 22:13:07 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9ALD6cZ54263984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 21:13:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F8742047;
        Thu, 10 Oct 2019 21:13:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B1EA4203F;
        Thu, 10 Oct 2019 21:13:06 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Oct 2019 21:13:06 +0000 (GMT)
Received: from [9.102.39.78] (unknown [9.102.39.78])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0E2F6A01C1;
        Fri, 11 Oct 2019 08:13:02 +1100 (AEDT)
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for
 DMARC purposes
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        git@vger.kernel.org
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Fri, 11 Oct 2019 08:13:01 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010194132.GA191800@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101021-4275-0000-0000-00000370F951
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101021-4276-0000-0000-000038840283
Message-Id: <236b9c32-b501-79a7-8366-26d64ceac24f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/19 6:41 am, Jonathan Nieder wrote:
> Interesting!  I'm cc-ing the Git mailing list in case "git am" might
> wnat to learn the same support.
Argh, that reminds me... this patch only rewrites the name and email 
that is recorded as the Patchwork submitter, it doesn't actually rewrite 
the From: header when you fetch the mbox off Patchwork.

Part of me would really like to keep Patchwork mboxes as close as 
possible to the mbox we ingested, but on the other hand it means the 
mangled address is still going to land in the git repo at the end... so 
I should probably just change it?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

