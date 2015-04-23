From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 02/16] refs: convert for_each_tag_ref to struct object_id
Date: Thu, 23 Apr 2015 11:13:32 -0700
Message-ID: <CAGZ79kas9QgJy1ooCjHPR+ZGGuTdMhTxO9zSMxnGpPk8rG5_xQ@mail.gmail.com>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
	<1429745061-295908-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:13:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlLd5-0007yI-9j
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 20:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbbDWSNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 14:13:34 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34287 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030405AbbDWSNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 14:13:33 -0400
Received: by iedfl3 with SMTP id fl3so75386124ied.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=USFW04ceuvuutWv1mbyQmYMAYl1YGb2tf1JFTZ97Qak=;
        b=CQWZBkEwROOfHmLKxZhEqZhUpD/1ltd0OHBIcbudfgnEkHspRANvSFHKWA1KC6pWqs
         moEW1xy47bSnmudOSMXw1358aXoJX04vNAPiatFvBfiONVEygiKN8ODPeo0A3aHcW2Qm
         mbTF71ODEqzfXME/sg3mip9dgdQ2Tq1EZ3PUWlnKz5DhgoZ+xmaDUo5BxZYZdIi4r119
         tV7EgnIqSutrBjqJ1bQ0hwpJ3bqlNN7XrF+MA6+Qyr0iw84VHFJsuOUPRB/pR2knuV76
         L5WdrLvbuZ7EjBcEcQIet1ivoyb2XO1KHiKMQeCXL8/AUjkA6aSkSSQEOqzh2Fo1WtF7
         F0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=USFW04ceuvuutWv1mbyQmYMAYl1YGb2tf1JFTZ97Qak=;
        b=kc4uw/sh+pg2moNwAk7yLBNeE7hKXbnHdayGCL1eQLF3ZTh47NQWMW7VaGBd0EENpe
         gsdhFFHcutzSDkCfHn1ZYzZA8nSwiiqaTfl7vZcm3brPkihzuKkBHFY4yc7OmWCicvVs
         h0ylUWAdQME+Rbt0wMVNP9g77L0kuS5m0yrEsck4/BuSKobLakezHkW6sDMI2XcDHlK2
         JnTWNmVFOHEV7y1eut2YU8MU8yLrKjKMxL1yeLFmfv57xzzz45DW8uPh6HVt3Bdc4iX9
         DvhHpehkLJrz1YveePgwgjzESruB6kVEE/F00ijgYhN2I6YkOHFU5zYuRm7y/tjbJkzE
         7etQ==
X-Gm-Message-State: ALoCoQn3EOnRHI4d4NG7d1VYfNZwOGpX8bW2FNKTOuJf+wfKbORk3vioMFU1w7NeQ0ONStrM+JOL
X-Received: by 10.42.30.141 with SMTP id v13mr5365787icc.76.1429812813034;
 Thu, 23 Apr 2015 11:13:33 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 23 Apr 2015 11:13:32 -0700 (PDT)
In-Reply-To: <1429745061-295908-3-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267696>

On Wed, Apr 22, 2015 at 4:24 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> To allow piecemeal conversion of the for_each_*_ref functions, introduce
> an additional typedef for a callback function that takes struct
> object_id * instead of unsigned char *.  Provide an extra field in
> struct ref_entry_cb for this callback and ensure at most one is set at a
> time.  Temporarily suffix these new entries with _oid to distinguish
> them.  Convert for_each_tag_ref and its callers to use the new _oid
> functions, introducing temporary wrapper functions to avoid type
> mismatches.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

