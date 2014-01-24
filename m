From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Thu, 23 Jan 2014 18:44:43 -0800
Message-ID: <52E1D39B.4050103@fb.com>
References: <52E080C1.4030402@fb.com> <20140123225238.GB2567@sigill.intra.peff.net> <52E1A99D.6010809@fb.com> <52E1AB78.1000504@fb.com> <20140124022822.GC4521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 03:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Wlk-0003tJ-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 03:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbaAXCor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 21:44:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52306 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750969AbaAXCor (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 21:44:47 -0500
Received: from pps.filterd (m0004003 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0O2hVsV002127;
	Thu, 23 Jan 2014 18:44:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=6zVf7uk+uHrut1dA53uMBV6n9h2m0bfSyatYQOx88aE=;
 b=fb2vQF3CgaM9VDjHAzwkhm77oacNO6lxY2gUb2cyQoxKz2jeThzI+YGXTLr8gMfvJD5z
 /RKsq19xuVnn/w0nvBzYRJvLrzLdq5sybgWn3RJDP9Si5JnOgWSV+YBtOohc09O9qqy9
 s75JhyhO4bg4du/l7eCOmXl83WBmw8RQAYE= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1hkdd58e3y-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 23 Jan 2014 18:44:45 -0800
Received: from [172.25.68.250] (192.168.57.29) by mail.TheFacebook.com
 (192.168.16.18) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 23 Jan
 2014 18:44:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140124022822.GC4521@sigill.intra.peff.net>
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-23_05:2014-01-23,2014-01-23,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=5.18003417937507e-11 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=62764
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401230209
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240995>

On 01/23/2014 06:28 PM, Jeff King wrote:
> I think your understanding is accurate here. So we want repack to
> respect keep files for deletion, but we _not_ necessarily want
> pack-objects to avoid packing an object just because it's in a pack
> marked by .keep (see my other email).

Yes, that makes sense and sounds pretty safe.

So the right solution for us probably is to apply the patch Vicent 
posted, set repack.honorpackkeep to false, and also have a cron job that 
cleans up stale .keep files so that subsequent repacks clean it up.
