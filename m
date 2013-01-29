From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: show branch name if possible in in-progress info
Date: Tue, 29 Jan 2013 14:13:40 +0100
Message-ID: <vpqd2worv23.fsf@grenoble-inp.fr>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
	<vpqy5fcrwzq.fsf@grenoble-inp.fr>
	<CACsJy8DLdG9O+HaWS8u4n+imdaSZe=GrbYbPOhcMsYMWDq9NZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 14:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0B0r-0008JA-PC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 14:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab3A2NNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 08:13:48 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51759 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab3A2NNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 08:13:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0TDDdTS027395
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Jan 2013 14:13:39 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U0B0O-0003bS-Ni; Tue, 29 Jan 2013 14:13:40 +0100
In-Reply-To: <CACsJy8DLdG9O+HaWS8u4n+imdaSZe=GrbYbPOhcMsYMWDq9NZw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 29 Jan 2013 19:56:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jan 2013 14:13:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0TDDdTS027395
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360070023.31813@H2YvDHWWNflM7+f3QGGoUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214937>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 29, 2013 at 7:31 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> I like the idea.
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
>>> index b3f6eb9..096ba6f 100755
>>> --- a/t/t7512-status-help.sh
>>> +++ b/t/t7512-status-help.sh
>>> @@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progre=
ss before resolving conflicts'
>>>       test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>>>       cat >expected <<-\EOF &&
>>>       # Not currently on any branch.
>>> -     # You are currently rebasing.
>>> +     # You are currently rebasing '\''rebase_conflicts'\''.
>>
>> Perhaps "rebasing *branch* 'rebase_conflicts'"
>
> Looks good. One minor thing, if the ref happens to be
> refs/somewhere-not-in-heads, should we still say "rebasing branch
> 'refs/...'" or just "rebasing 'refs/...'", or something else?

I think this should not happen, since HEAD can either point to a branch
or directly to a sha1 in normal conditions. But it doesn't harm to be
defensive, in case ...

>> Or even "rebasing branch 'rebase_conflicts' on <sha1sum>"
>
> <sha1sum> being SHA-1 of HEAD?

Not HEAD, but .git/rebase-merge/onto, i.e. the target of the rebase.
Ideally, I would have loved to see "rebasing master on origin/master",
but I do not think the target ref name is stored during rebase.

> Why would you need it?

The typical use-case is starting a rebase, do something else, come back
the day after and wonder wft. Which branch is being rebased is probably
the most useful, but the target may help too. But I can live
without ;-).

> In short version, not full SHA-1?

If you add it, the short one (long version would make overly long line
with limited use).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
