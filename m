Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB8C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 07:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKYHbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKYHbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 02:31:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4762E9CF
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:31:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so3392953pjj.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eUmdbJd54TtGTnWVBvb2OKXDIXZm0RFRaA9TAniBlq4=;
        b=q4pKUTl0DlEK1w+Z1eugccj3P8Dy329+weq4AecNXfvrfZ761KAQdesj2sHSpWb6KP
         30ZTKT5+YPFnFFHst0ApQh7ZoOQjQv3NnsKCwaMSIFREIrx0w61TBzk1MIA/M6IeLRF9
         BWjkOQWXAPRaNNnvpyQmFNCsjSmfucBJTpSiAOIjeZlOxZTg6janHTO+LBQb3bvnc+F3
         86qTFH8+AT+WRQN/fGZiFO2yKNLKloyVELPNZ0ZSgJyiU6cJAVz3Lph7kMlwoMR/HQnz
         +WC6aaNfDNddeIDipuu1z8UDqsT/x9XTFPstRwtZuaIyyVxmqfrz0Ae5zfO/vh4za92O
         Xqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUmdbJd54TtGTnWVBvb2OKXDIXZm0RFRaA9TAniBlq4=;
        b=BC8SzPPwOFeJyzhKniFfw84ekU7F+JDWpJk+Oeg301taAexr+wdRNlcj19azI6RDpR
         O7hY0vPbyTE6pK6I3BonY4pKK4ijJPWnFPLHMv4CaQK8W+LhNYUh4qn883QoauncJ5bv
         afioxbsUnGLXGUisxI/78vBGw4RkVwBoR02+VfaI6sjWbRKaNv5G2bhvhk9aG4KhGWfl
         ezUXmZnkOy6zUfif7Gxnc8FHOB7WZ66VoLgsJLILXfCQTu4Wq9ejoE4O3kzyF8kzQEt0
         DsmvtGTk0Z8FIQ5g+LRJDgCwmB8bGx2+KW6kIqUEvc0Lpo0TMT/mSy0g3cLrxB8R3ayw
         CvzA==
X-Gm-Message-State: ANoB5pmeVLi0HyGPqQDi3hN5cLBi17SWvctHt2rocXq9oWHFaxl5L8Ug
        xCdlX1vGRGGLbW6eElxowlU=
X-Google-Smtp-Source: AA0mqf7LPOIdLW9CYvqBroV3FJ1apfE3KEbXhgodFXoOXBgVAz5nPKw8wmaj8HEAiqFEaBPqOkOjJQ==
X-Received: by 2002:a17:90a:f406:b0:219:9e8:84b2 with SMTP id ch6-20020a17090af40600b0021909e884b2mr2642646pjb.121.1669361466511;
        Thu, 24 Nov 2022 23:31:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001895b2d48a1sm534267plk.253.2022.11.24.23.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:31:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 2/6] fsmonitor: determine if filesystem is local or
 remote
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
        <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <e53fc07754094aa5ba8080ec7761869c6429a8af.1669230044.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 16:31:05 +0900
