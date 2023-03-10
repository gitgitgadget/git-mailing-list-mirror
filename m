Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A17C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 05:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCJFjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 00:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCJFjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 00:39:47 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58764F7ECE
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 21:39:46 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d7so4602893qtr.12
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 21:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678426785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7maOuTr632zu7viQ54eTdRbX/Pg4kJ9tr0EIEDsMOz4=;
        b=Vj4lhfLXJ1QgUFva09QaT7G+RTppm8+ckPumoYWmOl+lXalyNvu0qTF/FLk3rcjBnp
         /eQBVFkqrNUR4OQZqJR5ld/sMz9j7V2s5FJfxi+GZ7jhQsgdxIO9z5ddyLk8OGsJDlQZ
         7FZvi2AVewOElR/atzwSDQ2jFR5F2uQvp9gmWcEwaA35cRe96nSOEyQUUa5NSeLf+pXZ
         WMckwRieVGE+miSKl4QUZRbtpW0nddSwReoVE14ucP53eSVwLHjYUH07yPvL9VJzngPc
         s9zyThE6fBSTNQWll51qarIXyvk1rZDRKwtvLjDFJYcdtZT2bwImnHS/bK+vA8Q+w1nB
         VKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678426785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7maOuTr632zu7viQ54eTdRbX/Pg4kJ9tr0EIEDsMOz4=;
        b=JAawWI67NzcsJlP5+aa0YYTFLjjoP/T9lWWtWz9OC0CNFh4bT+KraSZQzxl4m5x1cw
         +KpZLJBbWomr3Ow78WJCN8wzJIJ953l7ocmujz1/j6SiJAfgp9OSONHA+HtLSVllag3W
         GbDWvCbZsTx5FAE7gs9Rb3hEkvVIWbwJMc7b1ZrWLzpoyFaZQDbpecPFPafvNl8BcHuG
         Z39uRy5h/TFuVmM+HZq+cvxxFxgA9RBz28FVUQONPGwPLWXhJUnLQ1mum6ghaHx8exNM
         Bcv8rRjAad3OhXhJhFQSRBQZLv/1Y9FpS9+olgbI1idlQCKLc+1+DOPbAVnYGw/yEeXE
         p0eg==
X-Gm-Message-State: AO0yUKVt5fqezWn5uWOGY2IkcJfSJYJ7ep37N//w2mn3honJhZfp0Ju5
        m3cT3HEFnAiQwn3MxZDc1rbS8IzvCpaID7AuAi7HmMrfpO3WBw==
X-Google-Smtp-Source: AK7set/U3VJpDSRIdC/hy3TttwqmRzJJdJzwO82YizlpNtqGBmBvf9QYmupMrxWhARw3SvE4R8ziF2vR2XQFb5K4K9U=
X-Received: by 2002:a05:622a:1313:b0:3bd:1b6:9d3a with SMTP id
 v19-20020a05622a131300b003bd01b69d3amr239423qtk.0.1678426785378; Thu, 09 Mar
 2023 21:39:45 -0800 (PST)
MIME-Version: 1.0
References: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
 <CAP8UFD2s12CLDj6tOQAE-KMhog_qPpFUnp5TXHNSZAauue-8AQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2s12CLDj6tOQAE-KMhog_qPpFUnp5TXHNSZAauue-8AQ@mail.gmail.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Fri, 10 Mar 2023 11:39:34 +0600
Message-ID: <CAABMjtEUKcjYF=+RUASKSV+SS_5fnbig1LpygKNUDjnXmk=KJQ@mail.gmail.com>
Subject: Re: [GSoC23] Working on project Idea from SOC 2011
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2023 at 7:23=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Thu, Mar 9, 2023 at 1:15=E2=80=AFPM Khalid Masum <khalid.masum.92@gmai=
l.com> wrote:
> >
> > There is this SOC 2011 idea named "Resumable clone" here:
> >
> > https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/SoC201=
1Ideas.html
>
> [...]
>
> > Goal: Allow Git to resume a cloning process that
> > has been aborted for any reason.
> > Languages: C
>
> > Can I work on this idea for GSoC23?
>
> You would need to find (co-)mentors willing to mentor you on this project=
.
>
> I think we don't propose this kind of project anymore as we think they
> are too difficult. Some reasons are explained in the "Note about
> refactoring projects versus projects that implement new features" in
> https://git.github.io/General-Application-Information/
>
> > If so how should I get started?
>
> See the section I just mentioned. There is "an applicant proposing
> something original must engage with the community strongly before and
> during the application period to get feedback and guidance to improve
> the proposal and avoid the above potential issues".
>
> > I have completed one of the microprojects by the way.
>
> Great, thanks for your interest in working on Git!
Thanks, I shall try it.
  -- Khalid Masum
