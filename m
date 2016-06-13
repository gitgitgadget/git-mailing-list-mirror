From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 5/6] lock_ref_for_update(): make error handling more
 uniform
Date: Mon, 13 Jun 2016 09:16:05 +0200
Message-ID: <575E5DB5.8040109@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
 <6cc13da6767c5fd9dbf1b372634adf7c3a353464.1465544913.git.mhagger@alum.mit.edu>
 <1465585279.8278.2.camel@frank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: David Turner <novalis@novalis.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 09:16:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCM6Z-0000MX-BM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 09:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbcFMHQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 03:16:12 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44287 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030202AbcFMHQL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2016 03:16:11 -0400
X-AuditID: 12074413-487ff700000008c7-2a-575e5db9bf2c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0E.7F.02247.9BD5E575; Mon, 13 Jun 2016 03:16:09 -0400 (EDT)
Received: from [192.168.69.130] (p548D6022.dip0.t-ipconnect.de [84.141.96.34])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5D7G58X029502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 13 Jun 2016 03:16:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <1465585279.8278.2.camel@frank>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqLszNi7c4McCK4uuK91MFg29V5gt
	nsy9y2yx5OFrZovuKW8ZLX609DA7sHnsnHWX3ePhqy52j672I2wez3r3MHpcvKTs8XmTXABb
	FLdNUmJJWXBmep6+XQJ3xsLp/UwFT5grtl+fxdLA+IOpi5GTQ0LAROLpgqusXYxcHEICWxkl
	lr1bzQiSEBI4xyTROy8fxBYWCJX4efkGM4gtIqAmseztLzaIhlWMEmt7zrODOMwC1xkljmw7
	zQZSxSagK7GopxlsBa+AtsT9aW2sIDaLgKpE05V97CC2qECIxPl1W1khagQlTs58wgJicwro
	SNw5NxnsCmYBdYk/8y4xQ9jyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5ya
	rFucnJiXl1qka66Xm1mil5pSuokREuLCOxh3nZQ7xCjAwajEw6uxKjZciDWxrLgy9xCjJAeT
	kiivhE9cuBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3lu+QDnelMTKqtSifJiUNAeLkjiv2hJ1
	PyGB9MSS1OzU1ILUIpisDAeHkgTv5higRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKS
	jHhQVMYXA+MSJMUDtHcSSDtvcUFiLlAUovUUoy7Hgh+31zIJseTl56VKifO6gxQJgBRllObB
	rYAltFeM4kAfC/P+BKniASZDuEmvgJYwAS3h2BcNsqQkESEl1cDo1iAwKyBcwcFN/OS7O2+N
	daO2eHwVDvhk/tZBQ9h51WfDeb6V/KUuEsymrMn/DzMnnN0qpSzxZK3W3LKq7A0z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297162>

On 06/10/2016 09:01 PM, David Turner wrote:
> On Fri, 2016-06-10 at 10:14 +0200, Michael Haggerty wrote:
> 
>>  /*
>> + * Check whether the REF_HAVE_OLD and old_oid values stored in update
>> + * are consistent with the result read for the reference. error is
>> + * true iff there was an error reading the reference; otherwise, oid
> 
> "error" is not a thing here?

You're right; thanks for the feedback. I'll include it in the reroll
that I'm about to do.

Michael
