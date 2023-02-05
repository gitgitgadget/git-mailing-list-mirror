Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD54C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 15:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBEP2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 10:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjBEP2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 10:28:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27F4C19
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 07:28:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so13042613pjd.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvvHHY44lAts3yJbKebE86k9Ey3YQuXDQ9dblNDh9/0=;
        b=PuG+uNd+UOwl85A2AJZ61Z5/W2bkdq2FiIMBFaZTPJVvuIlwoRyzqGYwEsv4MPfne3
         N5VXKv1ntwKpfKo5sn/aU+rWsdkA3nwvY6oCVsyNYSPef563ymz5/5xN6W4qp9Adlowk
         CyYcPhetQDdolp3j2gZv99qA8asZsUKblAxqXea2wXxyvHEpw+XDeDxwWuym5w3gfuEK
         EAPd5+HqLQkXnFxT786kSCVZVKg/asl9y2mf32/U+JTkGsK2a5tCUG/AcjpAypPMBd33
         tw7qbUc4rIW4ydoAD25yxsEE2euuy0AjazSxnG4DeoU2e2n1WXSJ4mXxFpRhlE0OSFHF
         4+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvvHHY44lAts3yJbKebE86k9Ey3YQuXDQ9dblNDh9/0=;
        b=57Xkv+94YaTSNfGPibvkW5uj+YNmtT48WoxR16FjkFgqJTYAZOG73UYUE2qgJbcLyi
         XLWcv/ZvXIKYORyiNvsVaCDFxbaTLda11cC3jtea52X4wNcLTM/vkXOlD/nruB941f7A
         jvAXk5rrI+MXkzkrz9Dmd2ew1JjeNHdp1Ve6J7zcYj0zkseujyHCwieO+qvqnmK+L1R2
         1+RLgoPpBwHnK9s4WGE3ot+RbNEcUCYdPCDBnNgZHVPvZNKuGqR4SKTWouxKF4fBfT+b
         htLi4rMicYct0585HpfPdJckB5QUJbyX32Kr7zs6vpn76981qfnfMH1I/B4kqOO1ijug
         h7yg==
X-Gm-Message-State: AO0yUKU7zqPVZKyA+ITcT1TptoNle0V5JR/EIDcTMV019TapfjsI++3G
        m8sEosgdojPRnBB3pXD514ts4zi67TEvAl8VF6g=
X-Google-Smtp-Source: AK7set+UPL30mA9t4fWpJ9GbVdPTkbmO/zfCFtlTSjewmi8UpvajIdAWCHYMe6/k1SxmDTnLHFUtuAUxOldnBIM5e2A=
X-Received: by 2002:a17:90a:7f93:b0:22c:aacd:86c5 with SMTP id
 m19-20020a17090a7f9300b0022caacd86c5mr2707030pjl.76.1675610900723; Sun, 05
 Feb 2023 07:28:20 -0800 (PST)
MIME-Version: 1.0
References: <CADPR2CUgrO6ius5ss9Mgk8Zktf+4zQDq0vP4EEKOMku7K=V6FA@mail.gmail.com>
 <CAN0heSqwVV_G_nrt=omK0UjXVAD+TYPC+oB-1xHF4dG4oovncA@mail.gmail.com> <CADPR2CXR_KRKFjPA-0ZuHGHHq_-epHXtJWCuwYx6uvLF_H49mg@mail.gmail.com>
In-Reply-To: <CADPR2CXR_KRKFjPA-0ZuHGHHq_-epHXtJWCuwYx6uvLF_H49mg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 5 Feb 2023 16:28:07 +0100
Message-ID: <CAN0heSruSHQk8cPZ1-Zhp8dfL+j-OAsASrsBTVdWKQcx14Pxtw@mail.gmail.com>
Subject: Re: Bug Report: Superfluous Tab Characters
To:     Diogo Fernandes <diogoabfernandes@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Feb 2023 at 13:54, Diogo Fernandes <diogoabfernandes@gmail.com> w=
rote:
> On Fri, 3 Feb 2023 at 14:43 Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
>>
>> On Fri, 3 Feb 2023 at 13:50, Diogo Fernandes <diogoabfernandes@gmail.com=
> wrote:
>> >
>> > I have run into a bug where git seems to be adding superfluous tabs to
>> > the end of filenames that contain a space. I have attached the output
>> > of `git bugreport` for your review. Feel free to have a look
>> > https://github.com/trufflesecurity/trufflehog/issues/1060 for
>> > additional context.
>>
>> The code that adds this tab in the output of `git log` and friends has
>> changed a bit since it was originally added in 1a9eb3b9d5
>> ("git-diff/git-apply: make diff output a bit friendlier to GNU patch
>> (part 2)", 2006-09-22), but in that commit you can see the original
>> motivation.

> So, this is by design and not a bug? And is it still current in the lates=
t version of git?

Yes, it appears to be by design:

    Somebody was wondering on #git channel why a git generated diff
    does not apply with GNU patch when the filename contains a SP.
    It is because GNU patch expects to find TAB (and trailing timestamp)
    on ---/+++ (old_name and new_name) lines after the filenames.

    The "diff --git" output format was carefully designed to be
    compatible with GNU patch where it can, but whitespace
    characters were always a pain.

    This adds an extra TAB (but not trailing timestamp) to old_name
    and new_name lines of git-diff output when the filename has a SP
    in it.  An earlier patch updated git-apply to prepare for this.

From a quick test, this behavior does seem to be in newest git.

I sense there is some sort of ulterior motive here that hasn't come
across yet. Are you trying to parse the output of `git log` to find
something? Would `git diff-tree` work, e.g., if you're mostly just after
the filenames involved?  Depending on what you're trying to achieve, it
could be a bit simpler to parse `git diff-tree` and other "plumbing"
commands, rather than `git log` and other such "porcelain" commands.

(Also, note that one person's `git log` output can be different from
yours, e.g., because of various config knobs being set different ways.)

Martin
