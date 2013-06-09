From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] core: use env variable instead of config var to turn
 on logging pack access
Date: Sun, 9 Jun 2013 03:17:09 -0400
Message-ID: <CAPig+cQ-oKdL75P=f-WwKLxu72UNsvZknOC4YaS8+U2yaZw+Bw@mail.gmail.com>
References: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 09:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZsL-0001nR-Ff
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 09:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab3FIHRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 03:17:13 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36122 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3FIHRM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 03:17:12 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so1284190lab.8
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p6IVAC99vs/urbInVwAdMjof7cy6lPPCNFlj5U75l8E=;
        b=QLKbs9orupWjERT9BR70vsZmjfZdViSbdycEc1bjTuuGKW2pl0TZl8s0UBRyc9npo4
         mJt2U+w/umtj+pW/wSgRcRHESm/wmlyC/00SNDur0tPPG7qTUd/SqrIWp4xFLm9z7nvV
         ec56p7tdCA6OnGmOiG84/memie1bS8DJnSYwYy/uKmTZ7OYQqNN05sW4BHKPBjMb83t+
         5a1QXag6mHaop765rqZSVQ7ftIcptlweSzqe4rWLUW/HnFBwpxBwuHWpzi+sms1q5Ps2
         KJAX9d51bCb2x0/gOw7dVDGfbNtSmvMUjDT/2rPR3F58bDKREh4NdajZLIzQGuIgruNo
         tZyg==
X-Received: by 10.112.205.69 with SMTP id le5mr4248497lbc.3.1370762229427;
 Sun, 09 Jun 2013 00:17:09 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 00:17:09 -0700 (PDT)
In-Reply-To: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: s_SYfvMOKdVq48F1BEeNaUQyZ64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226938>

On Sun, Jun 9, 2013 at 1:22 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> 5f44324 (core: log offset pack data accesses happened - 2011-07-06)
> provides a way to observe pack access patterns via a config
> switch. Setting an environment variable looks more obvious than a
> config var, especially when you just need to _observe_, and more
> inline with other tracing knobs we have.
>
> Document it as it may be useful for remote troubleshooting.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git.txt |  7 +++++++
>  cache.h               |  3 ---
>  config.c              |  3 ---
>  environment.c         |  1 -
>  sha1_file.c           | 14 ++++++++++++--
>  5 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 68f1ee6..c760918 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -838,6 +838,13 @@ for further details.
>         as a file path and will try to write the trace messages
>         into it.
>
> +'GIT_TRACE_PACK_ACCESS'::
> +       If this variable is set to a path, a file will be created at
> +       the given path logging all accesses to any packs. For each
> +       access, the pack file name and an offset in the pack is
> +       recorded. This may be helpful for troubleshooting some
> +       pack-related performance problems.
> +
>  GIT_LITERAL_PATHSPECS::
>         Setting this variable to `1` will cause Git to treat all
>         pathspecs literally, rather than as glob patterns. For exampl=
e,
> diff --git a/cache.h b/cache.h
> index df532f8..4f41606 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -772,9 +772,6 @@ extern int parse_sha1_header(const char *hdr, uns=
igned long *sizep);
>  /* global flag to enable extra checks when accessing packed objects =
*/
>  extern int do_check_packed_object_crc;
>
> -/* for development: log offset of pack access */
> -extern const char *log_pack_access;
> -
>  extern int check_sha1_signature(const unsigned char *sha1, void *buf=
, unsigned long size, const char *type);
>
>  extern int move_temp_to_file(const char *tmpfile, const char *filena=
me);
> diff --git a/config.c b/config.c
> index 7a85ebd..d04e815 100644
> --- a/config.c
> +++ b/config.c
> @@ -688,9 +688,6 @@ static int git_default_core_config(const char *va=
r, const char *value)
>                 return 0;
>         }
>
> -       if (!strcmp(var, "core.logpackaccess"))
> -               return git_config_string(&log_pack_access, var, value=
);
> -
>         if (!strcmp(var, "core.autocrlf")) {
>                 if (value && !strcasecmp(value, "input")) {
>                         if (core_eol =3D=3D EOL_CRLF)
> diff --git a/environment.c b/environment.c
> index e2e75c1..0cb67b2 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -37,7 +37,6 @@ size_t packed_git_window_size =3D DEFAULT_PACKED_GI=
T_WINDOW_SIZE;
>  size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
>  unsigned long big_file_threshold =3D 512 * 1024 * 1024;
> -const char *log_pack_access;
>  const char *pager_program;
>  int pager_use_color =3D 1;
>  const char *editor_program;
> diff --git a/sha1_file.c b/sha1_file.c
> index b114cc9..4b23bb8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -36,6 +36,9 @@ static inline uintmax_t sz_fmt(size_t s) { return s=
; }
>
>  const unsigned char null_sha1[20];
>
> +static const char *no_log_pack_access =3D "no_log_pack_access";
> +static const char *log_pack_access;
> +
>  /*
>   * This is meant to hold a *small* number of objects that you would
>   * want read_sha1_file() to be able to return, but yet you do not wa=
nt
> @@ -1956,12 +1959,19 @@ static void write_pack_access_log(struct pack=
ed_git *p, off_t obj_offset)
>  {
>         static FILE *log_file;
>
> +       if (!log_pack_access)
> +               log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
> +       if (!log_pack_access)
> +               log_pack_access =3D no_log_pack_access;
> +       if (log_pack_access =3D=3D no_log_pack_access)
> +               return;
> +
>         if (!log_file) {
>                 log_file =3D fopen(log_pack_access, "w");
>                 if (!log_file) {
>                         error("cannot open pack access log '%s' for w=
riting: %s",
>                               log_pack_access, strerror(errno));
> -                       log_pack_access =3D NULL;
> +                       log_pack_access =3D no_log_pack_access;
>                         return;
>                 }
>         }
> @@ -1992,7 +2002,7 @@ void *unpack_entry(struct packed_git *p, off_t =
obj_offset,
>         int delta_stack_nr =3D 0, delta_stack_alloc =3D UNPACK_ENTRY_=
STACK_PREALLOC;
>         int base_from_cache =3D 0;
>
> -       if (log_pack_access)
> +       if (log_pack_access !=3D no_log_pack_access)
>                 write_pack_access_log(p, obj_offset);
>
>         /* PHASE 1: drill down to the innermost base object */
> --
> 1.8.2.83.gc99314b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
