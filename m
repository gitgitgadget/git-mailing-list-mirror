From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 4 Nov 2011 08:14:52 -0700
Message-ID: <CA+55aFw6JJDkkSJnp=X4cQuibXMHVBgbQ99iPqEbd7p_7J=VfQ@mail.gmail.com>
References: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com> <20111104145908.GA3903@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Ted Ts'o" <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	James Bottoml
X-From: linux-ide-owner@vger.kernel.org Fri Nov 04 16:15:21 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMLUF-0000oP-JG
	for lnx-linux-ide@lo.gmane.org; Fri, 04 Nov 2011 16:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab1KDPPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Fri, 4 Nov 2011 11:15:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45854 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1KDPPQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Nov 2011 11:15:16 -0400
Received: by wyh15 with SMTP id 15so2391988wyh.19
        for <multiple recipients>; Fri, 04 Nov 2011 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=0qK7NexbO/LL6jHK7YtYJIheq4y70x/xDvxRByOroLI=;
        b=wML1uqaS/060/xLwy3K0YcrY7dDdcoHoMx62elWxFLnFZClu6Y4lb5nkG3c6Ai2HEb
         0avelWuv+LatmkSDtemtEeDubvbc0xcAnnpOITH5PD/vdy/XmsgB5DbWeum0Wl3ci3n9
         yIusoYpWaG7qiSpcU/2iG6qavQAJ1PsQYGrFY=
Received: by 10.216.133.217 with SMTP id q67mr3254677wei.97.1320419714131;
 Fri, 04 Nov 2011 08:15:14 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Fri, 4 Nov 2011 08:14:52 -0700 (PDT)
In-Reply-To: <20111104145908.GA3903@thunk.org>
X-Google-Sender-Auth: g_0aJjAxucferXLsnG3GKm_YgG4
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184775>

On Fri, Nov 4, 2011 at 7:59 AM, Ted Ts'o <tytso@mit.edu> wrote:
>
> Note that a repository format change will break a bunch of other
> things as well, including references in commit descriptions ("This
> fixes a regression introduced in commit 42DEADBEEF")

No they won't. Not if you do it right. It's easy enough to
automatically replace the SHA1's in the description, the same way we
replace everything else.

Really.  It's *trivial*.

Maybe some current tools don't do it, but if I were to convert the
kernel tree, I'd absolutely *require* the conversion to be done right.
And "right" means "don't just get the parent SHA1's right, but the
ones hiding in the description too".

Any conversion tool has to keep track of the translation from "old
SHA1 to new SHA1" *anyway* because of all the other issues (ie exactly
things like parent pointers etc), so conversion tools by definition
have the information to do things like this right.

But "internal cryptographic signatures" are fundamentally different. A
conversion tool *cannot* convert them, since it won't have access to
the private keys in question, and thus cannot fix up the signature.

Sure, if I do the conversion, I could make *my* signatures match. And
that is true for every signer out there - individually. But only
individually, never collectively. Sure, we could all meet in one place
and synchronously re-sign things on our private machines with some
"distributed conversion tool", but realistically that really really
doesn't work.

It's a fundamental problem. And it really isn't a theoretical one -
it's one we know will happen *some* day.

I haven't worried about SHA1, exactly because I know it's not a real
problem - we can always convert. But internal signatures very
fundamentally change that.

And it really is about *internal* signatures. The kinds of signed tags
we have now are not a problem. Those can trivially be converted in a
distributed manner, exactly because they are "detatched" from what
they sign. We carry them along with the git repo, but they don't mess
up history, and they can be re-created individually without changing
anything else.

And yes, this was actually a design issue for me, which is why I feel
so strongly about it. I actually *thought* about issues like this
five+ years ago: I wanted to have cryptographic security, but I very
much on purpose wanted it to be "outside" the repo.

(Ok, so the git tag objects can sign other git tag objects
recursively, and in that case you have an ordering issue where a
conversion would first have to get somebody to re-sign their "inner"
tag before the "outer" signature can be re-created, but even if that
were to happen - and I don't think anybody does it - it's a trivial
problem with no real complexity issues).

>> =A0- they are ugly as heck, and you really don't want to see them in
>> 99.999% of all cases.
>
> So we can make them be hidden from "git log" and "gik" by default.
> That bit is a bit gross, I agree, but 3rd party verification really i=
s
> a good thing, which I'm hoping can be added in a relatively clean
> fashion.

I agree that we can hide them - that's after all what the pgpsig thing
does in the "internal commit signature" that git has in pu/next. That
one hides ie even more specifically, by putting it in the headers of
the commit, but that's just a random implementation detail.

But I really think that "internal signatures" that actually affect the
SHA1 of the object and its history have fundamental design problems.
They may not be "insurmountably bad", but they are definitely real.

                        Linus
