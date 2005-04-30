From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 20:44:04 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 05:40:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRipz-00081V-9n
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 05:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVD3Dpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 23:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVD3Dpk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 23:45:40 -0400
Received: from fmr13.intel.com ([192.55.52.67]:8418 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262495AbVD3Dpb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 23:45:31 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.1.192.58])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3U3j7mH017494;
	Sat, 30 Apr 2005 03:45:07 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j3U3j1i6028218;
	Sat, 30 Apr 2005 03:45:06 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005042920450606327
 ; Fri, 29 Apr 2005 20:45:06 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Apr 2005 20:45:06 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Apr 2005 20:45:06 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Trying to use AUTHOR_DATE
Thread-Index: AcVNM/sf5q9opQBeRv+Y94UsRAkZ2AAAdmtA
To: "Edgar Toernig" <froese@gmx.de>
X-OriginalArrivalTime: 30 Apr 2005 03:45:06.0010 (UTC) FILETIME=[FF8053A0:01C54D36]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>Another dependency :-(   I can live without http-pull but not
>without commit-tree.

Yes, the extra dependency sucks ... libcurl is missing from one of
the systems that I'd like to use GIT on ... so I'd prefer a solution
that doesn't involve libcurl.

>What's wrong with the patch I sent to fix this:
>
>	http://marc.theaimsgroup.com/?m=111446501003389
>

I missed it ... there is a problem that you drop the timezone.  When I
used this patch, I ended up with a commit that said:

author Keith Owens <kaos@sgi.com> 1114239900
committer Tony Luck <tony.luck@intel.com> 1114832076 -0700

See the missing timezone on the author line :-)  This is most upsetting
to cg-log.  It prints "expr: syntax error" and then

author Keith Owens <kaos@sgi.com> Thu, 01 Jan 1970 00:00:01

>> +	/* find the timezone at the end */
>> +	p = date + strlen(date);
>> +	while (p > date && isdigit(*--p))
>> +		;
>> +	if ((*p == '+' || *p == '-') && strlen(p) == 5)
>> +		snprintf(result, maxlen, "%lu %5.5s", then, p);
>
>This will choke on dates from Linus which have a trailing comment:
>
>	Date: Fri, 29 Apr 2005 15:26:14 -0700 (PDT)

You are right ... that's what comes from only looking at one e-mail
message to determine that pattern to match :-)

I'd much rather see your version fixed up to preserve the timezone
than have the libcurl dependency.

-Tony
