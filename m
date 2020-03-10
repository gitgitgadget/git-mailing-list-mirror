Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5890C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 12:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A700B2467D
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI3loZRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCJMIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:08:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbgCJMIN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 08:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583842091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j43gIQt9w7Ewcl0alstkJBMRKdvqYsENhwKqwYBOILc=;
        b=GI3loZRXLATnxQFul/8p9AFx9RmvW2vAbfUWimbvavrCXqmjh2PD9POBOnJ16UHApIEq6k
        n3N0mykXWeafF9zjTg9Sh/QrYQP2HcH79ouCE4TTiPbQYdCZ0yrinvDEQ2/F54PyIXR9SD
        lHYc7fBpx2/Z75Gn15wgvfHCEV8JoQU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-92RcNcq4M_Kz-8FefwFp3Q-1; Tue, 10 Mar 2020 08:08:07 -0400
X-MC-Unique: 92RcNcq4M_Kz-8FefwFp3Q-1
Received: by mail-wm1-f70.google.com with SMTP id z26so270116wmk.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 05:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j43gIQt9w7Ewcl0alstkJBMRKdvqYsENhwKqwYBOILc=;
        b=I7pCcqE1FUA5sxP/i2qYSLJb7XYEHVPXNpn1FSk3YmpiLV42zb4i90KG9eIlJEjm92
         EY/nLl0EbAM8m8iH6aj19UNrhKio1Ulv7q6shVXuZLRKrYRgIDzbCmgx96v69pz0qGY8
         tclyH0Fj75n23/yv1zo+qJqQGIbw+NOWNCvh3telrRFCmTs9ll/MFiIcfcqdLNdzbzZN
         i77loi5WCLj18F8p5Re6a69TgEV7w+lVBKl5f/h6OjkP6Dk+Qwvl7SXST4T+Lf/e2fOM
         rb6z0jrBFV4o0A882JJ4FgbbmuzYesZXryGcUAZTI41y1yICd+/LckIhSQ62b9dttoUp
         D5AQ==
X-Gm-Message-State: ANhLgQ2yk6EncwzGM+4X0FKsIsFJDtbapsvT9OFglq+rTMo73NYu4gUB
        58QBth3h0hxuUwgR/h4S5haLUmnFGg1Ro/4Gb5Wc9fWJLTseLv+MKLh11/4eI0tnyOK4AAaOLG9
        /7zZGfoMyQlxFmDMyIq85rfcrBe+w
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr1905898wmj.147.1583842086306;
        Tue, 10 Mar 2020 05:08:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtioodeSMVHCyIXae2C4x8KKB4NXSzHBMLIeZHx5Qj0ZqkUnbQHvWiEY7nQZ3oOLIR0jrpUH0NbA4e3npa38hw=
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr1905875wmj.147.1583842086084;
 Tue, 10 Mar 2020 05:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
 <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com>
In-Reply-To: <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com>
From:   Ondrej Pohorelsky <opohorel@redhat.com>
Date:   Tue, 10 Mar 2020 13:07:55 +0100
Message-ID: <CA+B51BErxp0Nzcc=1Ress4tbDmKYmcCqUyC-fmD+8O8KdaZLZQ@mail.gmail.com>
Subject: Re: git-core: try_to_follow_renames(): git killed by SIGSEGV
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your further analyzation and explanation.

I would love to make a patch for this bug, but sadly
I'm not fully aware of what is going on in this functions
and how they are affecting other git functionality.

I hope @szeder can look into this bug and provide more explanation
as he knows this code best.

Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

On Fri, Mar 6, 2020 at 3:58 PM Alexandr Miloslavskiy
<alexandr.miloslavskiy@syntevo.com> wrote:
>
> Since I like studying crashes and noone else replied, I decided to have
> a look.
>
> The problem is easy to reproduce with this (replace 1.c with any file):
>    git log --follow -L 1,1:1.c -- 1.c
>
> It occurs because `opt->pathspec.items` gets cleaned here:
>      clear_pathspec
>      queue_diffs
>          /* must look at the full tree diff to detect renames */
>          clear_pathspec(&opt->pathspec);
>          DIFF_QUEUE_CLEAR(&diff_queued_diff);
>      process_ranges_ordinary_commit
>      process_ranges_arbitrary_commit
>      line_log_filter
>      prepare_revision_walk
>      cmd_log_walk
>      cmd_log
>
> And on next iteration it crashes in 'try_to_follow_renames' on this line:
>      diff_opts.single_follow =3D opt->pathspec.items[0].match;
>
> I think that bug comes from commit:
>      a2bb801f by SZEDER G=C3=A1bor, 2019-08-21 13:04:24
>      line-log: avoid unnecessary full tree diffs
>
> @szeder could you please look into that?
>
> On 27.02.2020 13:56, Ondrej Pohorelsky wrote:
> > Hi,
> >
> > there is a SIGSEGV appearing in Fedora[0] with Git 2.24.1
> >
> > This bug started to appear after update to Git 2.24.1.
> > Bug reporter said that Git crashed on him while running VS Code with
> > Git Lens extension[1]
> > I have tried to reproduce this bug with my own compiled Git with debug
> > flags, but sadly SIGSEGV never appeared.
> >
> > To me it seems like there is a problem in commit a2bb801f6a[2] which
> > changes move_diff_queue() function. This function calls
> > diff_tree_oid() that calls try_to_follow_renames(). In the last two
> > functions there are no arguments checks.
> >
> > Best regards,
> > Ond=C5=99ej Poho=C5=99elsk=C3=BD
> >
> > [0] https://retrace.fedoraproject.org/faf/problems/bthash/?bth=3D25aa7d=
7267ab5de548ffca337115cb68f7b65105
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1791810
> > [2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=3Da2bb801f6a4=
30f6049e5c9729a8f3bf9097d9b34
> >
>

