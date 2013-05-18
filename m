From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: make git ignore the timestamp embedded in PDFs
Date: Sat, 18 May 2013 18:32:58 +0200
Message-ID: <5197AD3A.5050500@kdbg.org>
References: <87y5bhn1iw.fsf@med.uni-goettingen.de> <51928FE8.2050804@kdbg.org> <87ppwohgyd.fsf@med.uni-goettingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Leha <andreas.leha@med.uni-goettingen.de>
X-From: git-owner@vger.kernel.org Sat May 18 18:33:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udk4O-00017f-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 18:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3ERQdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 12:33:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:56141 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752648Ab3ERQdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 12:33:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4405A13004C;
	Sat, 18 May 2013 18:32:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5DE2219F5CF;
	Sat, 18 May 2013 18:32:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <87ppwohgyd.fsf@med.uni-goettingen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224797>

Am 18.05.2013 09:42, schrieb Andreas Leha:
>> Am 14.05.2013 15:17, schrieb Andreas Leha:
>>> Hi all,
>>>
>>> how can I make git ignore the time stamp(s) in a PDF.  Two PDFs that
>>> differ only in these time stamps should be considered identical.
>>> ...
>>> What I tried is a filter:
>>> ,----[ ~/.gitconfig ]
>>> | [filter "pdfresetdate"]
>>> |         clean = pdfresetdate
>>> `----
>>>
>>> This 'works' as far as the committed pdf indeed has the date reset to my
>>> default value.
>>>
>>> However, when I re-checkout the files, they are marked modified by git.
>>
>> I'm using cleaned files every now and then, but not on Linux. I have
>> never observed this behavior recently.
>>
>> If you 'git add' the file, does it keep its modified state? Does 'git
> 
> yes.
> 
>> diff' tell a difference?
> 
> no.

I do not believe you. I'm sure that "Binary files differ" was reported.
The reason is that your pdfresetdate script is not idempotent. Look:

$ pdfresetdate < x.pdf > y.pdf
$ pdfresetdate < y.pdf > z.pdf
$ md5sum x.pdf y.pdf z.pdf
c46a7097574a035e89d1a46d93c83528  x.pdf
8e6d942b4cc7d8a4dfe6898867573617  y.pdf
e6333bc0f8ab9781d3e1d811a392d516  z.pdf

A file that was already cleaned by the clean filter must not be
modified, i.e., the y.pdf and z.pdf should be identical. But they are not.

Fix your clean filter.

-- Hannes
