From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: add show_err flag to git_config_parse_key()
Date: Thu, 30 Oct 2014 11:21:09 -0700
Message-ID: <xmqqd299wh9m.fsf@gitster.dls.corp.google.com>
References: <CAEc54XBOvqT234s0UX-osYbOJfyuPquWLtmzDNDhAQoJ8b9eXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:21:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjuLU-0005WY-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 19:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849AbaJ3SVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 14:21:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758517AbaJ3SVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 14:21:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C74ED19D0B;
	Thu, 30 Oct 2014 14:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=au1KOMJoe4Zc1mZCDxKGlwFSfv0=; b=u17fsv
	6KPtJvSiwZyJHtQlMSYgXIv9dZ152abWMarhRl2B8X/4xx4e+NhDE48JbXwrlGM4
	ZN6ZnrRomi+8HqHSA9HnHjsjGcYluo/oo09f/3tWrkQ/bWqbgokNux0lLJ7QzI4H
	iZ0TPXSHCzzKVKwpEkzoXkuzNC0prhPh0Su/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vnEOqkzsbEFpsxtbvtKPtnc1tPT/9UYF
	Do6ZAFRiMdH8OsDMJEhBrQ50VPajm1xqRT7sLyeVEGYhvqhfA9dQaqW4l71OFCFy
	iifslOZj4FKjxTxxLo0IhxZhQcesFzEhS17ThK/Sn00yP8v4OgY1w/1YxUhukzrV
	8KcnW8PVr60=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB35919D0A;
	Thu, 30 Oct 2014 14:21:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0FAE19D09;
	Thu, 30 Oct 2014 14:21:10 -0400 (EDT)
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)git <git@vger.kernel.org>
								     ^-missing end of address
In-Reply-To: <CAEc54XBOvqT234s0UX-osYbOJfyuPquWLtmzDNDhAQoJ8b9eXg@mail.gmail.com>
	(Tanay Abhra's message of "Thu, 30 Oct 2014 23:18:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8630426E-6061-11E4-868D-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tanay Abhra <tanayabh@gmail.com> writes:

> `git_config_parse_key()` is used to sanitize the input key.
> Some callers of the function like `git_config_set_multivar_in_file()`
> get the pre-sanitized key directly from the user so it becomes
> necessary to raise an error specifying what went wrong when the entered
> key is defective.
>
> Other callers like `configset_find_element()` get their keys from
> the git itself so a return value signifying error would be enough.
> The error output shown to the user is useless and confusing in this
> case so add a show_err flag to suppress errors in such cases.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>
> Hi,
>
> You were right, one of the functions was calling git_config_parse_key()
> which was leaking errors to the console. git_config_parse_key() was
> meant for sanitizing user provided keys only but it was being used
> internally in a place where only a return value would be enough.
>
> Thanks for bringing this to our attention.
>
> Cheers,
> Tanay Abhra.

Who are *you* in the above, and what was the bug report about (if it
was a bug report)?  Perhaps summarize it in a form of a few new tests
in t/t13XX series is in order?

Thanks.

>
>  builtin/config.c |  2 +-
>  cache.h          |  2 +-
>  config.c         | 19 ++++++++++++-------
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 8cc2604..51635dc 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -200,7 +200,7 @@ static int get_value(const char *key_, const char *regex_)
>              goto free_strings;
>          }
>      } else {
> -        if (git_config_parse_key(key_, &key, NULL)) {
> +        if (git_config_parse_key(key_, &key, NULL, 1)) {
>              ret = CONFIG_INVALID_KEY;
>              goto free_strings;
>          }
> diff --git a/cache.h b/cache.h
> index 99ed096..8129590 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1362,7 +1362,7 @@ extern int git_config_string(const char **,
> const char *, const char *);
>  extern int git_config_pathname(const char **, const char *, const char *);
>  extern int git_config_set_in_file(const char *, const char *, const char *);
>  extern int git_config_set(const char *, const char *);
> -extern int git_config_parse_key(const char *, char **, int *);
> +extern int git_config_parse_key(const char *, char **, int *, int);
>  extern int git_config_set_multivar(const char *, const char *, const
> char *, int);
>  extern int git_config_set_multivar_in_file(const char *, const char
> *, const char *, const char *, int);
>  extern int git_config_rename_section(const char *, const char *);
> diff --git a/config.c b/config.c
> index 15a2983..eb9058c 100644
> --- a/config.c
> +++ b/config.c
> @@ -1299,7 +1299,7 @@ static struct config_set_element
> *configset_find_element(struct config_set *cs,
>       * `key` may come from the user, so normalize it before using it
>       * for querying entries from the hashmap.
>       */
> -    ret = git_config_parse_key(key, &normalized_key, NULL);
> +    ret = git_config_parse_key(key, &normalized_key, NULL, 0);
>
>      if (ret)
>          return NULL;
> @@ -1832,8 +1832,9 @@ int git_config_set(const char *key, const char *value)
>   *             lowercase section and variable name
>   * baselen - pointer to int which will hold the length of the
>   *           section + subsection part, can be NULL
> + * show_err - toggle whether the function raises an error on a defective key
>   */
> -int git_config_parse_key(const char *key, char **store_key, int *baselen_)
> +int git_config_parse_key(const char *key, char **store_key, int
> *baselen_, int show_err)
>  {
>      int i, dot, baselen;
>      const char *last_dot = strrchr(key, '.');
> @@ -1844,12 +1845,14 @@ int git_config_parse_key(const char *key, char
> **store_key, int *baselen_)
>       */
>
>      if (last_dot == NULL || last_dot == key) {
> -        error("key does not contain a section: %s", key);
> +        if (show_err)
> +            error("key does not contain a section: %s", key);
>          return -CONFIG_NO_SECTION_OR_NAME;
>      }
>
>      if (!last_dot[1]) {
> -        error("key does not contain variable name: %s", key);
> +        if (show_err)
> +            error("key does not contain variable name: %s", key);
>          return -CONFIG_NO_SECTION_OR_NAME;
>      }
>
> @@ -1871,12 +1874,14 @@ int git_config_parse_key(const char *key, char
> **store_key, int *baselen_)
>          if (!dot || i > baselen) {
>              if (!iskeychar(c) ||
>                  (i == baselen + 1 && !isalpha(c))) {
> -                error("invalid key: %s", key);
> +                if (show_err)
> +                    error("invalid key: %s", key);
>                  goto out_free_ret_1;
>              }
>              c = tolower(c);
>          } else if (c == '\n') {
> -            error("invalid key (newline): %s", key);
> +            if (show_err)
> +                error("invalid key (newline): %s", key);
>              goto out_free_ret_1;
>          }
>          (*store_key)[i] = c;
> @@ -1926,7 +1931,7 @@ int git_config_set_multivar_in_file(const char
> *config_filename,
>      char *filename_buf = NULL;
>
>      /* parse-key returns negative; flip the sign to feed exit(3) */
> -    ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
> +    ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 1);
>      if (ret)
>          goto out_free;
