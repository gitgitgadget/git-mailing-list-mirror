Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2DC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiGMN1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiGMN1M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:27:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA6B480
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657718824;
        bh=RwBPpDx3fM3sIbuzWjHNdkTvCzjeMPg8rZDw3iTWE+A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PpjqmtdkLxNO4KgJZhxrNOOgzKlYem0tCUSg1GkV8I+GEcDrINCrI8ZvEDGKQ6EkO
         Bg2O94XIcKJmEpoL4LUm/nSIO45VGowfrWX/nwGBeS8LekFzDov1t4173IBP3jgOtY
         beMGXFdzE3WZzh7Bh5Ed2d2djRwDQW1I6Ev+4NU8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.180.6] ([213.196.212.225]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1oBcOO2cAC-0005Zx; Wed, 13
 Jul 2022 15:27:04 +0200
Date:   Wed, 13 Jul 2022 15:27:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] *: use allowlist and denylist
In-Reply-To: <8aaceedb7a8f9d95550ef4a2d147c837ede6acec.1657718450.git.gitgitgadget@gmail.com>
Message-ID: <r5351157-0p62-7rp4-p254-04rn0r63o515@tzk.qr>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com> <8aaceedb7a8f9d95550ef4a2d147c837ede6acec.1657718450.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iw0sO6nMUX03jMgEhNkILWpg9AZ5GueXrwcYwKoAkd1GKqtmqAp
 hibVHk1HwkTKjFMobUfgK/scUyUUOwmDYebNSu1YF8W32yOSG8VcXcVTXzCL1NEnz/O8/1n
 DFIwC4jQy4/7VJHljH7BmFU9uqvJ5FqPQqh6R7MSyinzXS+exkLCUBcnyd+HnQ6ZC+skX4A
 iNrFXCMHoYoh+LneaXDmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YPZgn/sccCo=:2oSVADeVeg4bD/ZWCLjxoX
 QDOtfYNjc2FJDUWzUvgC2/PfVKSHw9tag0SB4pJiGAdvosZ85D4o+UPTmrhU7V4U9AIGAv1LA
 Xmf+o0gUEvOJ5LvLfYE7idbTNWz9gTj19Im7ipP354fhuKQGHkeqMlOwUtGKgRuxKbVHiMY0C
 qpo6aobmjdVxybWBXHmubcIjLDyJkFX4fJmkyCR5gi0PWAQrLA95xNeS/TVHaPgcPRTvAJxHd
 r4knlPYPM5gJOriPYvmwYIMF6XBBS+AVBDb8G8+kMAPj73Tv5NhP+E0DdZjNz24moQaWZBYeU
 Qmcj6F9CxJY0zxxN+77u5/6Xvw5+K7OglXwsxAESBlKwsnn37qLJeyHam8P8dNp6MIuSkwAlb
 YFg0GaGYArXUwzaLuyz92AZPWXNsUakcedwSayaydu4ZyNDLIlr8ykYJUcZUs4+N71+DOA/Xk
 EBHNVZzsiJSUzr4oWbNK9XGKUSp3mpmJnhNn1yODsa1RJ0WpVx0uWqTVx8Gtq8qgxfRa+Z5fG
 U4RW3XkV4+z5tiX9YXQWxQhBvhbJ2EbFKhQwqvEeCZLYNblGzPUdrCIov45SjMmYeK4eg0aFP
 rxhliSN2IOgcJ2musfC7I1tW0plh4PaP7+FpEBq4vNm7HBHqALF3cuOGkPdjU0Os0GOS/H2zg
 BOHuPda88w3yM0PDoi/J2H6DttGKl0xurONo5yOrdvLIIunPMyprfv9GsWoXssmJtnxTHgA38
 FwR68sAgADXDZZBFesJ58ZRs/qweHJ0sYdqOLYodhG0YpeP4NsOanutp46QaQHTJbKAxAyeqg
 3QQyikEs6okZNxprgsF/yyd74jjQohHqpi3j6282qzwAPC3CtUwuutjvf3Bb3cBvOf5VfnN6Z
 XbSSi8k9s6u1CEm4kIwswAIx/XENPMGrkg8BnNMRQ9t+Dzw6Xs6wG/+P0wPcZzOEUUgzQA1is
 o51uGc+WuosM8gCloEqCM70svieLS5w0XqbjnoYugY8y9xvINlztDUgkM0J68gG3+w6mbUrgk
 IGvy/kO1RoQgJhYn2isYtiFHfIYu0zVhn1IJH0uu+NGv6w+pBk4WXxgNqesdUBiBco/M+z92n
 gYZCYex8tLL4mmTKTRq79o7cRGxXPKhE22EwFWil4hHK1Z0Q6JhXv3pUpe+oJh4SWAXhqqXYg
 FdO58=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 13 Jul 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Using "allowlist" and "denylist" is a more precise definition of the
> functionality they provide. The previous color-based words assume
> cultural interpretation to provide the meaning.
>
> These changes to the Git codebase are mostly cosmetic. Several comments
> are updated. The renamed protocol_allowlist() method is local to
> transport.c so does not update any header file API definition. There are
> some untranslated error messages that are reworded, so this _might_
> affect error parsers. However, two of the three error messages are
> around option parsing, so they are "fast failures". The one perhaps
> meaningful change is the logerror() in daemon.c.

I do consider `git daemon` less important these days because we have two
transports that are secure (which `git://` is not): HTTPS and SSH. That
suggests that the `daemon.c` change might have a very low impact to begin
with.

The other changes affect `cvsserver` which I consider even less important.
In fact, I would be in favor of deprecating it soon and of deleting it in
due time.

