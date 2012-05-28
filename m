From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Sun, 27 May 2012 21:57:23 -0700
Message-ID: <7v1um47vik.fsf@alter.siamese.dyndns.org>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon May 28 06:57:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYs1e-0005IA-3D
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 06:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab2E1E51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 00:57:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab2E1E51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 00:57:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30259578F;
	Mon, 28 May 2012 00:57:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=33zclByaaU3k2PFs/ZcuGI7MMvg=; b=IQns/P
	mACQ/EAtMhtJRuvB5JfMdozSnUTeDqkb24IP2atV5IvD4XKXXPTg8lLzmQhuYBd0
	tCSRQQ2i/45slphGOsToZOGhAjernSnzn+szxKfEun+ycGM/qhX1pspdT1hKK8m+
	dWuchOtq8V01Tz+Pj3iRcExGEtpKX8Pxt79Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oe6HwdsHGZh15WfdDoqsKOaYQvXLlxW0
	aW2xSbUW0/sWYF5tRmTGwHwcK1WxzcOTMNmjXuaCiJoh2+jrIO4CwCjh3fUovAKH
	PvRfGuxuShCHB3PvhqRGk57otgcz1euYvbTijnrh+vvse38Gpuaf1MqGi4JqCRGR
	q7lQsQ0c4mA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24316578E;
	Mon, 28 May 2012 00:57:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EED0578C; Mon, 28 May 2012
 00:57:25 -0400 (EDT)
In-Reply-To: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Sat, 26 May 2012 14:38:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E1B60C4-A881-11E1-AB8D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198624>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:
Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> This patch provides more information about your current state after a git status command (in the cases of conflicts, before and after they are resolved, a rebase or a bisect process).
> This would help users to know what they are currently doing, in a more accurate way.

Please fix these overlong lines.

The description is unclear what problem it tries to solve and how,
and invites many questions.  Does it add more lines at the top?  At
the bottom?  How verbosely?  By pushing down existing information by
adding extra lines somewhere, the existing output lines may be made
harder to read, but how badly?  How does this affect "status
-s/status --porcelain" output?  What does the new code do to figure
out the "current state"?  By heuristics?  How often does the
heuristics get it wrong and in what circumstances?


> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..9839280 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -15,6 +15,7 @@
>  
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
> +	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
>  	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
>  	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
>  	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */

Why add new stuff in the middle, not at the end?

> @@ -728,6 +729,92 @@ static void wt_status_print_tracking(struct wt_status *s)
>  	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
>  }
>  
> +static void wt_status_print_in_progress(struct wt_status *s)
> +{
> +	int i;
> +	const char *c = color(WT_STATUS_IN_PROGRESS, s);
> +	const char *git_dir = getenv(GIT_DIR_ENVIRONMENT);
> +	const char* path;

> +	int unmerged_state = 0;
> +	int rebase_state = 0;
> +	int rebase_interactive_state = 0;
> +	int am_state = 0;
> +	int bisect_state = 0;

These are not independent (you cannot be in bisect and am at the
same time).  Why five independent variables?

> +	int conflict = 0;

How is this different from "unmerged"?

> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		struct string_list_item *it;
> +		it = &(s->change.items[i]);
> +		d = it->util;
> +		if (d->stagemask) {
> +			conflict = 1;
> +			continue;
> +		}
> +	}

That "continue" looks like a no-op.  Mental note: conflict seems to
remember if there was any path that was unmerged.

> +	path = mkpath("%s/MERGE_HEAD", git_dir);
> +	if (!access(path, R_OK))
> +		unmerged_state = 1;

Ahh, so "unmerged" is "conflicted during merge" (as opposed to
rebase_state is "conflicted during rebase")?  Doesn't the naming
sound odd?  If it were "merge_state", it might have made a bit more
sense (but again, these are not independent conditions, so multiple
variables do not make sense).

> +	path = mkpath("%s/rebase-apply", git_dir);
> +	if (!access(path, R_OK)) {
> +		path = mkpath("%s/rebase-apply/applying", git_dir);
> +		if (!access(path, R_OK))
> +			am_state = 1;
> +		else
> +			rebase_state = 1;
> +	}
> +	else {
> +		path = mkpath("%s/rebase-merge", git_dir);
> +		if (!access(path, R_OK)) {
> +			path = mkpath("%s/rebase-merge/interactive", git_dir);
> +			if (!access(path, R_OK))
> +				rebase_interactive_state = 1;
> +			else
> +				rebase_state = 1;
> +		}
> +	}

The above if/else makes it clear that if you are in "am" you can
never be in "rebase -i", but doesn't it strike you odd that the
check for MERGE_HEAD is not cascaded the same way?  I.e. if you know
you are in "merge", you cannot be "am" nor "rebase", but you check
the latter anyway even after you know you are in "merge".

> +	path = mkpath("%s/BISECT_LOG", git_dir);
> +	if (!access(path, R_OK))
> +		bisect_state = 1;

Likewise.

> +	if(bisect_state) {

s/if/if /;

> +		status_printf_ln(s, c, _("You are currently bisecting."));
> +		status_printf_ln(s, c, _("To get back to the original branch run \"git bisect reset\""));
> +		wt_status_print_trailer(s);
> +	}
> +
> +	if(unmerged_state) {

Likewise.

> +		if (conflict)
> +			status_printf_ln(s, c, _("You have unmerged paths: fix conflicts and then commit the result."));
> +		else
> +			status_printf_ln(s, c, _("You are still merging, run \"git commit\" to conclude merge."));
> +		wt_status_print_trailer(s);
> +	}

It is annoying that the above does things in random order, i.e.

	if (are we in X)
        	set state to X
	if (are we in Y)
        	set state to Y
	else if (are we in Z)
		set state to Z
	if (are we in W)
		set state to W

	if (Z)
        	say things about Z
	if (X)
		say things about X
	if (Y)
		say things about Y


Such a code structure invites bugs and missed cases (e.g. you do not
seem to say anything after you detect that you are in "am").


> +	if(rebase_state || rebase_interactive_state) {
> +		if (conflict) {
> +			status_printf_ln(s, c, _("You are currently rebasing: fix conflicts and then run \"git rebase -- continue\"."));
> +			status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git rebase --skip\"."));
> +			status_printf_ln(s, c, _("To check out  the original branch and stop rebasing run \"git rebase --abort\"."));
> +		}
> +		else {

	if (...) {
		...
	} else {
		...
	}

> +			if (rebase_state)

Why extra level of nesting?

> +				status_printf_ln(s, c, _("You are currently rebasing: all conflicts fixed; run \"git rebase --continue\"."));
> +			else {
> +				status_printf_ln(s, c, _("You are currently editing in a rebase progress."));
> +				status_printf_ln(s, c, _("You can amend the commit with"));
> +				status_printf_ln(s, c, _("	git commit --amend"));
> +				status_printf_ln(s, c, _("Once you are satisfied with your changes, run"));
> +				status_printf_ln(s, c, _("	git rebase --continue"));
> +			}

I am not sure if this level of verbosity is a good thing, given that
you are adding this near the very beginning of the output.  When you
have many conflicted or modified paths, these advice messages will
scroll off the top.

Oh, another thing.  Perhaps these (both detection logic and output)
should be protected with a new advise.* configuration variable, no?
