Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F76C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 12:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiFCMM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiFCMM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 08:12:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10679248FD
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 05:12:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v1so4850504ejg.13
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lf8rMKVMqFQ458Yh92cCBcJ/ZRngvw+JWJC41tcGIbg=;
        b=YQlS81v8ha+NSy5x/HoxLf6d2G2Vzq+/yev2cP+QDANuvODNOHGlOXn0PHeUvD3ToD
         m/LWBQBprOTuq/3B1vg/00Nsf08F1FFX2Fb4e62UnUXu3blAd6An6VPV+/3b6kph6yPZ
         fX7AYdCSZgNwdznd3+5uUj+xIqHCrVyPBgjUyB1HARcDN3TviViPIeo2ue6AqoIGQVsS
         wHGlpzDwQR/sgf8ahsc6ZyBUII+yMNFMkcmx6g1OxQDgY6wSSjtkM0TTZMQ7rkmkuTyA
         QjSVe26cJ+qI/QzoaHjqNrbjLlaAT7OmyxF4yQo9drmbnwWHuy5w3brNwjYVuULRwt44
         RBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Lf8rMKVMqFQ458Yh92cCBcJ/ZRngvw+JWJC41tcGIbg=;
        b=lxQDDpwXHcputExa7LjFFboo8m9lT/2ECBOcgqBz7v4K1RKAhOD2nEq61gecjd6kea
         EAoKq0uhgRIqvuDGAmldRmEtnAZRrlMq6PmZHx+7WS+3q2IhW5GdmFUi/7X5GYtjiX5U
         WmZUfl0rhZ7Pyb/3uh32fe0ZI8bL07KEfx5TZihXyC8UZwZDWQhOkRurKgyrVE0v6yFh
         MHdxzXq95+9mjwucJ2RemYULf46yzR9h4jqv292EugsLV/vT6Jsnx8wtreUViIPwtmIe
         C5gueNhCZjtLl1VpXIg5mv550RKwkpPofxU5CheZsIl/lVsnC4QqNkYEUrnhLhHroKXN
         Ut/A==
X-Gm-Message-State: AOAM530aBOP561gD/oKZ15RhdKssPjb8JSCng4ieOpkO7TniKucTaNWl
        hQVdCJkev8TZvnT3LnLgE9I=
X-Google-Smtp-Source: ABdhPJzTkUCdJpl1pu6yvDHGSsQBVIkxQWI+JCbMJpUMsLsTXB2coUZ7py7AxeVsJO2ZiaPcdSkZDA==
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id nb40-20020a1709071ca800b0070c68cedademr5279306ejc.723.1654258345453;
        Fri, 03 Jun 2022 05:12:25 -0700 (PDT)
Received: from localhost (78-131-17-130.pool.digikabel.hu. [78.131.17.130])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm488747ejb.188.2022.06.03.05.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:12:24 -0700 (PDT)
Date:   Fri, 3 Jun 2022 14:12:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 1/4] t: regression git needs safe.directory when using
 sudo
