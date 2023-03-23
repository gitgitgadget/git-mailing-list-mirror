Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15092C6FD1D
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 07:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCWHmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCWHmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 03:42:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501A10CE
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 00:42:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso558909wmb.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679557354;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN0gfZ2Gy5V1e1HfOSEqwBurECKxst3/yizX7lqacrY=;
        b=PCeweLyatUm6Yyv1kSHDZiwDDh+EsfInh+vSYPimlWnBPOCFDIGHtF9VzNv0iF0xUk
         4FCOgbRNHz4XeR4xQ9gj6LvBwgKCwcnNQjrKMw35vyBdvfezyDPYO6i/uXBSgMAWp0cJ
         NndoGcDem1CL4T6/XBQx8KKDa0r+9VMy7AP+KQzGmW5CUUZtqTC+lDMhy9t05dVrH4JN
         xhayVihl/wGBRF6idw3DtZ9eDWDC4AmovVmB4cMX3v8JamONy6Sf4b180u4YjR3t1x4O
         3xpC6n/hu7OHNuAxh1p79p3xLYRR5T0TJih3umntPFhSGyzn37PrKzPqXNMIXh2/jvi/
         +Tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679557354;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN0gfZ2Gy5V1e1HfOSEqwBurECKxst3/yizX7lqacrY=;
        b=zjr3SVPoSjjh76TL4gHTviWOPsUmtDMjq5SsTsyeAOJtydIDa2Hfgm4l6dbeN3Bv+V
         ZBQl6Zdsc1f/IvsrTocu3eJtFnj96UdR3IsnM8uDsD1gpvDBC04tscRW61GjsM1JRsuJ
         +uj3O+rIdBiHhG40XhSBS9LkMS28t9cXEj0jJlkJwst9N22euslQMKTR7YrywmZufBT5
         Ooh6FWE8HzNopPrX+UjEZ/yHLVR53yQyBvA8V647QJAk/282mWjX4GkPr9hgh9P2gEQL
         YekMqdj21EC9zFeH7TVLv2qLgia7f06Ytf06NXhTaSQmwFgfDiAov41YsDGBsjYpeSzv
         dVQQ==
X-Gm-Message-State: AO0yUKUeLfaVlZ6cXVf5Zgb8uPlgJaV5HeCXVyNQFSUfWr+hQQttmpOB
        S8laDDVOPrpJ0RUQlUC8KaEaMWjP8vuzwrOmUcuaTwEYkWQ=
X-Google-Smtp-Source: AK7set/R9OTfxJ1QJbHAJaa96DjFMhWUSpDnKVhsqFelVX6rJh7TUX922RVsRs5ybm+lwL+LMyhJh07twhcp8MW7528=
X-Received: by 2002:a1c:7702:0:b0:3ed:a25d:8ae1 with SMTP id
 t2-20020a1c7702000000b003eda25d8ae1mr503972wmi.3.1679557354262; Thu, 23 Mar
 2023 00:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205241.105476-1-cheskaqiqi@gmail.com> <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <xmqqilesbbph.fsf@gitster.g>
In-Reply-To: <xmqqilesbbph.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 23 Mar 2023 03:42:21 -0400
Message-ID: <CAMO4yUFshQ_bP3gXeZhfHQ3OevC+_3qKwa-iy2nNGScvRouu6Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 7:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> > 3. Use `--stat` to ignore file creation time differences in unrefreshed
> > index.
>
> I am curious about this one.  Why is this a preferred solution over
> say "run 'update-index --refresh' before running diff-files"?
>
> Note that this is merely "I am curious", not "I think it is wrong".

Hi Junio

Thank you for your question, it has prompted me to consider the matter
further =3D)  I think both solutions, using git diff-files --stat and using=
 git
update-index --refresh before git diff-files, can produce the same output b=
ut
in different ways.

When the index file is not up-to-date, git diff-files may show differences
between the working directory and the index that are caused by file creatio=
n
time differences, rather than actual changes to the file contents. By using=
 git
diff-files --stat, which ignores file creation time differences.

While 'git update-index --refresh' updates the index file to match the cont=
ents
of the working tree. By running this command before git diff-files, we can
ensure that the index file is up-to-date and that the output of git diff-fi=
les
accurately reflects the differences between the working directory and the i=
ndex.

Maybe using git update-index --refresh would be more direct and
straightforward solution.

(Hi Victoria, do you have any comments?  =3D)


Thanks
Shuqi
