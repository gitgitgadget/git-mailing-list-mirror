Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF921F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeKXM6T (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 07:58:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57443 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeKXM6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 07:58:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32C323455F;
        Fri, 23 Nov 2018 21:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6cYBSeBgPkd0
        WKlRfCL/Dce+REA=; b=xjp7z5B1crmzgYbopmcSeyhgto6AYcZSiSFbcqXajCA4
        Rl0zoFR1NDnPYg6fLDuC3Mq+ai41kcARbeCx9TusMTH8FhZDO30Ue8bb3RshL50h
        VB9pjbFLh86khlpUxxKfdeG4PmsOhSH2d4qMgxDC2+vGyL+o3ee6zVNgdGoV/2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FLFVIG
        3CJIiulexegdmpXD7nJ/S+o/qYvaXb7M65Ig6uYtpXgE7uAz5TqsiSC98fs2veSC
        QRcxfYFj3eUnsMcO1Rf6FY/UXnL0wxApgmCe5oWO1gbH+9WrfoonKJDa10Q92FJr
        Vfj/LaVD4ucxyYOVc7llbHHcQuZ4JAp5Ij/7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B8343455E;
        Fri, 23 Nov 2018 21:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3AC913455D;
        Fri, 23 Nov 2018 21:11:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
        <87muq2zoy9.fsf@evledraar.gmail.com>
        <20181122175259.GC22123@sigill.intra.peff.net>
Date:   Sat, 24 Nov 2018 11:11:36 +0900
In-Reply-To: <20181122175259.GC22123@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 22 Nov 2018 12:53:00 -0500")
Message-ID: <xmqqefbb442v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4688D322-EF8E-11E8-BF87-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, my intent had been to circle back around to this, but I just
> hadn't gotten to it. I'm still pondering a config option or similar,
> though I remain unconvinced that the cases in which you've showed it
> being slow are actually realistic or worth worrying about (and certainl=
y
> having an obscure config option is not enough to help most people). If
> we could have it kick in heuristically, that would be better.

Me neither and I agree.

> However, note that the cache-load for finding abbreviations _must_ have
> the complete list. And has been loading it for some time. So if you run
> "git-fetch", for example, you've already been running this code for
> months (and using the cache in more places is now a free speedup).
>
> At the very least, we'd want this patch on top, too. I also think Ren=C3=
=A9's
> suggestion use access() is worth pursuing (though to some degree is
> orthogonal to the cache).

OK, will queue, but I wonder where 66f0 comes from before silently
doing s/66f04152be/3a2e08245c/ myself.



> -- >8 --
> Subject: [PATCH] odb_load_loose_cache: fix strbuf leak
>
> Commit 66f04152be (object-store: provide helpers for
> loose_objects_cache, 2018-11-12) moved the cache-loading code from
> find_short_object_filename(), but forgot the line that releases the pat=
h
> strbuf.
>
> Reported-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1-file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sha1-file.c b/sha1-file.c
> index 5894e48ea4..5a272f70de 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -2169,6 +2169,7 @@ void odb_load_loose_cache(struct object_directory=
 *odb, int subdir_nr)
>  				    NULL, NULL,
>  				    &odb->loose_objects_cache);
>  	odb->loose_objects_subdir_seen[subdir_nr] =3D 1;
> +	strbuf_release(&buf);
>  }
> =20
>  static int check_stream_sha1(git_zstream *stream,
