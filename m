Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8789C433FE
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF61F60EDF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKJOuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhKJOuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:50:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9376C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:47:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ee33so11511452edb.8
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iCOFskeEpIu6Yc21XpP8EzQKvyubD1jsRR+OW12uMhA=;
        b=EqPvdgfj20sHRxJrjql70D0I8z/EforYUl8pbWuhUXSpXj2B7ZOqw3g40Vzhdn5z/Y
         9sXySI692I+e199vcMnerOKiJbE9ETh5pFwCvPpLKpx0ZWXuOkUrnnoGnBxZ3izOPiWS
         lMUTKPVPFWMUWF1SyxLKWzki/YXS7sIXm37RzFPtt/QKbyCn3du2oIZNqHKlY6cOAc+B
         hsAbsQjVNHOxscYdf4zsRt6P6jJxZjPE4QdGV5mNo/F1ke2x55KVTGrD30ioo2bkn2De
         vruEsaLT75OISABpPHp4ldBgUmEgX7/rtyK1UPvLWv05ognMYES2b+zlsNafDLxCy9xI
         rE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iCOFskeEpIu6Yc21XpP8EzQKvyubD1jsRR+OW12uMhA=;
        b=yIE/f/JAvUDlH1slGJIb3STtAYiECuZvmbE5ft//ziiPgmmnxfJlx9WNHGLjLk1L7o
         eYQt76iEX/hKUQQCDmMf+CSMKsIGWdvemQFImimt/nxwsW2GwV85sPbnmyQHhk3YDFtq
         WVRNSskG/ND9nWMaSFp6gCq2KvW5gdco0NBn5m0ahFjp5oZJcZOQj20YhjGjIJHPhE44
         auwU8vmscRZfDmIJvpiAKVo4HKro/0TPQNmBavDm087nEMDv8CzFLb1mxspqXHBJ3DmB
         ztyWiz4WxXy4WHuSEof98x337mdGCyMZZlezdZTjQ2EScGURw4iVjdf5lZtZ16S7oXTp
         gSrQ==
X-Gm-Message-State: AOAM532TqfprRl/TmXk0yTmTkyAvzeBXRayhd+lCU3+fXycvFfXp7wJe
        6ZTfbal1G8Al49+spHVU5LQ=
X-Google-Smtp-Source: ABdhPJx3LSOd8c/JqmFDIIbkmRpLE9mPJsQ51kmliO9PBOcsZRiNK/Zunh6afdU0Q5+g6W1CXNUCwQ==
X-Received: by 2002:a17:906:5641:: with SMTP id v1mr108567ejr.357.1636555652398;
        Wed, 10 Nov 2021 06:47:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dt4sm11657683ejb.27.2021.11.10.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:47:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkost-0011US-G1;
        Wed, 10 Nov 2021 15:47:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] wrapper: provide function to sync directories
Date:   Wed, 10 Nov 2021 15:40:24 +0100
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <3ac9d4d7abd224a4c0991f1036f2d95eedb9ceac.1636544377.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <3ac9d4d7abd224a4c0991f1036f2d95eedb9ceac.1636544377.git.ps@pks.im>
Message-ID: <211110.86zgqcgj98.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> In ec983eb5d2 (core.fsyncobjectfiles: batched disk flushes, 2021-10-04),
> we have introduced batched syncing of object files. This mode works by
> only requesting a writeback of the page cache backing the file on
> written files, followed by a single hardware-flush via a temporary file
> created in the directory we want to flush. Given modern journaling file
> systems, this pattern is expected to be durable.
>
> While it's possible to reuse the `git_fsync()` helper to synchronize the
> page cache only, there is no helper which would allow for doing a
> hardware flush of a directory by creating a temporary file. Other
> callers which want to follow the same pattern would thus have to repeat
> this logic.
>
> Extract a new helper `git_fsync_dir()` from the object files code which
> neatly encapsulates this logic such that it can be reused.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  bulk-checkin.c    | 13 +++----------
>  git-compat-util.h |  7 +++++++
>  wrapper.c         | 21 +++++++++++++++++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 4deee1af46..e6ebdd1db5 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -98,16 +98,9 @@ static void do_batch_fsync(void)
>  	 * hardware.
>  	 */
>  
> -	if (needs_batch_fsync) {
> -		struct strbuf temp_path = STRBUF_INIT;
> -		struct tempfile *temp;
> -
> -		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
> -		temp = xmks_tempfile(temp_path.buf);
> -		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> -		delete_tempfile(&temp);
> -		strbuf_release(&temp_path);
> -	}
> +	if (needs_batch_fsync &&
> +	    git_fsync_dir(get_object_directory()) < 0)
> +		die_errno("fsyncing object directory");

Nit: Similar to 1/3, but this message is new: We say "fsyncing object
directory", but it would be better to pass in some "verbose" flag to
git_fsync_dir() so we can say e.g.:

    error_errno(_("couldn't create core.fsyncRefFiles=batch tempfile '%s' in '%s'"), ...)
    error_errno(_("couldn't fsync() core.fsyncRefFiles=batch tempfile '%s' in '%s'"), ...)

I.e. being able to say specifically why we failed, permission error or
the tempfile? fsync() didn't work etc?

Looking at the underlying APIs maybe they already have a mode to "die"
or "warn" appropriately? Or...

> +int git_fsync_dir(const char *path)
> +{
> +	struct strbuf temp_path = STRBUF_INIT;
> +	struct tempfile *temp;
> +
> +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", path);
> +
> +	temp = mks_tempfile(temp_path.buf);
> +	if (!temp)
> +		return -1;
> +
> +	if (git_fsync(get_tempfile_fd(temp), FSYNC_HARDWARE_FLUSH) < 0)
> +		return -1;

...if they do maybe we should use their non-fatal mode, because
with/without that these "return -1" need to be "goto cleanup" so we can
attempt to clean up after ourselves here.

I think this whole thing would be better if we generalized tmp-objdir.h
a bit, so it could create and manage an arbitrary file in an arbitrary
directory, and that API should really be generalized to a user of
tempfile.c.

I.e. we'd then create this file, sync it optionally, whine if it does't
work, and be guaranteed to try to clean anything that goes wrong up
atexit().
