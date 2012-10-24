From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-status: show short sequencer state
Date: Wed, 24 Oct 2012 10:15:52 +0200
Message-ID: <vpqsj94mgjr.fsf@grenoble-inp.fr>
References: <1350948569-28445-2-git-send-email-hordp@cisco.com>
	<vpqsj95soxp.fsf@grenoble-inp.fr> <5086DBDB.9070606@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "phil.hord\@gmail.com" <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"konglu\@minatec.inpg.fr" <konglu@minatec.inpg.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 10:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQw8Z-00053s-1B
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 10:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758069Ab2JXIQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 04:16:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58560 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757352Ab2JXIQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 04:16:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9O88OUK001140
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2012 10:08:24 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TQw81-0008In-7t; Wed, 24 Oct 2012 10:15:53 +0200
In-Reply-To: <5086DBDB.9070606@cisco.com> (Phil Hord's message of "Tue, 23 Oct
	2012 14:03:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 24 Oct 2012 10:08:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9O88OUK001140
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1351670909.45052@cppmijH28oph0/y7iVDCCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208298>

Phil Hord <hordp@cisco.com> writes:

>>> +	if (state->substate==WT_SUBSTATE_NOMINAL)
>>>  		status_printf_ln(s, color,
>>>  			_("The current patch is empty."));
>> This looks weird. First, spaces around == (here and below). Then, the
>> logic is unintuitive. The "if" suggests everything is allright, and the
>> message below is very specific. This at least deserves a comment.
>
> Yes, I agree. It was less clear but more reasonable before I tried to
> clear it up some.  It's driven by the short-token printer. The state is
> "you're in a 'git am' but I do not see any conflicted files.  Therefore,
> your patch must be empty."

This was my guess, but I wouldn't have needed to guess if there was a
comment in the code ;-).

> I'll try to make this more explicit.   Currently the short-status
> version will say either "am" or "am \n conflicted" when a 'git am' is in
> progress.  The logical path to follow if I re-add 'git-am-empty' state
> tracker is for this to now show either "am \n am-is-empty" or "am \n
> conflicted".  But I think I should suppress the "am-is-empty" report in
> that case.  What do you think

I don't think you should remove it from the output (no strong opinion).
My point was just that the code looked weird.

>>> +static void wt_print_token(struct wt_status *s, const char *color, const char *token)
>>> +{
>>> +	color_fprintf(s->fp, color, "%s", token);
>>> +	fputc(s->null_termination ? '\0' : '\n', s->fp);
>>> +}
>> The output format seems to be meant only for machine-consumption. Is
>> there any case when we'd want color? [...]

> > [...]I thought I might be going back there, or that I might combine this
> > with full 'git status' again somehow, and colors seemed appropriate
> > still.
> > [...]
> > So I can remove this color decorator until someone finds a need for
> > it.

I'm fine with both options, with a slight preference for removing them.

> My own use-case involves $PS1.

That makes sense (indeed, the implementation of status hints was
slightly inspired from what the bash prompt in
contrib/completion/git-prompt.sh does). The next step could be to use
your porcelain there instead of checking manually file existance.

You may want to add a short note about this motivation in the commit
message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
