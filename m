From: Andreas Leha <andreas.leha@med.uni-goettingen.de>
Subject: Re: make git ignore the timestamp embedded in PDFs
Date: Sat, 18 May 2013 20:09:38 +0200
Message-ID: <87ip2ggnx9.fsf@med.uni-goettingen.de>
References: <87y5bhn1iw.fsf@med.uni-goettingen.de> <51928FE8.2050804@kdbg.org>
	<87ppwohgyd.fsf@med.uni-goettingen.de> <5197AD3A.5050500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 20:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdlaE-0005gv-A5
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab3ERSJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:09:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:60884 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab3ERSJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:09:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UdlZp-0005Nf-M8
	for git@vger.kernel.org; Sat, 18 May 2013 20:09:53 +0200
Received: from vpn-2097.gwdg.de ([134.76.2.97])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 May 2013 20:09:53 +0200
Received: from andreas.leha by vpn-2097.gwdg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 May 2013 20:09:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: vpn-2097.gwdg.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:lJiaDfx1Yd+AOjN2JCjmjaQMX5w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224798>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 18.05.2013 09:42, schrieb Andreas Leha:
>>> Am 14.05.2013 15:17, schrieb Andreas Leha:
>>>> Hi all,
>>>>
>>>> how can I make git ignore the time stamp(s) in a PDF.  Two PDFs that
>>>> differ only in these time stamps should be considered identical.
>>>> ...
>>>> What I tried is a filter:
>>>> ,----[ ~/.gitconfig ]
>>>> | [filter "pdfresetdate"]
>>>> |         clean = pdfresetdate
>>>> `----
>>>>
>>>> This 'works' as far as the committed pdf indeed has the date reset to my
>>>> default value.
>>>>
>>>> However, when I re-checkout the files, they are marked modified by git.
>>>
>>> I'm using cleaned files every now and then, but not on Linux. I have
>>> never observed this behavior recently.
>>>
>>> If you 'git add' the file, does it keep its modified state? Does 'git
>> 
>> yes.
>> 
>>> diff' tell a difference?
>> 
>> no.
>
> I do not believe you. I'm sure that "Binary files differ" was
> reported.

You are correct, of course.  I had forgotten that I also had enabled a
special diff for pdf files, that reports the difference in the pdfinfo
output.

> The reason is that your pdfresetdate script is not idempotent. Look:
>
> $ pdfresetdate < x.pdf > y.pdf
> $ pdfresetdate < y.pdf > z.pdf
> $ md5sum x.pdf y.pdf z.pdf
> c46a7097574a035e89d1a46d93c83528  x.pdf
> 8e6d942b4cc7d8a4dfe6898867573617  y.pdf
> e6333bc0f8ab9781d3e1d811a392d516  z.pdf
>

Thanks for that.  I had not noticed due to the non-binary diff I had
enabled.

> A file that was already cleaned by the clean filter must not be
> modified, i.e., the y.pdf and z.pdf should be identical. But they are not.
>
> Fix your clean filter.

I will (try to) do.  Anyway, git seems unresponsible for my issue.


Thanks for that clear analysis!

Regards,
Andreas
