Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49BF1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 20:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeAZUMM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 15:12:12 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39228 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeAZUML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 15:12:11 -0500
Received: by mail-yb0-f194.google.com with SMTP id 65so625777ybz.6
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HLr19xqoz/Cc54IVxfN+GumVXkJVTvnB8sPBYZ6tIUM=;
        b=d/BgqA5deAybV0nD8/FG/DNIriXXKIytrI8kGptoOgwG+6fcpe87HOEfH6vZ8Ec0T0
         t5kjUzq/MAYgYzeg111Yu3xmhow8epWKn/mhlGr0JFZo/0cdtVjJ2qW1hKgI3mTj9D/l
         UWnKsryllbc2IoUh1ZqrAOstQHdSHOLoADzJz4mjdzZbWdTTJ2RlC6kkfHkDhXNO6Css
         x7KtrgPcsGCHsOcunf7yK25ZL6VkpSC0Mi8lBYu4B+v1f3nGgEQFpO2TDw6Tt3PHrTJf
         zjT3h3Yc1288jlIYjrSZsqOczVLErabhbPQ/H0oo3AuTHBkM59f/38QLqFz3kY9ZV3yJ
         PMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HLr19xqoz/Cc54IVxfN+GumVXkJVTvnB8sPBYZ6tIUM=;
        b=LhCHR2yLbeSdHKFgIHsNJTTSEJTCk6bldJSFjQl9dIK738zeuYu3vwgVqEBZiXU9zk
         MyMF1y+lSt6AVTF4FPmohrgSjGPh58rDBcqteTdUbVwjiLDyYfSgxjO/cDK5wY1Ngh63
         P/8wue1JX6Vwom+GujWzTpkQyb+VGR746KunpnwleUKt+a9XEELiBuRcP0vdw74a9ltF
         Rt0+voj595ONiIs1OrTYAKtLmCFPKvibZuuthq4ncN+JV78mC2W+KHBc1IZ1ZhKm3iCM
         H5jYI6HCm3eASDG3HYZ+Ct5IJtERYGnV91Y+gDrU9QZecYIy1nFBBWntv6M0cv+Zdij5
         DIPA==
X-Gm-Message-State: AKwxytfNMINUtDWeP9Ys//Nzk5xoOqBlRqcg/Zg+qRvnOGj4rkZpFMMc
        +JxgYAcnOG0NjVHuS/qKPDJoWmGkv15XvhH8cpsPJw==
X-Google-Smtp-Source: AH8x227GneaglB+QlgG0buDD8+aCmaBiSfJeFZLKq8T6pJm9TAEDFIyjZMXDQsBBbfdb1d3uGV99kHG3lFOuGEXt+E8=
X-Received: by 10.37.34.8 with SMTP id i8mr12216668ybi.114.1516997530072; Fri,
 26 Jan 2018 12:12:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 26 Jan 2018 12:12:09 -0800 (PST)
