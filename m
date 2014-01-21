From: Siddharth Agarwal <sid0@fb.com>
Subject: git repack --max-pack-size broken in git-next
Date: Tue, 21 Jan 2014 14:48:07 -0800
Message-ID: <52DEF927.7090005@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <stefanbeller@googlemail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5k7G-00083v-Uj
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbaAUWsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 17:48:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42272 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038AbaAUWsO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jan 2014 17:48:14 -0500
Received: from pps.filterd (m0004060 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0LMk9xQ007139;
	Tue, 21 Jan 2014 14:48:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : content-type :
 content-transfer-encoding; s=facebook;
 bh=ravGaOx47Y4bGx+P47Qi86WDTiBbdpeTMXsHICWP7rE=;
 b=YZeZklYuMUlQRUhcZ7rorLelwr/CbFk7H94LQ3ZIQ4o0rRmMNzpiDBQGOyKD5PC8zqGW
 LavEW9Dqb4YR+x29ntUF4/NlxI8BFqhYMJNd7tzh2Qb9FykLSQ4m1xOdOS7BvmMq2JCW
 N4T+gPphfcjrjjB5Sgf6So81dzjc7qHWFFw= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1hj1f4g4pt-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Tue, 21 Jan 2014 14:48:10 -0800
Received: from [172.25.68.250] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 21 Jan
 2014 14:48:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-21_07:2014-01-21,2014-01-21,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=1.71959319006376e-09 kscore.compositescore=0
 circleOfTrustscore=287.009407511322 compositescore=0.999681428617885
 urlsuspect_oldscore=0.999681428617885 suspectscore=13
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.999681428617885 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401210178
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240783>

With git-next, the --max-pack-size option to git repack doesn't work.

With git at b139ac2, `git repack --max-pack-size=1g` says

error: option `max-pack-size' expects a numerical value

while `git repack --max-pack-size=1073741824` says

error: unknown option `max_pack_size=1073741824'

I bisected this down to a1bbc6c, which rewrote git repack in C.
