Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A259EB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGRX37 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Jul 2023 19:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGRX3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:29:53 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B20F7
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:52 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5634d8d1db0so3895309eaf.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722992; x=1690327792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcKyQOkL1rujx5tOXK3vktbs4yp5ZRZUo7SPysPFQSk=;
        b=BUoVJfUgT9K0h1Gc5Kb528+F6MJu4N6FG6Ds/Pm2YgtRC0fyxxrz5StlWCsgc7y2Bo
         Ny7xmhkSTYskWW6aeG98KS4gabonnHtadVROvnCFkHDQOAtMVyXAG67o6SLxGwS46vUc
         AmHhX9plFCs6g/ekv/c0MUbittBysJruyoV6/BGnquCx/TI3DambHlGlJZbnfHoch+Yx
         gf54uWnObMKrDFuyjksclYaOKqNgRQ0CieKkveT9UGM5kq0wMmDGs9vK1IgPSOsYEh9K
         bOHZQjOuyAh1y7DPm82+ueuvAHipl0EohiRKS1l3kfGpgcqqdECVg8K5QoOgQJ5IOBYO
         9I6g==
X-Gm-Message-State: ABy/qLax2RzP11SvrSuEZDbt7rQo5BAk/v1XzB6q4B+ewWMQTolwL49j
        LjcNyLkQVbZ/sss70usw/uAigVLiCoohEHDUhV4ua+JkUp62BXnmhdA2Rw==
X-Google-Smtp-Source: APBJJlHUKJpzErZIRZiN0p/dA5AInwrMvUbLTsA1Mi0hYabdcjWLiFBcBr3DSC1i3WtFRwXucuNvpbEPL3zhmpQZ4kY=
X-Received: by 2002:a4a:3416:0:b0:566:fa3f:ea29 with SMTP id
 b22-20020a4a3416000000b00566fa3fea29mr430634ooa.5.1689722992000; Tue, 18 Jul
 2023 16:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
 <xmqqfs5mgs8v.fsf@gitster.g> <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
 <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
 <CAGE71k3tMOtyFVrmGW33RuQ3GufJg8X6ORKCwHQgg6RmXbRCQA@mail.gmail.com>
 <xmqqa5vsg8gp.fsf@gitster.g> <CAGE71k28Gao4xuR565qsLmPH02tVAdoCZPeuCjo7r9YZXWs82Q@mail.gmail.com>
 <xmqqh6q0esbd.fsf@gitster.g>
In-Reply-To: <xmqqh6q0esbd.fsf@gitster.g>
From:   =?UTF-8?Q?Adam_=22Sinus=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Date:   Wed, 19 Jul 2023 01:29:40 +0200
Message-ID: <CAGE71k0ZSLOF+XZTwKy4+7vOZ_u-SMwgsA=viraqrAnU_ed2fQ@mail.gmail.com>
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glad to have pointed out a possible improvement. :)

By "different from others" I primarily meant that all the other hooks
(save for fsmonitor-watchman, I guess) are safe to simply be "echo
Hello world; exit 0" as they don't REPLACE any functionality. This one
does.

Perhaps there's a need for "pre-deploy" / "post-deploy" hooks,
ensuring that it's a good time to deploy, maybe bringing a live
website into and out of maintenance mode after the hopefully brief
deployment..?

On Wed, 19 Jul 2023 at 01:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Adam \"Sinus\" Skawiński"  <adam.skawinski@sinpi.net> writes:
>
> > Oh. Then it's different from the other hooks, which merely enhance or
> > abort the default behaviour by returning non-zero! I hadn't thought of
> > that.
>
> I do not know if it is all that different from others, but in any
> case it is a clear sign that the documentation needs a bit more love
> to make sure that it will not lead new readers and users into the
> same confusion.
>
> Thanks.



-- 
Adam "Sinus" Skawiński