In-Reply-To: <20180125235838.138135-6-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Jan 2018 12:12:09 -0800
Message-ID: <CAGZ79kYbhR-y7WkhFgQ-YBkWaNXWuadDAGXaAzWDyJBzDSqc2w@mail.gmail.com>
Subject: Re: [PATCH v2 05/27] upload-pack: factor out processing lines
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> Factor out the logic for processing shallow, deepen, deepen_since, and
> deepen_not lines into their own functions to simplify the
> 'receive_needs()' function in addition to making it easier to reuse some
> of this logic when implementing protocol_v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  upload-pack.c | 113 ++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 74 insertions(+), 39 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 2ad73a98b..42d83d5b1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -724,6 +724,75 @@ static void deepen_by_rev_list(int ac, const char **av,
>         packet_flush(1);
>  }
>
> +static int process_shallow(const char *line, struct object_array *shallows)
> +{
> +       const char *arg;
> +       if (skip_prefix(line, "shallow ", &arg)) {

stylistic nit:

    You could invert the condition in each of the process_* functions
    to just have

        if (!skip_prefix...))
            return 0

        /* less indented code goes here */

        return 1;

    That way we have less indentation as well as easier code.
    (The reader doesn't need to keep in mind what the else
    part is about; it is a rather local decision to bail out instead
    of having the return at the end of the function.)

> +               struct object_id oid;
> +               struct object *object;
> +               if (get_oid_hex(arg, &oid))
> +                       die("invalid shallow line: %s", line);
> +               object = parse_object(&oid);
> +               if (!object)
> +                       return 1;
> +               if (object->type != OBJ_COMMIT)
> +                       die("invalid shallow object %s", oid_to_hex(&oid));
> +               if (!(object->flags & CLIENT_SHALLOW)) {
> +                       object->flags |= CLIENT_SHALLOW;
> +                       add_object_array(object, NULL, shallows);
> +               }
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int process_deepen(const char *line, int *depth)
> +{
> +       const char *arg;
> +       if (skip_prefix(line, "deepen ", &arg)) {
> +               char *end = NULL;
> +               *depth = (int) strtol(arg, &end, 0);
> +               if (!end || *end || *depth <= 0)
> +                       die("Invalid deepen: %s", line);
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int process_deepen_since(const char *line, timestamp_t *deepen_since, int *deepen_rev_list)
> +{
> +       const char *arg;
> +       if (skip_prefix(line, "deepen-since ", &arg)) {
> +               char *end = NULL;
> +               *deepen_since = parse_timestamp(arg, &end, 0);
> +               if (!end || *end || !deepen_since ||
> +                   /* revisions.c's max_age -1 is special */
> +                   *deepen_since == -1)
> +                       die("Invalid deepen-since: %s", line);
> +               *deepen_rev_list = 1;
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +static int process_deepen_not(const char *line, struct string_list *deepen_not, int *deepen_rev_list)
> +{
> +       const char *arg;
> +       if (skip_prefix(line, "deepen-not ", &arg)) {
> +               char *ref = NULL;
> +               struct object_id oid;
> +               if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
> +                       die("git upload-pack: ambiguous deepen-not: %s", line);
> +               string_list_append(deepen_not, ref);
> +               free(ref);
> +               *deepen_rev_list = 1;
> +               return 1;
> +       }
> +       return 0;
> +}
> +
>  static void receive_needs(void)
>  {
>         struct object_array shallows = OBJECT_ARRAY_INIT;
> @@ -745,49 +814,15 @@ static void receive_needs(void)
>                 if (!line)
>                         break;
>
> -               if (skip_prefix(line, "shallow ", &arg)) {
> -                       struct object_id oid;
> -                       struct object *object;
> -                       if (get_oid_hex(arg, &oid))
> -                               die("invalid shallow line: %s", line);
> -                       object = parse_object(&oid);
> -                       if (!object)
> -                               continue;
> -                       if (object->type != OBJ_COMMIT)
> -                               die("invalid shallow object %s", oid_to_hex(&oid));
> -                       if (!(object->flags & CLIENT_SHALLOW)) {
> -                               object->flags |= CLIENT_SHALLOW;
> -                               add_object_array(object, NULL, &shallows);
> -                       }
> +               if (process_shallow(line, &shallows))
>                         continue;
> -               }
> -               if (skip_prefix(line, "deepen ", &arg)) {
> -                       char *end = NULL;
> -                       depth = strtol(arg, &end, 0);
> -                       if (!end || *end || depth <= 0)
> -                               die("Invalid deepen: %s", line);
> +               if (process_deepen(line, &depth))
>                         continue;
> -               }
> -               if (skip_prefix(line, "deepen-since ", &arg)) {
> -                       char *end = NULL;
> -                       deepen_since = parse_timestamp(arg, &end, 0);
> -                       if (!end || *end || !deepen_since ||
> -                           /* revisions.c's max_age -1 is special */
> -                           deepen_since == -1)
> -                               die("Invalid deepen-since: %s", line);
> -                       deepen_rev_list = 1;
> +               if (process_deepen_since(line, &deepen_since, &deepen_rev_list))
>                         continue;
> -               }
> -               if (skip_prefix(line, "deepen-not ", &arg)) {
> -                       char *ref = NULL;
> -                       struct object_id oid;
> -                       if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
> -                               die("git upload-pack: ambiguous deepen-not: %s", line);
> -                       string_list_append(&deepen_not, ref);
> -                       free(ref);
> -                       deepen_rev_list = 1;
> +               if (process_deepen_not(line, &deepen_not, &deepen_rev_list))
>                         continue;
> -               }
> +
>                 if (!skip_prefix(line, "want ", &arg) ||
>                     get_oid_hex(arg, &oid_buf))
>                         die("git upload-pack: protocol error, "
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
