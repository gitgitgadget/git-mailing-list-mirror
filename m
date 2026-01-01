Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3571E7660
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767278984; cv=none; b=IZLZv8hKhMgrGk6Kavr5+S8zYOq+MSISBRUpdjrnd8xrkfETjYh0LsxZoHayLpwLsUhgS48ULCy03NSlV9sqZPPw7PKkVBI6deDto+exmmDo7OCo5AeIQHvOQRKmQJxFA7uAbxBSENx1UB3p9F9KvmZyTXT9AGEHBlro/hfaxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767278984; c=relaxed/simple;
	bh=WNwps+QEcce6Snw+wbvsL7QKBoksSv1Qts3h0aMukG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C1ZXMydv0LiRTsYSir8wgP1MBl3XwH/CJBjQ7Ey7l61zgAVymnjAJGt1wlEVWFsTVzU3SHKTQ4Xstime1bvyWjhouAN3D8GjLPUB3oaQPUjDKI17iTewZoPqnp/6fbG6D5CyaCzVEuWPJodrhsKQVDR513/sKuaLE04Wook8cu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=UhnbZeLE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="UhnbZeLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767278977; x=1767883777;
	i=johannes.schindelin@gmx.de;
	bh=fFj1dV8Pofy+/BjqfQD6JBZXw2eajfuxZtPgFWNcDEQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UhnbZeLE3ErOy2t3Se/ivfKGJmEK0ok4I2XQCqgFOtRS66+hxdZic2PBCIM1rZ1t
	 Jb3mArBbj2NJ1x36oBui5VryaDk8ZqEIdQsqNsXFElIXcU/g3RNHSiOMn69AWfwth
	 GSqPoWUtkIvccO7sTYvAspA/gSHIBBfwSWWJU1iJseQdHKdZiO3Cn0WEaAYzIgvfS
	 ntgDm77t1ptGh6NIVjNbwbqulAcpa0fyaSJtXd0kpUMs+JdiZucpYu04DDOQzjTth
	 UQ/RhPpQIbi68159XQ+GDA867VyH3RzW8VbOr4ZmDC0ZETMJUkpqvzN63WKj8v5E8
	 9K8jNTBb7B11p/rwOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1vZg6J1dYs-004rnE; Thu, 01
 Jan 2026 15:49:37 +0100
Date: Thu, 1 Jan 2026 15:49:36 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
In-Reply-To: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
Message-ID: <699e6041-3cb8-a039-dc42-38a81f5df94c@gmx.de>
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MQh2NmFVY/yfuMbTDGTlY8rJeaRy+DNegTX7unc/mj59mwvLbCT
 FzSS94/LaRJTnQc7GfpB/GN48uBeXnIkED/dCPeHooHiM6ScSp8FJCPs7BTivhPdUJzzfOC
 wHQpLG+BFowFcmTLuT80H+nlmR3GRKFK1foGEu2A48tKFIXWJJNAERWiiH34xHWAUjHfF29
 sAJKTqc2p0nD0aDThp0Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QsPlt1cIYkY=;8O+l2yckf02r4RSLM95RNh0o78B
 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
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, 1 Jan 2026, Paul Tarjan via GitGitGadget wrote:

> From: Paul Tarjan <github@paulisageek.com>
>=20
> The "difftool --dir-diff syncs worktree without unstaged change" test
> fails intermittently, particularly on Windows CI.
>=20
> The test modifies a file in difftool's temp directory via an extcmd
> script and expects the change to be synced back to the worktree. The
> sync-back detection relies on git's change detection mechanisms.
>=20
> The root cause is that the original file content and the replacement
> content have identical sizes:
>=20
>   - Original: "main\ntest\na\n" =3D 12 bytes
>   - New:      "new content\n"   =3D 12 bytes
>=20
> When difftool creates the temporary index (wtindex), the cache entries
> have sd_size =3D 0 (zero-initialized via make_cache_entry with no
> refresh). Git's ie_modified() is designed to handle this by calling
> ce_modified_check_fs() for content hashing when sd_size is 0.
>=20
> However, Windows has known filesystem issues that may cause this to
> fail intermittently:
>=20
>  - UNRELIABLE_FSTAT: Windows fstat() on open files may not return the
>    same information as lstat() after close (config.mak.uname:506)
>=20
>  - NTFS timestamp issues: The racy-git documentation notes that NTFS
>    is "still broken" regarding timestamp granularity between in-core
>    and on-disk representations (Documentation/technical/racy-git.adoc)
>=20
>  - Attribute caching: Windows GetFileAttributesExW may cache results
>=20
> Fix this by changing the replacement content to "modified content\n"
> (17 bytes), ensuring the change is detected at the earliest size
> comparison in match_stat_data(), bypassing any platform-specific edge
> cases in the more complex code paths.
>=20
> Note: Other tests with same-size file patterns (t0010-racy-git.sh,
> t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
> because they use normal Git index operations with proper racy git
> detection. The difftool case is unique due to its ephemeral wtindex
> created via make_cache_entry() without full stat refresh.
>=20
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---

Nice! This test case indeed is flaky, and the analysis looks sound.

If anything, I would add that Git relies on the inode to change when
nothing else is different (file size, mtime, etc), but on Windows, there
are no inodes.

For what it's worth, this issue is actually a real-world problem, not just
a side effect observed exclusively in test scenarios, see e.g.
https://github.com/git-for-windows/git/issues/5132 for a bug report about
Git's being challenged with changes that aren't reflected by file
size/mtime differences.

Side note: There is _something_ similar to inodes for NTFS (called
`nFileIndexHigh`/`nFileIndexLow`), but it has no equivalent with FAT
filesystems and is therefore not really a solution in general. See
https://github.com/git-for-windows/msys2-runtime/pull/17 for an excellent
demonstration of the consequences of trying to emulate inodes for FAT
filesystems.

Another side note: Having said all that about "no solution in general",
there _is_ a ticket in Git for Windows to try to address this:
https://github.com/git-for-windows/git/issues/3707. The major challenge
with _that_ is that users sometimes have to access the same Git worktrees
using different Git implementations (e.g. Git for Windows and an Ubuntu
Git via the Windows Subsystem for Linux), and if the stat information
between those implementations does not match, the Git index will be
considered eternally "dirty".

All this is to say: Thank you for working on this flake and addressing it.
Feel free to add a Reviewed-by: trailer with my ident, if you want.

Thanks!
Johannes

>     t7800: fix racy "difftool --dir-diff syncs worktree" test
>    =20
>     In
>     https://github.com/git/git/actions/runs/20624095002/job/59231745784#=
step:5:416
>     this test failed for me on an unrelated commit. I had Claude look in=
to
>     it and it thought that this could be a racy git problem. I'm skeptic=
al
>     but a) I don't know the source well enough and b) the fix is low ris=
k so
>     I thought I'd send it to you folks. Everything below is the AI gener=
ated
>     explanation.
>    =20
>     The "difftool --dir-diff syncs worktree without unstaged change" tes=
t
>     fails intermittently, particularly on Windows CI.
>    =20
>     The test modifies a file in difftool's temp directory via an extcmd
>     script and expects the change to be synced back to the worktree. The
>     sync-back detection relies on git's change detection mechanisms.
>    =20
>     The root cause is that the original file content and the replacement
>     content have identical sizes:
>    =20
>      * Original: "main\ntest\na\n" =3D 12 bytes
>      * New: "new content\n" =3D 12 bytes
>    =20
>     When difftool creates the temporary index (wtindex), the cache entri=
es
>     have sd_size =3D 0 (zero-initialized via make_cache_entry with no
>     refresh). Git's ie_modified() is designed to handle this by calling
>     ce_modified_check_fs() for content hashing when sd_size is 0.
>    =20
>     However, Windows has known filesystem issues that may cause this to =
fail
>     intermittently:
>    =20
>      * UNRELIABLE_FSTAT: Windows fstat() on open files may not return th=
e
>        same information as lstat() after close (config.mak.uname:506)
>    =20
>      * NTFS timestamp issues: The racy-git documentation notes that NTFS=
 is
>        "still broken" regarding timestamp granularity between in-core an=
d
>        on-disk representations (Documentation/technical/racy-git.adoc)
>    =20
>      * Attribute caching: Windows GetFileAttributesExW may cache results
>    =20
>     Fix this by changing the replacement content to "modified content\n"=
 (17
>     bytes), ensuring the change is detected at the earliest size compari=
son
>     in match_stat_data(), bypassing any platform-specific edge cases in =
the
>     more complex code paths.
>    =20
>     Note: Other tests with same-size file patterns (t0010-racy-git.sh,
>     t2200-add-update.sh, t1701-racy-split-index.sh) are not vulnerable
>     because they use normal Git index operations with proper racy git
>     detection. The difftool case is unique due to its ephemeral wtindex
>     created via make_cache_entry() without full stat refresh.
>    =20
>     Signed-off-by: Paul Tarjan github@paulisageek.com
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-21=
49%2Fptarjan%2Fclaude%2Ffix-difftool-test-DDxDC-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2149/=
ptarjan/claude/fix-difftool-test-DDxDC-v1
> Pull-Request: https://github.com/git/git/pull/2149
>=20
>  t/t7800-difftool.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index bf0f67378d..8a91ff3603 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -647,21 +647,21 @@ test_expect_success SYMLINKS 'difftool --dir-diff =
=2D-symlinks without unstaged ch
>  '
> =20
>  write_script modify-right-file <<\EOF
> -echo "new content" >"$2/file"
> +echo "modified content" >"$2/file"
>  EOF
> =20
>  run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged cha=
nge' '
>  	test_when_finished git reset --hard &&
>  	echo "orig content" >file &&
>  	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
> -	echo "new content" >expect &&
> +	echo "modified content" >expect &&
>  	test_cmp expect file
>  '
> =20
>  run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged =
change' '
>  	test_when_finished git reset --hard &&
>  	git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
> -	echo "new content" >expect &&
> +	echo "modified content" >expect &&
>  	test_cmp expect file
>  '
> =20
>=20
> base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
> --=20
> gitgitgadget
>=20
>=20
