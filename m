From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Fri, 16 Jan 2009 14:46:01 +0100
Message-ID: <adf1fd3d0901160546o50db0594h7377774fed9fef99@mail.gmail.com>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
	 <496EE559.3060901@viscovery.net>
	 <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
	 <200901151500.01876.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
	 <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
	 <adf1fd3d0901160512i2de8f473gd471cc1dcb72afa4@mail.gmail.com>
	 <alpine.DEB.1.00.0901161415230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNp8b-0003ib-Tk
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765962AbZAPNvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 08:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbZAPNvp
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:51:45 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:11631 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765886AbZAPNvn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 08:51:43 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1039758mue.7
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 05:51:41 -0800 (PST)
Received: by 10.102.234.18 with SMTP id g18mr1199336muh.102.1232113561111; 
	Fri, 16 Jan 2009 05:46:01 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901161415230.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105961>

2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 16 Jan 2009, Santi B=E9jar wrote:
>
>> 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >
>> > Note that this affects creating bundles with --all; I contend that=
 it
>> > is a good change to add the HEAD, so that cloning from such a bund=
le
>> > will give you a current branch.  However, I had to fix t5701 as it
>> > assumed that --all does not imply HEAD.
>>
>> From the description I understand that it only affects when the HEAD=
 is
>> detached, but in t5701 the HEAD is not detached so nothing should be
>> fixed.
>
> The error in t5701 was that it _wanted_ to test a bundle without a HE=
AD,
> but it actually created it with --all.  That was implying that --all =
does
> not mean HEAD

Yes, that is the current behaviour.

> , and I disagree with that.

I know you disagree, but in the commit log you said:

---
[PATCH] revision walker: include a detached HEAD in --all

When HEAD is detached, --all should list it, too, logically, as a
detached HEAD is by definition a temporary, unnamed branch.
---

so nothing talks about changing the behaviour when the HEAD is not deta=
ched.

But the problem with t5701 is another thing. If you run this:

git init
: >file
git add .
git commit -m1
git bundle create b1.bundle --all HEAD
git ls-remote b1.bundle
git rev-parse --all HEAD

you will see that the same rev-parse parameters in "git bundle"
produce tree lines while with "git rev-parse" only two are produced.


>
>> For gc for sure it is a good thing, but I'm not convinced of the oth=
ers,
>> as a detached HEAD is a very special thing (temporary and unnamed
>> branch).
>
> So?  What does "--all" mean?  All branches or what? :-)
>
> Seriously, I think that --all should imply HEAD at all times, as the =
only
> time when it makes a difference is when you have that unnamed _branch=
_
> that is a detached HEAD.
>
> Maybe I would be more amenable to your criticism if you could come up=
 with
> a scenario where implying HEAD with --all is _wrong_.

I don't think it is plainly wrong. I think both makes sense, but I
think it is not a good idea to change the behaviour now as some
scripts may rely on it.

Santi
