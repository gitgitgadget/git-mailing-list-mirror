From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Fri, 03 Oct 2014 21:49:28 +0200
Message-ID: <vpq4mvlgchj.fsf@anie.imag.fr>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
	<542DB2FE.609@gmail.com>
	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
	<542DB711.9040503@gmail.com>
	<xmqqiok2m494.fsf@gitster.dls.corp.google.com>
	<vpqeguptz5k.fsf@anie.imag.fr>
	<xmqq1tqpm2na.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 21:49:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa8rG-0001Du-PN
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 21:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbaJCTti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 15:49:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34232 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaJCTti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 15:49:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s93JnRt2011447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Oct 2014 21:49:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s93JnS5g031897;
	Fri, 3 Oct 2014 21:49:28 +0200
In-Reply-To: <xmqq1tqpm2na.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 03 Oct 2014 11:25:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Oct 2014 21:49:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s93JnRt2011447
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1412970571.42316@J1kit8DtItQ8TiQmYPbMbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257848>

Junio C Hamano <gitster@pobox.com> writes:

> The "git config [--add] section.var value" UI, [...] finds the "var = value"
> definition at the end (or adds a "section" at the end and then adds
> [...]
>
> It is fine for single-valued ones that follow "the last one wins"
> semantics; "git config" would add the new definition at the end and
> that definition will win.

Not always.

git config foo.bar old-value
git config unset.variable foo.bar
git config foo.bar new-value

One could expect the new value to be taken into account, but it is not.

>> Well, the normal use-case for unset.variable is to put it in a local
>> config file, to unset a variable set in another, lower-priority file.
>
> I agree that is one major use case.
>
>> This common use-case works with the command-line "git config", and it
>> would be a pity to forbid the common use-case because of a particular,
>> unusual case.
>
> Either you are being incoherent or I am not reading you right.  If
> you said "If this common use-case worked with the command-line 'git
> config', it would be nice, but it would be a pity because it does
> not", I would understand.

I think you missed the "another" in my sentence above. The normal
use-case is to have foo.bar and unset.variable=foo.bar in different
files. In this case, you do not care about the position in file.

> in a repository whose .git/config does not have any unset.variable,
> you will add that _at the end_, which would undo what you did in
> your configuration file, not just what came before yours.  Even if
> you ignore more exotic cases, the command line is *not* working.

If my sysadmin has set foo.bar=boz in /etc/gitconfig, I can use

  git config [--global] unset.variable foo.bar

and it does work. Always.

Playing with the order of variables in-file is essentially useless OTOH
except for the include case you mentionned (if I want to unset a
variable in a file, I'll just delete or comment out the variable and I
don't need unset.variable).

Really, I don't see the point in making any complex plans to support the
useless part of the unset.variable feature. The reason it was designed
for already works, and $EDITOR does the job for other cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
