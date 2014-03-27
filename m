From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Thu, 27 Mar 2014 07:09:10 -0700
Message-ID: <53343106.4090303@fb.com>
References: <20140326072215.GA31739@sigill.intra.peff.net> <5333576F.1050603@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ben Maurer <bmaurer@fb.com>
To: Jeff King <peff@peff.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTAzg-0006Wh-QM
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbaC0OJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:09:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17123 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754971AbaC0OJP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 10:09:15 -0400
Received: from pps.filterd (m0044012 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s2RE1jKR011704;
	Thu, 27 Mar 2014 07:09:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=Yp77wZ6UtSS8JQq0y+KQ207zbwUy2ujq0SnolU9ZNIk=;
 b=cQBb8BGVDW5jUpneQZ7B7RQuSGwatNdSpPcjnByUNpMIqwMgfTeiSmJVAYVkQvrj86bD
 MupW9okm8NUWDP0owUeGleIxdFz2ZnarEizhXo5cIXnaIhmntv9vbLYjCvxX1123/0XT
 /GL+zwkEciz2Pnjuke3AArTioOJokQt273E= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1jv9981u1u-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 27 Mar 2014 07:09:14 -0700
Received: from [172.20.37.249] (192.168.16.4) by mail.thefacebook.com
 (192.168.16.12) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 27 Mar
 2014 07:09:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5333576F.1050603@fb.com>
X-Originating-IP: [192.168.16.4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-03-27_03:2014-03-27,2014-03-27,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=8.27116153345742e-15 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000
 definitions=main-1403270059
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245277>

On 03/26/2014 03:40 PM, Siddharth Agarwal wrote:
> On 03/26/2014 12:22 AM, Jeff King wrote:
>> [tl;dr the patch is the same as before, but there is a script to measure
>>         its effects; please try it out on your repos]

Here are the numbers from another, much larger repo:

Test                         origin HEAD
------------------------------------------------------------------------------------ 

5311.3: server   (1 days)    11.72(14.02+1.44) 6.33(5.87+0.75) -46.0%
5311.4: size     (1 days) 19.4M                     15.3M -21.3%
5311.5: client   (1 days)    6.99(8.06+1.50) 10.60(10.34+1.83) +51.6%
5311.7: server   (2 days)    39.82(40.56+3.05) 33.94(31.21+3.10) -14.8%
5311.8: size     (2 days) 26.5M                     22.8M -14.1%
5311.9: client   (2 days)    15.81(16.48+4.29) 19.20(18.20+4.19) +21.4%
5311.11: server   (4 days)   37.21(39.75+3.73) 28.01(26.97+1.75) -24.7%
5311.12: size     (4 days) 37.5M                     34.1M -9.0%
5311.13: client   (4 days)   24.24(26.43+6.76) 31.14(30.75+5.96) +28.5%
5311.15: server   (8 days)   33.74(40.47+3.39) 22.42(22.25+1.51) -33.6%
5311.16: size     (8 days) 81.9M                     78.4M -4.2%
5311.17: client   (8 days)   81.96(91.07+22.35) 88.03(89.45+17.11) +7.4%
5311.19: server  (16 days)   30.87(34.57+2.78) 27.03(25.93+2.73) -12.4%
5311.20: size    (16 days) 153.2M                    150.9M -1.5%
5311.21: client  (16 days)   169.99(183.57+46.96) 177.12(177.17+37.93) 
+4.2%
5311.23: server  (32 days)   51.00(75.49+4.62) 19.52(19.28+1.93) -61.7%
5311.24: size    (32 days) 279.4M                    283.0M +1.3%
5311.25: client  (32 days)   272.43(296.17+76.48) 284.75(285.98+63.19) 
+4.5%
5311.27: server  (64 days)   51.73(97.88+6.40) 37.32(32.63+5.05) -27.9%
5311.28: size    (64 days) 1.7G                      1.8G +5.0%
5311.29: client  (64 days)   2600.42(2751.56+718.10) 
2429.06(2501.29+651.56) -6.6%
5311.31: server (128 days)   51.33(95.33+6.91) 37.73(32.98+5.09) -26.5%
5311.32: size   (128 days) 1.7G                      1.8G +5.0%
5311.33: client (128 days)   2595.68(2739.45+729.07) 
2386.99(2524.54+583.07) -8.0%
