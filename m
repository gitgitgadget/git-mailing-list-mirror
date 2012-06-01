From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 21:39:11 +0200
Message-ID: <20120601213911.Horde.UIs0dHwdC4BPyRpflFgUaLA@webmail.minatec.grenoble-inp.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vmx4o58zc.fsf@alter.siamese.dyndns.org>
 <20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr>
 <7v396f3rhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaXgv-0007de-96
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098Ab2FATjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 15:39:17 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:45859 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964865Ab2FATjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 15:39:16 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 318511A02ED;
	Fri,  1 Jun 2012 21:39:12 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 01 Jun
 2012 21:39:11 +0200
In-Reply-To: <7v396f3rhg.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199016>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> konglu@minatec.inpg.fr writes:
>
>>>> +	} else {
>>>> +		status_printf_ln(s, color, _("You are currently editing a commi=
t
>>>> during a rebase."));
>>>> +		if (advice_status_hints) {
>>>> +			status_printf_ln(s, color, _("  You can amend the commit with"=
));
>>>> +			status_printf_ln(s, color, _("	git commit --amend"));
>>>> +			status_printf_ln(s, color, _("  Once you are satisfied with
>>>> your changes, run"));
>>>> +			status_printf_ln(s, color, _("	git rebase --continue"));
>>>
>>> For an advice in "git status" output, the above may be appropriate,
>>> but would the user see this in "git commit" template, and if so,
>>> isn't it because the user typed "git commit --amend"?  Does it make
>>> sense to suggest to run "git commit --amend" in that context?
>>
>> True, the user will see the messages in the "git commit" template. W=
e
>> didn't take this case into account because we thought that not many =
people
>> read the status in the "git commit" template. Anyway, just adding a =
=20
>> condition
>>
>> if (advice_status_hints && !s->amend)
>>
>> does the job.
>
> Hrm, what would happen if the user ran "git commit" without --amend?

The new advices will still be displayed (of course only if advice.statu=
shints
is enabled).

> It could be done by mistake, which will be greatly helped by the
> information you already gathered during the inspection phase.

Thus, if done by mistake, the user will know that he needs to do
"git commit --amend" to edit the commit.

> This also can be done deliberately to split a commit in "rebase -i",
> so "You are in 'rebase -i', do not commit without --amend!" is a
> wrong message, but it may be sensible to give "are you sure you
> meant to commit without --amend?"

An interesting case. In fact, more than warning the user about running
git commit without --amend, wouldn't it be better if there were specifi=
c
help messages about splitting a commit ? Like

# Not currently on any branch.
# You are currently splitting a commit.
#   (Once your working directory is clean, run "git rebase --continue")
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   t/t7060-wtstatus.sh
#       modified:   t/t7512-status-help.sh
#       modified:   wt-status.c
#
no changes added to commit (use "git add" and/or "git commit -a")

that will be the output of git status after a "git reset HEAD^" during
a rebase -i. There's already the advice "(use git add <file>...)" so
putting it twice is not really relevant.

What do you think about it ?
