From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Wed, 17 Sep 2008 00:53:13 +0200
Message-ID: <200809170053.15341.jnareb@gmail.com>
References: <200809160048.31443.trast@student.ethz.ch> <7v63ox9e20.fsf@gitster.siamese.dyndns.org> <7vhc8h7xgj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfjRG-0006xZ-P3
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 00:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYIPWxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 18:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYIPWxW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 18:53:22 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:56936 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYIPWxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 18:53:21 -0400
Received: by ik-out-1112.google.com with SMTP id c30so2614466ika.5
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HFluaa5opEbABVGtHzzJjguD7CPo1XM/FhXw+vkMAMI=;
        b=VylNwX5rXknFr4cGGf6yfM2yrG2n/eFHp1qkbR69w8Hjf6AdCblLpblKm8MX6R65l8
         y2Da8867QRkXBVMPD8gc2Na4KaZoyioLfzTvc4ghuuPr0qywOl0h4fmI9qcsD2aQicta
         9+Vd7qqz6QYQaa/HAcukR83UI47ve1Uc0RaBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Uy95onNLkbP/x48ONSZbf/8hhq1pahZaSZxnc8nis4wTtWWZ5QyAqihas8k7lmZ4/H
         AqfC1hQ3kWES4U6UA1LmLHogBSlGiyAT5EW7Ag+/nJaddAodiWnAY8PNW/CCMEPLd5gu
         QDNkUMVom8XFWnqJVYTLG3Stc/6IkKwQrIeNY=
Received: by 10.86.80.17 with SMTP id d17mr1327335fgb.41.1221605599713;
        Tue, 16 Sep 2008 15:53:19 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.240.247])
        by mx.google.com with ESMTPS id 12sm17379362fgg.0.2008.09.16.15.53.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 15:53:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhc8h7xgj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96041>

Dnia wtorek 16. wrze=B6nia 2008 02:20, Junio C Hamano napisa=B3:
> Junio C Hamano <gitster@pobox.com> writes:
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> The merge says
>>>
>>>   Trying simple merge with 5b3e4bb1c2d88d6967fb575729fbfc86df5eaec9
>>>   Simple merge did not work, trying automatic merge.
>>>   Auto-merging foo
>>>   ERROR: Merge conflict in foo
>>>   fatal: merge program failed
>>>   Automated merge did not work.
>>>   Should not be doing an Octopus.
>>>   Merge with strategy octopus failed.
>> ...
>> Read the second from the last line of what you were told by git.  Ru=
n "git
>> reset --hard" after that, perhaps.

The problem, as far as I understand it, is not that octopus merge fails=
=2E
The problem is that it fails halfway, and it leaves working are in
inconsistent state: git-status output with its "unmerged" suggests that
we are in the middle of the merge, but we are not.

> By the way, there are three failure modes in Octopus.
>=20
>  (0) your index (not work tree) is dirty; this is not limited to octo=
pus
>      merge but any merge will be refused;

IIRC the idea of stashing away changes, doing merge, and then unstashin=
g
was shot down as encouraging bad workflows, and more often than not
leading only to mess in workdir and index.

>  (1) while it merges other heads one-by-one, it gets conflicts on an
>      earlier one, before it even attempts to merge all of them.  Reco=
rding
>      the heads that it so far attempted to merge in MERGE_HEAD is wro=
ng
>      (the result won't be an Octopus the end user wanted to carete), =
and
>      recording all the heads the user gave in MERGE_HEAD is even more
>      wrong (it hasn't even looked at the later heads yet, so there is=
 no
>      way for the index or work tree to contain anything from them).
>=20
>      The above is hitting this case.

IMVHO the correct solution would be to rollback changes to the state
before attempting a merge. I'd rather 'octopus' did its thing as
transaction; contrary to ordinary merges if merge fails it doesn't
mean necessary that it is in the state of resolvable conflict, state
we can stop at. Perhaps (if it is still a shell script, doing git-stash
at beginning, and either dropping or popping the stash at the end;
or just saving old index if it is built-in).


BTW. does it mean that "git merge a b" might be not the same as
"git merge b a"?

>  (2) it gets conflicts while merging the _last_ head.  It records
>      MERGE_HEAD and allows you to record the resolved result.
>=20
> I think originally we treated (1) and (2) the same way, because an Oc=
topus
> is to record the most trivial merge with more than 2 legs, and a roug=
h
> definition of "the most trivial" is "tracks of totally independent wo=
rks;
> you could merge them one by one and _in any order_, and the result wo=
n't
> matter because they are logically independent.  However if they are _=
so_
> independent, why not record them as merged in one step (i.e. octopus)=
,
> instead of insisting on recording in what order you merged them".
>=20
> Obviously, if you get a conflict during Octopus creation, they were n=
ot
> tracks of totally independent works, and that is where the "Should no=
t" in
> the message comes from.
>=20
> We later relaxed it to allow a conflict at the last step, not because
> recording an Octopus with nontrivial merge is particuarly a good idea=
 we
> should encourage, but because there simply weren't reason not to.

Well, octopus merge could simply fail when merge is nontrivial (not
limited to being tree-level merge only).

--=20
Jakub Narebski
Poland
