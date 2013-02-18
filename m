From: Thibault Kruse <tibokruse@googlemail.com>
Subject: Re: git clone tag shallow
Date: Mon, 18 Feb 2013 11:11:25 +0100
Message-ID: <CAByu6UVfArRXGLTKgM=nw0fzij1urcVdzxx6xdoHihODD-LtRA@mail.gmail.com>
References: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
	<CACsJy8Dso-g7foyJhpY20DNrY11PA8ZZUmP6JXxsiJ_Ggbt_KA@mail.gmail.com>
	<CAByu6UWO=kUOvJ_YcPG9bo+XVZ5hSxRQpyEaUMcVxa=sXt_EMw@mail.gmail.com>
	<7vliamascv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NhP-00043z-9i
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860Ab3BRKL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:11:27 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34691 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab3BRKL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:11:26 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so5489971obb.36
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=65P440PhwKKGZEv41hbj8vXWspHImdLseQFtbTGCERM=;
        b=SU0Sxemw2pQGZXCaSHSfYnv6vsEp9mrfCTAuJeURNDuEWD2QdgHJD1r0eVaUs/Fao1
         KZ95syx2lhjRrubZU72mPkDIL6ixz+39oHmFnoUA9MrbbI8XbYhK8c5ycjv5rh6sDspO
         7Z6ALyuHMYQJrSUPMWmt+EKLuY6Av6YLhpTE7cLrdru15PCq37g3/kC/T4Y0UzmRLX4X
         P/O/QT5Gf3Zol9AHjrcpdUi2kP+Ytq5m6UTimviXCNYRPaRl+76pS7nS1fyca3Zpruyd
         bfYIkxB/PRN9UkBsdEqYkqzRi9n7XMP3bq9i4VlMDojCNMRDoTqB9gm1UJ3uPnLvhR2s
         HCPQ==
X-Received: by 10.182.159.98 with SMTP id xb2mr5978684obb.35.1361182285649;
 Mon, 18 Feb 2013 02:11:25 -0800 (PST)
Received: by 10.182.251.165 with HTTP; Mon, 18 Feb 2013 02:11:25 -0800 (PST)
In-Reply-To: <7vliamascv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216464>

Hi Junio,

On Mon, Feb 18, 2013 at 10:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thibault Kruse <tibokruse@googlemail.com> writes:
>
>> Whenever a command description involves "<branch>" this can, depending
>> on the command, refer to
>> 1) a name that, when prepended with "refs/heads/", is a valid ref,
>> 2) a name that, when prepended with "refs/heads/" or "refs/tags", is a
>> valid ref,
>> 3) a name that, when prepended with "refs/[heads|tags]/", or unique in
>> "refs/remotes/*/" is a valid ref
>>
>> Now in the docu I don't see a nice distinction between 1), 2) and 3).
>> I could work on a patch if someone
>> tells me how to clearly distinguish those cases.
>
> It is _very_ true that we do not give strict distinction in many
> cases in the SYNOPSIS section.
>
> It is clear that (1) should use <branch> or even <branch-name>.
> "git checkout master" and "git checkout head/master" mean very
> different things.  The former is the "git checkout <branch-name>"
> case---checkout the named branch and prepare to grow the history of
> that branch.  The latter is "git checkout <committish>"---detach the
> HEAD at that commit, and even when the committish was named using
> the name of an existing branch (e.g. "master^0" or "heads/master"),
> prevent future commits made in that state from affecting the branch.
>
> I am not sure why you meant to treat (2) and (3) differently,
> though.  Care to elaborate?

As in my example, git clone --branch <branch> does not accept all of (3).

I now see that indeed the options section for git clone --branch has
been changed to inlude the information that tags are also allowed, so that's
in order.

> Outside "git checkout", we historically deliberately stayed loose in
> an attempt to help beginners by avoiding <committish> or <ref>, when
> most people are expected to feed branch names to the command and
> used <branch>.  I am not sure if it is a good idea to break such a
> white lie just to be technically more correct in the first place.

That's fair enough, I guess, I am not sure either. If I understand you
right, the Synopsis and
description are supposed to explain the non-hackish usage of commands,
whereas documentation after the OPTIONS headline is supposed to be
more of a complete description. Hence e.g. the synopsis of git-checkout
does not mention the --t,--track,--no-track options, and takes a liberal
approach to option syntaxes (listing '[-p|--patch]', but only '-m',
but not '[-m|--merge]'),
similar git-clone help does not mention the '--branch' option in the synopsis
for that reason, I guess. Do I get this right?

Does this also extend to the (bash) tab completion?
E.g. hitting tab after "git clone --", offers me (Ubuntu precise, git 1.7.9.5):
--bare           --local          --no-checkout    --origin
--reference      --template=
--depth          --mirror         --no-hardlinks   --quiet
--shared         --upload-pack

missing:
---recursive --recurse-submodules (--[no-]single-branch)
--separate-git-dir --verbose --progress --branch

Is this also intentional?

cheers,
  Thibault
