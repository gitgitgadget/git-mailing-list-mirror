Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A0C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 14:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEHOyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjEHOyC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 10:54:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE931FE6
        for <git@vger.kernel.org>; Mon,  8 May 2023 07:54:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso2297992a12.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683557641; x=1686149641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR7cfVu/sWfHN/gHSUw6jty8dEzx/Y2Q3/i9IJfH1G0=;
        b=hV0EOONdjRt/YU2tzgFyDCSnQ+i36B/1Wp/XRzuWlH1TNXU6ON7kYlZIb+yJsi6F+x
         lPcKJ8blvO4vPRFL4tqwGd5p3zV+47LOyokCtRwA8T+k+G2tXfmWysl62+p6wgrGHFf3
         x1YTSGyks5t0nebnFJzJefDtA17F9DhuQwVGVdwK3xTr2rJ87woAnt+uhoKL8Jet4guq
         SdYrlViRur0cimaVJiSbZQ9qXV5JyvYUoQqTK5x66EOxo/p2mIbcnBVW9cvw4iFTfupE
         rcofkTROyLBt7fL19OkkwMNv25fmto+qzs47lygKNvlFqg7V0F3GR8Xt8ilf1Y0QDTLw
         rSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557641; x=1686149641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR7cfVu/sWfHN/gHSUw6jty8dEzx/Y2Q3/i9IJfH1G0=;
        b=Tdo52t9cvcKSr0J3wOPdxcK18Hzh042sxxyr7Vi3wP32Hk8USoV1Q9Tu7NwcylfV3Z
         V0nXQhAtffflHBuZw3025ABxWSi+xnysHSi6JyvGqGRe3w/mMFbxtIrLU9ABj5LDohU4
         CeCgRM/oaFSZcpl8mpR88x/mk7qM8XGNhFLTOtLmnNcbgvzRfueGDF4IBHOK9GgFswLS
         HJkM5Ux6+owiWPJ2bCSGOmVTZEb7uoMxDDUX+MJONtq0f9q4PfqBDy4vmCGK19xRKDl1
         qLNJc+XpjCUk3+g9dPO5DkxOcK8zDGUCdwruyAYUe5nqMULdvz3gMYtArTH42jzCGHFa
         7B0A==
X-Gm-Message-State: AC+VfDx9Ci9zELkYkxAW3/QWwXeZeYBK6fh2v8Wgs6xOoP14f/pXNHwR
        rpxBINcUfRp/yJq5wcwcvgG/lzLiFiPoAJHVrrIaqJs9
X-Google-Smtp-Source: ACHHUZ6xntixjTw+P3yg+4QxLd8h6JQRnHamzq8NwfA/hiLUYHbUi5jn3zNtAMCkQaJ88SySfczbktw8vziym8vtJx4=
X-Received: by 2002:a05:6a20:160e:b0:101:1008:6b84 with SMTP id
 l14-20020a056a20160e00b0010110086b84mr490483pzj.8.1683557641107; Mon, 08 May
 2023 07:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
 <a611877f-c515-033c-e015-f3952b520c08@gmail.com> <CAMP44s23Qsw3behbm57BNKeT9w_u1OunV04A9uzz85rDcD_Uug@mail.gmail.com>
In-Reply-To: <CAMP44s23Qsw3behbm57BNKeT9w_u1OunV04A9uzz85rDcD_Uug@mail.gmail.com>
From:   Dan Stromberg <strombrg@gmail.com>
Date:   Mon, 8 May 2023 07:53:50 -0700
Message-ID: <CAOvKW55MbXF8sDaGTTk9XJxw6Ln9E9G8qOF4wbXzEKY=GH=Zag@mail.gmail.com>
Subject: Re: Weird merge records
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Thomas Guyot <tguyot@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 7, 2023 at 1:34=E2=80=AFPM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Sat, May 6, 2023 at 10:20=E2=80=AFAM Thomas Guyot <tguyot@gmail.com> w=
rote:
>
> > You shouldn't change the user's config - you can instead use
> > command-line switches with git-pull to force the desired behavior. In
> > this case (which is also the default if there is no pull.rebase config)
> > it will merge with the remote (and that merge will be a fast-forward if
> > you have no added commits).
>
> Actually no: it won't merge the current branch with the remote, it
> will merge the remote with the current branch, which is not the same.
>
> This is one of the many reasons many git veterans recommend most users
> to simply avoid doing `git pull` [1]: it very rarely does what you
> want.

You seem to be implying that I shouldn't use 'git pull --rebase
upstream "$branch"'.

If that's the case, what would you recommend?
