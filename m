Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2457EC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 09:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjAIJBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjAIJAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 04:00:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004E183BB
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 00:52:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so6660753pjf.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6xJgTOaJ8LzAHT3JyBjyPhz/w6cxLZCaeuA8uQcO2g=;
        b=HfT9FRuu0pY2U4aUdp9Z41ifH6kZjCEzbfa2RccrSBiDKYJqsJ5XkrU6yLp5hutFbb
         /2yqVUUnQPLefTaGt0M96uOqf0y2U7AEYAtnalnOx0Pj+UjhexTPggiBXcyfo1Rkpgi0
         ExnbCD/Oqu/95zwRWLGXwwwrTZz1Glw8Q8sPPjNkUv5NeYrFMRJUnqWtJHRv6qZZ54dv
         7pqd31WFZuhIwLmN0Y6FK80uUeymlv1HxaV+PA098ibQsOGNJsuW4aMmvmDKkKtbjk9H
         lGufLbTJvLEuNzzFKXXL19/L+Wu4AT0Js88Tu8WIBSG7pgcHos3yttDV7U9imnYtvz1S
         y8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q6xJgTOaJ8LzAHT3JyBjyPhz/w6cxLZCaeuA8uQcO2g=;
        b=UK11Y6GVgu7pj45voFfT4yfgsFeEaxOerthe3Bxt6bl8RouEa55MyJu1El3ob5gRHd
         6Q1b0BzX3Ap722eV/6QxzekoSmtNiWYYH0FmHaYPfY3I5scSyPRXJZt/1D/MDAAia2UR
         Grb6UfMTZxFCOPnMKKNxfhmAdoyv7f9mXuBmnqX5Yg6TWMxH6CV7okT3DmtgGQT5c0VF
         w0luPxRu/yYbUugqzED3OtltO5D3pF6sIOMiYJ7b0jPjR5VpQrXsAv9YfT3mUleo5Erb
         F9khQRZIvd7HuxrE/5iLri78SRgb1sHunUwbu09T831jlZ+iwlwvOi3y4CR22O6JvPBb
         Dfnw==
X-Gm-Message-State: AFqh2koRXJo9l8dRGjb7U7tvxz3laID0wCsMpuAy6atE1/oUnqK9ZvnG
        wFsgsepFqVX/G5VgHd4k92A=
X-Google-Smtp-Source: AMrXdXurmbReUsGdZmnumJTrFJzH4dvbBpTmevj5mF1+94LhuxtjOUvPWWQjrjl/IO1uUzIg0rpPTg==
X-Received: by 2002:a17:90b:3649:b0:227:e22:4a85 with SMTP id nh9-20020a17090b364900b002270e224a85mr3642388pjb.9.1673254358540;
        Mon, 09 Jan 2023 00:52:38 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id mm10-20020a17090b358a00b00226daa7b377sm5549471pjb.52.2023.01.09.00.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:52:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Harshil-Jani via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] mingw: remove msysGit/MSYS1 support
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <e6d3d280a4f9216aa6e9c3c83a38b0fb8ba3a8a1.1670274213.git.gitgitgadget@gmail.com>
        <xmqqsfhdxxyj.fsf@gitster.g> <xmqq4jttxt0u.fsf@gitster.g>
        <4a2ce224-85e4-5903-44bc-664aa5a59f91@gmx.de>
Date:   Mon, 09 Jan 2023 17:52:37 +0900
In-Reply-To: <4a2ce224-85e4-5903-44bc-664aa5a59f91@gmx.de> (Johannes
        Schindelin's message of "Mon, 9 Jan 2023 08:48:05 +0100 (CET)")
Message-ID: <xmqq358kum22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would be good to avoid over-indexing on individual person's
> preferences. While it seems to be quite common in the Git project, it is
> obvious how this harms the Git project more than e.g. focusing on users'
> needs would.
>
> A more productive line of thought would therefore be:
>
> 	MSys has long fallen behind MSYS2 in features like Unicode or
> 	x86_64 support or even security bug fixes, and is therefore no
> 	longer used by anyone in the Git developer community. The Git for
> 	Windows project itself started switching from MSys to MSYS2 early
> 	in 2015, i.e. about eight years ago. Let's drop supporting MSys as
> 	a development platform.

Nicely written.

Will expect a reroll with Acked-by: added with updated description,
hopefully by the end of the week when I'll come back online?

Thanks.

