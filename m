Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC1C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 07:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiEKHeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiEKHeU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 03:34:20 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859D20792F
        for <git@vger.kernel.org>; Wed, 11 May 2022 00:34:18 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x11so469478uao.2
        for <git@vger.kernel.org>; Wed, 11 May 2022 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CP6dWZ3K+tJEe9ajkwzceVmq+DLDJm4DDJ3yn5tx4FA=;
        b=G4RPJqG30NR6SU/mUgFMnpM6daSopvqJzklq6Rz9is/221vZBXfr5fyePrxpx4kddm
         rLUnFMpQiqoaIOVlJnPyc+lLTh+QDpx8hiioCdAO22TvilH7C/9xy0v279O5ad+FFgYH
         NvBt6g0i3C6RW161pq14he1JotbdDwZJ3PH54tWctQSpGyVQdSS87aPGMTAXvXKb1EH4
         CI2yv/BJ+PgLWBZtC9Nd/TFw3i3zyaDJYTVU4ErcFrI3Y+aaR42LNttIsV9FIPK5Z2ll
         vNKpxDzCg/hIYVjDdBzg92AKTH1byzQRf8+2OPbG5ia9nEA1E9fM7kpeWOxsM4rpTduk
         TCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CP6dWZ3K+tJEe9ajkwzceVmq+DLDJm4DDJ3yn5tx4FA=;
        b=kuBb4UIgHaS/JTo5k77Vqgog+Y+6RDNwbL6wpps5JJBLSfK96kUpxGW+CnU4lhS8Ck
         hs4uyDnKrAVbLf5wg4WL8jyQNdpsOgYLwuj4mWjx07z7cEPL5tDahl9NUg1RqWVC45hs
         sRcNy2sp2rESyt+WRIB2wC56VbQaKafUP60hBgOC8yKvn9zUXGJ9f5IE6OrdbsqJ41B6
         QWEdq8DyW0N/7BwsM38Q54rKs7/omXI0hezSFFs+uIBKff0Wx/CJsmPP3mlur2uxxlmV
         fzVOqIjRCR7FDNgiQWo2AU1DBUW0Mq0kcgKIdYSfOkl4SiOOQRRoWyW4EO4CYloYZOey
         X20w==
X-Gm-Message-State: AOAM530l3x9ZaJCZQUEDDVs8ymUzsLw0H0VVVbrTIOUrNr33HcRdooYg
        oGGMEfdwNcnBSshsb+ZSBGOGgChtjfSQKCqU/JWKg0cy4kE=
X-Google-Smtp-Source: ABdhPJxnajigRFRBdu53GQUmEBoUC1KeUbwALOXDSkcUN/yFVQHnyuj0jdfaS1Ca3Z3cBIW61DhHAjuhtqA0jPv5k50=
X-Received: by 2002:a9f:3084:0:b0:360:1fa1:6aca with SMTP id
 j4-20020a9f3084000000b003601fa16acamr12961481uab.57.1652254457185; Wed, 11
 May 2022 00:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220507163508.78459-1-carenas@gmail.com> <20220510174616.18629-1-carenas@gmail.com>
 <20220510174616.18629-3-carenas@gmail.com> <xmqqv8ud5741.fsf@gitster.g>
In-Reply-To: <xmqqv8ud5741.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 11 May 2022 00:34:02 -0700
Message-ID: <CAPUEspiDeDm1p==H+yNq-s1cNyCyo8qOdqE20d7F4MVBi0thHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Because of compatibility with sudo, the code assumes that uid_t is an
> > unsigned integer type (which is not required by the standard) but is used
> > that way in their codebase to generate SUDO_UID.
>
> Heh, that is a good point.

except it is an implementation detail we can't control, and that we
have no way to test for (at least yet and definitely in these series)

just because sudo upstream does this, doesn't mean the sudo that was
built in that specific system does as well, and because strto*l will
silently convert a value from one sign to another it might even "do
the right thing" (tm) even when a signed uid_t exist and a negative
one is valid.

but since we are using a larger integer type to hold those values we
are especially at risk of misbehaving when uid_t is signed because we
didn't want to use atoi (and really couldn't safely).

