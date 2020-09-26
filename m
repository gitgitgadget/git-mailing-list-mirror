Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D8C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268DD21527
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LRpKXwz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgIZQXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 12:23:48 -0400
Received: from mout.web.de ([212.227.17.11]:56701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbgIZQXs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 12:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1601137422;
        bh=wN8kLxtHNZYzSKgh/HRUZ21rHrNhjtT7cTZIWpUrn4I=;
        h=X-UI-Sender-Class:From:Subject:To:References:Cc:Date:In-Reply-To;
        b=LRpKXwz2e8fM32G0snx/qGP8bC4keUu0GKkqqUrckgLiqzw9d7yDJNNoLEtc/Zphr
         W0OhWZP4tYm+gSKxS0lXEn2ZzA2posibBGIEn69/+CWYYQvNMUSPtgIz0xs4IHy2JQ
         rujmsh3Py7+7H24dlQafvVS0RxbP0pZqb6wQsE68=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLt5-1kT7Sj2GVr-011fXF; Sat, 26
 Sep 2020 18:23:42 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200925055954.1111389-1-gitster@pobox.com>
 <20200925055954.1111389-3-gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>
Message-ID: <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
Date:   Sat, 26 Sep 2020 18:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925055954.1111389-3-gitster@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F5GDTEdToEBWKZU++IayprODC76iqxBXxx86SFPssghJkttjXjz
 UMQV4s4VMnHLSdF41/4B1BGbSHxY/PzNmf1oR01TIQQAAzL0/I8PmNOyRi/KRO5sOYWVKiu
 tiyK9bhXowVohZR1DuJrdyoL2+18D1pybNvExX8xqjylYqmx6pwKsnXRiMLS/Gwe6fgQUS8
 Izn9iw4FT7xIfu+TQDtEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TPtgSday8Wk=:83Y1MKkiLa2m/mLq12BOaD
 0h6TxkPPOihvjngp1NRy5Dl9i3hEScg4+EeNWV7uw7M7Fh9z8kZ6Owv4qle8sa80zK4Tfzcqm
 CitVJKqQDJQ1Wh5CPXHIc4R1ecQpzh8kyNFaoZfe1q9a6cttuDDyQhZ02qJUBN3TF8TaouHby
 k6XgRh3rzd+TFk+I/X0VPN8X5KjhZumeD32unkNg6dgHO/0YwFUgG2ugK64za9dOEH9IlNzZU
 BoxYHJvHe8uh5zD4eIkYNUgxZ+5p1Paw0/2D6FNu0JVTbyBJfmVWdrrx14i2GBO8TR95/bD0y
 HC8qQ+KBqwA2GbSxLriANRrjd10WX3nBhACSGhm+QP7zPT21hzL0RysNhsMIG2d7N/OHLpDmA
 FXZyX1lds3DviLZRFj7hqs4ksrW2UYiMODQXQ25NpLP3oedlLrcq8RN258NuhxSZIujL/1dUt
 iqLJ7/mAxcjoBZqHabwjSaiT90IR4zjwfnqzkbU/3dGQ3nuoDFG2xWFfeVL04Glmeffd+eqJH
 NZMKpx0U1WF0L9YMw5hjmKEjHqCNki47nGpGs0Pf4LhZ7gESCwAvioNF64lAt6XkWNsNOSqpv
 fZAh8byVq2rUkD0+q7DF4HRtK7WD8RBdn3Azdjyx48Q+QsF46LMJj2u9Y+YVSbMo00770vfac
 sF2GACfk+XK2BIIxZFnFfj0GIQ6q03yBazPKYS7wDh2bI4glsuTtOiybKV+txjtj6uuuzIVUO
 Q+2Hz4/bKaQIAcNthF9O0mES2KOvxxM2hjIaSiirNibem8ZKr6M0zoM9kx5HmyeHcBTFPzjw4
 QrLoygw1T48cZOVfuGqecLceqgnthE9rOQQAkKSbNuwUUSAKfgCWLiaG3ykYfvLbKMNie3d51
 /CDMKQD8L6F8/qZsBSHGVQdcyXc8KMU6B1B5DTsPJjmgcXuKfxWsggWcdOmNUyFPm9YRm/DmC
 aM3hUbF4NGfVtjJpE7JJLyCMGXZSDIw+4SZIwuJgldP7a6dlR3fO3xtePu26T+g2hp/eIX1Pc
 BufEgcw+8UAaDjUdHzyMeQpyDz6nv3d4ymnXzx4bmuDb9PL1UxowXycFXNrlUgJVLJJzl6rw8
 mJTsBcz6wzT2frvgbSs0VKdh6rwviLjc/6peDmZxEAjIxlehFSm67nNMKgWzAlp/MirjrrvP6
 lHYjgv9owPN4WNdGYKgs577B2W4kQRPo9CE8aTm3IDMyXrpCzHV95PzY+mqNBgpz2smMGr5b2
 rbk7vzyaSC6pLP37W
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.09.20 um 07:59 schrieb Junio C Hamano:
> The command reads list of object names to place on the ignore list
> either from the command line or from a file, but they are not
> checked with their object type (those read from the file are not
> even checked for object existence).
>
> Extend the oidset_parse_file() API and allow it to take a callback
> that can be used to die (e.g. when an inappropriate input is read)
> or modify the object name read (e.g. when a tag pointing at a commit
> is read, and the caller wants a commit object name), and use it in
> the code that handles ignore list.

What's the benefit of such a check?  Ignoring a non-existing or
type-mismatched object is really easy -- no actual effort is required to
fulfill that request.

When I request "Don't eat any glue!", perfectly human responses could be
"But I don't have any glue!" or "It doesn't even taste that good.", but
I'd expect a computer program to act I bit more logical and just don't
do it, without talking back.  Maybe that's just me.

(I had been bitten by a totally different software adding such a check,
which made it complain about my long catch-all ignore list, and I had to
craft and maintain a specific "clean" list for each deployment --
perhaps I'm still bitter about that.)

>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/blame.c              | 27 ++++++++++++++++++++++++--
>  oidset.c                     |  9 ++++++++-
>  oidset.h                     |  9 +++++++++
>  t/t8013-blame-ignore-revs.sh | 37 ++++++++++++++++++++++++++----------
>  4 files changed, 69 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 94ef57c1cc..baa5d979cc 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -27,6 +27,7 @@
>  #include "object-store.h"
>  #include "blame.h"
>  #include "refs.h"
> +#include "tag.h"
>
>  static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [<=
rev>] [--] <file>");
>
> @@ -803,6 +804,26 @@ static int is_a_rev(const char *name)
>  	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
>  }
>
> +static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
> +{
> +	struct repository *r =3D ((struct blame_scoreboard *)cbdata)->repo;
> +	struct object_id oid;
> +
> +	oidcpy(&oid, oid_ret);
> +	while (1) {
> +		struct object *obj;
> +		int kind =3D oid_object_info(r, &oid, NULL);
> +		if (kind =3D=3D OBJ_COMMIT) {
> +			oidcpy(oid_ret, &oid);

At that point we know it's an object, but cast it up to the most generic
class we have -- an object ID.  We could have set an object flag to mark
it ignored instead, which would be trivial to check later.  On the other
hand it probably wouldn't make much of a difference -- hashmaps are
pretty fast, and blame has lots of things to do beyond ignoring commits.

> +			return 0;
> +		}
> +		if (kind !=3D OBJ_TAG)
> +			return -1;
> +		obj =3D deref_tag(r, parse_object(r, &oid), NULL, 0);
> +		oidcpy(&oid, &obj->oid);
> +	}
> +}
> +
>  static void build_ignorelist(struct blame_scoreboard *sb,
>  			     struct string_list *ignore_revs_file_list,
>  			     struct string_list *ignore_rev_list)
> @@ -815,10 +836,12 @@ static void build_ignorelist(struct blame_scoreboa=
rd *sb,
>  		if (!strcmp(i->string, ""))
>  			oidset_clear(&sb->ignore_list);

This preexisting feature is curious.  It's even documented ('An empty
file name, "", will clear the list of revs from previously processed
files.') and covered by t8013.6.  Why would we need such magic in
addition to the standard negation (--no-ignore-revs-file) for clearing
the list?  The latter counters blame.ignoreRevsFile as well. *puzzled*

>  		else
> -			oidset_parse_file(&sb->ignore_list, i->string);
> +			oidset_parse_file_carefully(&sb->ignore_list, i->string,
> +						    peel_to_commit_oid, sb);
>  	}
>  	for_each_string_list_item(i, ignore_rev_list) {
> -		if (get_oid_committish(i->string, &oid))
> +		if (get_oid_committish(i->string, &oid) ||
> +		    peel_to_commit_oid(&oid, sb))
>  			die(_("cannot find revision %s to ignore"), i->string);
>  		oidset_insert(&sb->ignore_list, &oid);
>  	}
> diff --git a/oidset.c b/oidset.c
> index 15d4e18c37..2d0ab76fb5 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -42,6 +42,12 @@ int oidset_size(struct oidset *set)
>  }
>
>  void oidset_parse_file(struct oidset *set, const char *path)
> +{
> +	oidset_parse_file_carefully(set, path, NULL, NULL);
> +}
> +
> +void oidset_parse_file_carefully(struct oidset *set, const char *path,
> +				 oidset_parse_tweak_fn fn, void *cbdata)
>  {
>  	FILE *fp;
>  	struct strbuf sb =3D STRBUF_INIT;
> @@ -66,7 +72,8 @@ void oidset_parse_file(struct oidset *set, const char =
*path)
>  		if (!sb.len)
>  			continue;
>
> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0')
> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0' ||
> +		    (fn && fn(&oid, cbdata)))

OK, so this turns the basic all-I-know-is-hashes oidset loader into a
flexible higher-order map function.  Fun, but wise?  Can't make up my
mind.

Ren=C3=A9
