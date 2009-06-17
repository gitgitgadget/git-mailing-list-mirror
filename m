From: Andreas Ericsson <ae@op5.se>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 13:31:20 +0200
Message-ID: <4A38D408.7000302@op5.se>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <4A38AD5D.6010404@gmail.com> <20090617102332.GA32353@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Bito <jwbito@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 13:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGtMb-0003dt-Sz
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 13:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbZFQLbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 07:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbZFQLbX
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 07:31:23 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40326 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753386AbZFQLbW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 07:31:22 -0400
Received: from source ([72.14.220.156]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSjjUC2K1BDVzRDWA5FgT0OLT9DAvZcLh@postini.com; Wed, 17 Jun 2009 04:31:25 PDT
Received: by fg-out-1718.google.com with SMTP id e21so82260fga.22
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 04:31:23 -0700 (PDT)
Received: by 10.86.27.6 with SMTP id a6mr433248fga.18.1245238283045;
        Wed, 17 Jun 2009 04:31:23 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm1162528fgg.15.2009.06.17.04.31.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 04:31:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090617102332.GA32353@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121736>

Jeff King wrote:
> 
>   3. Replace compat/regex with something faster. It still produces
>      exponential behavior in complex cases where glibc does not, and it
>      seems to be about 1/3 as fast on Paolo's regex.
> 
>      I haven't looked at how large or how portable the glibc
>      implementation is. Another alternative is that we could provide a
>      simple compat/ as now, and have better support for linking against
>      an external library like pcre, if it is available.
> 

The glibc implementation is quite large. Cutting the library-specific
cruft it still sits at about 10k LOC.

Using PCRE is a no-go, as it uses perl-compatible regexes even for the
posix-compatible API, as per pcreposix(3):

       When  PCRE  is  called  via these functions, it is only the API that is
       POSIX-like in style. The syntax and semantics of  the  regular  expres-
       sions  themselves  are  still  those of Perl, subject to the setting of
       various PCRE options, as described below. "POSIX-like in  style"  means
       that  the  API  approximates  to  the POSIX definition; it is not fully
       POSIX-compatible, and in multi-byte encoding  domains  it  is  probably
       even less compatible.

This would probably surprise some "git grep" users quite a lot, I think.

I like your other two suggestions though. The stuff already in compat/
seems to work well enough, so with Paolo's improved pattern it should
be fine.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
