From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Tue, 25 Aug 2015 08:47:12 +0200
Message-ID: <vpqk2sj7tlb.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-5-git-send-email-Karthik.188@gmail.com>
	<xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 08:48:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU822-0007J6-NM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 08:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbbHYGr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 02:47:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41780 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbbHYGrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 02:47:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7P6lBq4021902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 25 Aug 2015 08:47:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7P6lC6K007630;
	Tue, 25 Aug 2015 08:47:12 +0200
In-Reply-To: <xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 24 Aug 2015 15:13:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 25 Aug 2015 08:47:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7P6lBq4021902
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441090036.82898@b79/pnbQcVgVoevEh8MUuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276507>

Junio C Hamano <gitster@pobox.com> writes:

> You can see that I expected that "if !state.stack->prev" check to be
> inside append_atom(), and I would imagine future readers would have
> the same expectation when reading this code.  I.e.
>
> 	append_atom(struct atom_value *v, struct ref_f_s *state)
>         {
> 		if (state->stack->prev)
> 			strbuf_addstr(&state->stack->output, v->s);
> 		else
>                 	quote_format(&state->stack->output, v->s, state->quote_style);
> 	}
>
> The end result may be the same,

There's another call to append_atom() when inserting the "reset color at
end of line if needed", so moving this if inside append_atom means we
would do the check also for the reset color. It would not change the
behavior (by construction, we insert it only when the stack has only the
initial element), so it's OK.

I agree that this is a good thing to do.

> Moreover, notice that the function signature of append_atom() is
> exactly the same as atomv->handler's.  I wonder if it would be
> easier to understand if you made append_atom() the handler for a
> non-magic atoms, which would let you do the above without any if/else
> and just a single unconditional

I can't decide between "ah, very elegant" and "no, too much magic" ;-).
I lean towards the former.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
