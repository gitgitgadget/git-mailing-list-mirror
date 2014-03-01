From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Sat, 1 Mar 2014 12:31:58 +0100
Message-ID: <CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
	<xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 12:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJi9j-0004hX-Ah
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 12:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbaCALcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 06:32:00 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:48843 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbaCALb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 06:31:59 -0500
Received: by mail-vc0-f176.google.com with SMTP id la4so1810053vcb.7
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 03:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GI91MGZEKOw35KUFw3lyAyoiRiuF/UfJSGtu2YDDR7w=;
        b=u3wxXjjqJ84l6n0SVZd6/B5d1SSkyFs+ZC8bQnvipluQjZZ81l4nK9kRVrubjZ5SYc
         lkzhb5/E71Ro6VMCpbxuLuTGiWIblEP5LCTDvSoP56yGvNGhjI8sHvf6d6q4CMk98sPD
         sVbZGXUAckQlhD/M9PK4CEUhqQ/f7WtVtfhmYt+/ZYFkfcaVNLuTiEP4f+OLTrq2ghZ5
         av6AyV484nh9JJxHfPf2NaGJvkbzasHhDs6F0JgV2pDYgLL1YAcCF54UYG7upHorFhBl
         QaICI+/i8TUKD6R+x9+EFPExjcvMjlJF3tL983QucX95bemM+Cwasd3QvFrdWnLX/npA
         0bWg==
X-Received: by 10.220.92.135 with SMTP id r7mr7096782vcm.11.1393673518604;
 Sat, 01 Mar 2014 03:31:58 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Sat, 1 Mar 2014 03:31:58 -0800 (PST)
In-Reply-To: <xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243062>

> I am not sure I understand what you are trying to say.  Are you
> saying that we should stick to good/bad and allow the users use
> nothing else, because allowing "fixed" will be confusing?
>

No! Pretty much the opposite of that. My idea (the "mark" subcommand)
is to let people define their own pairs of labels to represent two
opposite states of a commit. My point was that, if people choose pairs
of words that are not opposites (such as "good" and "fixed") then it's
their error, not something that git should attempt to fix or detect.

> For a young tool or a feature, catering to perfect human perfectly
> is a good first goal---if it does not work well even for error-free
> human input, it would be worthless.  However, its second goal after
> achieving that first goal ought to be to help imperfect humans.
>

Loved this.

> Why do you think there is nothing it can do to help the user?  Upon
> seeing "bad", the tool should at least be able to say "Excuse me,
> but you earlier said 'fixed' for one of the commits, so your
> vocabulary now is limited to 'fixed' and 'broken'".  I think it also
> should be able to add "Did you mean to say 'broken'?", or even "I'd
> assume that you meant 'broken' and will continue."
>

I haven't said this, but this is pretty much what I had in mind.
Suppose a user wants to find a bugfix between HEAD and HEAD~10, this
is what she would do:

$ git bisect start
$ git bisect mark working HEAD
$ git bisect mark broken HEAD~10

[git will now start bisecting as usual. Suppose that she is now at HEAD~5]

$ git bisect mark bad
-> Error: unrecognized label 'bad'. You previously used 'working' and
'fixed' to describe commits in this git bisect session. Please mark
commits with one of these labels.

I suppose that we could cater a little better to imperfect humans if
we had two predefined parallel list of antonyms in which to search for
given labels and infer whether they are positive or negative labels,
but this is beyond the scope of my proposal.

> I have always wondered if we can introduce a value neutral synonyms
> to good and bad.  For a bisect session, we care only about two
> states: "still-X" and "no-longer-X" where X may be 'working' for the
> normal bug-hunting bisection and 'broken' for the fix-hunting one.
>
>         $ git bisect still-working v1.6.0
>         $ git bisect no-longer-working v1.8.0
>
> would be a way to find a bug that was introduced during v1.6.0..v1.8.0,
> while
>
>         $ git bisect still-broken v1.6.0
>         $ git bisect no-longer-broken v1.8.0
>
> would be a way to find a fix in the same range.  The lowest-level
> bisection machinery could just _ignore_ anything after still/no-longer
> and do its thing, [...]

This is remarkably similar to my proposal. Using "mark", these would be:

$ git bisect mark working v1.6.0
$ git bisect mark not-working v1.8.0

and

$ git bisect mark broken v1.6.0
$ git bisect mark not-broken v1.8.0

> while the end-user facing layer could enforce,
> once one commit is marked as still-X (or no-longer-X), that nothing
> other than the same X is used, and issue an error message, perhaps
> like this:
>
>         $ git bisect still-broken v1.6.0
>         $ git bisect still-working v1.8.0
>         error: You earlier marked v1.6.0 as "still-broken" and
>         error: are hunting for the first commit that can be marked
>         error: as "no-longer-broken".  Say either "still-broken" or
>         error: "no-longer-broken", not "still-working".
>
> and that can be done without having to understand that "broken" is
> the opposite of "working" (of course if we understood that, we could
> even offer to guess that the user meant "no-longer-broken" by
> "still-working", but we do not want to go there).

Here my proposal differs in that I have no way of knowing which label
is good and which label is bad: I blindly accept two distinct labels
and bisect with those. I gave an example of this behaviour above.
