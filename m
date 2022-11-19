Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D56C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKSPxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 10:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKSPxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 10:53:16 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36C776CA
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 07:53:15 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-141ca09c2fbso9292256fac.6
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 07:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAo94PnkJHNLiKBm/x2n2O77K2eJ67DgH8ijXhkaUSo=;
        b=7teiZYs6swpKjGKbqAq57p0y7Xir2GifjU+c4OSwUhQas5Bhdli23ie4TsbNeTr/9F
         wl6hJ9KSINp8G2LSp+y2E8YyaGvjwi7pXQruZUpOgMGRXCK0nP9ebYUDSRMwtbKQAUTU
         MmrAp9qecF4ZsDpJ3RGS6UDGM4IpFzgy7qZsqlyNccOUTlmbsHj7+o+cwJNwhs3l5PzZ
         t+i8B1cMKFX15PYuSS7EYs0cp7QSjK2hPFzyPRIr77uxgoOvEuLzevFWQ01M5x2J+HbE
         Hss38ZdPps1JbuZ3X6xevhCw0vu56Xkg/9PdTZElPMH44M9R8ThZWxhkD+KBYuSy+cpo
         rq5g==
X-Gm-Message-State: ANoB5pkQAMiyMRyP6gvuK0gosds8OlDBVNwAsGBBVymLdDR6kku8qyAb
        eXaATjY1FRxR7c0WeisV0McgmC5HyJNxTs/WPxU=
X-Google-Smtp-Source: AA0mqf6owM2GNriuAlCuzeaWVdSCENoCeDH2T9j5KLYrUiaD8S7JYJA+k2PwR+WVyQErEC/ZNqewX0NCcHPUEn20A28=
X-Received: by 2002:a05:6870:f5aa:b0:13b:becc:138 with SMTP id
 eh42-20020a056870f5aa00b0013bbecc0138mr9708279oab.28.1668873194508; Sat, 19
 Nov 2022 07:53:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com> <ed19668db860c8aafcb008aef306520e36d12dee.1668866540.git.gitgitgadget@gmail.com>
In-Reply-To: <ed19668db860c8aafcb008aef306520e36d12dee.1668866540.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Nov 2022 10:53:02 -0500
Message-ID: <CAPig+cSMoAoVW_NTidyN0rgTTY-FaQ49CAFQZhPyaYBsYu-RfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-jump: invoke emacsclient
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2022 at 9:09 AM Yoichi Nakayama via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> It works with GIT_EDITOR="emacsclient" or GIT_EDITOR="emacsclient -t"
>
> Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> ---
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> @@ -26,6 +26,11 @@ open_editor() {
> +if git var GIT_EDITOR | grep ^emacsclient >/dev/null; then
> +       type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
> +       open_emacsclient "$mode" "$@"
> +       exit 0
> +fi

Would it make sense to expand this to support the VISUAL and EDITOR
environment variables too? For instance, since I want to use Emacs for
all my editing needs, I have EDITOR set to reference emacsclient. So,
if GIT_EDITOR is unset, then check VISUAL, and if that is unset, check
EDITOR.

Also, on macOS, I need to set EDITOR (or GIT_EDITOR or VISUAL) to the
full path of emacsclient, but the regex used here is too tight to
recognize that. Perhaps loosening it to just 'emacsclient' would be a
good idea (as it seems unlikely to falsely match any other editor)?
