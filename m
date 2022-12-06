Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D247C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 19:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLFTrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFTrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 14:47:13 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E7731F9A
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670356029; bh=MQEE5drMd6d20f1FB6MGWqdSeZ/xnzJazFZfTxbys2I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=YGd/sfJG9fMc5hcUfKs3y6LO5nVmdXQtBaB/NMSw84IJUbHbIiDWEr0mS5BKzYKDV
         BAQehFnS/cjxDNrocIk/Z1vEPcL07evBr9NcDNNb/8IKmsPHBd+V+rUpssMNxJz45C
         MNSXTaz8+OIWgzQGJ5LlJuZpTmri9lEYJ+WxE/MB7DTn/VqLj3iM4UeLWHn5WsmEDG
         LW/Q1AYRMG9DqFpBMi+wESE0jcd46wqzge1YI7qkVtHSDaLqvToxDM4yg8C7SHtxbO
         o5pQ+MwIz1coHNHHcSzsQlLbAhajj6IdSAKyNFtVGm/pfY1kBE0+QZ/JhyS7A/lxvY
         wwBHGmkIBJqkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.23]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1VF-1oPAos2NHb-00dLvQ; Tue, 06
 Dec 2022 20:47:09 +0100
Message-ID: <f49b915e-46d1-7e53-ae4f-b01c2028b70d@web.de>
Date:   Tue, 6 Dec 2022 20:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        git@vger.kernel.org
References: <20221205190019.52829-1-cgzones@googlemail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20221205190019.52829-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sOEVY5W4hM/DUrPqm+GBNtlbJ8PxpvygFzXMsZxasWLCZ7xBzP4
 5VPiVVLg+Pcyfazy6vI7PV0s3K2jECjg8VZ5LdusQEgamtvl+mp8dKAhf/TwwMZxYdeBSLV
 j+4D11psHj9U7qu0kx7AigyeonDWkorzlnvHkwxIsAErQafqgUaZEEKg84pLPKINCxcqifO
 eOUJK3Ym+aLrm+/i2/ZUQ==
UI-OutboundReport: notjunk:1;M01:P0:p1FhCgCIVvc=;3dtfSNfKfDdtyzwuLHRnK1FVHa7
 TDSl/JIBMi6fboEZi0hF2uuhbtByavG2BYkwxl7+LZEDpC+x8A8Tm1tRB9kE1u0SkdnRj/sN3
 t+eneP40PJ70qBB2cuxCb8oiQWK/nKv0kIalb+ZhmpL9Jenc7vN1IESK2cHt87FJAlswnNt5o
 cnB5gOLPw07AUh2dPGDnvQb6lqpBJmW0hoVIeQmaZlY7/8+M2OxNDTAqYIM1aJE7Fhxqo92fR
 AISiq+zJgsP5hnv5wHNhc8nFWo5hHHJrmLP3jKOP2XgzJDNXrljaB1Gh1KLBwdWG1/nN0z5WK
 S5dEQrhwuoPcfE9TwEYJAX1RqFAuNukLe8ZU4/Rth1++21cU+ScTkXkuS4FoIuWnIfwfcjXj7
 iDCzUW+M5YVT/OFGOzpScXqGKgmb30ETLISs/NiB50L+w/LrqSY0W5Hyuix1WKJM/o2PkgIJG
 rOtKV9cDCr07nmu8SmOOwhOIEe6yjIy+cUfDiMyCr7Y1I0z0Zfcvpg+H5lKzy8nhjfL4jxElM
 EMKFM6aASDaoVeUMStIR2kf1FDaBwI/iRpCWWJC8FXnAhyk18VFqzJ1a2dKhYlHaQLSBdqPlR
 sIkfrQ0Ya+fswJIxWvwiRwbKDvoQE4cEbt5aVhQoaR6+99o8Ie0IOYQ4lTl6niUQ4eNgA6C+H
 osqcB8busOW62TTxoAwQ/C7Dl1FAPoscp7wS9YrqULassgWgJDOj2T8QJ2jkNbMv9C1Rgxlyu
 0hxQjDZBlEcaesCxk0NMUkqW8gjY7xRkBFOj8I963iOfjI4RXdL2XcE+nZPw1tUKgF124LR8C
 e7OAEffdRK2eymT4bHr81EFDg8Fxlbkk9F6q537k9HJNWRVmuisvl0+vJmyzwXjaEp72gz35P
 QaD9/usSrd/z1//mj377bb9E9aJ3dmnUDF/8qKtvDbrUacoVFTW3/sUSZsBKkMKLIET38dAAS
 4BpDBA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.22 um 20:00 schrieb Christian G=C3=B6ttsche:
> Commit 57f5d52a942 ("common-main: call sanitize_stdfds()") added the
> sanitization for standard file descriptors (stdin, stdout, stderr) to
> all binaries.  The lead to all binaries unconditionally opening
> /dev/null with the flag O_RDWR (read and write).  Most of the time the
> standard file descriptors should be set up properly and the sanitization
> ends up doing nothing.
>
> There are many non modifying git operations, like `git status` or `git
> stash list`, which might be called by a parent to gather information
> about the repository.  That parent might run under a seccomp filter to
> avoid accidental modification or unwanted command execution on memory
> corruptions.  As part of that seccomp filter open(2) and openat(2) might
> be only allowed in read-only mode (O_RDONLY), thus preventing git's
> sanitation and stopping the application.
>
> Check before opening /dev/null to populate a possible non-present
> standard file descriptor if actually any is missing.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> Alternatively one could add a command line argument
> (`--no-stdfd-sanitization`).
> ---
>  setup.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index cefd5f6..2af7170 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1669,7 +1669,14 @@ const char *resolve_gitdir_gently(const char *sus=
pect, int *return_error_code)
>  /* if any standard file descriptor is missing open it to /dev/null */
>  void sanitize_stdfds(void)
>  {
> -	int fd =3D xopen("/dev/null", O_RDWR);
> +	int fd;
> +
> +	if (fcntl(0, F_GETFD) !=3D -1 &&
> +	    fcntl(1, F_GETFD) !=3D -1 &&
> +	    fcntl(2, F_GETFD) !=3D -1)
> +		return;
> +
> +	fd =3D xopen("/dev/null", O_RDWR);
>  	while (fd < 2)
>  		fd =3D xdup(fd);
>  	if (fd > 2)

If read-only access is allowed, how about this?

diff --git a/setup.c b/setup.c
index cefd5f63c4..0f52c51759 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -1669,7 +1669,12 @@ const char *resolve_gitdir_gently(const char *suspe=
ct, int *return_error_code)
 /* if any standard file descriptor is missing open it to /dev/null */
 void sanitize_stdfds(void)
 {
-	int fd =3D xopen("/dev/null", O_RDWR);
+	int fd =3D xopen("/dev/null", O_RDONLY);
+	if (fd > 0)
+		close(fd);
+	if (fd > 2)
+		return;
+	fd =3D xopen("/dev/null", O_WRONLY);
 	while (fd < 2)
 		fd =3D xdup(fd);
 	if (fd > 2)

Requires an extra open/close pair if fd 0 is already open, but no extra
syscalls if 0, 1 and 2 are all open.

Can opening /dev/null (or NUL on Windows) multiple times instead of dup'in=
g
cause issues?  Can we e.g. lock ourselves out?

Ren=C3=A9

