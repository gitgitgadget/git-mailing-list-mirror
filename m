From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv6 1/4] wt-status.*: better advices for git status added
Date: Mon, 04 Jun 2012 11:51:10 +0200
Message-ID: <20120604115110.Horde.CoZeVXwdC4BPzIUOb8j18yA@webmail.minatec.grenoble-inp.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v7gvoyuk4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 11:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbTwU-0006SV-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 11:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab2FDJvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 05:51:14 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:48902 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756666Ab2FDJvN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 05:51:13 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id BF9D01A0258;
	Mon,  4 Jun 2012 11:51:10 +0200 (CEST)
Received: from wifi-030076.grenet.fr (wifi-030076.grenet.fr [130.190.30.76])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Mon, 04 Jun
 2012 11:51:10 +0200
In-Reply-To: <7v7gvoyuk4.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199123>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> +		if (advice_status_hints)
>> +			status_printf_ln(s, color,
>> +				_("  (use \"git am --abort\" to restore the original branch)"))=
;
>> +	} else if (advice_status_hints) {
>> +		status_printf_ln(s, color,
>> +			_("  (when you have fixed this problem run \"git am --resolved\"=
)"));
>> +		status_printf_ln(s, color,
>> +			_("  (use \"git am --skip\" to skip this patch)"));
>> +		status_printf_ln(s, color,
>> +			_("  (use \"git am --abort\" to restore the original branch)"));
>> +	}
>
> I think the structure can simply be:
>
> 	if (am_empty_patch)
> 		"The current patch is empty.";
> 	if (advice_status_hints) {
> 		"  (use --abort to restore)";
> 		"  (use --skip to skip)";
>                 if (!am_empty_patch)
> 			"  (use --resolved after you are done)";
> 	}
>
> Note that I am not suggesting to change the wording of the message
> in the above; just showing the flow-structure.
>
> Also when you are in the middle of "git am -3", there may be
> unmerged entries in the index; do we want to suggest "add/rm" to
> resolve to fill in the missing detail of "fix" in your "when you
> have fixed this problem" message?
>
> We may want to decide how detailed we want to make the help texts;
> the same fuzziness exists in "fix conflicts and then" at the
> beginning of show_rebase_in_progress().

In fact, to detail more "fix" in this case by suggesting "add/rm"
would be repetitive, as this advice is already given under the block
"unmerged paths":

# Not currently on any branch.
# You are currently rebasing.
#   (fix conflicts and then run "git rebase --continue")
#   (use "git rebase --skip" to skip this patch)
#   (use "git rebase --abort" to check out the original branch)
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add <file>..." to mark resolution)
#
#	both modified:      main.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

>> +static void show_rebase_in_progress(struct wt_status *s,
>> +				struct wt_status_state *state,
>> +				const char *color)
>> +{
>> +	if (has_unmerged(s)) {
>> +		status_printf_ln(s, color, _("You are currently rebasing."));
>> +		if (advice_status_hints) {
>> +			status_printf_ln(s, color,
>> +				_("  (fix conflicts and then run \"git rebase --continue\")"));
>
>> +			status_printf_ln(s, color,
>> +				_("  (use \"git rebase --skip\" to skip this patch)"));
>> +			status_printf_ln(s, color,
>> +				_("  (use \"git rebase --abort\" to check out the original bran=
ch)"));
>> +		}
>> +	} else if (state->rebase_in_progress) {
>> +		status_printf_ln(s, color, _("You are currently rebasing."));
>> +		if (advice_status_hints)
>> +			status_printf_ln(s, color,
>> +				_("  (all conflicts fixed: run \"git rebase --continue\")"));
>> +	} else {
>> +		status_printf_ln(s, color, _("You are currently editing a commit =
=20
>> during a rebase."));
>> +		if (advice_status_hints && !s->amend) {
>> +			status_printf_ln(s, color,
>> +				_("  (use \"git commit --amend\" to amend the current commit)")=
);
>> +			status_printf_ln(s, color,
>> +				_("  (use \"git rebase --continue\" once you are satisfied =20
>> with your changes)"));
>> +		}
>
> This last "else" block is taken when running "rebase -i" and there
> is no longer any unmerged index entry.  I wonder if the message from
> the first printf_ln needs to be clarified further depending on the
> context.
>
> Specifically, in this sequence:
>
> 	- the user marked a commit as "pick";
>         - replaying of that commit resulted in conflicts;
>         - the user edited files and used add/rm to resolve conflicts;
>         - the user did one of these:
> 	  1. "git status"
>           2. "git commit" without "--amend"
>           3. "git commit --amend"
>
> can this message come up?
>
> In such a case, "You are currently editing a commit" is actively
> wrong.  The user has finished resolving the conflict and are about
> to record the result.  Also, "git status" and "git commit" without
> "--amend" are both sensible commands in this situation, but running
> "git commit --amend" is likely to be a mistake, no?

True, the last "else" block is not supposed to be taken. The correct
message that should be displayed is the first "else if" block, saying
just that all conflicts are fixed and to run rebase --continue.
