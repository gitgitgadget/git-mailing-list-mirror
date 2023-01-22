Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5135C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 23:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAVXVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 18:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVXVg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 18:21:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259EF1C31F
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 15:21:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso9447094wmc.4
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 15:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18X6EkBv8dWi36EI/Z51TOhJvCFhGb9tRw+TS39XS3Q=;
        b=Nz+1r6VzV+FDbjngPzW3pfTfmH1kE+eNDcT7Pwz4/etEGXQZaadzO2GpsATBGkmRGB
         byLZbCBaL7hpDLETWjilyXI+YeMtqEw450B3CWM5j9W/ejhY5XjBfnii4tcHoC+F+2ss
         PTBH0qG8P/J05Mg92Go1nPVueBqp+pDPM0OVLAUFbVRd042GaRQt5B8ypx3UPrwGNRFQ
         FwuMyZygk+A34NGa6s0lP0WUwfW2bEAw0WMENw4vz0LK5AHQFXgjlB9WvxtQU6Q0NKTw
         byCXMWts+m9WOAi8sZTy4ajUAxSrLgHRs4/DWQ3qXJGGxkAbUQiSW3sFHjt8jmUJArkA
         sH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18X6EkBv8dWi36EI/Z51TOhJvCFhGb9tRw+TS39XS3Q=;
        b=S+RHd7Cy35R0CwzLBgq2sL3Mhm6vVbRBKBc/rs/4ow+Etj6u52SouZvYJa9dI02KSi
         DZorp1hEZD4bxxQU1fxqFP9WqlZFtKcqpMKTI0YvZ5Yte6puAU/V1wwIQfzIzgGYweuN
         XV7YMZkppi0rk/YrbnbxT4OjYJ+LIG99jq/SA6WO35kBnPGoIULUjatC9w/rn6d8UWsj
         K9LWUybnR8OYK1FOz9jP7SVJb1YzPNW4JDsRULBSpdmd0t935qr/E7iFRznlxaBQVz8x
         Ys9zujOl+rs1wfTi7myrBnsb2sijxnyGx6RXE4jWLYelOws+3UQ8JchwCtOlVM2Vitjc
         w8yw==
X-Gm-Message-State: AFqh2krrz9JKp+jIOXAu5yO/8F3MRhnyT8ydwajlCERZa8pKYGtSVXC/
        QiQyigu2oHS8iH8nkgZzL/c=
X-Google-Smtp-Source: AMrXdXs+u3uZaWaS7jBxIXrfI4p4a1RHCaDSZQuCMAtPS4AdKPMpHzZKWlxhb+/G+olte7Puh6MP+g==
X-Received: by 2002:a05:600c:4395:b0:3c6:f7ff:6f87 with SMTP id e21-20020a05600c439500b003c6f7ff6f87mr20986105wmn.11.1674429693564;
        Sun, 22 Jan 2023 15:21:33 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b002bc84c55758sm40300529wru.63.2023.01.22.15.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 15:21:33 -0800 (PST)
Subject: Re: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com> <xmqqbkmruykg.fsf@gitster.g>
 <766b25e1-2d7a-7b5c-10a9-43e545a57dba@gmail.com> <xmqqk01eqr3m.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <d61a2393-64c8-da49-fe13-00bc4a52d5e3@gmail.com>
Date:   Mon, 23 Jan 2023 00:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqk01eqr3m.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-ene-2023 11:58:05, Junio C Hamano wrote:

> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> As the proposed log message explained, updating die_if_checked_out()
> >> with this patch would fix a bug---can we demonstrate the existing
> >> breakage and protect the fix from future breakages by adding a test
> >> or two?
> >
> > 2/3 and 3/3, I think makes more sense on its own commit.
> 
> Hmph, how so?  Especially once you split 1/3 into the preliminary
> refactoring and the real fix, the fix becomes fairly small and
> clear.  And the tests to protect the fix would go best in the same
> commit.

My intention is to protect rebase (2/3) and switch (3/3).  If any of
those tests break, even if die_if_checked_out() is no longer used by
them, I try to make the original intent clear with that in there.

die_if_checked_out() was initially fine, the ignore_current_worktree was
unfortunately introduced.  I haven't checked, but other callers not
affected by the change, i.e. ignore_current_worktree = 0, his tests
should have protected them by the change.

You are right, in a future reroll, split 1/3 could leave a fairly small
commit, maybe not a bad thing.  Definitely this need a reroll, because
of the style issues, but I will wait some time for other reviewers. 

> >> The above comment is about find_shared_symref() which iterates over
> >> worktrees and find the one that uses the named symref.  Now the
> >> comment appears to apply to is_shared_symref() which does not
> >> iterate but takes one specific worktree instance.  Do their
> >> differences necessitate some updates to the comment?
> >
> > I think the comment still makes sense as is for the new function, both the
> > description and the recommendation.  I will review it again.
> 
> OK.  Thanks.
> 
> >> > +int is_shared_symref(const struct worktree *wt, const char *symref,
> >> > +		     const char *target)
> >> > +{
> >> 
> >> What this function does sound more like "is target in use in this
> >> particular worktree by being pointed at by the symref?"  IOW, I do
> >> not see where "shared" comes into its name from.
> >> 
> >> "HEAD" that is tentatively detached while bisecting or rebasing the
> >> "target" branch is still considered to point at the "target", so
> >> perhaps symref_points_at_target() or something?
> >
> > I tried to maintain the terms as much as possible.  I'll think about the name
> > you suggest.
> 
> When you did not change a thing in such a way that it does not
> change the relationship between that thing and other things, it
> makes perfect sense to keep the same term to refer to the thing.
> Otherwise, once the thing starts playing different roles in the
> world, there may be a better word to refer to the updated and
> improved thing.

I tried to maintain the relationship and the role, too.  Just introduce
the helper, as Phillip suggested and I think it is a good idea. 

Thank you.
