From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 10:42:11 +0200
Message-ID: <vpq8vg7jue4.fsf@bauges.imag.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:42:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNRA-0003gh-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 10:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357Ab2FAImU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 04:42:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36689 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757796Ab2FAImS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 04:42:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q518XnQC009707
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 10:33:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SaNQy-0004H7-PY; Fri, 01 Jun 2012 10:42:12 +0200
In-Reply-To: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Thu, 31 May 2012 17:15:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 10:33:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q518XnQC009707
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339144433.26498@uy3+bHkvXA0fpN4yBpLuxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198958>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> +	cat >expect <<-\EOF &&
[...]
> +	# Untracked files:
> +	#   (use "git add <file>..." to include in what will be committed)
> +	#
> +	#	expect
> +	#	output
> +	no changes added to commit (use "git add" and/or "git commit -a")
> +	EOF
> +	git status >output &&

You can run

  git status --untracked-files=no

instead, to get rid of these "expect" and "output". as Junio mentionned
on another topic, these make the test scripts a bit harder to maintain,
for example you should rename "output" to "actual", and you don't want
that to interfere with the content of "expect".

> +	} else if (state->rebase_in_progress) {
> +		status_printf_ln(s, color, _("You are currently rebasing%s"),
> +			advice_status_hints
> +			? _(": all conflicts fixed: run \"git rebase --continue\".") : ".");

Avoid having two ":" in the same sentense.

> +		if (advice_status_hints) {
> +			status_printf_ln(s, color, _("  You can amend the commit with"));
> +			status_printf_ln(s, color, _("	git commit --amend"));
> +			status_printf_ln(s, color, _("  Once you are satisfied with your changes, run"));
> +			status_printf_ln(s, color, _("	git rebase --continue"));
> +		}

Can this be more consistant with other status hints? When a hint follows
a statement on the next line, it's usually

# Say something
#   (use "git whatever" to change the current state)

e.g.

# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)

So this may be turned into

# Rebase in progress
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your changes)

> +	if (state->merge_in_progress)
> +		merge_in_progress_show(s, state, state_color);
> +	else if (state->am_in_progress)
> +		am_in_progress_show(s, state, state_color);
> +	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
> +		rebase_in_progress_show(s, state, state_color);
> +	else if (state->cherry_pick_in_progress)
> +		cherry_pick_in_progress_show(s, state, state_color);
> +	if (state->bisect_in_progress)
> +		bisect_in_progress_show(s, state, state_color);

I still disagree with the "else if" logic here. If the user started two
operations, I think we should show both messages.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
