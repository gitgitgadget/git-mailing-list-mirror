From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v3 1/3] Introduce die_errno() that appends strerror(errno)
 to die()
Date: Tue, 09 Jun 2009 11:29:51 +0200
Message-ID: <4A2E2B8F.3020005@op5.se>
References: <cover.1244299302.git.trast@student.ethz.ch> <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch> <20090608220713.GB29942@sigill.intra.peff.net> <200906091022.31738.trast@student.ethz.ch> <20090609085328.GA25721@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 11:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDxf4-0007r1-HD
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 11:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291AbZFIJ3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 05:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759000AbZFIJ3y
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 05:29:54 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34923 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759016AbZFIJ3x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 05:29:53 -0400
Received: from source ([72.14.220.157]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSi4rkph0EpysyL+z7/3AcNkmO+IRb55e@postini.com; Tue, 09 Jun 2009 02:29:56 PDT
Received: by fg-out-1718.google.com with SMTP id e12so1601682fga.10
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 02:29:53 -0700 (PDT)
Received: by 10.86.62.3 with SMTP id k3mr8207047fga.28.1244539793671;
        Tue, 09 Jun 2009 02:29:53 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d6sm1362141fga.2.2009.06.09.02.29.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 02:29:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090609085328.GA25721@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121160>

Jeff King wrote:
> On Tue, Jun 09, 2009 at 10:22:30AM +0200, Thomas Rast wrote:
> 
>>> Aren't you assuming that strerror(errno) has no '%'-signs here, which is
>>> what kicked off the whole discussion?
>> True, of course.  Hrm.
>>
>> So do we go back to v2 (for 1/3) and ask future callers to never use
>> custom formats with die_errno, or should I write a version that
>> doubles the % characters while tacking the error message onto the
>> format?
> 
> Personally, I think it is fine to assume that the format and arguments
> to die(), die_errno(), and to the die_routine() are all
> printf-compatible. That is how it has always been until now, and I don't
> see any callers who would want to change that.
> 
> This is all internal to git.  It's not as if we are talking about a
> library being called by arbitrary code, and we want to leave doors open
> for arbitrary clients. libgit2 would probably take a different approach
> (though I imagine their general strategy is never to die(), but to
> always return an error condition, anyway).
> 

Yup. libgit2 sets an internal git_errno variable and returns an error
code for each error it encounters, and we're referring callers to
regular "errno" to find out more about *why* a particular git_errno
condition was encountered.

We might want to give applications an easy way to die with a sensible
error message, but that's so far in the future that it's not worth
bothering with.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
