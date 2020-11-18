Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984ADC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDDB238E6
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgKRUyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:54:45 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34806 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKRUyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:54:44 -0500
Received: by mail-ej1-f68.google.com with SMTP id o9so4761572ejg.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 12:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITMq0n5ofwIFjkmt+vN4cFuh87Ckb07XaTuN89WCLNY=;
        b=b8UYJl54i28UIoRKWmBM+XCuLSXJ2NLeKCftEMRZcPvSj2v+xTUEHabNA6S64B4Oz7
         KVEXQxO7JoHIjIxk7lIE0XpsERss0Yr/1FHPhZq8bkD+QeKYxBi2HcWAsq4S3D1JS2Pp
         TXLOXvuqO5dXrnmx++/DUVA0Fq6flh+3sTPt7ohWjHzcnVQsTqtQF//+Sm7Q5As/tvai
         rIY4TC5ltAQjeU9QrvWJaYy0lbj9pvzfNU6QuYj32NWko8CpbEdzzosaqkW4331ECZ9r
         99u2FWX67YtftQe3KK9Y8FamMvMD5DK3vaxJnBxzqToPNpfJCfBh+4Aa3qcUR5lP2dns
         1HYQ==
X-Gm-Message-State: AOAM530TYKj/Y5N4DpFBfFF9zeU9Otn3ONUDCkzXFsdDZOCeX0RsBoGa
        Z1Tp40UMxUPwXqNSWINzRmCA+PE+kEYTRwAo+CM=
X-Google-Smtp-Source: ABdhPJxJRoQxGnIJXxWH69lYhP2NJWg7LwZVMD9XHOoIh9MiMnI2ZdyCIBcNKfboHUFwEN5yfNf0o8cVOwuZv8h+wVs=
X-Received: by 2002:a17:906:5587:: with SMTP id y7mr3021383ejp.138.1605732883082;
 Wed, 18 Nov 2020 12:54:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com> <b8d86fb9832b59884d3d38791de252dcb71e3629.1605647598.git.gitgitgadget@gmail.com>
 <CAPig+cRFQfg-NLx5dO+BjQpYduhOYs-_+ZRd=DhO8ebWjGB0iA@mail.gmail.com> <e8922076-1ed4-b540-f1c9-9b4a8fa7a085@gmail.com>
In-Reply-To: <e8922076-1ed4-b540-f1c9-9b4a8fa7a085@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Nov 2020 15:54:32 -0500
Message-ID: <CAPig+cQt+RFpikr-8cXfLtsXapS4tK4gufKZa-U1yN-ynJbiow@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] maintenance: use Windows scheduled tasks
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 1:30 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/18/2020 2:15 AM, Eric Sunshine wrote:
> > On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +       xmlpath =  xstrfmt("%s/schedule-%s.xml",
> >> +                          the_repository->objects->odb->path,
> >> +                          frequency);
> >
> > I missed this in the earlier rounds since I wasn't paying close enough
> > attention, but placing this XML file within the object database
> > directory (.git/objects/) feels rather odd, even if it is just a
> > temporary file. Using the .git/ directory itself might be better,
> > perhaps like this:
>
> It does look odd, and in this case we could use the .git directory
> instead. I specifically use the objects directory for the maintenance
> lock in 'git maintenance run' to allow maintenance to run when
> GIT_OBJECT_DIRECTORY points to an alternate, allowing us to maintain
> object databases that don't have a full .git directory around them.

I guess I'm confused. Won't a Git "common" directory exist even for
such a case when GIT_OBJECT_DIRECTORY is pointing elsewhere, whether
the "common" directory is .git/ or a bare repository, or whatnot?

Anyhow, this brings us back to my original suggestion of creating
these temporary files in a genuine temporary directory (/tmp or
$TMPDIR or $TEMP) instead of arbitrarily choosing a path within the
repository itself. An important reason for using a genuine temporary
directory for these temporary XML files is that it makes it less
confusing for those who come along later and try to understand this
code; they won't have to puzzle out why it is using a repository
location for a file which is clearly temporary.

To make this really simple, you could use one of the
x?mks_tempfile_t*() functions from tempfile.h which will automatically
place the file in $TMPDIR, thus relieving this code from having to
make the choice. Doing so would simplify this code even further since
you would replace create_tempfile() with x?mks_tempfile_t*(), and
wouldn't have to maintain (or free) `xmlpath` manually.

As for the test script, the `print-args` is already picking up the
pathname of the temporary file specified by the /xml option, so it
should be possible to make the rest of the test work with the
generated temporary filename.
