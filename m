Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F3C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77807246AE
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMKjrqKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1SPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:15:45 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:35099 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1SPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 13:15:45 -0500
Received: by mail-lj1-f172.google.com with SMTP id a12so3270717ljj.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YdJIyXTtNZnms9Hpwqz2Dk32sGkeox9K5G2yq9PvTQ8=;
        b=HMKjrqKkg+ofznpO9Kmfllu9ScDYtiX+07QrvJ53VlKtwsAJuCfBNQWhk3tvf/aYHt
         NX9DDo7HYnAmnBi+kzMHBgz1kxVqp6uUOqY2zNx/+WxsjuZTi+mqzl70IYwKV+8McIHH
         QvglkdldTgGIIeDdaeGP4uYUkqkC3ym938oWWnMtfyybBEB02Nl5F9BFOt5Sn82pFgsC
         w9El6kjG5nKoMpi1xi4NqwbGnKRKAXqrGjF/VyqASADePUBoEaSZusQ0IxOs5OubNCC+
         53gZnwTM4gSQTBuXWbtTkwj7akXphz5ZQhazmtfnNytbl8NeUcfCVL29Q2oM7/SxB0XH
         84Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YdJIyXTtNZnms9Hpwqz2Dk32sGkeox9K5G2yq9PvTQ8=;
        b=hC2274dGdvBOrNkTvli/nterfJTNN9/Jky2fJ0xy6yUuAGTEC4q1rJ1I9C8ib6QMhk
         yLASGkNAa7i4lZJufdLFu4hFHpS8QH//g/9cM1I7hxY2gg0Ap9Bai6GP/JXOA0GowbfM
         d5Vv46KlsYTj0Z1WWbgMj5ueMTCzPe9WnSeHxevU9WpgSoTcSR+xTMU2ajHxMDh+RUxI
         802IcYEllMZVE/2M/uityrvx5esvj7Sf+i8rCbNYevptcRmrdgz/fD9dXg+blTWC0Kcf
         EtJyeYyMF9uKH/jDsNpdHCnu3r9OVW8sDuXcp+ad+lNmh3VWkAkfwnRZDbh8GwkEomnC
         kC+g==
X-Gm-Message-State: ANhLgQ1PstB6dsIjzaYUCdLo2fe6tCQGyK9Hcp2C/6d6cJilCHvGgVt/
        P3PCne1xUeFq8DJu9hnF4her+F479ljBP6wryJIdZA==
X-Google-Smtp-Source: ADFU+vtR+AgCBJTntmnfCado1RZ//983e6b28hoXyzdUybEqlITgzwIfKlqToZlZIe+OdHTaIFfUQN6etl5L8SxKzN0=
X-Received: by 2002:a2e:5451:: with SMTP id y17mr3845979ljd.27.1582913741717;
 Fri, 28 Feb 2020 10:15:41 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 28 Feb 2020 12:15:29 -0600
X-Google-Sender-Auth: SDNLGoo9bMdt8WTpFzYugxBVx80
Message-ID: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
Subject: Why does `pull.rebase` default to `false`?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more of a question of practicality. Literally all of the team
and project workflows I've experienced have demanded that `git pull`
actually perform a rebase of your local commits, as opposed to
introducing a merge commit. This means setting `pull.rebase` to
`true`. I can't think of a practical, day-to-day use case for wanting
merge commits after a pull. Since the subject commits of the rebase
are always local, there's no harm to anything upstream since they
haven't been pushed yet.

I'm sure there are edge cases that explain why the default is `false`,
but I'd argue that it is likely a case of the minority concerns
becoming an inconvenience for the majority of users.

Thanks in advance for any enlightenment!
