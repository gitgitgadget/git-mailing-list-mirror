From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Wed, 23 May 2012 13:41:17 -0700
Message-ID: <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com>
References: <4FBAA33D.1080703@kdbg.org>
	<CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
	<7vzk8yzq35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXIMz-0003m1-W3
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 22:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab2EWUlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 16:41:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38286 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab2EWUlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 16:41:17 -0400
Received: by pbbrp8 with SMTP id rp8so10391408pbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GSY0MUC8Rro9uhGiERdHk32FSv28xkdYoPLGUt1q3+8=;
        b=gyiacnB/pwW8962gpdtKgEliz0b8gSSAEnSX7t9LiYUHWNzPb7qdsJJcm0h/3KVzm/
         usRVlkQA1Es+WhIwEyzZSxMsUvnDBSgR+XicOdIZ9mmJYDZM1lwHK2d5AhtBYhyzlDJA
         W0c4Q5xZearYwuah6VQYmHKfFo8LOfNMRIzKNb+k6oosxZGDXHxd1g0wRArT54zEZ08Q
         P1pAN9PiEz/gLd09+tE9yd086hRdVFTna6jaX7Ayn2hGFsRlt2xzRSLiLVmMcmvhP+Ta
         CndiCMykfmMNy1ErT2g6zxjjXm4fyApSZbOSmUtVX6MnhK/oCy4mc5Q6EmP63CBSZuku
         dvvw==
Received: by 10.68.197.99 with SMTP id it3mr13399612pbc.148.1337805677065;
 Wed, 23 May 2012 13:41:17 -0700 (PDT)
Received: by 10.68.51.130 with HTTP; Wed, 23 May 2012 13:41:17 -0700 (PDT)
In-Reply-To: <7vzk8yzq35.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198320>

On Wed, May 23, 2012 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> I think your original point was that the above clean picture would no=
t
> hold if e-b and g-b has interactions. =C2=A0g-b may contain some chan=
ge that
> e-b has independently done, in which case e'-g would be made smaller =
than
> e-b when the conflict is resolved while replaying e to produce e' on =
top
> of c' (the same applies if you replace e with any commit in the dag
> "rev-list ^b e d"). =C2=A0The merge to produce f' may result in confl=
icts,
> whether you merge e' and d' or replay f-e on top of e'.

Right. Or if e' was changed as a result of a "edit" action (I meant to
include '-i' in addition to '-p').

> A better way to keep potential "evil merges" at f while replaying to
> produce f' may *not* be by applying the difference f-e on top of e'.
> Instead, you can learn from what 'rerere' does. =C2=A0That is, to att=
empt a
> mechanical merge between e and d and call the result (with possible
> conflict markers and all) pre-f. =C2=A0If you compare pre-f and f, th=
at is the
> resolution and evil change made at f. =C2=A0When reproducing f', mech=
anically
> merge e' and d', call the result (again, with possible conflict marke=
rs
> and all) pre-f', and try reproducing f' by a 3-way merge between pre-=
f,
> pre-f' and f.

Yes, I've had the same idea myself. Anyway, as Johannes said, that's
probably something to consider for the sequencer.

Martin
