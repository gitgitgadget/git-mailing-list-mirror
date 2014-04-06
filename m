From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 18/22] lockfile: also keep track of the filename of the
 file being locked
Date: Mon, 07 Apr 2014 00:05:57 +0200
Message-ID: <5341CFC5.6050904@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>	<1396367910-7299-19-git-send-email-mhagger@alum.mit.edu> <xmqq7g77wsxj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:06:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWvCX-0000f6-CC
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 00:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbaDFWGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 18:06:01 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46200 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754450AbaDFWGA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 18:06:00 -0400
X-AuditID: 1207440c-f79656d000003eba-8b-5341cfc777ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 92.10.16058.7CFC1435; Sun,  6 Apr 2014 18:05:59 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36M5vkl007771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 18:05:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqq7g77wsxj.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqHv8vGOwwbUJYhZdV7qZLBp6rzBb
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNm3XvPUvCItWLOl5WMDYxX
	WLoYOTkkBEwkrnT1sELYYhIX7q1n62Lk4hASuMwo0d9+BMo5xyTROW0mWBWvgLbE87YHTCA2
	i4CqxJajG9hAbDYBXYlFPc1AcQ4OUYEgiT9nFSHKBSVOznwCtkxEQE1iYtshMJtZwEhi5pof
	jCC2sEC8RPfh9+wQu1YzSmxd/IwdJMEpYC2xb84cFpCZEgLiEj2NQRC9OhLv+h4wQ9jyEtvf
	zmGewCg4C8m6WUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMj
	JKR5djB+WydziFGAg1GJh3fFIcdgIdbEsuLK3EOMkhxMSqK8ameAQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4NU2AcrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd5v
	Z4EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kERHF8MjGGQFA/QXttzIHuLCxJz
	gaIQracYdTk2bFvTyCTEkpeflyolzrsYZIcASFFGaR7cClgCe8UoDvSxMC83yCgeYPKDm/QK
	aAkT0JKGMDuQJSWJCCmpBkbuF4WsAQce2eeu2L9oJ4fkjMM69QcYRUznG1xK6/zQMHN7OE/A
	qyyjgi1u8Q2hT5TMNZ4v3pkoWbqi9+XKK6ISDLMa3k75fEDAuUxEpsWs6P713BaB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245797>

On 04/02/2014 07:19 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This reduces the amount of string editing gyrations and makes it
>> unnecessary for callers to know how to derive the filename from the
>> lock_filename.
> 
> Hmph.
> 
> Is it worth duplicating the whole thing?  If you are planning to
> break the invariant lock_filename === filename + LOCK_SUFFIX in
> future changes in the series, it is understandable, though.

That is indeed the plan, but I'm splitting that change into a future
patch series because this one is getting big enough already dealing with
correctness issues.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
