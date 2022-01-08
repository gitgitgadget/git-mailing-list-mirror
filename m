Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9469C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 04:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiAHEym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 23:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiAHEyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 23:54:41 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DB1C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 20:54:40 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id kk22so7591532qvb.0
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 20:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cKq4uYEA6hxDPmLFROu1JxMgv0yhT8AVkh2JOnu/VA=;
        b=WhJRhmba9vSC3pl4dTXNIU13zwlssTCGe5V0JVv2MHloex0C1ua7jBL2eebQN391Rx
         IX1NTjUy2VRRWws22U6TWwAL1moojf26nV7eta4UM9lcWOQXqnlAEn6Czt2xc1a2xplh
         7npiC8v2uJAOqR67mTYdbu2ghjsLlm01F//tmzGdQ4F0/JODmh0Hvlh/zUHmPUNnhAap
         u/gpk7aTmA670T2atyW7uQXjjJ8PMHWglORhb2q2A7Cgjs3BsOeR6SBofx2RHiHq8ags
         6EZIcTz854GyH5icbA+7ps8E4b90iYqLNMjuSkCWsCMxldvkzVgYkUKkxDnVPkIsYeDs
         ch9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cKq4uYEA6hxDPmLFROu1JxMgv0yhT8AVkh2JOnu/VA=;
        b=KcLmL+xqI2iXG8W4hFBUZsxPB96JkFt6QsFZgD5j9NK4qm+IA3Ci9HhjR5XLIVMl14
         XtAxZZp50dm5rwWGkbc24AyyK5gHl3UD3E3IOzY/6DA/SmelzQPDftKPtLKfORoLs4lu
         OOla827r7UDAzKFGDfqU0jRVlYrQfpPxJzCjqvGbucGRW273EobluYlPJv4d1dCUPNc/
         tMZgh97lN5ywlCVLqQQgGDhIX3qs16wFRThUGZ1QEFyf5eeeG+FReqhKYVPyGr+/ocxK
         2ExNtPrt9H3aT2qeAlzNwhIhiHCcLqHW2yxM2ciseDk18HFcPFxjiSZhXOfQEVGBlibB
         kUtw==
X-Gm-Message-State: AOAM533XvU0f5sr0Ro+QhrCOxwgoVeDT610il+Nw+rFfDn1TlqgVFLgH
        GGEnITREvF4h7sY8nRDJjJmz/j6+L/8FOg==
X-Google-Smtp-Source: ABdhPJz8YOAQ49n4TJ7LbkqEtZowqSZfWtNWq3znPNHzibNU/J0eRtQAuDet184eN0KOYu5oeN8DWA==
X-Received: by 2002:a05:6214:23c8:: with SMTP id hr8mr7961936qvb.26.1641617678838;
        Fri, 07 Jan 2022 20:54:38 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id 14sm408125qtx.84.2022.01.07.20.54.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jan 2022 20:54:38 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6] receive-pack.c: consolidate find header logic
Date:   Fri, 07 Jan 2022 23:54:38 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <AF6241F3-8AA9-4FD8-BCB1-21E0ED29E108@gmail.com>
In-Reply-To: <pull.1125.v6.git.git.1641499655700.gitgitgadget@gmail.com>
References: <pull.1125.v5.git.git.1641430309837.gitgitgadget@gmail.com>
 <pull.1125.v6.git.git.1641499655700.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On 6 Jan 2022, at 15:07, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> There are two functions that have very similar logic of finding a heade=
r
> value. find_commit_header, and find_header. We can conslidate the logic=

