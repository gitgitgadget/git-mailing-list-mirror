From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Thu, 2 Jun 2016 18:57:34 +0200
Message-ID: <9535d962-5479-5a13-472e-cd558ef163e0@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527140104.11192-2-samuel.groot@grenoble-inp.org>
 <vpqeg8mi4wm.fsf@anie.imag.fr> <20160528233329.GA1132@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, gitster@pobox.com,
	aaron@schrab.com, Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: Eric Wong <e@80x24.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:57:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8VwD-0001CL-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 18:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbcFBQ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 12:57:37 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:42246 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161117AbcFBQ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 12:57:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 91726256D;
	Thu,  2 Jun 2016 18:57:33 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xsq5WIZfz0V6; Thu,  2 Jun 2016 18:57:33 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7F014256B;
	Thu,  2 Jun 2016 18:57:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 77FFE2077;
	Thu,  2 Jun 2016 18:57:33 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bw3P2-z3J9oN; Thu,  2 Jun 2016 18:57:33 +0200 (CEST)
Received: from wificampus-029066.grenet.fr (wificampus-029066.grenet.fr [130.190.29.66])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 5D12B2064;
	Thu,  2 Jun 2016 18:57:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <20160528233329.GA1132@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296216>

On 05/29/2016 01:33 AM, Eric Wong wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>
>>> Parsing and processing in send-email is done in the same loop.
>>>
>>> To make the code more maintainable, we create two subroutines:
>>> - `parse_email` to separate header and body
>>> - `parse_header` to retrieve data from header
>>
>> These routines are not specific to git send-email, nor to Git.
>>
>> Does it make sense to use an external library, like
>> http://search.cpan.org/~rjbs/Email-Simple-2.210/lib/Email/Simple.pm ,
>> either by depending on it, or by copying it in Git's source tree ?
>
> That might be overkill and increase installation/maintenance
> burden.  Bundling it would probably be problematic to distros,
> too.

We have 5 solutions here:

   1. Make a new dependence to Email::Simple.

   2. Bundle Email::Simple in Git's source tree.

   3. Use Email::Simple if installed, else use our library.

   4. Making our own email parser library.

   5. Duplicate parser loop as we did for our patch to implement
      `--quote-email` as proposed in $gmane/295772 .

Obviously, option (5) is the easiest one for us, but it leaves 
refactoring for later, and option (1) is also easier but adds a new 
dependence which is not that good.

Since our project ends next week, we might not have enough time to 
finish developing a custom parser API so (4) is not a viable option for 
now but could be done in the future.

We could consider bundling Email::Simple as the best option, as it's 
developed since 2003 and might be safer to use than anything we could 
write in several weeks.
