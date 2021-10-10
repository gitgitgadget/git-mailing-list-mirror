Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E68CC433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A41B60F38
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhJJViq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhJJVip (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 17:38:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE9C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:36:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ec8so9846559edb.6
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=niGo6PLbUKhacGOTbc9+9N5qM7X6aKMlWqyIfOP8upE=;
        b=Va301s+a0HMz5zYPQ+VKroY1lNk+FLdkJxdalhGVjo9331FMUfh+cGBTnsUKLx478L
         Hv7dBfzRqXSh3nPh85B1H4K5ZooIIDWWV4UVoaMGSKZt3lMXxKCdUahZlTjB1tAcE2J+
         VTkwx6IcXGiTsCFO9U417QtrppMF2EjRDvg0dAFoUDL90Gm/Y8ykfWU2Eg/DrbAEjm78
         FsIZMlZ6qid/F7UsIED87tCeu82D1tk7qAtCnpeMCbI1Rljfb4yGfmjLzWcNt6sviawE
         rDvoKgCgmcQcS3GNrAov0J1P+EDNZiuol1d7KF5sFsCMOf9SX2f0z0F/PXvv83d6MD4S
         QtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=niGo6PLbUKhacGOTbc9+9N5qM7X6aKMlWqyIfOP8upE=;
        b=13kxXQvdIM6yPxhupqp6l6Lcv9gBy8dw3QfYE2tIaWliSkjm0aYVNqX3BpKkI5Zz5t
         n46wbfC9RbNIdY50LStYNdQCwMRoZ0Rz7gppM3eL1IrY9RMuqfonY1l61Y1+sQVzDvAe
         dC2JpgZ36/dTnx8Dwv5cc5kbf0FcPX5HZlz0Sm3lwls9M8UPB2F74jVvN/einqNb1TYu
         hFEaSqCfyb04Wg4rpl0SOfuvfeYv9gISXMy0npds0S+baFm92yAEYTabWBi77HFChPuB
         Y2jFYaOliIkDZOSK2p+gJrvBcfIX3W7BTStKIlcUCGQej4cOIW9j5eKirtyIEP9MVlb0
         pChQ==
X-Gm-Message-State: AOAM533OnZJ4RHKRcL+Dk57S9DA9gqZ+br2uiBDd31dNhSMfC6g9enqZ
        Ma6Kg0M3EICZyrMWWSQa9h8=
X-Google-Smtp-Source: ABdhPJwvdF7ZiI1cxOqBa2lhI1lZUPZuNWivTw7pu/rXPr3ZTDlCgN2IVjMO5gDBXdcuIJs/3i3apA==
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr36082835edl.97.1633901805109;
        Sun, 10 Oct 2021 14:36:45 -0700 (PDT)
Received: from szeder.dev (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id dd3sm2504759ejb.55.2021.10.10.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 14:36:44 -0700 (PDT)
Date:   Sun, 10 Oct 2021 23:36:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: try to re-chmod & retry on failed trash
 removal
Message-ID: <20211010213643.GD571180@szeder.dev>
References: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 09, 2021 at 03:31:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
> This fixes a regression in [1] where t0004-unwritable.sh was made to
> use "test_when_finished" for cleanup, we wouldn't re-chmod the
> ".git/objects" on failure, leading to a persistent error when running
> the test.
> 
> This can be demonstrated as e.g. (output snipped for less verbosity):
> 
>     $ ./t0004-unwritable.sh --run=3 --immediate
>     ok 1 # skip setup (--run)
>     ok 2 # skip write-tree should notice unwritable repository (--run)
>     not ok 3 - commit should notice unwritable repository
>     [...]
>     $ ./t0004-unwritable.sh --run=3 --immediate
>     rm: cannot remove '[...]/trash directory.t0004-unwritable/.git/objects/info': Permission denied
>     FATAL: Cannot prepare test area
>     [...]
> 
> I.e. if any of its tests failed, and the tests were being run under
> "--debug"[2] or "--immediate"[3] (which was introduced after [1]) we

'--debug' runs the tests as usual, including any 'test_when_finished'
commands, so I don't see how it would be affected.  And indeed running
'./t0004-unwritable.sh --run=3 --debug' repeatedly doesn't have any
issues with removing the trash directory of the previous run.

> wouldn't re-chmod the object directory. We'd then fail on the next run
> since the test setup couldn't remove the trash files.
> 
> Instead of some version of reverting [1] let's make the test-lib.sh
> resilient to this edge-case, it will happen due to [1], but also
> e.g. if the relevant "test-lib.sh" process is kill -9'd during the
> test run. We should try harder to recover in this case. If we fail to
> remove the test directory let's retry after (re-)chmod-ing it.
> 
> This doesn't need to be guarded by something that's equivalent to
> "POSIXPERM" since if we don't support "chmod" we were about to fail
> anyway. Let's also discard any error output from (a possibly
> nonexisting) "chmod", we'll fail on the subsequent "rm -rf"
> anyway.
> 
> The lack of &&-chaining between the "chmod" and "rm -rf" is
> intentional, if we fail the first "rm -rf", can't chmod, but then
> succeed the second time around that's what we were hoping for. We just
> want to nuke the directory, not carry forward every possible error
> code or error message.
> 
> 1. dbda967684d (t0004 (unwritable files): simplify error handling,
>    2010-09-06)
> 2. 5a4a088add3 (test-lib: do not remove trash_directory if called with
>    --debug, 2008-08-21)
> 3. b586744a864 (test: skip clean-up when running under --immediate
>    mode, 2011-06-27)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/test-lib.sh | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index aa1ad8180ed..706ce0cdeb9 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1210,10 +1210,10 @@ test_done () {
>  			error "Tests passed but trash directory already removed before test cleanup; aborting"
>  
>  			cd "$TRASH_DIRECTORY/.." &&
> -			rm -fr "$TRASH_DIRECTORY" || {
> +			remove_trash_directory "$TRASH_DIRECTORY" || {
>  				# try again in a bit
>  				sleep 5;
> -				rm -fr "$TRASH_DIRECTORY"
> +				remove_trash_directory "$TRASH_DIRECTORY"
>  			} ||
>  			error "Tests passed but test cleanup failed; aborting"
>  		fi
> @@ -1370,6 +1370,18 @@ then
>  	exit 1
>  fi
>  
> +# Try really hard to clean up our mess
> +remove_trash_directory() {
> +	dir="$1"
> +	if ! rm -rf "$dir"
> +	then
> +		say_color info >&3 "Failed to remove trash directory, trying to re-chmod it first..."

Is this message really necessary?  I don't think it is, and there was
no similar message in the previous hunk around that 'sleep 5' either.

> +		chmod -R u+w "$dir" 2>/dev/null
> +		rm -rf "$dir"
> +	fi
> +	! test -d "$dir"
> +}
> +
>  # Are we running this test at all?
>  remove_trash=
>  this_test=${0##*/}
> @@ -1388,7 +1400,7 @@ GNUPGHOME="$HOME/gnupg-home-not-used"
>  export HOME GNUPGHOME USER_HOME
>  
>  # Test repository
> -rm -fr "$TRASH_DIRECTORY" || {
> +remove_trash_directory "$TRASH_DIRECTORY" || {
>  	GIT_EXIT_OK=t
>  	echo >&5 "FATAL: Cannot prepare test area"
>  	exit 1
> -- 
> 2.33.0.1492.gcc3b81fc59a
> 
