From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 18:43:29 +0200
Message-ID: <vpqr3dyud3i.fsf@anie.imag.fr>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com>
	<cover.1459946531.git.d.f.fischer@web.de>
	<alpine.DEB.2.20.1604211737170.2826@virtualbox>
	<34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dominik Fischer <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:43:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHhc-0004ss-Pj
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcDUQng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:43:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60552 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcDUQng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:43:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3LGhR1s003986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 21 Apr 2016 18:43:27 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3LGhT47014320;
	Thu, 21 Apr 2016 18:43:29 +0200
In-Reply-To: <34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de> (Dominik Fischer's
	message of "Thu, 21 Apr 2016 18:30:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 21 Apr 2016 18:43:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3LGhR1s003986
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461861810.79485@Oc/cNIXeTouRXEEZBl1CMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292124>

Dominik Fischer <d.f.fischer@web.de> writes:

> I strove to create an add.patch configuration option that did the same
> as always passing the parameter --patch to git-add. Junio C Hamano
> then made me aware that when set, this option would influence and
> possibly destroy other commands that internally use git-add. So I
> implemented the recursion counter, which is now the first of the two
> commits.

This does not solve the problem of scripting. People write scripts, and
write git commands in these scripts. "git add" is a very good candidate
to appear in scripts, indeed.

You can't break people's scripts without a very solid transition plan.
And most of the time, safe transition plans are also painful for
everyone (remember the push.default change? I'm happy it's done, but
that wasn't a lightweight change ...).

In this case, it's quite clear to me that any transition plan would be
far more painful than the possible benefits. Without breaking backward
compatibility, I can already set "alias.p = add --patch" and use "git p"
instead of "git add --patch". Even better: that's 2 less keystrokes.

A config variable to set an option by default is good when the user
wants to set it and forget about it. In this case, you clearly can't
"forget about it", as running "git add" and "git add -p" correspond to
really different use-cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
