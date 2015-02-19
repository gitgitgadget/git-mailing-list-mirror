From: Stefan Beller <sbeller@google.com>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 16:13:51 -0800
Message-ID: <CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOEke-0007sS-KB
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 01:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbbBSANw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 19:13:52 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36397 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbBSANw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 19:13:52 -0500
Received: by mail-ig0-f182.google.com with SMTP id h15so5836417igd.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aEcEr1mj6kofTUf+FhJIb2EzYsDsgxkRn5A3KpY2JCw=;
        b=dHhd6Z5Uo6CFbPin56VB/Q35dhnLKI899RGJlCesln/jJbGqINdQC/M8e2a0DWzntu
         8/WlH/cPQoEu1hU6/Ua30cOUZwIWRo0ukcGAf7snROl6i5ZllOppFUIlIMUCiu+eO2Qk
         1gOcQKj3GFjokbFArqtgbsALR33X7fe8DdPaWzMcL/JDCSxLpgAWAl3he4Uz0quZGS0n
         k7OzVVMnntEniyde1LUpIPjoXKwFVPeMYXqDN7ODI6Gt+58eSfz8g9lz0aWUrFkDUdl4
         SfR1uAL1SZfAMjdl6X/WfOif2qShn10POqROLy9/LC7m/faBI/ns0I9OFcQon9HPV2nC
         y9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aEcEr1mj6kofTUf+FhJIb2EzYsDsgxkRn5A3KpY2JCw=;
        b=GalxadKkgPPMY/Nw/QbWXPKhlRbuptkU+hGODBTXEZSZwQCYe69v2F1mEAM623Qtv3
         1ycyZz9xlkZaQdbeFX05uuivmxv4K9KbNmlOg3Z+7yBkgxGWm8loa+V+hl6JG7ieRYRz
         YBNdeZOEvOg68FZiAoGKNJnkHnOVoWsc5YnTR2tBclfXMQs/aiiV541IJL7qmG0DjUdC
         B4OtgQGGQ9NOad8g0Dcq6Q7iItqPRRJvfTSH7/ZGR+kYiYBpWk2B5yIHTEbk2GsapoBG
         FkPICvM0fr/5SruX+N93V+C38ChNYXkwp8oh4mNGZsKLhYBFnsVSLzQ5vXeqSvTrrma3
         D16g==
X-Gm-Message-State: ALoCoQmzx2tuGcNnCSilGGORyAvsoFK9WhIYjI7xM2zjXE+5ggaIXl8uYkSEHgu5bPV8iCYja8qr
X-Received: by 10.42.159.129 with SMTP id l1mr3108866icx.15.1424304831419;
 Wed, 18 Feb 2015 16:13:51 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 18 Feb 2015 16:13:51 -0800 (PST)
In-Reply-To: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264075>

On Wed, Feb 18, 2015 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If you did this:
>
>     $ git init void &&
>       git -C void commit --allow-empty -m initial &&
>       git -C void symbolic-ref HEAD refs/heads/nosuch
>     $ git clone --no-local void new
>
> you would get
>
>     warning: remote HEAD refers to nonexistent ref, unable to checkout.

I think there is another problem.
$ git status
On branch master

Initial commit

which makes no sense.

So after playing around I found:

$ git init void &&
   git -C void commit --allow-empty -m initial &&
   touch void/asdf
   git -C void add asdf
   git -C void commit -a -m "add a file"
   git -C void symbolic-ref HEAD refs/heads/nosuch
   git clone --no-local void new

This yields the warning as above and git status still tells us we're
on master. Though ls new shows an empty directory/repository.
After a `git checkout master` we can see the file and all is good to go.

How did we know we are on the master branch in the first place?
(and not on foo/bar, HEAD is pointing at nonsense!)
So what is the `current branch` of your new error message referring to?

Why did git status claim to be on branch master, but the repository
state was not in masters state, but in the unborn state?

These questions asked, would it make sense to either add a
git checkout `current branch` at the end of clone? (I suppose that is
what HEAD is good for actually).

Also it would make sense to have it's own HEAD pointing to 0{40}
or equivalent (just nothing) instead of having the master branch
available.

>
> While it is correct that we are unable to perform the normal
> "checkout" of their primary branch that their HEAD points at,
> it was reported that some users find this message unnecessarily
> alarming.
>
> Rephrase by saying what we decided to do, instead of only stating
> what led us to that decision without telling what that decision is.
> That is, "(because we cannot checkout), we left the HEAD pointing at
> an unborn branch."
>
> ---
>  builtin/clone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9572467..c7f1bf2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -625,8 +625,8 @@ static int checkout(void)
>
>         head = resolve_refdup("HEAD", RESOLVE_REF_READING, sha1, NULL);
>         if (!head) {
> -               warning(_("remote HEAD refers to nonexistent ref, "
> -                         "unable to checkout.\n"));
> +               warning(_("remote HEAD refers to nonexistent ref; "
> +                         "leaving the current branch unborn.\n"));

Personally I find that more confusing, because I have an idea of
what checkout may refer to. The notion of an unborn branch is not
clear to me.
Maybe

> -               warning(_("remote HEAD refers to nonexistent ref, "
> -                         "unable to checkout.\n"));
> +               warning(_("remote HEAD refers to nonexistent ref; "
> +                         "Checking out $branch instead.\n"));

with $branch being master in the example above. I'd have no idea
how to come up with a good heuristic which branch to checkout.
(It would need to match current behavior)
