From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 08:25:29 -0700
Message-ID: <CAGZ79karNW3+xiZQuoh5v-nRabs+h-5pyHDfjHS4vTVBkAyv_Q@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net>
	<20160428133744.GC25319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:25:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnow-0003pW-Su
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbcD1PZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:25:32 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37578 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbcD1PZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:25:30 -0400
Received: by mail-ig0-f173.google.com with SMTP id s8so23859672ign.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fVYUHNFeOEoKUbi+SueT5WoVihGeYSU2fX+Dls14Kgw=;
        b=F9iHs/m/g+qdcCxbGPxiqvTut3ZrCquJz7UWTfk0usUgyLJ7Bj6XMXw5c071gnEjTy
         rBIfa6BHI4HGYUH+yHI9bECaJm9TheJo6ZXRsjYO2APGZWZWGikKnUyKCqeTJ2tXglSD
         ICqrCTQo2ks4BlBnLndIo4LkHeMEt2W9dbRdUWrS4J6+e0hd74hn/a/znaQ04Bl8Odbp
         0rKPuu5RYozqlzy7EFQR+whW0hZIUuf6CLbDtkwmKPsUIahKIHvWiIRW8H0TdE8dJYCY
         4PVukLvJ/g7ov/Ngo3TbNvktxqdJSzyKOJzMNVSX1KcQY51kUm23q8etdEeDJLHZpC72
         K/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fVYUHNFeOEoKUbi+SueT5WoVihGeYSU2fX+Dls14Kgw=;
        b=mFPt1VN2st1bqf2JVij41dG+TBLxPHtzGUJaQhRgqAqnptBXtd8jRZNqP/b2VlDUxI
         MxWp01y4poTMSlIq/sJL31WmocsQFJq6ICpkK4yxJMGw8zLmhiZ0MMRQXQcde3uW/HE+
         98NcmvLtxWQ54+cu8MsJCjsHQFFIhk1tiA1cYqjvLN96hwgKJluFPLa6URnG4EI5ASNd
         rP+bod8iGHs5nDMUoRwggYJzmnpUIf5QhOYatrO6dZ+NjppqANNGuQwH6ei15/l63fro
         odPm6v58f+eTT5WogPgAY3akIXC6YEIplckYPyJVrIWLSS7nGIh69EtfcvlBMmAd0i1A
         FvQw==
X-Gm-Message-State: AOPr4FUkgmFqwiWLzmz3CMVMRiGZpCHNd29Cl0MFycoAb/o09vfxfha6XC4JT15onFPENKLEKbuVDeP8Phci1b7R
X-Received: by 10.50.102.207 with SMTP id fq15mr30142122igb.94.1461857129380;
 Thu, 28 Apr 2016 08:25:29 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 08:25:29 -0700 (PDT)
In-Reply-To: <20160428133744.GC25319@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292897>

On Thu, Apr 28, 2016 at 6:37 AM, Jeff King <peff@peff.net> wrote:
> Commit 14111fc (git: submodule honor -c credential.* from
> command line, 2016-02-29) taught git-submodule.sh to save
> the sanitized value of $GIT_CONFIG_PARAMETERS when clearing
> the environment for a submodule. However, it failed to
> export the result, meaning that it had no effect for any
> sub-programs.
>
> We didn't catch this in our initial tests because we checked
> only the "clone" case, which does not go through the shell
> script at all. Provoking "git submodule update" to do a
> fetch demonstrates the bug.
>
> Noticed-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-submodule.sh           |  1 +
>  t/t5550-http-fetch-dumb.sh | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2a84d7e..3a40d4b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -200,6 +200,7 @@ sanitize_submodule_env()
>         sanitized_config=$(git submodule--helper sanitize-config)
>         clear_local_git_env
>         GIT_CONFIG_PARAMETERS=$sanitized_config
> +       export GIT_CONFIG_PARAMETERS
>  }
>
>  #
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index e8e91bb..13ac788 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -112,6 +112,23 @@ test_expect_success 'cmdline credential config passes to submodule via clone' '
>         expect_askpass pass user@host
>  '
>
> +test_expect_success 'cmdline credential config passes submodule update' '
> +       # advance the submodule HEAD so that a fetch is required
> +       git commit --allow-empty -m foo &&
> +       git push "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git" HEAD &&
> +       sha1=$(git rev-parse HEAD) &&
> +       git -C super-clone update-index --cacheinfo 160000,$sha1,sub &&

The use of update-index seems elegant to me, though different than
any submodule test I wrote so far. :)

> +
> +       set_askpass wrong pass@host &&
> +       test_must_fail git -C super-clone submodule update &&
> +
> +       set_askpass wrong pass@host &&
> +       git -C super-clone \
> +           -c "credential.$HTTPD_URL.username=user@host" \
> +           submodule update &&
> +       expect_askpass pass user@host
> +'
> +
>  test_expect_success 'fetch changes via http' '
>         echo content >>file &&
>         git commit -a -m two &&
> --
> 2.8.1.617.gbdccc2d
>
