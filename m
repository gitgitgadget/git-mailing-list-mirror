From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Thu, 24 Nov 2011 08:35:48 +0700
Message-ID: <CACsJy8BYN-nu6a92dk-qpF5_jR_frKwg+DD1EThr2kMPGHV5kQ@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do> <7vk46th5bz.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7HVe8kLR5j9Ej0tJhpkxigCXRqpg9DvE9qJsfengi1Q@mail.gmail.com> <7vy5v6bvy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 02:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTOEk-0003f0-84
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 02:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab1KXBgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 20:36:21 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54827 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab1KXBgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 20:36:20 -0500
Received: by bke11 with SMTP id 11so2294261bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 17:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ar52u3MY2Fn94zJNWcDZoyC0vsBhBMg6Tm18mxuzqWw=;
        b=JfMXDaBignFCnxQOyibXu6V6G13LB7c0TJtm2d65V/b3OHZYLG4aa7VnNeSFm0is6f
         MCTCLIFNG4z6BXM/NiSuEohATc808RWSI2Yt0HTg8HZsgzMsjmNuIAqVipEskrVnRAq0
         JdDb8sNee/nW2sl/x1R+Gnn3pRpSKnh6+5hGo=
Received: by 10.205.117.10 with SMTP id fk10mr26703642bkc.29.1322098579165;
 Wed, 23 Nov 2011 17:36:19 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 23 Nov 2011 17:35:48 -0800 (PST)
In-Reply-To: <7vy5v6bvy4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185887>

On Thu, Nov 24, 2011 at 12:16 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, Nov 21, 2011 at 10:18 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> In the medium term, I think one reasonable way forward solving the =
"TODO
>>> that used to be tracked but now untracked and ignored" issue is to
>>> introduce "info/exclude-override" that comes between command line a=
nd
>>> in-tree patterns. The info/exclude file is designed as the fallback
>>> definition to be used when all other sources are too lax, and comes=
 near
>>> the precedence stack; the "TODO" situation however calls for an ove=
rride
>>> that is stronger than the in-tree patterns.
>>
>> "info/precious" might be a better name
>
> The above is only about the precedence order and is not about introdu=
cing
> the new "precious" class at all.

The way I see how info/exclude-override helps keep (ignored but)
precious files is it un-ignores files that are ignored by info/exclude
and .gitignore. But if we go that way, then git-add will also
un-ignore precious files, allowing users to add them in-tree by
mistake.

>>> In the longer term, we should carefully determine if we need "preci=
ous" in
>>> the first place. The last time this was brought up there were peopl=
e who
>>> argued they are OK with having to remove the ignored file by hand w=
hen
>>> checking out another branch (i.e. we switch the semantics of "ignor=
ed" so
>>> that they are "not tracked but all precious").
>>>
>>> I think it matters in two cases.
>>>
>>> =C2=A0(1) If you change an untracked "cruft" file on branch A into =
a directory
>>> =C2=A0 =C2=A0 with tracked files in it on another branch B. If you =
are on branch A,
>>> =C2=A0 =C2=A0 have that "cruft" file (perhaps it is a build product=
 after running
>>> =C2=A0 =C2=A0 "make"), and try to checkout branch B, such an update=
d "git checkout"
>>> =C2=A0 =C2=A0 will start erroring out telling you that "cruft" will=
 be lost.
>>>
>>> =C2=A0(2) If you have a directory on branch A, underneath of which =
there are
>>> =C2=A0 =C2=A0 untracked "cruft" files (e.g. think "build/" director=
y that is full
>>> =C2=A0 =C2=A0 of "*.o" files and ".gitignore" to mark object files =
as ignored but
>>> =C2=A0 =C2=A0 is otherwise empty), and another branch B that has th=
e same path as a
>>> =C2=A0 =C2=A0 file. If you are on branch A, have "cruft" files in t=
hat directory,
>>> =C2=A0 =C2=A0 and try to checkout branch B, such an updated "git ch=
eckout" will
>>> =C2=A0 =C2=A0 start erroring out telling you that "cruft" will be l=
ost.
>>
>> I think we should do this regardless precious being added or not.
>
> Because (see below)?

Because it may potentially lose user's changes. Assume file "A" is
tracked and also ignored. Users may make some changes in A, then move
HEAD away without touching worktree, now HEAD does not see "A" as
tracked any more. If we switch to a branch that has A tracked, git may
override A and wipe our user changes in that file. In short, if a file
is tracked (either in source or target in 2-way merge) then we ignore
excluded() result on that file.

>>> If people are OK with such a behaviour, we can do without "precious=
".
>>
>> What about git-clean to remove ignored but not precious files?
>
(git clean without -x snipped because I was talking about -x)
>
> "clean -x" is more subtle. It has been a way to say "Remove cruft the
> usual way, and in addition, remove the expendable build products, jus=
t
> like 'make clean' _should_ do, but I do not trust my Makefile". If we
> introduced "precious", it would be very clear what it should do---eve=
n
> with "-x" precious files should be kept. But if we don't and just try=
 to
> get away by changing the semantics of "ignored", they will still need=
 to
> be removed, so we won't really get the "precious".
>
> The conclusion from this is that it is a mistake to change the semant=
ics
> of "ignored" from the current "untracked and expendable if needed" if=
 the
> purpose of that change is to avoid introducing the new "precious" cla=
ss.
>
> I don't care too much about it, as I do not use "git clean -x" myself=
 ;-)
> but that wouldn't stop others from think about the issue and try to c=
ome
> up with a good solid design.

I don't use "git clean -x" myself either. This is just some input to
the discussion and true users are supposed to speak up. The point I
want to make is, if users really want the ability remove non-precious
ignored files, then we may need to add the new "precious" class that
(and you seem to reach the same conclusion).
--=20
Duy
