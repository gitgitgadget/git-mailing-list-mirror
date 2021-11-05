Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E4C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2467460FC0
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhKELuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhKELua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 07:50:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6CC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 04:47:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b12so13279384wrh.4
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2nBwGzdZLzfAKY1gTQr75oJjItkZRHzlYjFk2mNm5Vc=;
        b=XQQlXJ6gkwzbOwNRkmgFrcH20U46tGu3JbnucD4mrBCB0KZ9qSQHQ0Z9fGT+e7E1lV
         nW+vNMJG1xQdq9qdIm6OSTxF2uu+gexJSpc6FMnoDuenKWdQ9UVCasg22G6zJLt9UJUi
         NyOQXfP9fhK9b/Xi3IDA7UHhKUQhAfQDjpAa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nBwGzdZLzfAKY1gTQr75oJjItkZRHzlYjFk2mNm5Vc=;
        b=ujNYfRAsS4jttN7/Ih/j6MaktnaOXEgydzj/TjdaDzQHr3s7lcY92hWLZELaYaunGa
         9nEp1mQX+PaeMoVGGUa1yynJw8TqDQFjuISy/rBfvEScZbcye07PIM3egxaAHgIlrlDE
         zFus/zf9rcBi3kGKhG2xI/JEGDlnmjAO+y9cX7B67AtqzL6V8Llx7tn0JUm6XZLcyPU/
         6kv/Ccnt5jlg8ljd5Ipf2zMwvXifqRYjsZhs7esyTK8PqSfZT3EJjI7THvyV9REWh9Nj
         DKxVUEgkyuhVoJD8cVO2UszfyVv50/aJLxN7xKkPPolqigTxKtYnJXQXNAfj9X8URXzB
         3oEw==
X-Gm-Message-State: AOAM532cxOzQGpfYBWZJaCYOWME9c6AP84uypYcXkiXMhFfp24nmEWAY
        Oijveji1EQlGHfXfTnKF0Qwyj3faJbJRCw==
X-Google-Smtp-Source: ABdhPJwxIYc4/zI4/KY2yB8cAYmy9EhxhMcRxf5m/NhGA/mhfE/IChfEepzhwj1kdnEEyIEQZAWX+A==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr65519556wrt.91.1636112869277;
        Fri, 05 Nov 2021 04:47:49 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id u14sm7628497wrt.49.2021.11.05.04.47.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Nov 2021 04:47:48 -0700 (PDT)
Date:   Fri, 5 Nov 2021 11:47:47 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <20211105114747.GB25887@dinwoodie.org>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <6acb22bc-a90c-b8b6-2e7d-d7e17ba595ea@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acb22bc-a90c-b8b6-2e7d-d7e17ba595ea@ramsayjones.plus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 04 November 2021 at 08:09 pm +0000, Ramsay Jones wrote:
> Hi Adam,
> 
> On 04/11/2021 19:25, Adam Dinwoodie wrote:
> > SSH keys are expected to be created with very restrictive permissions,
> > and SSH commands will fail if the permissions are not appropriate.  When
> > creating a directory for SSH keys in test scripts, attempt to clear any
> > ACLs that might otherwise cause the private key to inherit less
> > restrictive permissions than it requires.
> 
> I was somewhat surprised to see your report, since all these tests
> passed without issue for me on '-rc0'! :D (64-bit cygwin only).
> 
> So, the difference seems to be down to FS ACLs, Hmmm ...
> 
> (BTW, I am on windows 10 21H1)

I'm running these tests in subdirectories in the temporary drive on
Dv4-size Windows 11 Pro Gen2 Azure VMs.  I'm spinning up fresh VMs and
using new Cygwin installations regularly, in the name of build
reproducibility; I'm vaguely working on automating more and more of the
Cygwin Git test and release processes.

(At some point now they're becoming available, I'll probably shift to
Ddv5 Azure VMs for this work; I very much doubt that'll make a
difference, but I note it for the sake of completeness.  Longer-term,
I'm hoping to swap to using GitHub Actions to do most of the heavy
lifting.)

This isn't the first time I've seen similar problems in this environment
that haven't been spotted elsewhere: see a1e03535db (t4129: fix
setfacl-related permissions failure, 2020-12-23).

The `getfacl` output for the temporary drive, from Cygwin's perspective,
is as below; I'm `cd`ing into that directory and getting the Git
repositories by running `git clone https://github.com/git/git` from
there.

```
# file: /cygdrive/d
# owner: NETWORK SERVICE
# group: NETWORK SERVICE
user::r-x
group::r-x
group:SYSTEM:rwx        #effective:r-x
group:Administrators:rwx        #effective:r-x
group:Users:r-x
mask::r-x
other::r-x
default:user::rwx
default:group::---
default:group:SYSTEM:rwx
default:group:Administrators:rwx
default:group:Users:rwx
default:mask::rwx
default:other::r-x
```

I'm honestly not sure what it is that means I keep hitting these
problems with this setup.  I've managed to avoid needing anything but
the most cursory knowledge of extended permissions handling,
particularly for Cygwin where one has to contend with both the
underlying OS's interpretation of file permissions and with the Cygwin
layer's reinterpretations.  I can't say I'm keen to get a deep working
knowledge of how all these pieces interact!
