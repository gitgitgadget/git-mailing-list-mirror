Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124E31F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJKEgN (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:36:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbfJKEgM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Oct 2019 00:36:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9B4RKC8185340
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 00:36:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vjdd0r8cy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 00:36:11 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <ajd@linux.ibm.com>;
        Fri, 11 Oct 2019 05:36:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Oct 2019 05:36:05 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9B4a4rK48431170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 04:36:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89A62AE04D;
        Fri, 11 Oct 2019 04:36:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36C88AE057;
        Fri, 11 Oct 2019 04:36:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Oct 2019 04:36:04 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 44F10A01C1;
        Fri, 11 Oct 2019 15:36:02 +1100 (AEDT)
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for
 DMARC purposes
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        git@vger.kernel.org
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
 <20191010225405.GA19475@sigill.intra.peff.net>
 <xmqqblunj461.fsf@gitster-ct.c.googlers.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Fri, 11 Oct 2019 15:36:02 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqblunj461.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101104-4275-0000-0000-000003710E65
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101104-4276-0000-0000-000038841823
Message-Id: <c942d9ce-d8fe-32ca-bedd-1cdb3837823d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910110040
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/19 3:29 pm, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> This might provide an alternate solution (or vice versa). I kind of like
>> this one better in that it doesn't require the sender to do anything
>> differently (but it may be less robust, as it assumes the receiver
>> reliably de-mangling).
> 
> I share the assessment.  I also feel that relying on Reply-To: would
> make the result a lot less reliable (I do not have much problem with
> the use of X-Original-Sender, though).
> 

It would be nice if Mailman could adopt X-Original-Sender too. As it is, 
it adds the original sender to Reply-To, but in some cases (where the 
list is set as reply-to-list, or has a custom reply-to setting) it adds 
to Cc instead. (In the patch that started this thread, I match the name 
from the munged From field against the name in Reply-To/Cc for the case 
where there's multiple Reply-Tos/Ccs.)

For the Patchwork use case, I'm quite okay with accepting the risk of 
using Reply-To, as the alternative is worse, the corner cases are rare, 
and ultimately a maintainer can still fix the odd stuff-up before 
applying the patch.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

