Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4364BC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 21:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4320702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="deuLMM4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA2VX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:23:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52163 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgA2VX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 16:23:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so1377378wmi.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMLNJI1G4gcIXrhS83v11SWr1JQlpINjOYbQKlU/9jA=;
        b=deuLMM4bXCC/FKNtOsn/rau8Kq2KsGvN28pWpLzUeXteRIdsCv2hvPpp0iZWqdr4SU
         D6t1GA3yehxA380abhZLdIX0otSMl91S2Lkum+d2zQqhFagVUx2352vTiFnHAh7E+5KO
         uv32bir1utFcU7youpJYx4A8g/hqoM29aVFNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMLNJI1G4gcIXrhS83v11SWr1JQlpINjOYbQKlU/9jA=;
        b=AwhsIXOIINYu8WhxY/zswE3+FURdM+zb43q3D1aUpFUdrVHCd/yQ2PyoUGwbdt+VcY
         fw18zpSVeBp1d2nUPNPyMY+DLO5sXsxKBAQu+xttqmvjLjSksv8Z3HTNNAyyguoZh1yH
         DJqSQfNJGhQbdKgY+DJdLuHGqU6NjBRrdjrkSE2u3PguOHiWigXlMAwj+UdWboL8AFXt
         lD5w2Dd56CvoXrFpopPWZwuPUvLD24oVEt6w9B7lXSCVmV16X5Sy0Q7u/dYT+7yB+FGl
         b1vzmn3Y4K42c/l2+a4Ci6eKRKqGqPDpeENEqZGbEwRk8NUXByquLGp7jyhKmckYOzNZ
         mA9w==
X-Gm-Message-State: APjAAAW6SzRY5lsjCZBytceeV2Vbaa+osJ9gD9uvzZ+Vfc1G8RwqMSLs
        wbKhhjtVrHjz8RvOdT7+ltt8vIj8D/yIO8U99cYBkw==
X-Google-Smtp-Source: APXvYqwsLa8u5ed5fl0qprObxELKI1155OgEuhu4C6e79jVU/+kbnP2Z0/giqG4hi8naKThjvruQdbxvIkRO4B4eMTY=
X-Received: by 2002:a1c:a947:: with SMTP id s68mr1196481wme.61.1580333004681;
 Wed, 29 Jan 2020 13:23:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
 <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com> <CAE5ih79a4SeiAnC_c+XHXAiibeNBg-h1ZjMsv2pHMNtHGmqX1w@mail.gmail.com>
 <xmqqtv4edqx9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv4edqx9.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 29 Jan 2020 21:23:13 +0000
Message-ID: <CAE5ih79BCWmTb1-9xU0L=q8QOSdU6OdrGMNfxkCjoED1_oDKcw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrey Mazo <ahippo@yandex.com>, Git Users <git@vger.kernel.org>,
        Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Jan 2020 at 19:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Diamand <luke@diamand.org> writes:
>
> > On Tue, 21 Jan 2020 at 23:05, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> [jc] asking for help from those who made non-trivial changes to "git
> >> p4" in the past 18 months or so for reviewing.
> >
> > This looks fine to me. I've not actually tested it.
> >
> > Ack.
>
> Thanks, but it wasn't very helpful to see an Ack (i.e. "an expert
> says this is good") without seeing any of my "why is this good?"
> answered by either the original author or the expert X-<.

You're right.

Revisiting the code, there is already a p4-pre-submit hook. However, I
don't think that would suffice as it doesn't get given the actual
commits, and trying to figure out the commit messages would be quite
tricky.

However, a regular git pre-submit hook could do this.

If the commit-message-checking relied on talking to the Perforce
server though, this proposed hook would be necessary.


>
> >> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > From: Ben Keene <seraphire@gmail.com>
> >> > Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
> >>
> >> "git shortlog --no-merges" would show that the convention is to
> >> downcase "Add".
> >>
> >> With two consecutive non-words (i.e. 'pre' and "pedit'), it really
> >> feels an unpronounceable mouthful to a non-perforce person like me.
> >>
> >> On the core Git side, "git commit", which is the primary command
> >> that is used to create a new commit, has two hooks that helps to
> >> enforce consistency to the commit log messages:
> >>
> >>  - The "prepare-commit-msg" hook prepares the message to be further
> >>    edited by the end-user in the editor
> >>
> >>  - The "commit-msg" hook takes what the end-user edited in the
> >>    editor, and can audit and/or tweaks it.
> >>
> >> Having a matching pair of hooks and making sure the new hooks have
> >> similar names to these existing ones may help experienced Git users
> >> adopt the new hooks "git p4" learns here.
> >>
> >> What makes "p4-pre-pedit-changelist" a good name for this hook?  "In
> >> pure Perforce without Git, there is 'pre-pedit-changelist' hook that
> >> Perforce users are already familiar with" would be a good answer but
> >> not being P4 user myself, I do not know if that is true.
> >>
> >> Also, "git commit" has a mechanism (i.e. "--no-verify") to suppress
> >> the "auditing" hook, and it serves as an escape hatch.  The new hook
> >> "git p4" learns may want to have a similar mechanism, to keep its
> >> users productive even when they have broken/stale/bogus hook rejects
> >> their legitimate log message, by allowing them to bypass the
> >> offending hook(s).
> >>
> >>
> >> > Add an additional hook to the git-p4 command to allow a hook to modify
> >> > the text of the changelist prior to displaying the p4editor command.
> >> >
> >> > This hook will be called prior to checking for the flag
> >> > "--prepare-p4-only".
> >> >
> >> > The hook is optional, if it does not exist, it will be skipped.
> >> >
> >> > The hook takes a single parameter, the filename of the temporary file
> >> > that contains the P4 submit text.
> >> >
> >> > The hook should return a zero exit code on success or a non-zero exit
> >> > code on failure.  If the hook returns a non-zero exit code, git-p4
> >> > will revert the P4 edits by calling p4_revert(f) on each file that was
> >> > flagged as edited and then it will return False so the calling method
> >> > may continue as it does in existing failure cases.
> >>
> >> The githooks(5) page should talk about some of these, I would think.
> >>
> >> >  git-p4.py | 11 +++++++++++
> >> >  1 file changed, 11 insertions(+)
> >> >
> >> > diff --git a/git-p4.py b/git-p4.py
> >> > index 40d9e7c594..1f8c7383df 100755
> >> > --- a/git-p4.py
> >> > +++ b/git-p4.py
> >> > @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
> >> >          tmpFile.write(submitTemplate)
> >> >          tmpFile.close()
> >> >
> >> > +        # Run the pre-edit hook to allow programmatic update to the changelist
> >> > +        hooks_path = gitConfig("core.hooksPath")
> >> > +        if len(hooks_path) <= 0:
> >> > +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> >> > +
> >> > +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
> >> > +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
> >> > +            for f in editedFiles:
> >> > +                p4_revert(f)
> >> > +            return False
> >> > +
> >> >          if self.prepare_p4_only:
> >> >              #
> >> >              # Leave the p4 tree prepared, and the submit template around
> >> >
> >> > base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
