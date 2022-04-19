Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F48DC4167D
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357146AbiDSSZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358050AbiDSSYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 14:24:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380946650
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 11:17:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bn33so21549909ljb.6
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3oCiGnQ3FnOhleiaDf8lkUP1+skeKcNCUZ4oZiqfd50=;
        b=k0dOaC1x1sAzzfl4lBjlRwOohezCsbAI9FTZjduGPr6XpV9c3CHiEhbXtIuNwVuM1k
         kudnuOwZux5FSNojPTIthGnE/d0ox1+XYbT+57qIoH+nUI8N36qnIVoT80fQ+9rW65gU
         k0nrkjeLZBTaYM+iUuw8X0GvaM5IiRtjAqW7/b87ceWlVdPsCfWAB/M+4/FOORoy3S09
         rPxMf7riAX3n5wLMr/aa04OVZC8fhVE/5zX7+iCdTQvF4Sp34UodU6qjjaDkQt1a7dqB
         s2MeQFltfUgGmDXzKr/C/Z53g9/mRIfvh+bc/6I7t0UyMHXcSfgOok/UieIYZs1KXRbR
         XLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3oCiGnQ3FnOhleiaDf8lkUP1+skeKcNCUZ4oZiqfd50=;
        b=U/v6o8hRsX/qq3ZIJpb3UpCkb17wc6jm+ODmb00m2hFatDsshVP5EW9IQp4zX+KFyV
         FkjDgymbRbAm+Pz7owWPpvo5+f7Fl8Bd3Smc8wlpGjTk06k2YdAWH1mDlDaTcyen1j/K
         FQvyvedUdZVhYItJB2tHU+YlxvmlvxgsU8iqD5s+NcS2coDqgLFaUOe3HlfCbC3tPEYq
         9gPW4RQDPMFCSaGUew5fDQENWthVA/X29qMn3fWenokiQ3F/Bu8iyhLxO5vyHTdOK4gS
         pgmSI9iVtkCTVwIoescUrjJR1lKMBy3LtfYNG3mfBoptJyoggq4Zibe4TexfRu7MhDrs
         j2Hw==
X-Gm-Message-State: AOAM531CoJsmwQSJhCiwc7Okt0wGBhUyNuqw7fOI0TW8UbMSyQbcU5HY
        XopANT/g/ouQlxqeZrFJaF0FTg1M2Wk=
X-Google-Smtp-Source: ABdhPJxZP4ULB6OHGeG+uCjuSxT8mbndmG1XP9TAlmWl+NLMwXcOCnx57thANrG41M13KWk2gytFaQ==
X-Received: by 2002:a2e:9e19:0:b0:247:deb7:cd9f with SMTP id e25-20020a2e9e19000000b00247deb7cd9fmr10370384ljk.261.1650392255262;
        Tue, 19 Apr 2022 11:17:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05651c232000b0024dba831e9bsm755037ljb.135.2022.04.19.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:17:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
        <87h76qwd8a.fsf@osv.gnss.ru>
        <CANiSa6jAjbPRii8GYYLzU88K9P-TG5GGBJGY-H1CwmPkb+yU-w@mail.gmail.com>
Date:   Tue, 19 Apr 2022 21:17:33 +0300
In-Reply-To: <CANiSa6jAjbPRii8GYYLzU88K9P-TG5GGBJGY-H1CwmPkb+yU-w@mail.gmail.com>
        (Martin von Zweigbergk's message of "Tue, 19 Apr 2022 08:24:21 -0700")
Message-ID: <87zgkh9buq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Tue, Apr 19, 2022 at 5:25 AM Sergey Organov <sorganov@gmail.com> wrote:
>>

[...]

>> so I'd still propose to
>> *rebase* merge *commits* as *content*, without any additional info being
>> used, if at all possible.
>
> Rebasing is about applying changes from some commit onto some other
> commit, as I'm sure you know.

Yep.

> What Elijah and I are proposing is to
> consider the changes in the commit to be relative to the auto-merged
> parents (regardless of the number of parents - auto-merging a single
> parent commit just yields that commit), although I don't think Elijah
> phrased it that way.

I admit I didn't put enough thought into this new (to me) idea, but I
can't immediately see advantages of this method. Suppose, for the sake
of the argument, that the merge commit in question has been created
without any use of an auto-merge (whatever it actually means) in the
first place. What's then the reason to consider it to be a diff with
respect to an auto-merge? What advantages would it bring?

Then, do we need to be able to reproduce that exact auto-merge in 2
years from now for the method to work reliably? If so, isn't it a
problem, as we seem to agree that merge algorithms are subject to change
over time?

Essentially, this method apparently still puts a result of particular
procedure at the root of the method, again mixing merge-a-process with
merge-commit-the-result, that to me looks fundamentally flawed. I still
think that at its core Git should remain indifferent to the way a commit
has been created, be it merge or non-merge.

OTOH, the method of rebasing merge commits I've described long ago has
no assumptions about procedures involved in creation of the commit to be
rebased, nor does it need any notion of conflicts being involved in the
process, if any. It simply doesn't care, exactly the same way current
rebase doesn't care, when it rebases non-merge commits, if they were
created, say, using conflicting cherry-picks. What it cares about is
preserving the content by properly applying the recorded changes to the
new base. This property of the method I've suggested makes me believe it
is the best candidate for the core functionality, on top of which other
usable features could evolve.

Anyway, the choice is up to whoever gets time and desire to implement
it, and, not being that guy for now, I'm only looking forward for any
suitable solution for reliable rebasing of merge commits.

Thanks,
-- Sergey Organov
