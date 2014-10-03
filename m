From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Fri, 03 Oct 2014 09:01:27 +0200
Message-ID: <vpqeguptz5k.fsf@anie.imag.fr>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
	<542DB2FE.609@gmail.com>
	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
	<542DB711.9040503@gmail.com>
	<xmqqiok2m494.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 09:01:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZwsB-0006Tl-HC
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 09:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbaJCHBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 03:01:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44378 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbaJCHBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 03:01:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s9371RVg005412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Oct 2014 09:01:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s9371Rwa020867;
	Fri, 3 Oct 2014 09:01:27 +0200
In-Reply-To: <xmqqiok2m494.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 02 Oct 2014 16:38:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Oct 2014 09:01:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s9371RVg005412
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1412924489.76117@zhRkZX7Q3Mad6/y1V2WfVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257833>

Junio C Hamano <gitster@pobox.com> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> I can think of two solutions, one leave it as it is and advertise it to be
>> explicitly typed in the config files at the appropriate position or to change
>> the behavior of unset.variable to unset all matching variables in that file,
>> before and after. We could also change git config --add to append at the end
>> of the file regardless the variable exists or not. Which course of action
>> do you think would be best?
>
> Off the top of my head, from an end-user's point of view, something
> like this would give a behaviour that is at least understandable:
>
>  (1) forbid "git config" command line from touching "unset.var", as
>      there is no way for a user to control where a new unset.var
>      goes.  And

Well, the normal use-case for unset.variable is to put it in a local
config file, to unset a variable set in another, lower-priority file.

This common use-case works with the command-line "git config", and it
would be a pity to forbid the common use-case because of a particular,
unusual case.

>  (2) When adding or appending section.var (it may also apply to
>      removing one--you need to think about it deeper), ignore
>      everything that comes before the last appearance of "unset.var"
>      that unsets the "section.var" variable.

That would probably be the best option from a user's point of view, but
I'd say the implementation complexity is not worth the trouble.

> Alternatively, if the syntax to unset a "section.var" were not
>
> 	[unset]
>         	variable = section.var
>
> but rather
>
> 	[section]
> 		! variable
>
> or soemthing, then the current "find the section and append at the
> end" code may work as-is.

But that would break backward compatibility rather badly: old git's
would stop working completely in repositories using this syntax.

Well, perhaps we can also consider that this is acceptable: just don't
use the feature for a few years if you care about backward
compatibility.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
