From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently  processed
Date: Tue, 18 Jun 2013 12:12:22 +0200
Message-ID: <2dc2004fbf61d625515c2b6f62cc104e@ensibm.imag.fr>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <7vy5a8d1my.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uosts-0007hx-It
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab3FRKM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:12:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33218 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab3FRKM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:12:27 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5IACMpG032556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 12:12:23 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5IACN7R010549;
	Tue, 18 Jun 2013 12:12:23 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5IACNJK000608;
	Tue, 18 Jun 2013 12:12:23 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5IACMAw000605;
	Tue, 18 Jun 2013 12:12:22 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <7vy5a8d1my.fsf@alter.siamese.dyndns.org>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 12:12:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228185>

Le 2013-06-17 20:37, Junio C Hamano a =C3=A9crit=C2=A0:
> Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> writes:
>
>> When in the middle of a rebase, it can be annoying to go in .git
>> in order to find the SHA1 of the commit where the rebase stopped.
>>
>> git-status now includes this information in its default output.
>> With this new information, the message is now shorter, to avoid
>> too long lines.
>>
>> The new message looks like:
>> $ git status
>>  HEAD detached from 33e516f
>>  Editing c346c87 while rebasing branch 'rebase_i_edit' on 'f90e540'.
>
> Hmph.  It only looks into rebase-merge and not rebase-apply; is this
> patch complete, or just to show a Work-In-Progress?
It's a complete patch, at least we considered it as one.
We didn't want to change the output too much, so when the old message=20
was
too vague (ie. saying "...ing a commit") we replaced "a commit" by the=20
SHA1.
>
> I do not think you need to introduce a new stopped-sha file (if you
> need it, call that with "sha-1").  "git rebase [-i/-m]" knows where
> it stopped and what the next step is without having to have such an
> extra file.  Why should you need one?
I'm not following. At what point are we introducing a new file ?
What we meant to do was:
- if the user removed the file .git/.../stopped_sha for some reason,
   go back to the old "too vague" output
- otherwise, use the content of the file to display the SHA1 in the=20
output
>
> It seems that wt_status_get_state() tries to read in-progress state
> for various operations, and I think the logic to _detect_ what to
> show (i.e. what is the next commit to be replayed?  how many more
> remains to be replayed?, etc.) would mix well with that function.
This patch is meant to be a first-step.
The only modification it's supposed to bring is the SHA1 where we=20
stopped.
Display the list of what's left to be done isn't the purpose of this=20
particular patch.
> Extend wt_status_state structure to hold the necessary info, query
> the state from the filesystem in that function, and display the info
> (but not collect info) in show_rebase_in_progress(), to keep the
> clean division of labor between these two places.
Do you mean that we should include the stopped_SHA in wt_status_state ?
>
> Also, please pay closer attention to topics that are under
> discussion in other threads.  I think Ram's "Fix 'checkout -' after
Will do.
> 'rebase' finishes" topic cf.
>
>  =20
> http://thread.gmane.org/gmane.comp.version-control.git/227994/focus=3D=
228092
>
> makes the output reasonably better and consistent (please check what
> I'll be pushing out on 'pu' later today after fixing some of them
> up).  I suspect that this patch will conflict with it, so either you
> would need to wait, or work together with that branch (i.e. rebase
> on top of it as necessary), or something.
We have several modifications to make, so in the end we'll rebase on=20
top of it.
>
> In the longer term to address issues discussed in this thread cf.
>
>  =20
> http://thread.gmane.org/gmane.comp.version-control.git/227432/focus=3D=
227471
>
> I think the right direction is *NOT* to keep the first "HEAD
> detached at" line and to add more cruft to the status output as
> additional lines, when various sequencer-like operations that
> tentatively take you to detached HEAD state to give control back to
> you in the middle.  "git status" knows what operation is in
> progress, and I think we should start our output _without_ that
> "HEAD detached at" line.
>
> Thanks.

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
