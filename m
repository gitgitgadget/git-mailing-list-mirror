From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Wed, 18 Nov 2015 14:38:29 -0800
Message-ID: <CA+P7+xoDi54ZQFJp7eK5p7QqtWHqpsjLNO5oo_Q5kpuwOXVbww@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
 <CA+P7+xoyCwgYWaiVj0FNVHuaY=kUZA5a3LBMtpe6SirOVeK9rA@mail.gmail.com>
 <CALKQrgdDH2WZc-xi3ROLUBxdk=yVqfFGN3jN1GjQq4qJj_K+-A@mail.gmail.com>
 <CA+P7+xqGwb6yejh+HZMt8cwx=4arR6+YKCNVdftuQe5SBY_X9w@mail.gmail.com> <CALKQrge+agZ2NstnjkkVKmgqQRtE1cwiq6d7B9bP4_VApq+e_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 23:39:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzBNV-0002ak-2w
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 23:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303AbbKRWiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 17:38:51 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36737 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbbKRWit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 17:38:49 -0500
Received: by igcph11 with SMTP id ph11so112456135igc.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oSN5J9g+ZPg/23EkOCJ/Cg1bv9ub4umu4sU9VcOen24=;
        b=INIFmmGrnqEF42YmWlIev0g/k/HGz9t2pD5bC4TkkXZSmUJEkhGcaddr0wiElfnFPu
         QbfxpkRLK1HugjbVqOJLwFlXVDxpy+1Vr/X6ma8QbENi7CBwFimTSIpuTR1jCeGUl4ud
         Ovjoz1rT9ZVAeAB0uYjxjoqmblBAL4cDXRDtLnoKomFVI9vIVHGaGyNPOTueEK9YfjcN
         +yRLRKIzjwUU1TBTWKg8hXCaQ3kO0regCQwrj04DQp80rQX0AfT9ljxBb621UUhsQe2x
         pRNiPTzkciTILCY1A/Ij/gIRN4NBLzqYdf1ceQOU+j5jEd571IfDWF/hGk8cccF7efyv
         mi1A==
X-Received: by 10.50.32.69 with SMTP id g5mr10583581igi.35.1447886328863; Wed,
 18 Nov 2015 14:38:48 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Wed, 18 Nov 2015 14:38:29 -0800 (PST)
In-Reply-To: <CALKQrge+agZ2NstnjkkVKmgqQRtE1cwiq6d7B9bP4_VApq+e_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281463>

On Wed, Nov 18, 2015 at 2:29 PM, Johan Herland <johan@herland.net> wrote:
> On Mon, Nov 16, 2015 at 8:41 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> The main other issue is how to get notes DWIM things to work for all
>> cases where we want to use notes refs, since right now the DWIM is
>> basically done at the top level and only handles notes like things.
>> The problem with it is that if you specify a full ref that *isn't*
>> refs/notes, you will always prefix it with refs/notes, like so:
>>
>> refs/remote-notes/origin => refs/notes/refs/remote-notes/origin,
>
> I am becoming convinced that this is a bug. I don't know anywhere else
> in Git, where a fully qualified ref name (i.e. anything starting with
> "refs/") is not interpreted verbatim. For the notes code to do just
> that adds unnecessary confusion.
>

I agree, and I had a patch to change this behavior, but the main issue
being I think it didn't fallback to the suggested proposal below.

>> This makes it really difficult to expand a ref. However, Junio seemed
>> to think this was a possibly valuable expansion under normal
>> circumstances.
>
> I doubt it. It carries its own set of problems in that refs/foo/bar
> (=> refs/notes/refs/foo/bar) is treated differently from refs/notes/bar
> (=> refs/notes/bar). If users _really_ want to create
> refs/notes/refs/$whatever, they should have to be explicit about that
> (i.e. we should require them to say refs/notes/refs/$whatever instead
> of allowing them to lazily say refs/$whatever). (It even saves them
> from a potential bug if their $whatever happens to start with "notes/",
> in which case the current code already forces them to fully qualify...)
>

The question is whether we do:

a) check for refs/abc/xyz and fail if we can't find it or

b) check for refs/abc/xyz and then expand to refs/notes/refs/abc/xyz
if we can't?

I think that the first is generally preferable but with read-only ops
it's not a big deal since we won't be writing to notes trees.

> I realize this is a backwards-incompatible change in behavior, but I
> don't think it'll matter much in practice. Given e.g.
>
>   git notes --ref refs/foo list
>
> when refs/foo and refs/notes/refs/foo is both missing:
>   Current behavior: refs/notes/refs/foo lookup fails.
>     Treat like empty notes tree; no output, exit code 0
>   Proposed behavior: refs/foo lookup fails -> refs/notes/refs/foo
>     lookup fails. Same behavior as current.
>
> when refs/notes/refs/foo exists:
>   Current behavior: refs/notes/refs/foo lookup succeeds.
>     Shows notes in that tree
>   Proposed behavior: refs/foo lookup fails -> refs/notes/refs/foo
>     lookup succeeds. Same as current.
>
> when refs/foo exists:
>   Current behavior: refs/notes/refs/foo lookup fails. Treat like empty
>     notes tree; no output, exit code 0
>   Proposed behavior: refs/foo lookup succeeds. Load as notes tree,
>     probably empty, hence no output, exit code 0
>
> when both refs/foo and refs/notes/refs/foo exist:
>   Current behavior: refs/notes/refs/foo lookup succeeds. Shows notes
>     in that tree
>   Proposed behavior: refs/foo lookup succeeds. Load as notes tree,
>     probably empty, hence no output, exit code 0
>
> In other words, this change requires both refs/foo and
> refs/notes/refs/foo to be present in order to cause any real confusion.
> And in that case, the proposed behavior forces you to use fully-
> qualified refs (which will be interpreted as such) whereas the current
> behavior takes what looks like a fully-qualified ref (refs/foo) and
> interprets it like a notes-shorthand (-> refs/notes/refs/foo), which
> I argue is probably more confusing to most users.
>
>> The current solution is to try to do a normal lookup
>> first and only use the notes DWIM after we fail a lookup, which I
>> think is what the above patch attempts to do. This seems ok enough to
>> me.
>
> Yes, given $whatever, we should first lookup $whatever, and only
> failing that, we should try refs/notes/$whatever. Maybe it's also
> worth trying refs/$whatever (before refs/notes/$whatever), since that
> would be consistent with what's currently done for other refs (e.g.
> try "git log heads/master" or "git log tags/v2.6.3" in git.git).
>
>

The biggest implementation issue here is that the notes code that does
DWIM happens before lookup of whether the ref exists, and the code
that does lookup of refs in the notes.c code won't fallback and try a
different expansion.

I think that is why my proposed change was dropped, if I remember correctly.

I am in agreement with you, and think we should use the proposed
behavior above, as it is very unlikely to cause any issues with
current cases, especially since we already try not to allow operation
on refs outside of the notes tree today.

Regards,
Jake

> ...Johan
>
> --
> Johan Herland, <johan@herland.net>
> www.herland.net