All the changes in this patch look good to me: ACK!

Thank you!
Dscho

>
> After this change, the only remaining uses of the previous words are
> in release notes for older versions of Git.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  daemon.c           |  8 ++++----
>  git-cvsserver.perl |  2 +-
>  sha1dc/sha1.c      | 12 ++++++------
>  transport.c        |  8 ++++----
>  4 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 58f1077885c..ed7c53b1110 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -279,7 +279,7 @@ static const char *path_ok(const char *directory, st=
ruct hostinfo *hi)
>  		/* The validation is done on the paths after enter_repo
>  		 * appends optional {.git,.git/.git} and friends, but
>  		 * it does not use getcwd().  So if your /pub is
> -		 * a symlink to /mnt/pub, you can whitelist /pub and
> +		 * a symlink to /mnt/pub, you can allowlist /pub and
>  		 * do not have to say /mnt/pub.
>  		 * Do not say /pub/.
>  		 */
> @@ -298,7 +298,7 @@ static const char *path_ok(const char *directory, st=
ruct hostinfo *hi)
>  			return path;
>  	}
>
> -	logerror("'%s': not in whitelist", path);
> +	logerror("'%s': not in allowlist", path);
>  	return NULL;		/* Fallthrough. Deny by default */
>  }
>
> @@ -403,7 +403,7 @@ static int run_service(const char *dir, struct daemo=
n_service *service,
>  	 * a "git-daemon-export-ok" flag that says that the other side
>  	 * is ok with us doing this.
>  	 *
> -	 * path_ok() uses enter_repo() and does whitelist checking.
> +	 * path_ok() uses enter_repo() and does allowlist checking.
>  	 * We only need to make sure the repository is exported.
>  	 */
>
> @@ -1444,7 +1444,7 @@ int cmd_main(int argc, const char **argv)
>  		cred =3D prepare_credentials(user_name, group_name);
>
>  	if (strict_paths && (!ok_paths || !*ok_paths))
> -		die("option --strict-paths requires a whitelist");
> +		die("option --strict-paths requires a allowlist");
>
>  	if (base_path && !is_directory(base_path))
>  		die("base-path '%s' does not exist or is not a directory",
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 4c8118010a8..7d13b0a5ac1 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -152,7 +152,7 @@ $state->{allowed_roots} =3D [ @ARGV ];
>
>  # don't export the whole system unless the users requests it
>  if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
> -    die "--export-all can only be used together with an explicit whitel=
ist\n";
> +    die "--export-all can only be used together with an explicit allowl=
ist\n";
>  }
>
>  # Environment handling for running under git-shell
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index dede2cbddf9..b4a5f23c1ec 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -86,30 +86,30 @@
>         defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || =
\
>         defined(__sparc))
>  /*
> - * Should define Big Endian for a whitelist of known processors. See
> + * Should define Big Endian for a allowlist of known processors. See
>   * https://sourceforge.net/p/predef/wiki/Endianness/ and
>   * http://www.oracle.com/technetwork/server-storage/solaris/portingtoso=
laris-138514.html
>   */
>  #define SHA1DC_BIGENDIAN
>
> -/* Not under GCC-alike or glibc or *BSD or newlib or <processor whiteli=
st> */
> +/* Not under GCC-alike or glibc or *BSD or newlib or <processor allowli=
st> */
>  #elif (defined(_AIX) || defined(__hpux))
>
>  /*
> - * Defines Big Endian on a whitelist of OSs that are known to be Big
> + * Defines Big Endian on a allowlist of OSs that are known to be Big
>   * Endian-only. See
>   * https://lore.kernel.org/git/93056823-2740-d072-1ebd-46b440b33d7e@fel=
t.demon.nl/
>   */
>  #define SHA1DC_BIGENDIAN
>
> -/* Not under GCC-alike or glibc or *BSD or newlib or <processor whiteli=
st> or <os whitelist> */
> +/* Not under GCC-alike or glibc or *BSD or newlib or <processor allowli=
st> or <os allowlist> */
>  #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
>  /*
>   * As a last resort before we do anything else we're not 100% sure
> - * about below, we blacklist specific processors here. We could add
> + * about below, we denylist specific processors here. We could add
>   * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
>   */
> -#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor w=
hitelist> or <os whitelist> or <processor blacklist> */
> +#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor a=
llowlist> or <os allowlist> or <processor denylist> */
>
>  /* We do nothing more here for now */
>  /*#error "Uncomment this to see if you fall through all the detection"*=
/
> diff --git a/transport.c b/transport.c
> index 52db7a3cb09..321bbe382cc 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -940,7 +940,7 @@ static int external_specification_len(const char *ur=
l)
>  	return strchr(url, ':') - url;
>  }
>
> -static const struct string_list *protocol_whitelist(void)
> +static const struct string_list *protocol_allowlist(void)
>  {
>  	static int enabled =3D -1;
>  	static struct string_list allowed =3D STRING_LIST_INIT_DUP;
> @@ -1020,9 +1020,9 @@ static enum protocol_allow_config get_protocol_con=
fig(const char *type)
>
>  int is_transport_allowed(const char *type, int from_user)
>  {
> -	const struct string_list *whitelist =3D protocol_whitelist();
> -	if (whitelist)
> -		return string_list_has_string(whitelist, type);
> +	const struct string_list *allowlist =3D protocol_allowlist();
> +	if (allowlist)
> +		return string_list_has_string(allowlist, type);
>
>  	switch (get_protocol_config(type)) {
>  	case PROTOCOL_ALLOW_ALWAYS:
> --
> gitgitgadget
>
