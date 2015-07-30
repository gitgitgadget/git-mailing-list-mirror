From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/10] port tag.c to use ref-filter APIs
Date: Thu, 30 Jul 2015 11:44:52 +0200
Message-ID: <vpqzj2e9dyj.fsf@anie.imag.fr>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<CAPig+cQv4BWFwgx7mDHh=gNpxbEeR7auw4os-tOpf3cGah=zpw@mail.gmail.com>
	<xmqqbneu907l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 11:45:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKkOg-0007Ux-TO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 11:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbbG3JpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 05:45:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40733 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbbG3Jo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 05:44:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6U9ip3k023491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jul 2015 11:44:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6U9iqOK032138;
	Thu, 30 Jul 2015 11:44:52 +0200
In-Reply-To: <xmqqbneu907l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2015 13:29:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 30 Jul 2015 11:44:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6U9ip3k023491
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438854293.42515@NkHjb6+Tx8yUDYpDHSLnKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274977>

Junio C Hamano <gitster@pobox.com> writes:

> "Currently we do not need it to reimplement the canned 'tag -l'
> format" is an OK and sensible justification to stick to the current
> implementation of %(padright:N), but we'd need to think if we would
> want to keep this limited and strange form that applies to a single
> atom that comes next (ignoring any literal spans) as a private
> implementation detail between ref-filter and "git tag".  Opening it
> up to end-users would not mean we cannot add a correctly operating
> variant of "pad this string to the right" later, but it does mean we
> have to maintain %(padright) in this limited form forever.
>
> My knee-jerk reaction is that we probably should not want to expose
> this to the end users, and to discourage its use, perhaps name it
> somewhat strangely (e.g. "%(x-padright:N)" or something).

I disagree. The current %(padright) fits 99.9% needs. It's handy for the
user if he wants a column-display with --format. It's consistant with
the "git log" %<() atoms.

Sure, if the user wants really advanced formatting, it's not sufficient.
But first I believe this is a case of YAGNI, "right-pad an arbitrary
string" is a funny coding exercice, but not very useful in real-life.
And then, if one really has a use-case for advanced formatting, I think
a much better approach is to dump an easy-to-parse language
(XML/JSON/CSV/...) and pipe it to a formatter written in a real
programming language. It will always be more powerful than having to
chose in a limited set of %(atoms).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
