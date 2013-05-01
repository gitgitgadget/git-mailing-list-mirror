From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Wed, 1 May 2013 10:35:00 +0200
Message-ID: <87li7zcd3f.fsf@hexa.v.cablecom.net>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
	<87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
	<20130430150430.GA13398@lanh>
	<7vehdsf19m.fsf@alter.siamese.dyndns.org>
	<CACsJy8B3PpzidvAHado=y3ZromzROidmHh_OW9ZCOoFegzmQ3Q@mail.gmail.com>
	<CALkWK0nnmzV0dcZ9avO9zDPhnQh9wkF7stA77cNycoXfecfUuw@mail.gmail.com>
	<CACsJy8CZ8E-ASmo237rRbYR7pqoseo-NpU6jVrg6Rvd9qSY01w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 10:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXSVQ-00018j-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 10:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab3EAIfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 04:35:12 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:45783 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab3EAIfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 04:35:09 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 1 May
 2013 10:35:01 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 1 May
 2013 10:35:05 +0200
In-Reply-To: <CACsJy8CZ8E-ASmo237rRbYR7pqoseo-NpU6jVrg6Rvd9qSY01w@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 1 May 2013 09:18:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223076>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, May 1, 2013 at 12:15 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Duy Nguyen wrote:
>>> We could put still ref aliases
>>> into the same ref namespace, with lower precedence that actual refs,
>>> so no new syntax required.
>>
>> Actually, ref-alises are the right way to solve the problem.
>> Recursive symref peeling is a bad idea: I can't take my aliases with
>> me, and they complicate unnecessarily.
>>
>> Any thoughts on how to implement it?  Should it go as deep as
>> resolve_ref_unsafe()?
>
> Depends on how you define ref alias. resolve_ref_unsafe allows you to
> substitute one ref with another. Thomas was talking about substituting
> part of extended sha-1 syntax (U -> @{u}) so it can't be done down
> there. I still think get_sha1_with_context_1() is the right place.
> Still not so sure how to handle when we have both alias "U" and
> refs/heads/U.

Well, I'm not sure about the semantics that I want.  But so far I am
*pretty* sure that I don't want it to be parameterized / part of another
ref.

So I'm fine with looking at *just* the alias, and resolving that to a
SHA1, and going from there.  So assuming U = @{u} and H = HEAD, you'd be
allowed to say U^ or U..H but not HU or H@U or whatever contortionate
syntax that would need.

As for the collisions, not sure which one is better.  Probably having
the same semantics as command aliases would be less confusing, i.e.,
existing refs take precedence.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
