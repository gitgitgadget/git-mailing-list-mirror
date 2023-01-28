Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3DC27C76
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 11:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjA1Lug (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 06:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjA1Luf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 06:50:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5D023650
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 03:50:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f3so4791529pgc.2
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3HUOA07SRQPFYU7EH21qiExIryhPf1/SY9Uykyiijc=;
        b=MhYS4qHvUtYDoaAH+0+H5JsLWSJSelF56yJsEu+Rsvo8DFwS5qPxq9OcYckTSNZW/3
         M5ClrIud0FWPgErmoXsE4ICZwDIjxLMMux4mUI7p9hkyO6maXk7KJKombiPiQqs5TtiZ
         VANtI0rnHaqmUd4Kb4ux6yyMocNjzwh/C7sQYjvCiMXZDmrctIq+kKAzG3Mrfj5i/njx
         Jx9zym1cAbDsZfKS3MkrVtHKWAR6HiCMwqvlRGD0rwS35gmKqwGlTEwS5tSiw2OedywC
         ncLZgIM0pgFDAfwtDX8eJRvtm40NpD/GOccdmoa4qAiGMkedEUGqHfxmfg54+zO9XQJ7
         fl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3HUOA07SRQPFYU7EH21qiExIryhPf1/SY9Uykyiijc=;
        b=t32V+qUZAfOZHF6mODac9fobuPEY+0WZuWe2qNcB8X1Z8DZVl8h+BUPP5b+J1HGkEz
         f3xt0ncgyeAoSlxl7yn8n+rqVBHYxzOVvIf3/Lkc9c1L9gf9hoUkbgFpAsgFfCnpORAy
         kZNLYGkoIMeModRFIx3dYbyz/4d8SyirBKBU9OrQPfIFgKMwmcXRRdBmQVMx+yQrcPwb
         rjaVI7Q4dLzGb98hPamIyJtvmIrjh+hKC0KzA4nbPOPbwvPY3KihG7vptZRTktYK2+qN
         IqDfL0ifat+uiUn9gY/fGevXa1ACpWw4I6njYIxBvRm8DD1O3KLH07uDaWLJdU+JNzmA
         nZWQ==
X-Gm-Message-State: AFqh2kryzdrl99oAOzE8AFeTFcNaZBACpR4pzQO9hTzEGTduHWmEbHmP
        rlbilgksPB2CMN2RZPHLa2k=
X-Google-Smtp-Source: AMrXdXsrTJrwG4I9AvW7GCZLGZYIqqYgS6VAp5bRjfFbxbvxoHXgfuWOc9ykLgzRAQuYSzeQci0DPA==
X-Received: by 2002:aa7:80d3:0:b0:58d:e33b:d565 with SMTP id a19-20020aa780d3000000b0058de33bd565mr33251474pfn.5.1674906633987;
        Sat, 28 Jan 2023 03:50:33 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id i7-20020a056a00004700b005939de7104asm709859pfk.215.2023.01.28.03.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jan 2023 03:50:33 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     sunshine@sunshineco.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 3/5] notes.c: drop unreachable code in 'append_edit()'
Date:   Sat, 28 Jan 2023 19:50:27 +0800
Message-Id: <20230128115027.57250-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c50
In-Reply-To: <CAPig+cR5s3XzmY+L_jDW2g_PEgi5E791x0GuV+VPkxFA_6sB7A@mail.gmail.com>
References: <CAPig+cR5s3XzmY+L_jDW2g_PEgi5E791x0GuV+VPkxFA_6sB7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine writes:

> > Situation of note "removing" shouldn't happen in 'append_edit()',
> > unless it's a bug. So, let's drop the unreachable "else" code
> > in "append_edit()".
> >
> > The notes operation "append" is different with "add", the latter
> > supports to overwrite the existing note then let the "removing"
> > happen (e.g. execute `git notes add -f -F /dev/null` on an existing
> > note), but the former will not because it only does "appends" but
> > not doing "overwrites".
> >
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > @@ -630,13 +630,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >                 if (add_note(t, &object, &new_note, combine_notes_overwrite))
> >                         BUG("combine_notes_overwrite failed");
> >                 logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
> > -       } else {
> > -               fprintf(stderr, _("Removing note for object %s\n"),
> > -                       oid_to_hex(&object));
> > -               remove_note(t, object.hash);
> > -               logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
> > +               commit_notes(the_repository, t, logmsg);
> >         }
> > -       commit_notes(the_repository, t, logmsg);
>
> This change breaks removal of notes using "git notes edit". Prior to
> this change, if you delete the content of a note using "git notes
> edit", then the note is removed. Following this change, the note
> remains, which contradicts documented[1] behavior.
>
> [1]: Unfortunately, perhaps, this behavior is documented under the
> "remove" subcommand rather than the "edit" subcommand, but it is
> nevertheless documented and has worked this way for ages, so this
> patch causes a regression.

As the commit msg describes, the subcommands I understand should have clear
responsibilities as possible (documentaion may have some effect in my mind). So,
the removal opertion under "append subcommand" here is little wired to me, but
your suggestion makes sense, this may have compatibility issues. Although I
think it's weird that someone would use this in the presence of the remove
subcommand, and my feeling is that this code is actually copied from the add
method (introduced by 52694cdabbf68f19c8289416e7bb3bbef41d8d27), but I'm not
sure.

So, it's ok for me to drop this one.

Thanks.
