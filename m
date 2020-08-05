Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80EC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B822521D95
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHEU6S convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 Aug 2020 16:58:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37733 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEU6R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:58:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id k8so7674139wma.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 13:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LKlWqQDvkI/+9qB2UpmGcvScIPrmXsjuW1BtDFPSItk=;
        b=l1aQ3oRzRF4tE3F0wAfW6iImj4ZpX8nzIO5uaHMiuehohV5npHQo5Kaj5wkHbGojuf
         zUe8OvEKV+VfzQALYtnMCbZu9i7yVkuXx+ZSnX46O4VFgsWJfGe1sGOOQMjf3W9ZMi/G
         YBx3WRDAD6yDUguL4VugknW3ZL+AtHUE8lmYg7njkHsJ9j896AUzKsfVxEGKPvdM5fif
         bsa7zVIzLRk4vrHErPcHmnzYhOhLliGE1MGpKxgFyrFl64gQo/gMqPVcFjsSJMpiqe7b
         uiL6GkqVsKrvfH/bM6DEoVgy/Y8FaKRE3bH9NYxmD0b0tlAb29rfz1gro/dShq0iCGF1
         M+DA==
X-Gm-Message-State: AOAM532F+ccdOTZpBfO8Ws+GFRY7fS5xkWiYQLdEwQ7Sb/xEMd1vBAom
        72QapXs+6OSQpGc2D6+cyBdbAWiOL7tY8xdZ8Cg=
X-Google-Smtp-Source: ABdhPJzmUL3gkdIGcWX+ywlESxNQe6en24tVlkGoj2Bd+pjpFrmTn0hRcczBe4Vk16SHoHVAjDSfHfEr/Yt0JZc2bc0=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr4788494wmh.11.1596661095514;
 Wed, 05 Aug 2020 13:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com> <66a026ae678341fe7e93a89e22f76e24282cebaa.1596634463.git.gitgitgadget@gmail.com>
In-Reply-To: <66a026ae678341fe7e93a89e22f76e24282cebaa.1596634463.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Aug 2020 16:58:04 -0400
Message-ID: <CAPig+cR_04fL85nH1tJnbWYbwk3Bn5fRqzr2JReB2xXu9iUGAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
To:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 3:51 PM Marco Trevisan (Treviño) via
GitGitGadget <gitgitgadget@gmail.com> wrote:
> To list merge tool candidates we used to use a private GNOME env
> variable (GNOME_DESKTOP_SESSION_ID) that has been deprecated for long time ago
> and removed as part of GNOME 3.30.0 release [1].
>
> So, git should instead check the XDG_CURRENT_DESKTOP env variable, that
> is supported by all the desktop environments.
>
> Since the variable is actually a colon-separated list of names that the current
> desktop is known as, we need to go through all the values to ensure
> we're using GNOME.
>
> Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
> ---
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> @@ -266,6 +266,19 @@ run_merge_cmd () {
> +is_desktop () {
> +       IFS=':'

We usually want to restore the value of IFS after we're done with it.
For instance:

    OLDIFS=$IFS
    IFS=:

and then restore it before returning:

    IFS=$OLDIFS

> +       for desktop in ${XDG_CURRENT_DESKTOP}
> +       do
> +               if test "$desktop" = "$1"
> +               then
> +                       return 0
> +               fi
> +       done
> +
> +       return 1
> +}

Rather than looping and mucking with IFS, even easier would be:

is_desktop () {
    case ":$XDG_CURRENT_DESKTOP:" in
    *:$1:*) return 0 ;;
    *) return 1 ;;
    esac
}

But perhaps that's too magical for people?

> @@ -275,7 +288,7 @@ list_merge_tool_candidates () {
> -               if test -n "$GNOME_DESKTOP_SESSION_ID"
> +               if is_desktop "GNOME"

Why do we need to retire the $GNOME_DESKTOP_SESSION_ID check here,
thus penalizing people who might still be on an old version of GNOME?
It doesn't seem like it would be a maintenance burden to continue
checking it while also taking advantage of $XDG_CURRENT_DESKTOP:

    if test -n "$GNOME_DESKTOP_SESSION_ID" || is_desktop GNOME
