Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696601F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeACUi0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:38:26 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35595 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeACUiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:38:25 -0500
Received: by mail-qt0-f194.google.com with SMTP id u10so3667997qtg.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b5l91cjJBj470OTgjQFVfD05pN62g+YdbPGFaaDCXHU=;
        b=Vrg7MiKi0pOC9MvCTvHfxMXczu1p5lwbONQQeLKjjWVcL8ebiDBY3FFYBZvnhohW3c
         E2dnnRpxEyb/MwxijYdWCGGjmRGH0bHG+d0bSdxEXFYuZeeRKb7JJ69i1yyc7AJbXM1y
         1pVpf+BTp5Ki0t7/JQLh0M+OjFgvfHebW+43zG5FW7p3+Qnr5XmKBPLTZzUiWm18nj5W
         aYPoV2U7hK9kllRWE60bk8qdLsz+eoQFioZP2Ngpue18bzUyMOL9H77R13GMKosGiIL1
         Xe10ygu+iB1gdAsXzuqfD3L0x+JsnXnx6kMW97ugSoQjZsyjNiThPW9nJUlkjWQn+qd8
         UuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b5l91cjJBj470OTgjQFVfD05pN62g+YdbPGFaaDCXHU=;
        b=uZNQMfcx4QFVaDc62qKwMB/tHhHKVkk3latpgF/Ks9guMwpDQVQ/OJvU0kKiIUlD9W
         TwVGR7WmlI0cQKbpdJ7jWIFzT0KFmF/bUwkUfbpP7bX2n74G339GHFAV0Y0XceHklkex
         ahJvhAgs5vIDTDwPllgti1YfCIpApQoQQqIH5tI0sdg99eaui2DjyGONOWNflI1Qs7nE
         3jdM4E0OPCvZVV55olVk2ipBDWBGraYdwHQjwE6AJqtB+kfwvvmijXVT914nR3JZoH2J
         XXlnqWVIfp3ImRt0WpHqSZLkDtRDrDYD/BKa80dbtE2h1v3IQDZMpLCx2xZfy9RT/HXA
         5eOw==
X-Gm-Message-State: AKGB3mKEG4yoeUXpk07BqPGtGcTZFIkfHzYdlzyywfSa2DiB2gacs5o6
        hA1W2M9ry5ELxjEos8FDppCJR94lqtUXK9CmRZRpqIaS
X-Google-Smtp-Source: ACJfBovuX/adOdcNt5OR0dfPqLuY0E3dG2ny3+07ghJsHRZCnH2HJlnWrHo4lU7+xBS1FgcadCWRk9+IaA7foQx+2po=
X-Received: by 10.200.35.215 with SMTP id r23mr3225939qtr.174.1515011903943;
 Wed, 03 Jan 2018 12:38:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 12:38:23 -0800 (PST)
In-Reply-To: <20180103001828.205012-6-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 12:38:23 -0800
Message-ID: <CAGZ79kaydGBVO=NQuqE-J_pkXGMLN2D42VAuNsPvkkQcK71BLA@mail.gmail.com>
Subject: Re: [PATCH 05/26] upload-pack: factor out processing lines
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

On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
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
> index 20acaa49d..9a507ae53 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -731,6 +731,75 @@ static void deepen_by_rev_list(int ac, const char **av,
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
> +               *depth = strtol(arg, &end, 0);
> +               if (!end || *end || depth <= 0)
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
> @@ -752,49 +821,15 @@ static void receive_needs(void)
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
> 2.15.1.620.gb9897f4670-goog
>
