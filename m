From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 07/10] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sun, 11 Oct 2015 18:12:49 +0200
Message-ID: <vpqa8rp2xku.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-8-git-send-email-Karthik.188@gmail.com>
	<vpqa8rtnqzp.fsf@grenoble-inp.fr>
	<CAOLa=ZTvD5cXduPH3G0bGDba_hevLQsuwYsoZFtmfTd2SS4Prw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 18:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJFs-0000oY-TS
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbbJKQNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:13:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53369 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbbJKQNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:13:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGClZr028276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 18:12:47 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGCntS023579;
	Sun, 11 Oct 2015 18:12:49 +0200
In-Reply-To: <CAOLa=ZTvD5cXduPH3G0bGDba_hevLQsuwYsoZFtmfTd2SS4Prw@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 10 Oct 2015 23:49:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 11 Oct 2015 18:12:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BGClZr028276
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445184769.09822@3ippMD1sZUCQz0/y58km+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279339>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Fri, Oct 9, 2015 at 12:10 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> --- a/ref-filter.c
>>> +++ b/ref-filter.c
>>> @@ -1118,8 +1118,10 @@ static void populate_value(struct ref_array_item *ref)
>>>                               char buf[40];
>>>
>>>                               if (stat_tracking_info(branch, &num_ours,
>>> -                                                    &num_theirs, NULL))
>>> +                                                    &num_theirs, NULL)) {
>>> +                                     v->s = "[gone]";
>>
>> My remark about translation still holds. The string was previously
>> translated in "branch" and you are removing this translation (well, not
>> here, but when 09/10 starts using this code).
>>
>
> I should have mentioned in my cover letter, I didn't really understand
> what has to be done about this, couldn't find much reference to go
> about this. What do you suggest?

>From the user point of view :

git for-each-ref --format '%(upstream:track)' => Should always be the
same, because this may be parsed by scripts (plumbing). Should not
depend on $LANG, and shouldn't change from a version of Git to another.

git branch --format '%(upstream:track)' => Should show what is most
pleasant to the user (porcelain): translated according to $LANG and
friends, and may be improved in the future.

I already pointed out a fix where a string was translated in a plumbing
command. Another example is setup_unpack_trees_porcelain() in
unpack-trees.c which solves exactly the same problem.

I'll followup with a small series on top of yours to show the way. I did
not try to polish it since I guess you have local changes on the same
part of the code. Feel free to squash patches together or to squash them
with yours. The commit messages are not meant to be final either.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
