Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FDC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A412071E
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XL5V1IY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgBUAM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:12:29 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36214 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgBUAM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 19:12:29 -0500
Received: by mail-wm1-f47.google.com with SMTP id p17so426943wma.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 16:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Z4zHyfeJcT6+vgSH4uR450tRtpdDn/GCWoFXYVCk7Qc=;
        b=XL5V1IY913+D9G2nc8vZ5hSr2HrfoOtenbFm0tytpsXb1HMNWr6SWXxJ/xI6aUYuM3
         VHPyGJhyiEZ56Ryz4CGnU/OEry6ULrQo9MeqqaPuE+CvGVYR1fcDguNySo6YVSHA3dNj
         kvr7f6BQ5X2dyRbB03l+J/rm+cmHj9/DbqK2V1sAmGWVs8XtKPwWObyOKsY5wUT+RQKR
         3FpbkBBYgfHAAM7JItIuDfFzhzLUA7cMaEY1+yOrjHW3k2grFjIOcWhFYM0SCxyDxaow
         8s07PfVJVyAdvduSAXJm819jKNpf+3qv5dxGlajuzvOHqhGRfcU7/rT6gfkFnqQG5hpG
         S1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Z4zHyfeJcT6+vgSH4uR450tRtpdDn/GCWoFXYVCk7Qc=;
        b=ICFUGJBAIXvBTmiyoXItotdoGSE4SR7GkF9vCuaEqUto8oTusBjx3QR52ZPLhgB7jS
         mRLW94PzFqX6fXo3FtSFvqN6E1iwJ5HhTCNScYi7V8eHw3RCHYvP1aMmpfAcILv+SIU4
         qdiR5quHYJkAtSIXYrTqIGUh+KkWk1D2eOHutV3QCwDXcooojnkRc6ElFJKV1a2GqBQk
         TBIxSV0GRmDDd54rVMP2kOiSHBTGupTNJIGvosCzOt7zCEfoLafGj3UEboKER0UlrhMX
         EOtOaI07xwvMnNWizDJrdlcJ+XXjKksf0t9iT1ZuGYZrIesBoD95MFXS6ORZq3jjA60i
         9QNQ==
X-Gm-Message-State: APjAAAVnHhKglRG6CJH/ld0cv8yW8iERTZVUbWPUuJr3pPVhUQioTmnU
        M4CNNPeKwe3FMSTdaYQ0vF3oz2ToTj4i1J2SRw/oxP7o0e4=
X-Google-Smtp-Source: APXvYqwGVf52cJf8bi5gw0UcK8Fzc2uTqIje6GDVmfC2wlYnzanb9g2Grz/lYMh/AIwrFPODuKcnofl+IcJZg+Yo/MA=
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr6948314wmb.19.1582243946832;
 Thu, 20 Feb 2020 16:12:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
 <20200221000141.GA6462@camp.crustytoothpaste.net>
In-Reply-To: <20200221000141.GA6462@camp.crustytoothpaste.net>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 20 Feb 2020 16:12:18 -0800
Message-ID: <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
Subject: Re: git does not wait on hook exes (^C)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 4:01 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-02-20 at 21:14:55, Anthony Sottile wrote:
> > Here's a small example:
> >
> > ```bash
> > #!/usr/bin/env bash
> > foo() {
> >     echo zzz part 2
> >     sleep 1
> >     echo exiting now
> > }
> > trap foo SIGINT
> >
> > echo zzz part 1
> > sleep 10
> > ```
> >
> > ```console
> > $ git --version
> > git version 2.25.GIT
> > $ git commit --allow-empty -m foo
> > zzz part 1
> > ^Czzz part 2
> >
> > $ exiting now
> > ```
> >
> > - I pressed ^C during the first sleep
> > - control was returned back to my terminal
> > - the hook script was still running in the background
>
> I believe the way that SIGINT works on a terminal is that it sends the
> signal to all processes in the foreground process group.  So my guess of
> what's happening here is that Git and your script both get SIGINT, Git
> cleans up and exits quickly, leaving your script running.
>
> If so, I'm not sure that Git can do much here.  If Git waited for the
> hook to exit, then a broken or hung hook would cause Git to hang
> indefinitely, which is not what the user intended when they pressed
> Ctrl-C.  Usually what the user wants is an immediate return to the
> terminal in such a case, and I think most users would consider it a bug
> if Git were to wait for its children.
>
> Certainly I'm open to hearing other views on this, though.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


Taking git out of the situation:

Create a shell script:

```bash
#!/usr/bin/env bash
.git/hooks/pre-commit
```

```console
$ ./t.sh
zzz part 1
^Czzz part 2
exiting
$
```

that works fine (and is the expected case for `subprocess` calls for
example in python)

Anthony