> by introducing a new function find_header_mem, which is equivalent to
> find_commit_header except it takes a len parameter that determines how
> many bytes will be read. find_commit_header and find_header can then bo=
th
> call find_header_mem.
>
> This reduces duplicate logic, as the logic for finding header values
> can now all live in one place.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>     Consolidate find_header logic into one function
>
>     This addresses the NEEDSWORK comment in builtin/receive-pack.c:
>
>      /**
>        * NEEDSWORK: reuse find_commit_header() from jk/commit-author-pa=
rsing
>        * after dropping "_commit" from its name and possibly moving it =
out
>        * of commit.c
>        **/
>
>
>     There are two functions that have very similar logic of finding a h=
eader
>     value. find_commit_header, and find_header. We can conslidate the l=
ogic
>     by introducing a new function find_header_mem, which is equivalent =
to
>     find_commit_header except it takes a len parameter that determines =
how
>     many bytes will be read. find_commit_header and find_header can the=
n
>     both call find_header_mem.
>
>     This reduces duplicate logic, as the logic for finding header value=
s can
>     now all live in one place.
>
>     Changes since v4:
>
>      * adjust verbiage of NEEDSWORK comment block
>
>     Changes since v3:
>
>      * added NEEDSWORK block detailing what needs to be done to clean u=
p
>        find_header_mem
>      * fixed verbiage in commit message
>      * adjusted style of an if block (based on Junio's feedback)
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
125%2Fjohn-cai%2Fjc%2Freplace-find-header-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1125=
/john-cai/jc/replace-find-header-v6
> Pull-Request: https://github.com/git/git/pull/1125
>
> Range-diff vs v5:
>
>  1:  02da3136c43 ! 1:  2b01d92b951 receive-pack.c: consolidate find hea=
der logic
>      @@ commit.c: struct commit_list **commit_list_append(struct commit=
 *commit,
>       +	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the =
range
>       +	 * given by len. However, current callers are safe because they=
 compute
>       +	 * len by scanning a NUL-terminated block of memory starting at=
 msg.
>      -+	 * Make this function safer by checking if the input is NUL-ter=
minated
>      -+	 * or has a NL between line[0] and msg[len].
>      ++	 * Nonetheless, it would be better to ensure the function does =
not look
>      ++	 * at msg beyond the len provided by the caller.
>       +	 */
>       +	while (line && line < msg + len) {
>        		const char *eol =3D strchrnul(line, '\n');
>
>
>  builtin/receive-pack.c | 33 ++++++++++-----------------------
>  commit.c               | 16 ++++++++++++++--
>  commit.h               |  5 +++++
>  3 files changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9f4a0b816cf..5c2732a0d07 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -581,32 +581,19 @@ static char *prepare_push_cert_nonce(const char *=
path, timestamp_t stamp)
>  	return strbuf_detach(&buf, NULL);
>  }
>
> -/*
> - * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing=

> - * after dropping "_commit" from its name and possibly moving it out
> - * of commit.c
> - */
>  static char *find_header(const char *msg, size_t len, const char *key,=

>  			 const char **next_line)
>  {
> -	int key_len =3D strlen(key);
> -	const char *line =3D msg;
> -
> -	while (line && line < msg + len) {
> -		const char *eol =3D strchrnul(line, '\n');
> -
> -		if ((msg + len <=3D eol) || line =3D=3D eol)
> -			return NULL;
> -		if (line + key_len < eol &&
> -		    !memcmp(line, key, key_len) && line[key_len] =3D=3D ' ') {
> -			int offset =3D key_len + 1;
> -			if (next_line)
> -				*next_line =3D *eol ? eol + 1 : eol;
> -			return xmemdupz(line + offset, (eol - line) - offset);
> -		}
> -		line =3D *eol ? eol + 1 : NULL;
> -	}
> -	return NULL;
> +	size_t out_len;
> +	const char *val =3D find_header_mem(msg, len, key, &out_len);
> +
> +	if (!val)
> +		return NULL;
> +
> +	if (next_line)
> +		*next_line =3D val + out_len + 1;
> +
> +	return xmemdupz(val, out_len);
>  }
>
>  /*
> diff --git a/commit.c b/commit.c
> index a348f085b2b..28391c3468d 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1631,12 +1631,20 @@ struct commit_list **commit_list_append(struct =
commit *commit,
>  	return &new_commit->next;
>  }
>
> -const char *find_commit_header(const char *msg, const char *key, size_=
t *out_len)
> +const char *find_header_mem(const char *msg, size_t len,
> +			const char *key, size_t *out_len)
>  {
>  	int key_len =3D strlen(key);
>  	const char *line =3D msg;
>
> -	while (line) {
> +	/*
> +	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
> +	 * given by len. However, current callers are safe because they compu=
te
> +	 * len by scanning a NUL-terminated block of memory starting at msg.
> +	 * Nonetheless, it would be better to ensure the function does not lo=
ok
> +	 * at msg beyond the len provided by the caller.
> +	 */

Let me know if this verbiage makes sense.

> +	while (line && line < msg + len) {
>  		const char *eol =3D strchrnul(line, '\n');
>
>  		if (line =3D=3D eol)
> @@ -1653,6 +1661,10 @@ const char *find_commit_header(const char *msg, =
const char *key, size_t *out_len
>  	return NULL;
>  }
>
> +const char *find_commit_header(const char *msg, const char *key, size_=
t *out_len)
> +{
> +	return find_header_mem(msg, strlen(msg), key, out_len);
> +}
>  /*
>   * Inspect the given string and determine the true "end" of the log me=
ssage, in
>   * order to find where to put a new Signed-off-by trailer.  Ignored ar=
e
> diff --git a/commit.h b/commit.h
> index 3ea32766bcb..38cc5426615 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -290,12 +290,17 @@ void free_commit_extra_headers(struct commit_extr=
a_header *extra);
>
>  /*
>   * Search the commit object contents given by "msg" for the header "ke=
y".
> + * Reads up to "len" bytes of "msg".
>   * Returns a pointer to the start of the header contents, or NULL. The=
 length
>   * of the header, up to the first newline, is returned via out_len.
>   *
>   * Note that some headers (like mergetag) may be multi-line. It is the=
 caller's
>   * responsibility to parse further in this case!
>   */
> +const char *find_header_mem(const char *msg, size_t len,
> +			const char *key,
> +			size_t *out_len);
> +
>  const char *find_commit_header(const char *msg, const char *key,
>  			       size_t *out_len);
>
>
> base-commit: c8b2ade48c204690119936ada89cd938c476c5c2
> -- =

> gitgitgadget
