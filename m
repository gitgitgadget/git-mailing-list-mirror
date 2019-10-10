Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC2A1F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfJJXBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:01:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbfJJXBe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Oct 2019 19:01:34 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9AMvDEt049266
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 19:01:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vjbndkdm8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 19:01:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <ajd@linux.ibm.com>;
        Fri, 11 Oct 2019 00:01:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Oct 2019 00:01:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9AN1Q9T31129734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 23:01:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A05AF11C058;
        Thu, 10 Oct 2019 23:01:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E27911C04A;
        Thu, 10 Oct 2019 23:01:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Oct 2019 23:01:26 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A4231A01C1;
        Fri, 11 Oct 2019 10:01:22 +1100 (AEDT)
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for
 DMARC purposes
To:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        git@vger.kernel.org
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
 <20191010225405.GA19475@sigill.intra.peff.net>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Fri, 11 Oct 2019 10:01:23 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010225405.GA19475@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101023-4275-0000-0000-00000370FDC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101023-4276-0000-0000-000038840725
Message-Id: <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/19 9:54 am, Jeff King wrote:
> Neat. There was discussion on a similar issue recently in:
> 
>    https://public-inbox.org/git/305577c2-709a-b632-4056-6582771176ac@redhat.com/
> 
> where a possible solution was to get senders to use in-body From
> headers even when sending their own patches.

I think that's a good idea.

> 
> This might provide an alternate solution (or vice versa). I kind of like
> this one better in that it doesn't require the sender to do anything
> differently (but it may be less robust, as it assumes the receiver
> reliably de-mangling).

Yep, it's less robust - but OTOH there's always a long tail of users 
stuck on old versions of git for whatever reason and having some logic 
to detect DMARC munging may thus still be useful.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

