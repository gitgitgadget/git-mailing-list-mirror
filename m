Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C374C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjAYXTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYXTg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 18:19:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A841B465
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 15:19:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lp10so16685125pjb.4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 15:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVNvXa9iPnuvw11zu/4Tuy5BZZID5M4jPpcMjokTYn8=;
        b=XLKOSaAvQP6dQWuRNBuMafu94V32qTVbp0JbJeJDuvKnGR3YKpgg3a92uiDNuK1X9A
         2jrWGApSdes/HncBtwRKiMcd7Hf5tEO7cyh1+cSQ5mIbYAMN/imRAI7rtN1T3o+zOIzu
         XGZ7CEsMHsUvnPgVgRNyiY9sBX+u4ktIEkv8HuAH104G5OgVZKSHZQUXmxJ4J365nYwg
         q79HLcivqMiZKfxC+oSl+TX01jgXqFcqQ3HHmemPUIyOsBxnZLXEp3KBovzuFqH5J/F9
         IsxzYew2IudqgJLfp1MRSu22dd0IrpMBtGw5yVb7r9v+NUtf7oQuOSxyNVncVu7kBU/i
         FZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HVNvXa9iPnuvw11zu/4Tuy5BZZID5M4jPpcMjokTYn8=;
        b=hI7JMx1JdFiyLOC6Bhv4tswZvKvCbuxOnGv9qC0GQKy+9CEdi81t3SyZr6dC6Zm6YA
         OIo9XuSqt0FbS6tJMGzWv7VYprzCUsSjVlK1XQcAzS6UYvHvdR393qxY6kuAkT73sfaJ
         GUFJeSs0B83lukyX2pmt/dLMe2uzz7GAXmCi98ucB8b746YPjtRHnO/8Tyn8DUlg43uJ
         SpoKOe5VS9k9QPmuta4EPmyK4uJ8d7eO5bJBIawn+SUurZl2Prm/VYMlcgAyrnRkGHb4
         wsAYJ+btX8mtLA2sugnHg/uHkjp56czO4fQ7ADCpgKER2KowREFgn1xvW5s4J87Z8423
         sWIA==
X-Gm-Message-State: AFqh2kpaD2jTJYtNavZ3hXEc5mGIjht2zYimx5HNEYePfoLFayWCYZ3y
        LYZvA9P8hIdilGGIe7xaTjqaHeHzh6o=
X-Google-Smtp-Source: AMrXdXvbzxg8MPKQlVfz0H9V2j3KGGedf88FWuStcwdalvgDNxwE4uudhZs2m6U8dOiGT5E2E48cZw==
X-Received: by 2002:a17:902:b195:b0:194:4484:8e61 with SMTP id s21-20020a170902b19500b0019444848e61mr32405224plr.69.1674688774825;
        Wed, 25 Jan 2023 15:19:34 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0019607984a5esm4190140plr.95.2023.01.25.15.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:19:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] request-pull: filter out SSH/X.509 tag signatures
References: <20230125230117.3915827-1-gwymor@tilde.club>
Date:   Wed, 25 Jan 2023 15:19:34 -0800
In-Reply-To: <20230125230117.3915827-1-gwymor@tilde.club> (Gwyneth Morgan's
        message of "Wed, 25 Jan 2023 23:01:17 +0000")
Message-ID: <xmqq8rhqdwxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> git request-pull filters PGP signatures out of the tag message, but not
> SSH or X.509 signatures.
> ---

Please sign-off your contribution. 
cf.  Documentation/SubmittingPatches[[sign-off]]

>  git-request-pull.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 2d0e44656c..01640a044b 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -153,7 +153,7 @@ for you to fetch changes up to %H:
>  if test $(git cat-file -t "$head") = tag
>  then
>  	git cat-file tag "$head" |
> -	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
> +	sed -n -e '1,/^$/d' -e '/^-----BEGIN \(PGP\|SSH\|SIGNED\) /q' -e p

This makes readers debate themselves if being more specific and
narrow like the posted patch is safer and better, or making it
looser by just requiring "^-----BEGIN " and making it forward
looking is sufficient and maintainable.

If this were signed-off already, I would have said "let's queue it
as-is, while waiting for input from others", but without a sign-off
I am not queuing (yet).

Thanks.
