Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D4C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C462220728
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E7xFBeA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCCVld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:41:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59034 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCCVld (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 16:41:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E092443154;
        Tue,  3 Mar 2020 16:41:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WXJ+ZTP7BPQu
        DkYvgzLTDcGV1h0=; b=E7xFBeA6CPnh+TwyFKJh5JkVtDKIrrC4zkvDlPk6zi4Z
        iCEa3hNoTEAJauV5ey5XKCDhlRoD4U+e+oAcmJkbVb+n/OD3v5ObYreQ5+COJeTf
        C3dm9GOBSbS7FyJnrurw70wTyqDYZf9bf7PFptFx4i7A7itXlTcbfkw0hrhXmiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j1DEQv
        NOhUz/8M+27erTxQByZSWD4SmmwB2K18Q7c4XGkjDKwsOXFmNiGAv//xBui78RgH
        BQQp1uRAzw+LqlniLlljXmhwLOpf0e+dJyQzbi1QgxD+qa8RRC6isUMX4W2C73RS
        XrcOn0qUOtXYDYO6hQPYSxjKvsS5m74plem3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7E4943153;
        Tue,  3 Mar 2020 16:41:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D91743152;
        Tue,  3 Mar 2020 16:41:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Manish Devgan <manish.nsit8@gmail.com>
Subject: Re: [PATCH RESEND] remote-curl: show progress for fetches over dumb HTTP
References: <e387d31d-afab-fe09-4e37-535a2650afca@web.de>
Date:   Tue, 03 Mar 2020 13:41:26 -0800
In-Reply-To: <e387d31d-afab-fe09-4e37-535a2650afca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 3 Mar 2020 21:55:34 +0100")
Message-ID: <xmqq1rq986bd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD209C7C-5D97-11EA-AC6A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Fetching over dumb HTTP transport doesn't show any progress, even with
> the option --progress.  If the connection is slow or there is a lot of
> data to get then this can take a long time while the user is left to
> wonder if git got stuck.
>
> We don't know the number of objects to fetch at the outset, but we can
> count the ones we got.  Show an open-ended progress indicator based on
> that number if the user asked for it.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Original submission:
> https://lore.kernel.org/git/9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de=
/

Thanks.

>
>  remote-curl.c |  1 +
>  walker.c      | 13 ++++++++++++-
>  walker.h      |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 8eb96152f5..e4cd321844 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1026,6 +1026,7 @@ static int fetch_dumb(int nr_heads, struct ref **=
to_fetch)
>
>  	walker =3D get_http_walker(url.buf);
>  	walker->get_verbosely =3D options.verbosity >=3D 3;
> +	walker->get_progress =3D options.progress;
>  	walker->get_recover =3D 0;
>  	ret =3D walker_fetch(walker, nr_heads, targets, NULL, NULL);
>  	walker_free(walker);
> diff --git a/walker.c b/walker.c
> index bb010f7a2b..4984bf8b3d 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -8,6 +8,7 @@
>  #include "tag.h"
>  #include "blob.h"
>  #include "refs.h"
> +#include "progress.h"
>
>  static struct object_id current_commit_oid;
>
> @@ -162,6 +163,11 @@ static int process(struct walker *walker, struct o=
bject *obj)
>  static int loop(struct walker *walker)
>  {
>  	struct object_list *elem;
> +	struct progress *progress =3D NULL;
> +	uint64_t nr =3D 0;
> +
> +	if (walker->get_progress)
> +		progress =3D start_delayed_progress(_("Fetching objects"), 0);
>
>  	while (process_queue) {
>  		struct object *obj =3D process_queue->item;
> @@ -176,15 +182,20 @@ static int loop(struct walker *walker)
>  		 */
>  		if (! (obj->flags & TO_SCAN)) {
>  			if (walker->fetch(walker, obj->oid.hash)) {
> +				stop_progress(&progress);
>  				report_missing(obj);
>  				return -1;
>  			}
>  		}
>  		if (!obj->type)
>  			parse_object(the_repository, &obj->oid);
> -		if (process_object(walker, obj))
> +		if (process_object(walker, obj)) {
> +			stop_progress(&progress);
>  			return -1;
> +		}
> +		display_progress(progress, ++nr);
>  	}
> +	stop_progress(&progress);
>  	return 0;
>  }
>
> diff --git a/walker.h b/walker.h
> index 6d8ae00e5b..d40b016bab 100644
> --- a/walker.h
> +++ b/walker.h
> @@ -10,6 +10,7 @@ struct walker {
>  	int (*fetch)(struct walker *, unsigned char *sha1);
>  	void (*cleanup)(struct walker *);
>  	int get_verbosely;
> +	int get_progress;
>  	int get_recover;
>
>  	int corrupt_object_found;
> --
> 2.25.1
