From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 15:15:21 +0200
Message-ID: <vpqliin6bva.fsf@bauges.imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
	<vpq1ukgai4e.fsf@bauges.imag.fr>
	<7vwr28agcq.fsf@alter.siamese.dyndns.org>
	<vpq1ukg82st.fsf@bauges.imag.fr>
	<20120713130021.GA2553@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 15:21:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spfnt-0006dq-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 15:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163025Ab2GMNVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 09:21:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50913 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932646Ab2GMNU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 09:20:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6DDDiZ8006219
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2012 15:13:45 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SpfiM-0002e2-PZ; Fri, 13 Jul 2012 15:15:22 +0200
In-Reply-To: <20120713130021.GA2553@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jul 2012 09:00:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 13 Jul 2012 15:13:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6DDDiZ8006219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342790026.01378@aiBZmY8B3Uo0GEqUZm9kOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201401>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 13, 2012 at 10:48:18AM +0200, Matthieu Moy wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > But is it really true that we want to error out on missing HOME if
>> > we have usable XDG stuff?
>> 
>> Anyone else have an opinion on this?
>> 
>> In short, the question is whether
>> 
>>   export XDG_CONFIG_HOME=some-existing-dir
>>   unset HOME
>>   git config foo.baz boz
>> 
>> should die("$HOME is unset") or use the XDG config file.
>
> What did previous versions of git do? From my reading of 21cf32279, the
> previous behavior was that if $HOME was not set, git would silently
> avoid reading from $HOME/.gitconfig entirely.

Yes, and this is still the case for _reading_. But the current case is
about deciding which file to use when _writing_. Git was already dying
when writing with an unset $HOME. There is no behavior change in this
case.

With Junio's suggestion, we would have a behavior change in that we
would write to the XDG file if we can find it (using XDG_CONFIG_HOME,
obviously, since $HOME is unset in this case).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