some systems provide UID_T_MAX as means to figure out (both if it is
signed or not and to truncate safely), and I presume there are others
where you can get that value at runtime with something like getconf(),
but as you pointed out all that is moot if we still run as root so has
been punted from this series and all that is left are these documented
issues, which I meant to get to and fix ASAP (but with changes that
will be more intrusive and wouldn't be safe for maint), but that I
also want to leave clearly visible as bus factor protection.

> > +When git tries to check for ownership of git repositories, it will
> > +obviously do so with the uid of the user that is running git itself,
>
> We do not need "obviously" here, but this has overlap with the
> beginning part of the safe.directory explanation, so I would
> probably suggest rewriting it altogether.

obviously

> > +but if git is running as root, in a platform that provides sudo and is
> > +not Windows, it will check first if it might have been started through
>
> Does Windows provide sudo that leaves the original user in SUDO_UID
> (I doubt it)?  If not, then "on a platform that provides sudo, it will"
> would be sufficient.

At least my windows box does not, but dscho's somehow had and so that
line was added at his request[1] after he wasted so much time trying
to get this to work and realized the function where SUDO_UID logic
resides doesn't even exist in a Windows build.

While I think it is probably ok to go, something that would save
someone else that trouble is probably worth having one way or another,
especially since he wasn't the only one while reviewing[2] this code,
that got it wrong, either.

> > +If that is not what you would prefer and want git to only trust
> > +repositories that are owned by root instead, then you should remove
> > +the `SUDO_UID` variable from root's environment.
>
> s/should/can/.  But otherwise this is excellent.

It weakens the message I wanted to apply to this as being a way to
signal intention, and also being kind of the "official" way to do so
for the future, but I agree it might be premature and it is obviously
not that relevant once the next thing we might add is your code that
fixes the "regression" and allows both root and SUDO_UID to work for
this code.

> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 63ba89dd31..754cd90d43 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -393,12 +393,64 @@ static inline int git_offset_1st_component(const char *path)
> >  #endif
> >
> >  #ifndef is_path_owned_by_current_user
> > +
> > +#ifdef __TANDEM
> > +#define ROOT_UID 65535
> > +#else
> > +#define ROOT_UID 0
> > +#endif
> > +
> > +/*
> > + * This helper function overrides a ROOT_UID with the one provided by
> > + * an environment variable, do not use unless the original user is
> > + * root or could be used as means to escalate to root privileges.
>
> I do not understand the "or could be used ..." at all.  If the
> original user obtained from geteuid() is not root, then no matter
> what we do to *id here in this function, we won't let you gain the
> root privilege.  The system won't let us give you the root privilege
> because we (Git) are running as a normal user.

It is just there to explain the risks of using this function (which is
very visible) somewhere else, as well as to explain why it is only
meant to be used in a process running as root.

> Or do you mean
>
>         Do not use this function when
>
>          (1) geteuid() did not say we are running as 'root', or
>          (2) using this function will compromise the system.
>
> Then I can sort-of understand it, but (2) is a too obvious thing to
> say.

As usual I like your wording of it better, and yes I agree it is
obvious but since this function is very visible (which is not
necessary) and it is going to sit there in several maint releases, it
might not be that all unwarranted IMHO.

> > + * PORTABILITY WARNING:
> > + * This code assumes uid_t is unsigned because that is what sudo does.
> > + * If your uid_t type is signed and all your ids are positive then it
> > + * should all work fine, but need to make sure sudo never generates a
> > + * value higher than what can be represented by your uid_t type or a
> > + * negative value or it will trigger wraparound bugs.
>
> "sudo" generating a value higher than what uid_t can represent in
> SUDO_UID *is* a bug that we shouldn't have to worry about.
> Otherwise "sudo" as a tool would be unusable by folks with higher
> UID on their system.

not necessarily; that system might had decided to use negative uids
instead of changing to unsigned and everything will still work, but
you are correct that in that case sudo printing the uid_t with "%u" is
a bug in that sudo and should be fixed there, but the irony is that if
fixed, would then cause a bug on our side since we assume uid was
always positive and was printed with "%u".

this whole message is there just to try to explain the portability
issue that having signed uid_t might trigger and that would be
unlikely to happen in real life as an alternative to try to do
something about it (like I did in previous versions), or plainly
refusing to run like you proposed (at least NONSTOP seems to have
signed uid_t), specially considering this is in a maint track,

I was thinking it might be something better done (in the future) and
with all the portability bits hidden away in a proper compat file
instead of here.

> In their implementation of "sudo", they must have done getuid(),
> stored the value in uid_t and formatted it into a string.  If they
> lost precision there by wrapping around or truncating, we can do
> nothing about it, but the thing is, we cannot even tell.

exactly, but we can warn the users that the problems they might have
with this feature might be because of that, and the information they
will provide could guide us into implementing a more portable version
of this code in the future.

and meanwhile, they might be able to keep a local patch which would be
really simple to write on their side.

> > + * If that happens the uid used might be incorrect and then trigger
> > + * an access error from the filesystem itself.
>
> If uid we are extracting is incorrect, Git will fail to refuse
> access, the access is done as 'root', and filesystem level safety
> will not trigger.

My bad, I didn't mean that the filesystem will trigger the error, but
that we might fail to match the uid_t we got from the filesystem with
the one we parsed from uid_t and therefore fail to allow access.

Hopefully that mismatch would be easy to spot as well because of a
compiler warning (like -Wsign-compare), or we might get lucky and
might even work (ex: sizeof(long) == sizeof(uid_t))

> The end result is that I run "sudo git describe"
> in your repository and instead of getting refused, because our "sudo"
> was broken and SUDO_UID had your numeric uid, I execute "git" as root
> in your repository.

That shouldn't happen unless the overflow was big enough to trigger an
ERANGE though, which also means uid_t would be much larger than the
expected uint32_t it seems to have almost everywhere I looked.

> IOW, this change is meant to make it slightly convenient to allow
> access to one's own stuff, but it got a bit more convenient by
> allowing me access to my own stuff plus yours ;-)

Well, you said before that since we are running as root you can
already have access to mine so it shouldn't matter ;)

> > + * In the unlikely scenario this happened to you, and that is how you
> > + * got to this message, we would like to know about it by letting us
> > + * now with an email to git@vger.kernel.org indicating which platform,
> > + * you are running on and which version of sudo you used to see if we
> > + * can provide you a patch that would prevent this issue in the future.
>
> Nice.  What message does the reporter see?

when using `sudo git status` a rejection of access to the directory they own

> > + */
> > +static inline void extract_id_from_env(const char *env, uid_t *id)
> > +{
> > +     const char *real_uid = getenv(env);
> > +
> > +     /* discard anything empty to avoid a more complex check below */
> > +     if (real_uid && *real_uid) {
> > +             char *endptr = NULL;
> > +             unsigned long env_id;
> > +
> > +             errno = 0;
> > +             /* silent overflow errors could trigger a bug below */
>
> What "bug" are we referring to?

All of them, the ones we decided to ignore because they are irrelevant
when running as root, and the ones that are documented in the long
paragraph above.

Carlo

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet/
[2] https://lore.kernel.org/git/CAPUEspitAQrEjMpUyw8e2pyT1MT+h_dO5wSU0wWDWTqSye5TwA@mail.gmail.com/
