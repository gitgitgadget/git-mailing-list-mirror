From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Thu, 20 Aug 2015 09:29:49 +0200
Message-ID: <vpq7foq1kpe.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
	<CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
	<vpqa8tn2sgy.fsf@anie.imag.fr>
	<CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
	<CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 09:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSKIR-0001GP-O4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 09:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbbHTH3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 03:29:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34406 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbbHTH3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 03:29:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7K7Tm4M028046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 20 Aug 2015 09:29:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7K7TnEq028728;
	Thu, 20 Aug 2015 09:29:49 +0200
In-Reply-To: <CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 19 Aug 2015 21:40:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 20 Aug 2015 09:29:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7K7Tm4M028046
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440660589.6965@Czhwxb5N+CelycAMyUxaIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276232>

Karthik Nayak <karthik.188@gmail.com> writes:

> Speaking of quote_value, The quote doesn't work well with color's
> for e.g.
> git for-each-ref --shell --format="%(color:green)%(refname)"
> '''refs/heads/allow-unknown-type'''
> Seems like an simple fix, probably after GSoC I'll do this :)

Anyway, the %(color) is really meant to be displayed on-screen, and the
quoting is really meant to feed the value to another program, so I can
hardly imagine a use-case where you would want both.

But the current behavior seems fine to me: the color escape sequence is
quoted, which is good. For example, you can

x=$(git for-each-ref --shell --format="nocolor%(color:green)%(refname)" | head -n 1)
sh -c "echo $x"

it will actually display "nocolor" without color, then a green refname.
I'm not sure the quoting is really necessary, but it doesn't harm and it
makes sense since the escape sequence contains a '[' which is a shell
metacharacter.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