Message-ID: <xmqqedtrcwxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int is_remote_fs(const char* path) {

Style (asterisk sticks to the variable not to the type).

> +	switch (fs.f_type) {
> +		case 0x61636673:  /* ACFS */
> ...
> +		case 0xA501FCF5:  /* VXFS */
> +			return 1;
> +		default:
> +			break;
> +	}

Align case/default to switch by de-denting one level, just like you
did the switch() statement in find_mount().

> +static int find_mount(const char *path, const struct statvfs *fs,
> +	struct mntent *ent)
> +{
> +	const char *const mounts = "/proc/mounts";
> +	const char *rp = real_pathdup(path, 1);

Nobody seems to free() this once we are done with this function.

> +	struct mntent *ment = NULL;
> +	struct statvfs mntfs;
> +	FILE *fp;
> +	int found = 0;
> +	int dlen, plen, flen = 0;
> +
> +	ent->mnt_fsname = NULL;
> +	ent->mnt_dir = NULL;
> +	ent->mnt_type = NULL;

More on this later.

> +	fp = setmntent(mounts, "r");
> +	if (!fp) {
> +		error_errno(_("setmntent('%s') failed"), mounts);
> +		return -1;
> +	}
> +
> +	plen = strlen(rp);
> +
> +	/* read all the mount information and compare to path */
> +	while ((ment = getmntent(fp)) != NULL) {
> +		if (statvfs(ment->mnt_dir, &mntfs)) {
> +			switch (errno) {
> +			case EPERM:
> +			case ESRCH:
> +			case EACCES:
> +				continue;
> +			default:
> +				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
> +				endmntent(fp);
> +				return -1;
> +			}
> +		}
> +
> +		/* is mount on the same filesystem and is a prefix of the path */
> +		if ((fs->f_fsid == mntfs.f_fsid) &&
> +			!strncmp(ment->mnt_dir, rp, strlen(ment->mnt_dir))) {
> +			dlen = strlen(ment->mnt_dir);
> +			if (dlen > plen)
> +				continue;
> +			/*
> +			 * root is always a potential match; otherwise look for
> +			 * directory prefix
> +			 */
> +			if ((dlen == 1 && ment->mnt_dir[0] == '/') ||
> +				(dlen > flen && (!rp[dlen] || rp[dlen] == '/'))) {
> +				flen = dlen;
> +				/*
> +				 * https://man7.org/linux/man-pages/man3/getmntent.3.html
> +				 *
> +				 * The pointer points to a static area of memory which is
> +				 * overwritten by subsequent calls to getmntent().
> +				 */
> +				found = 1;
> +				free(ent->mnt_fsname);
> +				free(ent->mnt_dir);
> +				free(ent->mnt_type);
> +				ent->mnt_fsname = xstrdup(ment->mnt_fsname);
> +				ent->mnt_dir = xstrdup(ment->mnt_dir);
> +				ent->mnt_type = xstrdup(ment->mnt_type);
> +			}

So more than one mount entries could match the given path.  This
loop implements "the last one wins", but is that a sensible thing to
do?  Shouldn't it be more like "the longest one, being the most
specific, wins"?  If /usr mounts on / and /usr/local mounts on /usr,
asking for /usr/local/me would want to discover that it is on
the filesystem mounted at /usr/local regardless of the order in
which getmntent() returns the entries, no?

> +		}
> +	}
> +	endmntent(fp);
> +
> +	if (!found)
> +		return -1;
> +
> +	return 0;
> +}


> +
> +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
> +{
> +	struct mntent ment;
> +	struct statvfs fs;
> +
> +	if (statvfs(path, &fs))
> +		return error_errno(_("statvfs('%s') failed"), path);
> +
> +
> +	if (find_mount(path, &fs, &ment) < 0) {
> +		free(ment.mnt_fsname);
> +		free(ment.mnt_dir);
> +		free(ment.mnt_type);

It is a good idea to free, but I _think_ the code is easier to
follow if you _clear_ ment before calling find_mount(), not in
find_mount().

> +		return -1;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
> +			 path, fs.f_flag, ment.mnt_type, ment.mnt_fsname);
> +
> +	fs_info->is_remote = is_remote_fs(ment.mnt_dir);
> +	fs_info->typename = ment.mnt_fsname;
> +	free(ment.mnt_dir);
> +	free(ment.mnt_type);
> +
> +	if (fs_info->is_remote < 0) {
> +		free(ment.mnt_fsname);
> +		return -1;

fs_info->typename just started to point into an already freed memory
at this point, which is a very safe thing to do to the caller of
this function.

Rather, perhaps delay the setting of typename after this statement,
which would be more friendly to the caller than telling them that
they are not allowed to touch the member when the function returns
negative.

> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"'%s' is_remote: %d",
> +				path, fs_info->is_remote);
> +
> +	return 0;
> +}
> +
> +int fsmonitor__is_fs_remote(const char *path)
> +{
> +	struct fs_info fs;
> +
> +	if (fsmonitor__get_fs_info(path, &fs))
> +		return -1;
> +
> +	free(fs.typename);
> +
> +	return fs.is_remote;
> +}
> +
> +/*
> + * No-op for now.
> + */
> +int fsmonitor__get_alias(const char *path, struct alias_info *info)
> +{
> +	return 0;
> +}
> +
> +/*
> + * No-op for now.
> + */
> +char *fsmonitor__resolve_alias(const char *path,
> +	const struct alias_info *info)
> +{
> +	return NULL;
> +}
