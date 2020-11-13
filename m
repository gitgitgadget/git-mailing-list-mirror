Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5EEC56202
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9297F22256
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKMUyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:54:11 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41781 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMUyL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:54:11 -0500
Received: by mail-ej1-f68.google.com with SMTP id cw8so15566202ejb.8
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aVoOo7fSODhyOYdUxgpdyt4LdCLFHdX3XlwX1oBkus=;
        b=pb9JtP1AfiHZE4Tt3GtJ2AW1osgHkb5lETen2ztgM+CviTmC3gYAKV9uBHSVS8Z+Re
         KihZJ0cbVB6blTB4DY7XxppFaDv81slAvRfK3oPyYPze2wq5VEXjsyn/iRYyf7E9EXAt
         dxzZ+FQ4fr2hkYTVmyy5KHiCdBrQrTRQ83v6SXHI3xoz0FayyJ8v13vRpn0opju484Tu
         I3fpqoO5MAyxrvdo2fQ8NVeXwdJusMwSFel+0lCA5tXebQL4Hnxd3BfmahsxQTH6b5pN
         uWUGef7c9m8TYkSNlMPkmQ2LB95vhtJMoyLffDHcwJPnPVu6Wpa6fc4wnMdo8JV606AN
         wxOA==
X-Gm-Message-State: AOAM532wneaX7uOljtFWMxhl9hU0sK7RSxEeK+izdCjih9gkkvsmjsMj
        Y7UV4DSg7N519CScPtA1BIxz0rYcs4fIQMnwDAA=
X-Google-Smtp-Source: ABdhPJxdasQ0s5lbumUQo32yfowLctuFnl5dBT7lxqgjnLvV6K+unx/c6zlxpIdBCRpNkI+pl9ddd8e2mgbGuAheRKU=
X-Received: by 2002:a17:907:42cf:: with SMTP id nz23mr3846703ejb.138.1605300848926;
 Fri, 13 Nov 2020 12:54:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com> <1629bcfcf82dbc2ed9889a0e9ea2d08427901c4e.1605276024.git.gitgitgadget@gmail.com>
 <CAPig+cQQrucwE-KSndQ5kCjG9Q1MtjxraAmA95+OQe=6bdks-Q@mail.gmail.com> <d9c51446-c223-dce9-692a-959f841d506f@gmail.com>
In-Reply-To: <d9c51446-c223-dce9-692a-959f841d506f@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Nov 2020 15:53:57 -0500
Message-ID: <CAPig+cTRJb-fn2R6rJO1hkeCc_ehVhkNufO4=LhtPQudVeonnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] maintenance: use launchctl on macOS
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 3:42 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/13/2020 3:19 PM, Eric Sunshine wrote:
> >     if (pipe_command(child, NULL, 0, &out, 0, &err, 0) {
> >         if (out.len && err.len)
> >             strbuf_addstr(&out, "; ");
> >         strbuf_addbuf(&out, &err);
> >         die(_("launchctl failed: %s"), out.buf);
> >     }
>
> We would also want to pass a "die_on_failure" into the method, since
> in the 'git maintenance start' case we don't want to report a failure
> when 'launchctl bootout' fails before we call 'launchctl bootstrap'.

Right. I started writing that we'd also need a `die_one_failure` flag
but deleted the comment since I decided to wait until I got an
answer...

> > By the way, won't this die() be a problem when schedule_plist() calls
> > boot_plist() to remove the old scheduled tasks before calling it again
> > to register the new ones? If the old ones don't exist, then it will
> > die() unnecessarily and never register the new ones. Or am I
> > misunderstanding? (I'm guessing that I must be misunderstanding since
> > the test script presumably passes.)
>
> This die() is only if the process cannot _start_, for example due to
> launchctl not existing on $PATH. The result from finish_command()
> would be non-zero when we bootout a plist that doesn't exist.

... to this question.

Another thought I had was simply checking for the presence of the file
and skipping `bootout` altogether if it doesn't exist. That would, I
think, obviate the need for mucking with stdout/stderr oppression.

> > write_script() takes the script body as stdin, not as an argument, and
> > you don't need to specify /bin/sh. What you have here works by
> > accident only because write_script() takes an optional second argument
> > specifying the shell to use in place of the default /bin/sh.
> > Nevertheless, it should really be written:
> >
> >     write_script print-args <<-\EOF
> >     echo $*
> >     EOF
> >
> > Patch [4/4] uses write_script() correctly.
>
> Ah. Sorry for misunderstanding. That explains why it works this way
> on macOS but it did _not_ work that way on Windows.

Sorry on my part too. I missed the `args` redirect in my example. It should be:

    write_script print-args <<-\EOF
    echo $* >args
    EOF
