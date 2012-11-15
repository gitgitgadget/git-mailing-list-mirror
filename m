From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: add advice on how to push/pull to tracking branch
Date: Thu, 15 Nov 2012 20:40:09 +0100
Message-ID: <vpqmwyid59i.fsf@grenoble-inp.fr>
References: <1352976300-20159-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vr4nu92hm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ5NY-0000ia-39
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 20:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768846Ab2KOTpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 14:45:22 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51183 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768600Ab2KOTpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 14:45:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qAFJVNv4013220
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2012 20:31:23 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TZ5IH-0007ha-HM; Thu, 15 Nov 2012 20:40:09 +0100
In-Reply-To: <7vr4nu92hm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Nov 2012 09:53:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Nov 2012 20:31:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAFJVNv4013220
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1353612684.92858@n529ed722CGKOXB4ob4RQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209845>

Junio C Hamano <gitster@pobox.com> writes:

>> -	if (!num_theirs)
>> +	if (!num_theirs) {
>>  		strbuf_addf(sb,
>>  			Q_("Your branch is ahead of '%s' by %d commit.\n",
>>  			   "Your branch is ahead of '%s' by %d commits.\n",
>>  			   num_ours),
>>  			base, num_ours);
>> -	else if (!num_ours)
>> +		strbuf_addf(sb,
>> +			_("  (use \"git push\" to publish your local commits)\n"));
>> +	} else if (!num_ours) {
>
> The message should make it clear that the two words in double quotes
> only hint what command is used to "publish your local commits" and
> not to be taken as literal "here is what you exactly would type",
> but I do not think that is what I would get from this if I were a
> total newbie who would need this advise.
>
> It is even more true given that this is showing an arbitrary, and
> more likely than not a non-current branch, especially with the
> recent move from "matching" to "simple" where a naive use of "git
> push" is to push the branch that is currently checked out and no
> other branches.

I don't understand what you mean by "non-current". If you mean a local
branch not pointed to by HEAD, then I don't understand the remark, as
the message is shown by "git status" (looking more closely, it is also
shown by "git checkout", but after switching branch so also showing a
message about the current branch) and precisely talks about the current
branch. If you mean that the upsteam branch has a name different from
the local one, then with "push.default=simple", argumentless "git push"
will fail and show a detailed explanation to the user, which I find
acceptable.

I can tweak the advice to show the full "git push" command with
push.default=matching/current, but first, I'd like to understand your
remark.

>> +		strbuf_addf(sb,
>> +			_("  (use \"git pull\" to update your local branch)\n"));
>> +	} else {
>
> Likewise, and the non-currentness of the branch being described is
> even worse in here, as unlike "git push" that can still be used to
> push a non-current branch, "git pull" is never to be used to update
> local branch that is not current, which means the advice must mention
> "git checkout" somewhere.

I understand this remark even less. We're showing a message about the
current branch and its upstream branch. In which case would "git pull"
not do the right thing?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
