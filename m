Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78CF21F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfJMLF6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 07:05:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728620AbfJMLF6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Oct 2019 07:05:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9DAvEMl060643
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 07:05:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vkveqq056-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 07:05:56 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <ajd@linux.ibm.com>;
        Sun, 13 Oct 2019 12:05:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 13 Oct 2019 12:05:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9DB5pm548300184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 11:05:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C8454C050;
        Sun, 13 Oct 2019 11:05:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 390B94C04A;
        Sun, 13 Oct 2019 11:05:51 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 13 Oct 2019 11:05:51 +0000 (GMT)
Received: from [9.102.57.136] (unknown [9.102.57.136])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ED0CAA00F3;
        Sun, 13 Oct 2019 22:05:48 +1100 (AEDT)
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for
 DMARC purposes
To:     Jeff King <peff@peff.net>, Daniel Axtens <dja@axtens.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        patchwork@lists.ozlabs.org, Eric Blake <eblake@redhat.com>,
        git@vger.kernel.org
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
 <20191010225405.GA19475@sigill.intra.peff.net>
 <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
 <87pnj3thja.fsf@dja-thinkpad.axtens.net>
 <20191011155151.GA19395@sigill.intra.peff.net>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Sun, 13 Oct 2019 22:05:49 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011155151.GA19395@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101311-4275-0000-0000-00000371A509
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101311-4276-0000-0000-00003884B201
Message-Id: <a59c318f-476b-c3ab-fa6b-5067503820a3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910130112
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/19 2:51 am, Jeff King wrote:
> On Sat, Oct 12, 2019 at 02:42:49AM +1100, Daniel Axtens wrote:
> 
>>>> where a possible solution was to get senders to use in-body From
>>>> headers even when sending their own patches.
>> [...]
>> I'm not sure this solution is correct.
>>
>> If I take a patch from Andrew, backport it, and send to the list, Andrew
>> will be listed in the in-body From. However, he shouldn't be the sender
>> from the Patchwork point of view: he shouldn't get the patch status
>> notification emails - I should. We don't want to spam an original author
>> if their patch is backported to several different releases, or picked up
>> and resent in someone else's series, etc etc. So unless I've
>> misunderstood something, we can't rely on the in-body from matching
>> Patchwork's understanding of the sender.
> 
> Yeah, it may be that patchwork and git have two different priorities
> here. From my perspective, the problem is getting the patch into a git
> repo with the right author name. But patchwork may want to make the
> distinction between author and sender.
> 

Yes, I was referring to the git am case, not the Patchwork case.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

