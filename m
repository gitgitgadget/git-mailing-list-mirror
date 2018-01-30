Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A2A1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeA3VPW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:15:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37588 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeA3VPU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:15:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id v71so3930004wmv.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kT8X+b9rQDQ60Etr2hAyg0RyABzkH2q1QcI2oYiEJi4=;
        b=mK1g3bhdje+clf8S7ZbH6kgnx+P8lqAuJe5ST9cSxd7v2QdWsOPpEkez9dU+45e3C0
         OG2JCb62KxsP50qyATMBEbBxZqNtzs4+rbiiv6kyEZiND4TYlD/Rh05V9s2VHDKi5ZbT
         KWidaBd/Fs7PXygAXE7mfXfiT7/UbCZcu9zMyS9NWbL2xUjT+eNqtHasM8pvWi1nnijY
         pdHyMmXUkFb8fTUymSNToFT4ELQrgi3bJ+rnNSD5FRmJ3Q26ku7Jrtq6N8QAnIn8s1Bs
         TWNfaOP00dwYeEfQNf3Rt1IZk143Zd8mmeoAuWpnK+HsnEr6Uva8CHxKuwzRVeEQM4op
         lMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kT8X+b9rQDQ60Etr2hAyg0RyABzkH2q1QcI2oYiEJi4=;
        b=Rqge2wT57+JrEdUk+lQauWh8N/EQZT2EZqkIhwNlzTYwEalJwX1duxmvvC84/KgWyp
         qoYyqw0tX9+X+pchwDTBg8Zm/ohJiC3BRP8n3UMxAllYYTh3DbK1rphwC3DI+5DI6HsJ
         hiYkdr7/mpfRwrnxP9anzcf/XRaqTwKCB9FJBRdpxVnmuRs1AAK/sfcJnnFI1Ed/xav/
         pAcxOMmjpRemctj3PqUAwXkj2J8UMnf5deGUdDWpGSwZkHI3pL14MI4BvlHnCRpjWIGw
         ED147t30iCP6hoBB+vM9Bwr51oIk3/7YREfWxTi2GweH0jM0C9W4zj9vcokqH5fYJUjv
         9OXw==
X-Gm-Message-State: AKwxytdQOm19Yn4gEGzSjnpp3ZG9mU+jx73qDMCig38+33N6ELw2X0Mc
        jV2Ha0Cfw/YW8vrcJ65EZfneAtN5
X-Google-Smtp-Source: AH8x225NeUaxw6/PNMCencY6bvlh/dXwamMS2H8uYFKuiYGX1isKh5WIQ//HqtP7tGoBUNw/F1K6Eg==
X-Received: by 10.28.7.68 with SMTP id 65mr21177835wmh.9.1517346919253;
        Tue, 30 Jan 2018 13:15:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm29308576wmf.7.2018.01.30.13.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 13:15:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Todd Zullinger <tmz@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-svn: control destruction order to avoid segfault
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
        <20180129025812.GD1427@zaya.teonanacatl.net>
        <20180129120627.al2xvx4yhhvwn6ih@untitled>
        <20180129184345.GI1427@zaya.teonanacatl.net>
        <20180129231653.GA22834@starla>
Date:   Tue, 30 Jan 2018 13:15:18 -0800
In-Reply-To: <20180129231653.GA22834@starla> (Eric Wong's message of "Mon, 29
        Jan 2018 23:16:53 +0000")
Message-ID: <xmqqvafjrqu1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Todd Zullinger <tmz@pobox.com> wrote:
>> I'm running the tests with and without your patch as well.
>> So far I've run t9128 300 times with the patch and no
>> failures.  Without it, it's failed 3 times in only a few
>> dozen runs.  That's promising.
>
> Thanks for confirming it works on other systems.
> Pull request and patch below:
>
> The following changes since commit 5be1f00a9a701532232f57958efab4be8c959a29:
>
>   First batch after 2.16 (2018-01-23 13:21:10 -0800)
>
> are available in the Git repository at:
>
>   git://bogomips.org/git-svn.git svn-branch-segfault
>
> for you to fetch changes up to 2784b8d68faca823489949cbc69ead2f296cfc07:
>
>   git-svn: control destruction order to avoid segfault (2018-01-29 23:12:00 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (1):
>       git-svn: control destruction order to avoid segfault
>
>  git-svn.perl | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks.  I'd actually apply this as a patch instead of pullilng, as
I suspect you'd want it in 'maint' as well, though.


> ---------8<---------
> Subject: [PATCH] git-svn: control destruction order to avoid segfault
>
> It seems necessary to control destruction ordering to avoid a
> segfault with SVN 1.9.5 when using "git svn branch".
> I've also reported the problem against libsvn-perl to Debian
> [Bug #888791], but releasing the SVN::Client instance can be
> beneficial anyways to save memory.
>
> ref: https://bugs.debian.org/888791
> Tested-by: Todd Zullinger <tmz@pobox.com>
> Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  git-svn.perl | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 76a75d0b3d..a6b6c3e40c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1200,6 +1200,11 @@ sub cmd_branch {
>  	$ctx->copy($src, $rev, $dst)
>  		unless $_dry_run;
>  
> +	# Release resources held by ctx before creating another SVN::Ra
> +	# so destruction is orderly.  This seems necessary with SVN 1.9.5
> +	# to avoid segfaults.
> +	$ctx = undef;
> +
>  	$gs->fetch_all;
>  }
