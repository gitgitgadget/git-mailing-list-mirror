From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Sun, 30 Oct 2011 16:55:54 +0700
Message-ID: <CACsJy8Ae1MPYzjoouZoFCU6Ltr9UznukfuTrJb=OUJYr9VTYSg@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com> <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
 <7vr51z3bqx.fsf@alter.siamese.dyndns.org> <CACsJy8C2nUJkN5=E7p2u_wjHqWy7EC_BS3Sr4+_QgunWHDdtKg@mail.gmail.com>
 <7vobx2z60w.fsf@alter.siamese.dyndns.org> <CACsJy8DdQXXoYT2gB2L5z6pdCNU_vL2w7c8eJvKRGX2T9iAC3Q@mail.gmail.com>
 <7vaa8jrm6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 10:56:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKS7z-0004i7-OQ
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 10:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299Ab1J3J41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 05:56:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47598 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481Ab1J3J40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 05:56:26 -0400
Received: by bkbzt4 with SMTP id zt4so1419288bkb.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5zC4BPRQGHkWStx6pS4pxOm8+jaVS4UMRI97NPi/tMU=;
        b=EkfDgY1mX9j4ucBPc4GL7oNjzY0Phne6L+YOlngnLU1C9Ad7xCtFz1jrTvMZZMAlwg
         IkUfTC5E2DrdwpVZN/hNw8GW0vQa+wa/Z/VUmv9XL0sCV3LNhXx+x6ywLcCf1GRg708f
         HdgzGgUOCV63Yqh7bQkqn6Uu99eZvmW0Lry6g=
Received: by 10.204.147.215 with SMTP id m23mr7127595bkv.84.1319968585090;
 Sun, 30 Oct 2011 02:56:25 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Sun, 30 Oct 2011 02:55:54 -0700 (PDT)
In-Reply-To: <7vaa8jrm6a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184471>

On Sun, Oct 30, 2011 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Side note. I just did this and I am not ge=
tting what you saw above.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ mkdir -p /var/tmp/j/y && cd /var/tmp/j/y
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git init; git init clone2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ : >3; : >clone2/2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ GIT_DIR=3Dclone2/.git git add clone2/2 3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ GIT_DIR=3Dclone2/.git git ls-files
> =C2=A0 =C2=A0 =C2=A0 =C2=A03
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clone2/2
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The behavour is different when clone2/.git=
 already has commit, and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0whatever codepath that gives these two dif=
ferent behaviour needs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to be fixed.

It's resolve_gitlink_ref() in treat_directory(). I think replacing
that call() with is_git_directory() would fix this problem. We may
want to do the same with remove_dir_recursively().

> When GIT_DIR=3Dclone2/.git is given, however, the caller explicitly d=
eclines
> the repository discovery. We do not know how the repository we are de=
aling
> with (which we were explicitly told with $GIT_DIR) and a directory wh=
ose
> name is ".git" under "clone2" we happened to find in read_directory()
> relates to each other, especially when our index does not have clone2=
 as
> our submodule.
>
> We however *do* know that our working tree is our current directory, =
so
> it would be wrong to do this:
>
> =C2=A0 =C2=A0$ GIT_DIR=3Dclone2/.git git add clone2/2 3; echo $?
> =C2=A0 =C2=A0error: 3 is outside our repository, possibly goverened b=
y .git
> =C2=A0 =C2=A01
>
> The command should just add clone2/2 and 3 as it was told to.

I am concerned about clone2/2 in this case, not 3. I guess we can
check if clone2/.git is the repo we are using. If it is, skip it.
--=20
Duy
