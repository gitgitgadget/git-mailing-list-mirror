From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the presentation layer
Date: Wed, 29 Jul 2015 23:27:42 +0200
Message-ID: <vpq4mkmejsh.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
	<vpqbnewxwcx.fsf@anie.imag.fr>
	<CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
	<vpqk2tjmgeg.fsf@anie.imag.fr>
	<CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 23:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKYtI-0006S2-1O
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 23:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbbG2V1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 17:27:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59785 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbbG2V1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 17:27:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLRdeE009396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 23:27:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLRgMZ024070;
	Wed, 29 Jul 2015 23:27:42 +0200
In-Reply-To: <CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 30 Jul 2015 00:22:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 23:27:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TLRdeE009396
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438810064.48627@kPV9LvsU7mHWu5HSgBg5MQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274956>

Karthik Nayak <karthik.188@gmail.com> writes:

> What I was thinking of was something like this :
>
> struct strbuf format = STRBUF_INIT;
> char c = ' ';
> if (current)
>     c = '*';
> strbuf_addf(&format, "%c....", c, other format options...);
> show_ref_array_item(item, format.buf, quote_style, 0);
> strbuf_release(&format);

I think that would interact badly with verify_ref_format(). Usually, you
have just one format string and call verify_ref_format() on it, not a
different format string for each ref_array_item. That would probably be
solvable.

> This would remove the need of making the printing of the "*" to be
> needed by ref-filter. As this is only needed in branch.c
>
> If going on what you're saying we could have a "%(starifcurrent)" atom or
> something, but I don't see a general use for this.

To have a really customizeable format, you would want to allow e.g.

  git branch --format '%(starifcurrent) %(objectname) %(refname)'

if the user wants to get the sha1 before the refname, and still have the
star in front. It's a bit frustrating to have a hardcoded format that
the user can't reproduce with the --format option, since it means you
can't easily make a small variation on it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
