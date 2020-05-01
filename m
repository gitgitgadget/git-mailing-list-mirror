Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21222C47259
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07EA2166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="c6inziqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgEAWco (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgEAWcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:32:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D64C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:32:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f7so2172004pfa.9
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VDDKla8Lx9EcXR3hHEgfjCzFIbf5iv5RGX1sZbv2G5k=;
        b=c6inziqwH3FfhTbELjHQVqrmnnaQAT2MQliE4EwZSLwYcYS0TwpSIAMc3/SJzU4OkD
         CTKsE02AT0ZHxZJW2PYCrOf1oPiYClIQOIOWp4Auq71xG9ydsx0nIhAMeFK4X0IvD+B2
         RchZpRKFWD5EDwzmdTfCDcc6uVwNfg0H/Zqtr4qnTLvdIPs89mlmMH+2jEjQqQiZ98FG
         Xiqmyn3THPPu2pZQlBTuKTC/CbgFFkn465coaUoiU1bd+F/CUUs6BhAegQgo+zvgn6vH
         YBptjb5bzo7FfeULzhujOH0M7n4gPIabZQbSdpTH2v0sB04EDuKDrFCQPg7pKqoJpUMt
         oEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDDKla8Lx9EcXR3hHEgfjCzFIbf5iv5RGX1sZbv2G5k=;
        b=XAwBvVtz6wc82R13sros3A5e7dzeLHU1XGLQNKhvU5gH6j4Dy7qJVG9wGyK37Ij6lc
         VLTbpXmHo3AhdwkXA73LzJaHk8Ukh8Df2Q5RIIMF0Tuaeqg47TlnswjC8C5PLDneF2xc
         g6AdH9Zot+GSbgNBtrsHc6UReinO+f8q3BcI+XzANROLfk2efc9NtpNagIaUmQlQ/FAa
         NBTww8y6haXAXeVlGZ6CDo2BhjWetga+oZZDYxxlH3KYmFqAZrIoKzQGKz0pulyb60dF
         RmErDyruBccR81dqE51lW3eS1zgkXQwAVX9i1139FF0WSf6ox3OMuAnWGG3IbdpYh+Pz
         XFRA==
X-Gm-Message-State: AGi0PuacHx4q+ZgHCaHVFZyVcucaVyPQtooAstmIVA6rC+xa3vGVkd0a
        JB/rQnGPMVuG5PdCbWkERMFhGg==
X-Google-Smtp-Source: APiQypKM7xATac3LTFzqR5SaMk88Vy6T00lJ/TUxDJrHpZ0LC++Mc1riViPQaFx0pK8zMvoOESQZYg==
X-Received: by 2002:aa7:9724:: with SMTP id k4mr6226683pfg.309.1588372362854;
        Fri, 01 May 2020 15:32:42 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h14sm527946pjc.46.2020.05.01.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:32:42 -0700 (PDT)
Date:   Fri, 1 May 2020 16:32:40 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Doug Glidden <41mortimer@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export not preserving executable permissions?
Message-ID: <20200501223240.GG41612@syl.local>
References: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
 <20200429184909.GE83442@syl.local>
 <CAHTRwmhhQCs4i04atAK66REiFJP_9e910MoYMt9iyu2v6S2jVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHTRwmhhQCs4i04atAK66REiFJP_9e910MoYMt9iyu2v6S2jVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 09:35:28AM -0400, Doug Glidden wrote:
> Taylor,

(My full response is below, but please in general do not top-quote mail
here.)

>
> Thanks for your response! It looks like git does not actually
> recognize the file as executable:
>
>     $ git ls-tree HEAD
>     100644 blob 7d2f57b2381766924e1e4ffcc62615c637bbd784    executable_script.sh
>     100644 blob d1d7cf309e091f54f268503b31653d8eba42fe88
> non_executable_file.txt
>
> Now you have me wondering if the real problem here is that I'm working
> in git-bash on a Windows machine, which means the file permissions
> aren't completely native.

I was wondering if that was the case ;-). If you are using NTFS or
FAT32, neither of these filesystems support execute permission bits. (I
am certainly not an expert here, but I know that Dscho (cc'd) would be
able to answer authoritatively here.)

That said, *Git* understands executable permissions, even if your
filesystem doesn't. You can tell Git to mark a file as executable by
the following:

  $ git update-index --chmod=+x /path/to/file

and then committing the result. Round-tripping this through 'git
fast-{im,ex}port' should preserve the permissions from Git's
perspective, and ditto for checking out the contents of a repository on
a filesystem that does support the executable permission bit.

> I'm going to run a similar experiment in a native Linux environment
> and see if I get the same results. I'll let you know what I find.

Sounds good. I'll be very surprised if it doesn't work as you expect.

> Thanks,
> Doug
>
>
>
> On Wed, Apr 29, 2020 at 2:49 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Hi Doug,
> >
> > On Wed, Apr 29, 2020 at 09:36:31AM -0400, Doug Glidden wrote:
> > > Hello Git world!
> > >
> > > I have run into an issue that I cannot seem to resolve with git
> > > fast-export. When running a fast-export on a repo that contains
> > > scripts with executable permissions (e.g. a gradlew script), the
> > > resulting export does not properly reflect the executable permissions
> > > on the script files.
> >
> > Interesting. fast-import and fast-export both understand executable
> > modes (although Git only understands the modes 644 and 755 for blobs),
> > so this should be working.
> >
> > I can not reproduce the issue as-is. Round-tripping a fast-import and
> > fast-export preserves executable bits for me:
> >
> >   #!/bin/bash
> >
> >   set -e
> >
> >   rm -rf repo client
> >
> >   git init -q repo
> >   git init -q client
> >
> >   (
> >     cd repo
> >     printf "x" >x
> >     printf "y" >y
> >     chmod +x x
> >     git add x y
> >     git commit -q -m "initial commit"
> >   )
> >
> >   git -C repo fast-export HEAD | git -C client fast-import
> >
> >   diff -u <(git -C repo ls-tree HEAD) <(git -C client ls-tree HEAD)
> >
> > > To illustrate this issue, I created a small sample repo, with one
> > > executable file and one non-executable file. From the output below,
> > > you can see that the mode in the output from fast-export is the same
> > > for both files; according to the documentation for fast-import, the
> > > mode for the executable file should be 100755 instead of 100644.
> > >
> > >     $ ls -gG
> > >     total 2
> > >     -rwxr-xr-x 1 106 Apr 29 09:13 executable_script.sh*
> > >     -rw-r--r-- 1  63 Apr 29 09:12 non_executable_file.txt
> > >
> > >     $ git fast-export --all
> > >     blob
> > >     mark :1
> > >     data 106
> > >     #!/bin/bash
> > >
> > >     # This is a shell script that should be executable.
> > >     echo 'The script executed successfully!'
> > >
> > >     blob
> > >     mark :2
> > >     data 63
> > >     This file is a simple text file that should not be executable.
> > >
> > >     reset refs/heads/dev
> > >     commit refs/heads/dev
> > >     mark :3
> > >     author Doug <41mortimer@gmail.com> 1588167102 -0400
> > >     committer Doug <41mortimer@gmail.com> 1588167102 -0400
> > >     data 25
> > >     Adding some sample files
> > >     M 100644 :1 executable_script.sh
> > >     M 100644 :2 non_executable_file.txt
> > >
> > > Please let me know if there is any further information I can provide
> > > about this issue.
> >
> > Does Git think that the file is executable? Please run 'git ls-tree
> > HEAD' to find out.
> >
> > > Thank you,
> > > Doug
> >
> > Thanks,
> > Taylor
Thanks,
Taylor
