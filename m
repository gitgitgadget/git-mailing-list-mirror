Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85412C7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 20:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEQUPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 16:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEQUPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 16:15:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185E7AA9
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:15:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7700622925fso32851239f.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684354509; x=1686946509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw4axLYp+L0ZD5LW4Hgc5nkQsCr5VrsVNgv91SbAres=;
        b=JkZnndex/Q8Zh7pDU4oYbX1Upj1PK0w99vRPfvb1ppi8USP4fJEIS/fLhrSj+jMFRr
         OZ6kP6chlCDEqpGJVNpDy3gJ0EHbtcPz3kUKCArrJVhxaKpYrsClaCfHvmPpNc4s+iwY
         pHndjc/V2qosHLiumqTiWTxa3RYT7u0AU/u38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354509; x=1686946509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw4axLYp+L0ZD5LW4Hgc5nkQsCr5VrsVNgv91SbAres=;
        b=cSmckiJoO5BOY49lRx18h1MBd6yRM8J15v6geHNIPhO1Q2IvSbs0QU1oOAZsnmNyEx
         5g5fHsoiraPYSiWfC2jW0ZVWW7R3mty7k11DPZ2/h5tkvxzaXZ/qVhBWDMr8AmnRjcbU
         rBwdhTCpUI6/lX0QLheN0FzS1jgof64SAZlq6i9cBZCcq78s/9sJ3TGdUIFgfY7o9J8S
         /QdWlhJ+6deTgmWSXqVXRpAk4skzVax3vFq+H7YygCrOQQYpHOgUIuEbP0WPuRyb3HOJ
         chqWGvVo/8nX52BjQ/YdVLvrLVmQTb50F+qkdWs/58HbPOyrZBPnQZ0hLF5/J8srTsV6
         xFmg==
X-Gm-Message-State: AC+VfDziVX+EFUhD3xJ0eOafxJ8KzpxN7EJOf4ovfwzJ76xmOTYcGYo5
        uYf/k8AZ6yXYPaPUxN24mWTo1kFPr2VKElagxFc=
X-Google-Smtp-Source: ACHHUZ6FH/15EArId7t1sXfEewmaaczxi2x1Fi97Adi6gU3Ww9GZK3vWPHOEEggCVDiVj6+UvvzKEg==
X-Received: by 2002:a5d:9816:0:b0:76e:748b:e49a with SMTP id a22-20020a5d9816000000b0076e748be49amr4882256iol.5.1684354509410;
        Wed, 17 May 2023 13:15:09 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id w9-20020a056638138900b0041698357280sm6357158jad.59.2023.05.17.13.15.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:15:08 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33164ec77ccso40955ab.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:15:08 -0700 (PDT)
X-Received: by 2002:a05:6e02:b29:b0:338:3b6a:4719 with SMTP id
 e9-20020a056e020b2900b003383b6a4719mr3533ilu.17.1684354508119; Wed, 17 May
 2023 13:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
 <xmqqo7mipyt0.fsf@gitster.g> <xmqqjzx6pxuu.fsf@gitster.g>
In-Reply-To: <xmqqjzx6pxuu.fsf@gitster.g>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 13:14:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkZBQ6SFB7xu8OD3vxtODp6RUq=K3xXzofpJjUZO18+w@mail.gmail.com>
Message-ID: <CAD=FV=UkZBQ6SFB7xu8OD3vxtODp6RUq=K3xXzofpJjUZO18+w@mail.gmail.com>
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, michael.strawbridge@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, May 17, 2023 at 12:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> # With the attached patches, where all of the patches have a
> >> # Message-Id but the cover letter doesn't.
> >> git send-email *.patch
>
> I suspect this is a recent regression with the addition of the
> pre_process_file step.  56adddaa (send-email: refactor header
> generation functions, 2023-04-19) makes all messages parsed
> before the first message is sent out, by calling a sub
> "pre_process_file" before invoking the validate hook.  The same sub
> is called again for each message when it is sent out, as the
> processing in that step is shared between the time the message gets
> vetted and the time the message gets sent.
>
> Unfortunately, $message_id variable is assigned to in that sub.  So
> it is very much understandable why this happens.
>
> I wonder if it is just doing something silly like this?
>
> --- >8 ---
> Subject: [PATCH] send-email: clear the $message_id after validation
>
> Recently git-send-email started parsing the same message twice, once
> to validate _all_ the message before sending even the first one, and
> then after the validation hook is happy and each message gets sent,
> to read the contents to find out where to send to etc.
>
> Unfortunately, the effect of reading the messages for validation
> lingered even after the validation is done.  Namely $message_id gets
> assigned if exists in the input files but the variable is global,
> and it is not cleared before pre_process_file runs.  This causes
> reading a message without a message-id followed by reading a message
> with a message-id to misbehave---the sub reports as if the message
> had the same id as the previously written one.
>
> Clear the variable before starting to read the headers in
> pre_process_file
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I am not surprised at all if there are similar problems in this
>    function around variables other than $message_id; this patch is
>    merely reacting to the bug report and not systematically hunting
>    and fixing the bugs coming from the same root cause.  If the
>    original author of the pre_process_file change is still around,
>    the second sets of eyes from them is very much appreciated.
>
>  git-send-email.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git c/git-send-email.perl w/git-send-email.perl
> index 89d8237e89..889ef388c8 100755
> --- c/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1771,6 +1771,7 @@ sub send_message {
>  sub pre_process_file {
>         my ($t, $quiet) =3D @_;
>
> +       undef $message_id;
>         open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t)=
;
>
>         my $author =3D undef;

I can confirm this fixes the regression for me. Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>
