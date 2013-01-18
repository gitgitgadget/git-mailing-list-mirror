From: Durham Goode <durham@fb.com>
Subject: bug: git-svn seg fault during 'git svn fetch' due to perl < 5.10
Date: Fri, 18 Jan 2013 04:14:12 +0000
Message-ID: <2B10A89294DA6740AC6155F56842F9CE05234E6C@PRN-MBX01-2.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw3Ld-0001RW-N4
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 05:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab3AREOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 23:14:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42247 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754008Ab3AREOJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 23:14:09 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id r0I4CitL028720
	for <git@vger.kernel.org>; Thu, 17 Jan 2013 20:14:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : content-type : content-id : content-transfer-encoding :
 mime-version; s=facebook; bh=1lPPuiYnQk62LPQDN1+rSy7+42obV0I3aYuwtjIIq9k=;
 b=m6WzKUby2qdlKt1SIRNF8ye2Ppr75FP9kGz1xsGJ2dycBG4JVQ+NpTa0qdYS6Ike6V1N
 O2+Tk1QGKLhEEnE/RHCsUHzNzIQ/QledmseJLmVKcVT/7kIiV3NJ1OkQRH5kMDSmh/8n
 oPQWtrh9BUY1dMCa8ebmY6B+e7HV+1dFqUk= 
Received: from mail.thefacebook.com (prn1-cmdf-dc01-fw1-nat.corp.tfbnw.net [173.252.71.129] (may be forged))
	by mx0b-00082601.pphosted.com with ESMTP id 19xkmrss69-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Thu, 17 Jan 2013 20:14:08 -0800
Received: from PRN-MBX01-2.TheFacebook.com ([169.254.4.9]) by
 PRN-CHUB04.TheFacebook.com ([fe80::7ded:c10e:ef04:80d8%12]) with mapi id
 14.02.0318.004; Thu, 17 Jan 2013 20:14:07 -0800
Thread-Topic: git-svn seg fault during 'git svn fetch' due to perl < 5.10
Thread-Index: AQHN9TJFY3SfoIMBzkGfKUbhPVXaLg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.4]
Content-ID: <1D47B281C9E90E409410E3723EAB6784@fb.com>
X-Proofpoint-Spam-Reason: safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.9.8327,1.0.431,0.0.0000
 definitions=2013-01-18_02:2013-01-17,2013-01-18,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213900>

In git 1.8.1, when we do 'git svn fetch' on a large repo, we're seeing a
seg fault.  It's caused by git-svn trying to parse a large yaml file
(introduced in 
https://github.com/git/git/commit/68f532f4ba888f277637a94b4a49136054df0540
) which encounters a perl regex stack overflow bug that was present in
perl < 5.10 (https://bugzilla.redhat.com/show_bug.cgi?id=192400).

We'll find a work around, but it'd be nice if there was a config setting
to let us choose not to use the yaml format.

Let me know if there's a better place to report this.

-Durham
