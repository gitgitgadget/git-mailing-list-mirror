From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 16:05:56 +0200
Message-ID: <87hatboiwr.fsf@thomas.inf.ethz.ch>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
	<vpq1ukgai4e.fsf@bauges.imag.fr>
	<7vwr28agcq.fsf@alter.siamese.dyndns.org>
	<vpq1ukg82st.fsf@bauges.imag.fr>
	<20120713130021.GA2553@sigill.intra.peff.net>
	<vpqliin6bva.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	<git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 13 16:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpgVc-0002US-Qd
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 16:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab2GMOGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 10:06:11 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:14282 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab2GMOGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 10:06:09 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 13 Jul
 2012 16:06:01 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.47) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 13 Jul
 2012 16:06:00 +0200
In-Reply-To: <vpqliin6bva.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri,
	13 Jul 2012 15:15:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201403>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Jul 13, 2012 at 10:48:18AM +0200, Matthieu Moy wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>> > But is it really true that we want to error out on missing HOME if
>>> > we have usable XDG stuff?
>>> 
>>> Anyone else have an opinion on this?
>>> 
>>> In short, the question is whether
>>> 
>>>   export XDG_CONFIG_HOME=some-existing-dir
>>>   unset HOME
>>>   git config foo.baz boz
>>> 
>>> should die("$HOME is unset") or use the XDG config file.
>>
>> What did previous versions of git do? From my reading of 21cf32279, the
>> previous behavior was that if $HOME was not set, git would silently
>> avoid reading from $HOME/.gitconfig entirely.
>
> Yes, and this is still the case for _reading_. But the current case is
> about deciding which file to use when _writing_. Git was already dying
> when writing with an unset $HOME.

Umm, are you sure?  I may be somewhat confused about this, but the tests
I used to trigger the access(NULL) were IIRC

  unset HOME
  git config --get foo.bar
  git config --global --get foo.bar

none of which is writing....

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