I am currently running this patch series via
git rebase -i origin/next --exec=make --exec="make test"
through the compilation and test suite one by one.
(My current view of origin/next is (c8da2d582, Sync with 2.4.0-rc3)
and this commit fails in t5312-prune-corruption.sh test 3 5 and 8

> ---
>  builtin/pack-objects.c |  4 ++--
>  builtin/rev-parse.c    |  7 ++++++-
>  builtin/tag.c          |  8 ++++----
>  refs.c                 | 34 ++++++++++++++++++++++++++++++----
>  refs.h                 | 10 +++++++++-
>  5 files changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c067107..0c69b0c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -540,11 +540,11 @@ static enum write_one_status write_one(struct sha1file *f,
>         return WRITE_ONE_WRITTEN;
>  }
>
> -static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
> +static int mark_tagged(const char *path, const struct object_id *oid, int flag,
>                        void *cb_data)
>  {
>         unsigned char peeled[20];
> -       struct object_entry *entry = packlist_find(&to_pack, sha1, NULL);
> +       struct object_entry *entry = packlist_find(&to_pack, oid->hash, NULL);
>
>         if (entry)
>                 entry->tagged = 1;
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 4d10dd9..7b70650 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -198,6 +198,11 @@ static int show_reference(const char *refname, const unsigned char *sha1, int fl
>         return 0;
>  }
>
> +static int show_reference_oid(const char *refname, const struct object_id *oid, int flag, void *cb_data)
> +{
> +       return show_reference(refname, oid->hash, flag, cb_data);
> +}
> +
>  static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
>         show_rev(REVERSED, sha1, refname);
> @@ -682,7 +687,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                                 continue;
>                         }
>                         if (!strcmp(arg, "--tags")) {
> -                               for_each_tag_ref(show_reference, NULL);
> +                               for_each_tag_ref(show_reference_oid, NULL);
>                                 clear_ref_exclusion(&ref_excludes);
>                                 continue;
>                         }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 6f07ac6..61399b7 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -215,7 +215,7 @@ free_return:
>         free(buf);
>  }
>
> -static int show_reference(const char *refname, const unsigned char *sha1,
> +static int show_reference(const char *refname, const struct object_id *oid,
>                           int flag, void *cb_data)
>  {
>         struct tag_filter *filter = cb_data;
> @@ -224,14 +224,14 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>                 if (filter->with_commit) {
>                         struct commit *commit;
>
> -                       commit = lookup_commit_reference_gently(sha1, 1);
> +                       commit = lookup_commit_reference_gently(oid->hash, 1);
>                         if (!commit)
>                                 return 0;
>                         if (!contains(commit, filter->with_commit))
>                                 return 0;
>                 }
>
> -               if (points_at.nr && !match_points_at(refname, sha1))
> +               if (points_at.nr && !match_points_at(refname, oid->hash))
>                         return 0;
>
>                 if (!filter->lines) {
> @@ -242,7 +242,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>                         return 0;
>                 }
>                 printf("%-15s ", refname);
> -               show_tag_lines(sha1, filter->lines);
> +               show_tag_lines(oid->hash, filter->lines);
>                 putchar('\n');
>         }
>
> diff --git a/refs.c b/refs.c
> index 522d15d..95863f2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -694,6 +694,7 @@ struct ref_entry_cb {
>         int trim;
>         int flags;
>         each_ref_fn *fn;
> +       each_ref_fn_oid *fn_oid;
>         void *cb_data;
>  };
>
> @@ -717,8 +718,13 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
>         /* Store the old value, in case this is a recursive call: */
>         old_current_ref = current_ref;
>         current_ref = entry;
> -       retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
> -                         entry->flag, data->cb_data);
> +       if (data->fn_oid) {
> +               retval = data->fn_oid(entry->name + data->trim, &entry->u.value.oid,
> +                                entry->flag, data->cb_data);
> +       } else {
> +               retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
> +                                entry->flag, data->cb_data);
> +       }
>         current_ref = old_current_ref;
>         return retval;
>  }
> @@ -1950,6 +1956,21 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
>         data.trim = trim;
>         data.flags = flags;
>         data.fn = fn;
> +       data.fn_oid = NULL;
> +       data.cb_data = cb_data;
> +
> +       return do_for_each_entry(refs, base, do_one_ref, &data);
> +}
> +
> +static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
> +                          each_ref_fn_oid fn, int trim, int flags, void *cb_data)
> +{
> +       struct ref_entry_cb data;
> +       data.base = base;
> +       data.trim = trim;
> +       data.flags = flags;
> +       data.fn = NULL;
> +       data.fn_oid = fn;
>         data.cb_data = cb_data;
>
>         if (ref_paranoia < 0)
> @@ -1998,6 +2019,11 @@ int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
>         return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
>  }
>
> +static int for_each_ref_in_oid(const char *prefix, each_ref_fn_oid fn, void *cb_data)
> +{
> +       return do_for_each_ref_oid(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
> +}
> +
>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
>  {
>         return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
> @@ -2009,9 +2035,9 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
>         return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
>  }
>
> -int for_each_tag_ref(each_ref_fn fn, void *cb_data)
> +int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
>  {
> -       return for_each_ref_in("refs/tags/", fn, cb_data);
> +       return for_each_ref_in_oid("refs/tags/", fn, cb_data);
>  }
>
>  int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> diff --git a/refs.h b/refs.h
> index 6d7d9b4..b83529b 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1,6 +1,8 @@
>  #ifndef REFS_H
>  #define REFS_H
>
> +#include "cache.h"
> +
>  /*
>   * A ref_transaction represents a collection of ref updates
>   * that should succeed or fail together.
> @@ -70,6 +72,12 @@ typedef int each_ref_fn(const char *refname,
>                         const unsigned char *sha1, int flags, void *cb_data);
>
>  /*
> + * Like each_ref_fn, but passes the object ID using a struct.
> + */
> +typedef int each_ref_fn_oid(const char *refname,
> +                       const struct object_id *oid, int flags, void *cb_data);
> +
> +/*
>   * The following functions invoke the specified callback function for
>   * each reference indicated.  If the function ever returns a nonzero
>   * value, stop the iteration and return that value.  Please note that
> @@ -81,7 +89,7 @@ typedef int each_ref_fn(const char *refname,
>  extern int head_ref(each_ref_fn, void *);
>  extern int for_each_ref(each_ref_fn, void *);
>  extern int for_each_ref_in(const char *, each_ref_fn, void *);
> -extern int for_each_tag_ref(each_ref_fn, void *);
> +extern int for_each_tag_ref(each_ref_fn_oid, void *);
>  extern int for_each_branch_ref(each_ref_fn, void *);
>  extern int for_each_remote_ref(each_ref_fn, void *);
>  extern int for_each_replace_ref(each_ref_fn, void *);
> --
> 2.3.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
