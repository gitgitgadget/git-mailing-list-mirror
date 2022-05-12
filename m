Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C798C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 16:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356385AbiELQRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356392AbiELQRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 12:17:16 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E50BCEB1
        for <git@vger.kernel.org>; Thu, 12 May 2022 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652372213;
        bh=LhRLz8GxXkoKmbXHhOsqEWY9Ynkpx1/qRFF/xi0XU2I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f+Upz7A4/ugItsGqKIAxqjKfBiDJnjvB2MY0qJXmk8Dqp4dnC8xjEkxP/p03W7dX8
         XIkDRa9lDeVVs2qlNEiR701A2KdSsqWNNQjAT47wpS3RkgFyjUQSVmmf3/Fr+/5sUm
         tqPq4tjX9flXsMaew4euxs7P3Vlx3Kz+zO3X4uyI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.145.161]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1o6APj46S7-00sWdo; Thu, 12
 May 2022 18:16:53 +0200
Message-ID: <47ed5a2f-f4aa-1ec1-27c9-9b0b70eb8bca@web.de>
Date:   Thu, 12 May 2022 18:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
 <xmqqtu9x6ovh.fsf@gitster.g> <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
 <xmqq8rr955zf.fsf@gitster.g> <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de>
 <xmqqzgjnkgy0.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqzgjnkgy0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jicOOmrFtUOTQATx669G1hZXjV7aG1RWBpa3fLOTHLjlOyMbFJr
 3n94+qaBLMbZ2JuKOsTR6VA1iUsp2H4xZOvHzRMC7ZqVwkzmPXmMG3kHLocW8Y9pQaoEA+y
 C6tRNW0/ZxJl9UDhxgp3TX97B6TF0F3qzBpxN0Ne/WJolJ3iZNFyOf/a55r/NRCuJ7vnJep
 TdbwQugZttU5f5/mYG5rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eojMwRmA4E8=:o28eqcgyy2SC38Jx2/7jyp
 xmKId48ELKmTn+/Od9+pzX/HTz4iuiooJt0DstFhpkL3SBD9dmat95HyhlDERPA7i26blwEu/
 SGlN8zNP6wChaGH+IJgnxKAF1aOTHSAElAz5SPwhD6jDHFpqTRxkZXFs0Bjv57EGerCf5dMo0
 uFx87UQklyVjAb76n5yHXj7yDNAfYLSNgY8X1SBsUthS88sqle0jjs86S7F+OohydR4KFY+CR
 Ldzt0+K5chMkQwTIvouXT0/Py5bSk36IdLAhxG6WDhMSVGdq1TRtcyVVXY5myEWpV2T08oLli
 CdkzhQZurD8aN8yDbyvaLl5YztTuX9VFMDGgULzOmCeWewl1ecqIXJjwA+Q3ttToN1i1BLeWh
 zstv3X8A98ZtKdgHHkW5Nd88xkVrElCmqZHRrFe7urLbAXUlQFWiZ/G33VgdeA3FS8iZ6HmqF
 OAbbOCwfJbvSey2q6R+wy1mce0c9IsRnyIxSGIcZAnULN+o+D36Ux1EUxWghqKnSdcu0nFdfL
 WZ5/uiXqKmQRtPZUWo0foRqpEjJFFKf2ZFQ34vAb3WihJgJyWQy4lWyEP0+Hzbz/zRgxIh+L2
 ntG4zWj63M+D6M9huA8aUxV0zwtmhpang7ad9ABZI/L42DZGP31WpDv5pvFnc3PWrKFvUvbe2
 UoP7vWamxbWKeGWGGtl0TCdQMvQOiMC8LTA4aE9ci+5JOJGlggVAe4nOxp8utyoWdv9jHbc6C
 7C6QNhuEHUgnXGbE891XmX19cW/5gpdryGcIKRE5qodvF+SKujLawUtgE4EtXLHPpI2hteSj6
 7461lvEpYItXjobIigEfDOP38OLI0AtBVh0nTLIqIW85ROvchgoDOmd2kU1nbKL2CoQX9+c2z
 p+wCau44ywi34AVgjpx0CtsPG0tQWRfJna3T7beANVkgxKp1U3Gv0RdEQrs/cpJMvV409JhfA
 ZAfeFxDz/00jIhVnAR6DjyPpDnQYtWWCipgmXvP1PLbUV5gAyz1doomZ9U6mZeQhUoLsVWtp7
 wHILjRBfbmB+uvg8VjO+0TDdgUjjL2vJyzcsqoV3nRmSasuktQCVeLt7QJ7YL/QDFw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.22 um 21:27 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Regarding file modes: We only effectively support the executable bit,
>> so an additional option --add-virtual-executable-file=3D<path>:<content=
s>
>> would suffice.
>
> While I do not think we want to support more than one "is it
> executable or not?" bit, I am not so sure about what the current
> code does, though, for these "not from a tree, but added as extra
> files" entries.
>
> If you add an extra file from an on-disk untracked file, the
> add_file_cb() callback picks up the full st.st_mode for the file,
> and write_archive_entries() in its loop over args->extra_files pass
> the full info->stat.st_mode down to write_entry(), which is used by
> archive-tar.c::write_tar_entry() to obtain mode bits pretty much
> as-is.

Good point.  write_tar_entry() actually normalizes the permission bits
and applies tar.umask (0002 by default):

	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
		*header.typeflag =3D TYPEFLAG_DIR;
		mode =3D (mode | 0777) & ~tar_umask;
	} else if (S_ISLNK(mode)) {
		*header.typeflag =3D TYPEFLAG_LNK;
		mode |=3D 0777;
	} else if (S_ISREG(mode)) {
		*header.typeflag =3D TYPEFLAG_REG;
		mode =3D (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;

But write_zip_entry() only normalizes (drops) the permission bits of
non-executable files:

                attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
                        (mode & 0111) ? ((mode) << 16) : 0;
                if (S_ISLNK(mode) || (mode & 0111))
                        creator_version =3D 0x0317;

attr2 corresponds to the field "external file attributes" mentioned in
the ZIP format specification, APPNOTE.TXT.  It's interpreted based on
the "version made by" (creator_version here); that 0x03 part above
means "UNIX".  The default is MS-DOS (FAT filesystem), with effectivly
no support for file permissions.

So we currently leak permission bits of executable files into ZIP
archives, but not tar files. :-|  Normalizing those to 0755 would be
more consistent.

> For tracked paths, we probably are normalizing the blobs
> between 0644 and 0755 way before the values are passed as "mode"
> parameter to the write_entry() functions, but for these extra files,
> there is no such massaging.

Right, mode values from read_tree() pass through canon_mode(), so only
untracked files (those appended with --add-file) are affected by the
leakage mentioned above.

Ren=C3=A9
