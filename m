From: Andreas Ericsson <ae@op5.se>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Wed, 17 Sep 2008 08:45:10 +0200
Message-ID: <48D0A776.1000009@op5.se>
References: <200809160048.31443.trast@student.ethz.ch> <7v63ox9e20.fsf@gitster.siamese.dyndns.org> <7vhc8h7xgj.fsf@gitster.siamese.dyndns.org> <200809170053.15341.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 08:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfqnw-0002Bn-Nr
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 08:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbYIQGpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 02:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbYIQGpQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 02:45:16 -0400
Received: from mail.op5.se ([193.201.96.20]:41310 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbYIQGpO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 02:45:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E66E31B80046;
	Wed, 17 Sep 2008 08:35:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.259
X-Spam-Level: 
X-Spam-Status: No, score=-3.259 tagged_above=-10 required=6.6
	tests=[AWL=-0.760, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAWnP4GewW4v; Wed, 17 Sep 2008 08:35:02 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id E66B11B80078;
	Wed, 17 Sep 2008 08:35:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200809170053.15341.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96069>

Jakub Narebski wrote:
> Dnia wtorek 16. wrze=C5=9Bnia 2008 02:20, Junio C Hamano napisa=C5=82=
:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Thomas Rast <trast@student.ethz.ch> writes:
>>>
>>>> The merge says
>>>>
>>>>   Trying simple merge with 5b3e4bb1c2d88d6967fb575729fbfc86df5eaec=
9
>>>>   Simple merge did not work, trying automatic merge.
>>>>   Auto-merging foo
>>>>   ERROR: Merge conflict in foo
>>>>   fatal: merge program failed
>>>>   Automated merge did not work.
>>>>   Should not be doing an Octopus.
>>>>   Merge with strategy octopus failed.
>>> ...
>>> Read the second from the last line of what you were told by git.  R=
un "git
>>> reset --hard" after that, perhaps.
>=20
> The problem, as far as I understand it, is not that octopus merge fai=
ls.
> The problem is that it fails halfway, and it leaves working are in
> inconsistent state: git-status output with its "unmerged" suggests th=
at
> we are in the middle of the merge, but we are not.
>=20
>> By the way, there are three failure modes in Octopus.
>>
>>  (0) your index (not work tree) is dirty; this is not limited to oct=
opus
>>      merge but any merge will be refused;
>=20
> IIRC the idea of stashing away changes, doing merge, and then unstash=
ing
> was shot down as encouraging bad workflows, and more often than not
> leading only to mess in workdir and index.
>=20
>>  (1) while it merges other heads one-by-one, it gets conflicts on an
>>      earlier one, before it even attempts to merge all of them.  Rec=
ording
>>      the heads that it so far attempted to merge in MERGE_HEAD is wr=
ong
>>      (the result won't be an Octopus the end user wanted to carete),=
 and
>>      recording all the heads the user gave in MERGE_HEAD is even mor=
e
>>      wrong (it hasn't even looked at the later heads yet, so there i=
s no
>>      way for the index or work tree to contain anything from them).
>>
>>      The above is hitting this case.
>=20
> IMVHO the correct solution would be to rollback changes to the state
> before attempting a merge. I'd rather 'octopus' did its thing as
> transaction; contrary to ordinary merges if merge fails it doesn't
> mean necessary that it is in the state of resolvable conflict, state
> we can stop at. Perhaps (if it is still a shell script, doing git-sta=
sh
> at beginning, and either dropping or popping the stash at the end;
> or just saving old index if it is built-in).
>=20
>=20
> BTW. does it mean that "git merge a b" might be not the same as
> "git merge b a"?
>=20

No. Git merges all the sub-things together and then merges the result
of that jumble into the branch you're on.

Someone might have to correct me on that, but that's as far as I've
understood it.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
