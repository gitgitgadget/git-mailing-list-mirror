From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Mon, 8 Jul 2013 20:13:18 +0700
Message-ID: <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org> <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
 <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:13:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBGL-0001sE-3S
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab3GHNNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:13:49 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:43549 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3GHNNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:13:48 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so6215341oag.23
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MKDUnguD058EmvqrmR3YeHOTrD5Zg/FTkkP53R+cenY=;
        b=ZtC9Q7lSphTzP/S4bbidDt+9Xkj8xQ3RlOZ7Q5OCbq5K6EPsRQnDHQVGZffNoJbwQB
         X7QUBDtS5g4L/Fk1glCIzdvis4PR34ZFHzqphUT5R05UIT8SZHQiDeIyeS4KUeejT0ab
         6VknaoJY/dyBD0kaH3vUdrfKgnJ1HgVnqdjCrSd8A/UWrcfOFmp3C4fzDjv5i+2cYGoa
         OOks9lxXixhoYwZODtYk3XD0uNq1DMo3LK+DF8tUgQ3Vwmhg+GeI4pbNn3n5MFSTW0TN
         Yrz5lbQ7+W9Jn54OFtly4V2dvRLSdUjXkSXNHNtRrNYmjGu5Zx1xzZPEefFizf12tlB6
         auRg==
X-Received: by 10.60.83.116 with SMTP id p20mr19984345oey.83.1373289228073;
 Mon, 08 Jul 2013 06:13:48 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 8 Jul 2013 06:13:18 -0700 (PDT)
In-Reply-To: <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229849>

On Mon, Jul 8, 2013 at 7:00 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> This is what I wanted to do with the in for-each-ref's pretty
>> formatting [1]. I used to hack cat-file --batch to extract info I
>> needed for experimenting with various pack index extensions. If you
>> are not in hurry, maybe we can introduce something similar to your
>> syntax, but applicable for all for-each-ref, branch and log family.
>
> I'm still quite confused about this "grand plan".  We have short
> commit-specific format specifiers that don't work with refs, among
> several other quirks in [1].  I personally think we should absolutely
> stay away from short format-specifiers (like %H, %f, %e; we'll soon
> run out of letters, and nobody can tell what they are without the
> documentation anyway) for the new options, and just start adding new
> long-form ones as and when they are necessary.  I think refname:short,
> upstream:track, upstream:trackshort are very sensible choices, and
> that we should continue along that line.  I'm fine with
> format-specifiers having meanings only in certain contexts as long as
> we document it properly (how can we possibly get %(refname) to mean
> something sensible in cat-file?).

The short/long naming is the least I worry about. We could add long
names to pretty specifiers. The thing about the last attempt is, you
add some extra things on top elsewhere, but format_commit_item code
may need to be aware of those changes, which are not obvious when
sombody just focuses on format_commit_item. Having all specifiers in
one place would be better (hence no hooks, no callbacks) because we
get a full picture. And yes we need to deal with specifers that make
no sense in certain context.

All that makes changes bigger, but when format_commit_item (now just
"format_item") knows how to deal with all kinds of objects and refs,
it becomes a small declaration language to extract things out of git.
You can use it for pretty printing or mass extraction in the case of
"cat-file --batch". "cat-file --batch" is just some bonus on top,
mostly to exercise that we do it right.

> As far as this series is concerned, I think Peff can implement %H and
> %(object:[disk-]size) locally without worrying about code-sharing or
> waiting for us.  Then, after the for-each-ref-pretty thing matures, we
> can just replace the code underneath.

There's also syntax sharing. I don't think each command should have
its own syntax. f-e-r already has %(objectsize). If we plan to have a
common syntax, perhaps %(disk-size) should be %(objectsize:disk) or
something. Adding formatting to cat-file --batch from scratch could be
another big chunk of code (that also comes with bugs, usually) and may
or may not be compatible with the common syntax because of some
oversight. --batch-cols=... or --batch-disk-size would be simpler, but
we might never be able to remove that code.
--
Duy
