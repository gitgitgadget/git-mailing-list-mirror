Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE7C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355799AbiELPLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355812AbiELPLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:11:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D12608EB
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652368277;
        bh=rAGIGMDCj+AC5NtrO6VIP7JojbBLyElmByEbmHJ5SPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b/MuQGTHoM0HvYlAI8Zld/gX3FiB2PfTL92RWspLdVW+Q5SUJ1LR0I6GuitBqn1zl
         aFeBQKOM2nuPaZ6TYv+Iuge0f3/0ZIUHH9rDjx+GJ9mu8+V5k9HnmSSuuMNg7buoXz
         OLXOXSfSfczl7WjIobCjFilgJE9mQev/T1ttZExo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([213.196.213.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1oM2FY2l3Z-00bu4X; Thu, 12
 May 2022 17:11:17 +0200
Date:   Thu, 12 May 2022 17:11:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 23/28] fsmonitor: never set CE_FSMONITOR_VALID on
 submodules
In-Reply-To: <d0e25f6bac663e9ae4d63322f102378dd2ecba84.1650662994.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205121709210.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <d0e25f6bac663e9ae4d63322f102378dd2ecba84.1650662994.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BiZGWfYD2BT5+02lZOomox7UZkck98qkest8suJldEnnF+2czcJ
 MDbV++10H4TfYgGDKQymVClPf9Qn+Ulm2QIC1j7IuyBtUKm9XH3D5hwPTA2YWng1rcA5KC7
 7qoD7tHj21jBpLD5jWok//AibMIWIBtmmbrybkGhRGQArW0VY/n6x1F4PvWwN/PLhbOU3Du
 ZhcQxkk7CsBUVp1k844gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qc91myQjjUg=:IpzupQT4ODSYKqulUBgdQY
 ADjKWAGcS1NEeoRIHceNEbhPlDQbPBw10keGXZaJ2oHgT1QIEUea65HYbkU4Bbl5mvE1yj22k
 v9r/inMGvRLSP+OINkCE/H5GA4tQyhKkoikfzDkUmGYrXdnQggUFjwsioV6sbpctVOM18aG/5
 mxF3jHZMoghiCfSRhzhbfNgnrhRrmuj7ozyHGacZnnba3yATBk4csuNC3QYYSY3I0MLGX1yvs
 QdRpR5dTOQqxwIUkMJSkxqVN6i81oehxOaHUW9E+DwGk3GK4oH9E+99HOopUx0fw71T6/ku5d
 xuPo/U59/u2GN7Hm20szldWG+3VFga0irpJ9sPX6/nZFzmuzYiRWd0Xaypqq5aaULKAv+YAe8
 ymrZEoKAP0pDW+AZ4Kg8+id5TQ4aS96ydN6azmULbSs8fosO/ZrgARoPBTe3SHXOgCvKsmgej
 UzoBVnWq32izTjtUVr6mps4X2Lz7U6nUewGctiFtJlTHtfH1Lle9dIShTIYbQ1vk+vpVP72y8
 2IiSmRnVPFJL8cv3fPoWo70dSnvJ9IVdt/rMdRTNzJt+hU6iJYnnwVjPhMnwBTJLBReECfZeP
 TznSFGeh6pQ+7JFYXgtUqoBGelXPmBURkiXQyeB8tplf0tpuavfEm6yXf8iZYC+PQVom5bxla
 47kerTLZ0Z/+v+c/qni80vjkfHcukypANUZJy6bOZFlaWrCAE4h3t4HqeRAeXIfe2LTj0DymV
 dZeRgQbPR7q8yDBcCnCBfeIdRjEBJDWnWr6/eMIoeDK3asrL8Ufc6h7R7/f149ZuGxx+JVmGG
 GQtkErGETeIK9o9JHXHFBsls41etP3/QKJIG9nyrhl85kk/AaCLKh6bwVCOYrETIdRLfRDbCa
 +kVOZUnYxrXnE75eRhZLu7tvM2oqpgN1bOQpqPa2AwwIvB4/bUC5/iEBwy0QIa87BjcFLkwKF
 3bqO4daMQhKNMXQGucg+PS2Sm+z3wU8PWhG02/JQ8ncs1E0/HwPYdPBc9DA7lOYz0ywlDn4De
 Vm4W75f6QgTEZruGP6bqDX1NUKh8P29jQnnv8/w1u5zPX30kiDHhhT09+cHYxFnwim5qiOBd4
 WAdWHS7Wrt1kDM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Never set CE_FSMONITOR_VALID on the cache-entry of submodule
> directories.
>
> During a client command like 'git status', we may need to recurse
> into each submodule to compute a status summary for the submodule.
> Since the purpose of the ce_flag is to let Git avoid scanning a
> cache-entry, setting the flag causes the recursive call to be
> avoided and we report incorrect (no status) for the submodule.
>
> We created an OS watch on the root directory of our working
> directory and we receive events for everything in the cone
> under it.  When submodules are present inside our working
> directory, we receive events for both our repo (the super) and
> any subs within it.  Since our index doesn't have any information
> for items within the submodules, we can't use those events.
>
> We could try to truncate the paths of those events back to the
> submodule boundary and mark the GITLINK as dirty, but that
> feels expensive since we would have to prefix compare every FS
> event that we receive against a list of submodule roots.  And
> it still wouldn't be sufficient to correctly report status on
> the submodule, since we don't have any space in the cache-entry
> to cache the submodule's status (the 'SCMU' bits in porcelain
> V2 speak).  That is, the CE_FSMONITOR_VALID bit just says that
> we don't need to scan/inspect it because we already know the
> answer -- it doesn't say that the item is clean -- and we
> don't have space in the cache-entry to store those answers.
> So we should always do the recursive scan.
>
> Therefore, we should never set the flag on GITLINK cache-entries.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  fsmonitor.c                  |   2 +
>  fsmonitor.h                  |  11 ++++
>  t/t7527-builtin-fsmonitor.sh | 111 +++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index e1229c289cf..57d6a483bee 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -580,6 +580,8 @@ void tweak_fsmonitor(struct index_state *istate)
>  		if (fsmonitor_enabled) {
>  			/* Mark all entries valid */
>  			for (i =3D 0; i < istate->cache_nr; i++) {
> +				if (S_ISGITLINK(istate->cache[i]->ce_mode))
> +					continue;
>  				istate->cache[i]->ce_flags |=3D CE_FSMONITOR_VALID;
>  			}
>
> diff --git a/fsmonitor.h b/fsmonitor.h
> index 3f41f653691..edf7ce5203b 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -68,6 +68,15 @@ static inline int is_fsmonitor_refreshed(const struct=
 index_state *istate)
>   * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
>   * called any time the cache entry has been updated to reflect the
>   * current state of the file on disk.
> + *
> + * However, never mark submodules as valid.  When commands like "git
> + * status" run they might need to recurse into the submodule (using a
> + * child process) to get a summary of the submodule state.  We don't
> + * have (and don't want to create) the facility to translate every
> + * FS event that we receive and that happens to be deep inside of a
> + * submodule back to the submodule root, so we cannot correctly keep
> + * track of this bit on the gitlink directory.  Therefore, we never
> + * set it on submodules.
>   */
>  static inline void mark_fsmonitor_valid(struct index_state *istate, str=
uct cache_entry *ce)
>  {
> @@ -75,6 +84,8 @@ static inline void mark_fsmonitor_valid(struct index_s=
tate *istate, struct cache
>
>  	if (fsm_mode > FSMONITOR_MODE_DISABLED &&
>  	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
> +		if (S_ISGITLINK(ce->ce_mode))
> +			return;
>  		istate->cache_changed =3D 1;
>  		ce->ce_flags |=3D CE_FSMONITOR_VALID;
>  		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->n=
ame);
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index d0e681d008f..4c49ae5a684 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -721,4 +721,115 @@ do
>  	'
>  done
>
> +# Test fsmonitor interaction with submodules.
> +#
> +# If we start the daemon in the super, it will see FS events for
> +# everything in the working directory cone and this includes any
> +# files/directories contained *within* the submodules.
> +#
> +# A `git status` at top level will get events for items within the
> +# submodule and ignore them, since they aren't named in the index
> +# of the super repo.  This makes the fsmonitor response a little
> +# noisy, but it doesn't alter the correctness of the state of the
> +# super-proper.
> +#
> +# When we have submodules, `git status` normally does a recursive
> +# status on each of the submodules and adds a summary row for any
> +# dirty submodules.  (See the "S..." bits in porcelain V2 output.)
> +#
> +# It is therefore important that the top level status not be tricked
> +# by the FSMonitor response to skip those recursive calls.  That is,
> +# even if FSMonitor says that the mtime of the submodule directory
> +# hasn't changed and it could be implicitly marked valid, we must
> +# not take that shortcut.  We need to force the recusion into the
> +# submodule so that we get a summary of the status *within* the
> +# submodule.
> +
> +create_super () {
> +	super=3D"$1" &&
> +
> +	git init "$super" &&
> +	echo x >"$super/file_1" &&
> +	echo y >"$super/file_2" &&
> +	echo z >"$super/file_3" &&
> +	mkdir "$super/dir_1" &&
> +	echo a >"$super/dir_1/file_11" &&
> +	echo b >"$super/dir_1/file_12" &&
> +	mkdir "$super/dir_1/dir_2" &&
> +	echo a >"$super/dir_1/dir_2/file_21" &&
> +	echo b >"$super/dir_1/dir_2/file_22" &&
> +	git -C "$super" add . &&
> +	git -C "$super" commit -m "initial $super commit"
> +}
> +
> +create_sub () {
> +	sub=3D"$1" &&
> +
> +	git init "$sub" &&
> +	echo x >"$sub/file_x" &&
> +	echo y >"$sub/file_y" &&
> +	echo z >"$sub/file_z" &&
> +	mkdir "$sub/dir_x" &&
> +	echo a >"$sub/dir_x/file_a" &&
> +	echo b >"$sub/dir_x/file_b" &&
> +	mkdir "$sub/dir_x/dir_y" &&
> +	echo a >"$sub/dir_x/dir_y/file_a" &&
> +	echo b >"$sub/dir_x/dir_y/file_b" &&
> +	git -C "$sub" add . &&
> +	git -C "$sub" commit -m "initial $sub commit"
> +}
> +
> +my_match_and_clean () {
> +	git -C super --no-optional-locks status --porcelain=3Dv2 >actual.with =
&&
> +	git -C super --no-optional-locks -c core.fsmonitor=3Dfalse \
> +		status --porcelain=3Dv2 >actual.without &&
> +	test_cmp actual.with actual.without &&
> +
> +	git -C super/dir_1/dir_2/sub reset --hard &&
> +	git -C super/dir_1/dir_2/sub clean -d -f
> +}
> +
> +test_expect_success "Submodule always visited" '

I almost feel bad offering this nit: could you use single-quotes, and
start with a lower-case `s`?

Thanks,
Dscho

> +	test_when_finished "git -C super fsmonitor--daemon stop; \
> +			    rm -rf super; \
> +			    rm -rf sub" &&
> +
> +	create_super super &&
> +	create_sub sub &&
> +
> +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
> +	git -C super commit -m "add sub" &&
> +
> +	start_daemon -C super &&
> +	git -C super config core.fsmonitor true &&
> +	git -C super update-index --fsmonitor &&
> +	git -C super status &&
> +
> +	# Now run pairs of commands w/ and w/o FSMonitor while we make
> +	# some dirt in the submodule and confirm matching output.
> +
> +	# Completely clean status.
> +	my_match_and_clean &&
> +
> +	# .M S..U
> +	echo z >super/dir_1/dir_2/sub/dir_x/dir_y/foobar_u &&
> +	my_match_and_clean &&
> +
> +	# .M S.M.
> +	echo z >super/dir_1/dir_2/sub/dir_x/dir_y/foobar_m &&
> +	git -C super/dir_1/dir_2/sub add . &&
> +	my_match_and_clean &&
> +
> +	# .M S.M.
> +	echo z >>super/dir_1/dir_2/sub/dir_x/dir_y/file_a &&
> +	git -C super/dir_1/dir_2/sub add . &&
> +	my_match_and_clean &&
> +
> +	# .M SC..
> +	echo z >>super/dir_1/dir_2/sub/dir_x/dir_y/file_a &&
> +	git -C super/dir_1/dir_2/sub add . &&
> +	git -C super/dir_1/dir_2/sub commit -m "SC.." &&
> +	my_match_and_clean
> +'
> +
>  test_done
> --
> gitgitgadget
>
>
