Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04490C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F2A64F91
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBCRt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:49:27 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45577 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBCRt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:49:26 -0500
Received: by mail-ed1-f42.google.com with SMTP id t5so577934eds.12
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 09:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44W/oF/NA/1kHZWe2uaIFlttNZiefUb9NleGYbJDxqo=;
        b=nr5u/wymkvytkmVnqaWcrU6d9qcRLaq5Un3n4H2BLFXFkZeEq45taa4y7m29NaHdvV
         jYdb8qCfbecK6nY0pKaRHa5EI3HFgHMXKK6V+/Qe8YU5Jo7p2u+9P7WfTIpbFQj9tK+o
         wRVIxlSRE0RnA9YJYNmuMIlVeTbfW1TuH7D8sU6l419p2g02nEZq1mSFOogTAmS04eCQ
         tQhEgGdQu7M0ClWodEjg/sFqOYSOsr2cYrfCg3CFa8gRmGe6/7kQPVuOsYz8kRuOtYzH
         RhqTqlUBH3hHZPXkgqhkA083abrpk360o6QaGs2B24q+w3nIFXPHfiopUsswPcnjsW0K
         3qGw==
X-Gm-Message-State: AOAM532Z5a9sBVnafrm7TyvqRE8vpu7juEsWTaekX+CmLiTwAXtzURdM
        bPtgylvztBfeH3SUfsKVIFECqOyoDEv4JluucNYTOh7dxAQ=
X-Google-Smtp-Source: ABdhPJxKNy5g25x303VkVqVy2PCKGEeQONVzzpSwL6Frua0VIvrREqRHX2xLs0yq2M+PX0V1E4vrk526Xkyzn3DZ3S8=
X-Received: by 2002:a50:9310:: with SMTP id m16mr4253094eda.94.1612374524347;
 Wed, 03 Feb 2021 09:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20210202200301.44282-1-me@yadavpratyush.com> <fdfe1661-463b-fc18-02cc-4c6e22ce0463@kdbg.org>
In-Reply-To: <fdfe1661-463b-fc18-02cc-4c6e22ce0463@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Feb 2021 12:48:33 -0500
Message-ID: <CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 12:35 PM Johannes Sixt <j6t@kdbg.org> wrote:
> Am 02.02.21 um 21:03 schrieb Pratyush Yadav:
> > The comment character is specified by the config variable
> > 'core.commentchar'. Any lines starting with this character is considered
> > a comment and should not be included in the final commit message.
> >
> > Teach git-gui to filter out lines in the commit message that start with
> > the comment character. If the config is not set, '#' is taken as the
> > default.
>
> This is WRONG. Git GUI is that: a GUI, it's all about WYSIWYG. If you do
> not give sufficient unambiguous visual clue to the user that certain
> lines will be ignored, you cannot ignore them.
>
> Perhaps what you are really only interested in is to remove the list of
> conflicted files after a merge conflict? Then the correct way to proceed
> would be to sanitize the contents of .git/MERGE_MSG before it is
> inserted into the edit box.

This is indeed the case I run into which is annoying because the
commented-out list of conflicted files does not get removed when
git-gui performs the actual commit.

However, although what you propose here seems superficially enticing,
it doesn't mirror the behavior of git-commit itself when launching an
editor, in which case the unsanitized file (containing the
commented-out conflicted file list) is loaded into the editor
verbatim, and it is only sanitized when the edit session is finished.
The important difference is that extra text is added to the edit
buffer telling the user explicitly that "lines beginning with '#' will
be ignored".

So, perhaps one way forward is for Pratyush to emulate that behavior
and insert some text into the edit box saying "lines beginning with
'#' will be ignored", or add a label above or below the edit box
stating the same. (Of course, the actual displayed comment-character
should be determined dynamically.)
