Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBFC433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9F020792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecn8vgbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGWUMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:12:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F11C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 13:12:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i4so7578557iov.11
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=S9Mdrh4Agm5tW77e0Aq2fkjxeFmsdE1wjHX55wbCyc4=;
        b=Ecn8vgbm2hBC6BpGrXNQx5kVMouukzm5v1HDDrrcd0kbptlMNac9TfBJCg6sEo//RL
         bAZYrpt4p/HHwxkGF/nTcMlklaV2Lb2xUJ/4wVUulVIZtm3tg+i+nyKLgMjUfP9K660x
         OdTl9pLNYetNrK94RL9CYV4Wx+IorxxWe2LOXywwtOZk5MGigvPu2Cns6cU4bi0e9/r4
         DW8xX3DN/t/hfiKusMBiMNtC6tJNvGCdqHFxna8X9z+4/ZO0FZxfVLh1w78MLwdDELa7
         RF6SjDvIPDlT8HkHsqT8GiGJf/xruyCHG2S4U2KS1YF1X0jXzow+cgVRZeTPKvw8qOd2
         ikwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=S9Mdrh4Agm5tW77e0Aq2fkjxeFmsdE1wjHX55wbCyc4=;
        b=abfaliLSOxKpJvlfq6fRaIbHe74MX4EOgpp9Lisj+7sw4LP3Oc6dxBCKhMAXjv+qOL
         sixETnQnegOY9FFSsm6pTcKW8rEfOucdQhWYyypCmqvgHcjyJdcYzRMUziX+8zwdLdV1
         C373n+x4cL8TS6ZEzME+hx9oLz1X6WeWKLsr7s7CYgf6TvDOwaeS/DwxzYBugPwOJOd4
         mSp0LRE8MiUIYY+X5Jl10iF0qw+fkFJ0YT8e286BAFg5hc29bMSjoYj5l3t+lvy9qMX+
         g7C2ieZ0AlPpTT2NzSi4CzsoUdVTQ9GNMqUupvjFxiGD/I0lzteOwqTmHBbtZODY9D7l
         /Ibg==
X-Gm-Message-State: AOAM533gsZKrjA8G61rj23yNRM083d8jEZP+F5w20idzvwfbouX+ZGxw
        2DfjlXt9JDJYtU0pj4lEC4XIu+43JLzngOps60Dfw7yB3XA=
X-Google-Smtp-Source: ABdhPJz9hHdIaACUgGuBGKT1NoNEp4WRnPRSq0K8rrZ9Bt+S7QH6eg52v6WFZCgYDXiGdddTnnJv5lSATCLXeAAHDrc=
X-Received: by 2002:a05:6638:11cb:: with SMTP id g11mr6604175jas.14.1595535169035;
 Thu, 23 Jul 2020 13:12:49 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Glassman <matthewglassman78@gmail.com>
Date:   Thu, 23 Jul 2020 16:12:22 -0400
Message-ID: <CAO-dU=fQZ6YVk1rWw_Tc8YT-i_zH7-hw3GATXmf7hwaqqC3j4Q@mail.gmail.com>
Subject: Trying to update GIT in Ubuntu 18.04
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My git version is listed as 2.17.1.  If I try to just do sudo apt
install git..It will tell me I have the latest version and this is
after running apt update.  I can not get the PPA to work because there
is no GPG Key to input and thus Ubuntu will automatically keep it from
use due to insecurity.  Can you please advise me on how to best update
GIT to the current stable version please.

Regards,
Matthew
