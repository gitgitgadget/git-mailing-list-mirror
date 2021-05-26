Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4308CC47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9F0613D2
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhEZXge (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbhEZXgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:36:33 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAEAC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:35:01 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so2671867otk.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ln+G9uc7d0NAi0d9JWQIxWxkKWurIfW6mvQ8UCsv/GY=;
        b=K5VwzxfORw5PNEV9R4rHRcJ0wVF0rFF7ZMAP7oktRyBZtasVzxlU+Jfa6DyUBfjy25
         fM51BEKmdE4lLZbWxOZOJ6zyvCtFREbaP+sK2MdCG79Ypom8V8O/GJW8P5ZpztKpd3Fs
         /8+0o+vUNm4Hm6weog2oGBjGMbI7ETUaTO6MJSLz1ycNTOK1kYxp/uTVvo8xtuuqfss+
         vA8I/0Rz3YDMI36AN6e7x1L0yvXkytgiodUJFKA/X9U2CTEvN7SiCxQ/xzIBwlKi+SWl
         O22p02aXFjIFsp4YKxRHLM4uCBCET24ZgNBpsRrGItwM/xqbyZP/37fYJ0XaO0qBwdv0
         C65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ln+G9uc7d0NAi0d9JWQIxWxkKWurIfW6mvQ8UCsv/GY=;
        b=nImJcgXp9DNUbVdlmhr5UfMSioSIWXOcjHY7m2Gq/DKZvjHivCj5rXUVgSbpCBVHg6
         8lLPbI3pyrH1zfu4LihzzQ9lODfm/rVDw4SViE8KDugO1qhdbb/ibTDKe6NnRIYq7d22
         3X461jFYzEjGrKJ5kTjPTWgC2J6HWos42Yashxzzj4Pz09kjf97tMNoYOHLVB0iJB4og
         NVAm8uYLv9vbys5uJ+n5OzChM8CKuCpze93TOlcps7UlvQxsEISpTtVd/GlMHQFWOjHT
         oDlGAWqiYi2wXvRzKHoyvSVpCRnwHRcLwWPt7wpb886TmDzu3+cGPlRXlwxbk13XV3wr
         cNtA==
X-Gm-Message-State: AOAM531YCQmNlZ5e9hzFdwVAEGybOijGYwDlMwl8IBkZhS5CXL+kXsS4
        Jow6k4VNyGCfVZ60LPeUeAs=
X-Google-Smtp-Source: ABdhPJztnP1hwB7apK894CcG7miwKC8sAJ3q2seG0JRlAdCjt7ka2UGH9fEYHoHU5YFur2SM7ZPc/g==
X-Received: by 2002:a9d:3d4:: with SMTP id f78mr567938otf.224.1622072100865;
        Wed, 26 May 2021 16:35:00 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i4sm142554oth.38.2021.05.26.16.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:35:00 -0700 (PDT)
Date:   Wed, 26 May 2021 18:34:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60aedb22c075e_4bd420896@natae.notmuch>
In-Reply-To: <6dcc8557-9df4-9ea2-c348-f4ebf76ff446@iee.email>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
 <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
 <60ae947797deb_25ba2089c@natae.notmuch>
 <6dcc8557-9df4-9ea2-c348-f4ebf76ff446@iee.email>
Subject: Re: fast forward merge overwriting my code
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 26/05/2021 19:33, Felipe Contreras wrote:
> > Philip Oakley wrote:
> >> On 26/05/2021 03:53, Felipe Contreras wrote:
> >>> Andre Ulrich wrote:
> >>>> So the last point is where we still want to do some fine tuning. Right  
> >>>> now this looks about: my prof fetches my edits and locally checks out  
> >>>> a branch to compare the changes with git diff.
> >>>> But in this diff view you can't edit the files. So you have to  
> >>>> separately open up another window to edit the changes (lets say my  
> >>>> prof only wants to keep some of my changes, but not all).
> >>> So for example after fetching your changes your professor sees this:
> >> Part of Andre's problem was that this diff wasn't stable because the
> >> underlying file format is said to be json so items can move around
> >> without issue (e.g. key value pairs swapping position) and that they
> >> aren't really working on the json file (it may as well be binary..) but
> >> on the jupytper notebook display view, so one step removed from the 'diff'.
> > Andre said they use the diff view, and he wants to be able to edit it.
> > Not sure how else would you interpret "But in this diff view you can't
> > edit the files".
> >
> In
> https://lore.kernel.org/git/20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de/
> Abdre did say they used the special jupyter notebook diff viewer.

Yes, but that is a separate issue.

Right now they are able to resolve conflicts with a jupyter mergetool.
The tool gets rid of all the extra noise so the user is able to focus
only on the actual important changes. When they exit the tool, their
changes are properly staged.

The problem Andre described in [1] appears when mergetool does *not*
run. In that case the user is forced to run `git diff` (jupyter difftool
will be used), edit the file manually with some viewer, `git add
--update`, and then run `git diff --cached` to verify the changes.

In case an unwanted change sneaks by, the user would have to edit the
file again, or do `git checkout --patch` to selectively remove chunks
(and since this tools presents the diffs in reverse, it's
counterintuitive and error-prone).

This is far from ideal.


The problem is that there is no `git stage edit`, in order to launch the
mergetool.

I just wrote an example `git stage-edit` [2] that does launch the
mergetool even if there are no merge conflicts, allowing the user to
modify the stage directly and with no hassle.

Cheers.

[1] https://lore.kernel.org/git/20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de/
[2] https://dpaste.com/62XS8TTXP

-- 
Felipe Contreras