Message-ID: <20220603121223.GB1749@szeder.dev>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513010020.55361-2-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2022 at 06:00:17PM -0700, Carlo Marcelo Arenas Belón wrote:
> Originally reported after release of v2.35.2 (and other maint branches)
> for CVE-2022-24765 and blocking otherwise harmless commands that were
> done using sudo in a repository that was owned by the user.
> 
> Add a new test script with very basic support to allow running git
> commands through sudo, so a reproduction could be implemented and that
> uses only `git status` as a proxy of the issue reported.
> 
> Note that because of the way sudo interacts with the system, a much
> more complete integration with the test framework will require a lot
> more work and that was therefore intentionally punted for now.
> 
> The current implementation requires the execution of a special cleanup
> function which should always be kept as the last "test" or otherwise
> the standard cleanup functions will fail because they can't remove
> the root owned directories that are used.  This also means that if
> failures are found while running, the specifics of the failure might
> not be kept for further debugging and if the test was interrupted, it
> will be necessary to clean the working directory manually before
> restarting by running:
> 
>   $ sudo rm -rf trash\ directory.t0034-root-safe-directory/
> 
> The test file also uses at least one initial "setup" test that creates
> a parallel execution directory under the "root" sub directory, which
> should be used as top level directory for all repositories that are
> used in this test file.  Unlike all other tests the repository provided
> by the test framework should go unused.
> 
> Special care should be taken when invoking commands through sudo, since
> the environment is otherwise independent from what the test framework
> setup and might have changed the values for HOME, SHELL and dropped
> several relevant environment variables for your test.  Indeed `git status`
> was used as a proxy because it doesn't even require commits in the
> repository to work and usually doesn't require much from the environment
> to run, but a future patch will add calls to `git init` and that will
> fail to honor the default branch name, unless that setting is NOT
> provided through an environment variable (which means even a CI run
> could fail that test if enabled incorrectly).
> 
> A new SUDO prerequisite is provided that does some sanity checking
> to make sure the sudo command that will be used allows for passwordless
> execution as root without restrictions and doesn't mess with git's
> execution path.  This matches what is provided by the macOS agents that
> are used as part of GitHub actions and probably nowhere else.
> 
> Most of those characteristics make this test mostly only suitable for
> CI, but it might be executed locally if special care is taken to provide
> for all of them in the local configuration and maybe making use of the
> sudo credential cache by first invoking sudo, entering your password if
> needed, and then invoking the test with:
> 
>   $ GIT_TEST_ALLOW_SUDO=YES ./t0034-root-safe-directory.sh
> 
> If it fails to run, then it means your local setup wouldn't work for the
> test because of the configuration sudo has or other system settings, and
> things that might help are to comment out sudo's secure_path config, and
> make sure that the account you are using has no restrictions on the
> commands it can run through sudo, just like is provided for the user in
> the CI.
> 
> For example (assuming a username of marta for you) something probably
> similar to the following entry in your /etc/sudoers (or equivalent) file:
> 
>   marta	ALL=(ALL:ALL) NOPASSWD: ALL
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t0034-root-safe-directory.sh | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100755 t/t0034-root-safe-directory.sh
> 
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
> new file mode 100755
> index 00000000000..f6a5d63ff41
> --- /dev/null
> +++ b/t/t0034-root-safe-directory.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description='verify safe.directory checks while running as root'
> +
> +. ./test-lib.sh
> +
> +if [ "$GIT_TEST_ALLOW_SUDO" != "YES" ]
> +then
> +	skip_all="You must set env var GIT_TEST_ALLOW_SUDO=YES in order to run this test"
> +	test_done
> +fi
> +
> +test_lazy_prereq SUDO '
> +	sudo -n id -u >u &&
> +	id -u root >r &&
> +	test_cmp u r &&
> +	command -v git >u &&
> +	sudo command -v git >r &&

'command' is a shell builtin, thus it's not something 'sudo' can
execute, so this prereq fails with:

  [...]
  + command -v git
  + sudo command -v git
  sudo: command: command not found
  error: last command exited with $?=1
  prerequisite SUDO not satisfied
  ok 1 # skip setup (missing SUDO)

Changing it to:

  sudo sh -c "command -v git" >r &&

makes it work, but then it lists the path of the system git binary
instead of the one that's supposed to be tested, so the prereq is
still not satisfied (this is why the commit message suggested
adjusting that secure_path config, right?  I haven't got that far
yet.)

> +	test_cmp u r
> +'
> +
> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	(
> +		cd root/r &&
> +		git init
> +	)
> +'
> +
> +test_expect_failure SUDO 'sudo git status as original owner' '
> +	(
> +		cd root/r &&
> +		git status &&
> +		sudo git status
> +	)
> +'
> +
> +# this MUST be always the last test
> +test_expect_success SUDO 'cleanup' '
> +	sudo rm -rf root
> +'
> +
> +test_done
> -- 
> 2.36.1.371.g0fb0ef0c8d
> 
