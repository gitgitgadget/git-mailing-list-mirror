Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FCC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 11:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKXLBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 06:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKXLBF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 06:01:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C49179A98
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:01:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z4so1948818wrr.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tp39+qQtv5nXxrdyBbe3QqYVHiZ1n+xHgP7YSGH9a8Q=;
        b=jdyIHxBEJ2hdS/s0+d5NigMVwOiQT3sTIkM+FY2HhjhuHwSEOH1wZN3ZxKzenbNLSp
         rYec1DTilZschvv91p5d3ijTjfKhQlT+YseKqPVKy0ODvsuVEvQ+1g+AJgiauYlXh4M7
         56/1UsBto5DpffhG9szrhm4Y/3Arn5fEXfVb5QqClihs4LwsJWCay5oXrYQJT46BeRmm
         AzqPBqj8pnLbpV9SwT0LInJ9YNbrovophgRKvZM81oYOot5KMkLgs7WrL7YQghqD+NI0
         AReeXDrDPTTJ8k4GFNrbMsZRCo5w8faKQJ3WWCEjBgLmoTE+RlIEH1fRCq/LaauaxO2N
         l91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp39+qQtv5nXxrdyBbe3QqYVHiZ1n+xHgP7YSGH9a8Q=;
        b=YEWpmO0V/hgsgoFR5tf+mbIvMM9bL1hdvAU2Uh6QvVZ2LmYQIjvqA6AOHd/0yjnrXz
         1fRPyx66RPNlUUNXqgNJuUOo3G+I3ZaGXrgOYy0di47MmbrS8BnkmZpL1KWwKb7jQyE2
         8ZeO0fQ6Lw3yus81C0s8vbuUaTNgjSYCesAsBbAZ4EdEr8mJDSd6hwR+emiMELvlys4q
         WX6MhcDwhCI1OV8HAq9qZKzUzR4ubdQiV0YPBuDshqXF7xT7CNtoNPnhD9OwEQllUfEY
         4Gxyk11Bab+nxLQL37BCIxHsGsRCoyZd0IGp888UJVKdDW1og+TyR6XMjXSQenrZcIHS
         nwQw==
X-Gm-Message-State: ANoB5pkhk0fiwvycnUDRjgUaLU7K9ivJA/GQS/wFnwFqqZxWljH4iLtP
        VJfF6txCit8w2LqontWFcjM=
X-Google-Smtp-Source: AA0mqf6rX04NKN/Bk7hyE/WhI6YUZ6eREbKZF7eHjlQUGatL31L2wKONVXYTQPg59GL4DsARplr9hg==
X-Received: by 2002:adf:f1cc:0:b0:236:e629:adab with SMTP id z12-20020adff1cc000000b00236e629adabmr11117719wro.621.1669287660900;
        Thu, 24 Nov 2022 03:01:00 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b00236c1f2cecesm1174312wrs.81.2022.11.24.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:01:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oy9yW-0006MZ-08;
        Thu, 24 Nov 2022 12:01:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 2/3] ci: upgrade version of p4 to 21.2
Date:   Thu, 24 Nov 2022 11:55:20 +0100
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-3-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221124090545.4790-3-worldhello.net@gmail.com>
Message-ID: <221124.86ilj4pqfn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> There would be a segmentation fault when running p4 v16.2 on ubuntu
> 22.04 which is the latest version of ubuntu runner image for github
> actions.
>
> By checking each version from [1], p4d version 21.1 and above can work
> properly on ubuntu 22.04. But version 22.x will break some p4 test
> cases. So p4 version 21.x is exactly the version we can use.
>
> In addition to upgrade p4 from version 16.2 to 21.2, also add some
> instructions to show errors of command "p4 -V", so we can see why the
> command output doesn't match.
> [...]
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 0c0767d354..a618d66b81 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -246,7 +246,7 @@ ubuntu)

Omitted from this context is:

	# The Linux build installs the defined dependency versions below.
	# The OS X build installs much more recent versions,

That part should be updated here, as it's now out-of-date, they're now
installing the same version: 21.2.

>  	# were recorded in the Homebrew database upon creating the OS X
>  	# image.
>  	# Keep that in mind when you encounter a broken OS X build!
> -	export LINUX_P4_VERSION="16.2"
> +	export LINUX_P4_VERSION="21.2"
>  	export LINUX_GIT_LFS_VERSION="1.5.2"
>  
>  	P4_PATH="$HOME/custom/p4"

This is a welcome change, but it would be even more welcome if you
followed-up and unified the linux and osx p4 logic as a follow-up.

I.e. after this we'll install 21.2 on both osx and linux, so the
versions are no longer different.

I think we probably won't need to install different versions for the two
ever, we just drifted on the linux version, or maybe (per the comment
we'll need to adjust) there was some problem before with upgrading the
linux version, but no longer?

I didn't dig, but covering some of that in the commit message would be
most welcome.

So can we just s/LINUX_P4_VERSION/P4_VERSION/ or something, and then
change this in the "macos-latest";

	wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz"

To:

	wget -q "https://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.macosx1015x86_64/helix-core-server.tgz"

While doing that we can just move the "LINUX_P4_VERSION" (or whatever we
rename it to) from lib.sh to "install-dependencies.sh".

