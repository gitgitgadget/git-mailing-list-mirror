Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01321FAE2
	for <e@80x24.org>; Fri, 26 Jan 2018 21:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeAZVdm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 16:33:42 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45841 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeAZVdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 16:33:41 -0500
Received: by mail-pg0-f65.google.com with SMTP id m136so1034675pga.12
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T9h5JfErAGlWCPlfdzWK1I7GEAUGsgcQVuPwT18n/84=;
        b=EaZvSHdEpir44f+6BlS5Nh7m9Lg9QyeFFPsVCpb/rylIyBVBT2q/3KBtxU9lfuB5Ws
         jWOx41brEuyAUOSERPvyqvmrhvD6CPhOa7cd9XWCvYX4gbD58YoxsoRmchofnuisobJT
         1b0I3+3+X2T+TbDjB9VYFbGIfZ0zkJO7o/rlkTdGwmr/gfdFEUzKk6KkngiWLjHOZHbm
         TpNcJJvCl1W26RjJwasa3HKoB31QWMMrEgJ8bIWM3K9ouP33FLuyv3EIsb3LW8vRgRF/
         rAQwxz/NcqcWvcgfV+iIjLVljPbCUpdQGex4R9W3HiMfpbl471rO0cpO/ZQU79kOCp+C
         G+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9h5JfErAGlWCPlfdzWK1I7GEAUGsgcQVuPwT18n/84=;
        b=Pnk2ywqS9fXaevrEcJXojVIiHY8vrgbqOIa3MacHsCeMp4cHye6tremDD30j6oN9MB
         BdkRMNoiVusz2JElL+vTd7yiEp9XG6I3N/BqS9lzaCffnh9MJuayP8b+qmnWbuqZZHit
         Qc0RDQniLA8tEvAYxTkUKffd2sKE6sbk6vlscIjWdq8NIV+XDJj/4V4G7IpcHrOygpci
         ZZV2Dbt04+LypXutY6dx0okssyBK6YplFVUC172QjkYEfLhRzKfmHrNlOnGko7qIafmP
         FdUY1KJ4f4RMQw4UTZ3yuquNfD3lh0sqfSJH0sEb9yL60W2iMa1Tuuw/IcxG33g4FfHA
         PbjQ==
X-Gm-Message-State: AKwxytf2QCcwoBdtbnaciNDkUL1pJYIK1YL17nCkMztJNvQpU4SR0Zuv
        6nQVFpqICjXGB5Fs64yKdpNfuA==
X-Google-Smtp-Source: AH8x225F73PolECy2aqvvbzc9NckLTzEd7gttd9yuj+AO6M5+zwWlqi7oEyBKxu1oVWp7yPrImnBPw==
X-Received: by 10.101.64.4 with SMTP id f4mr16034790pgp.171.1517002420532;
        Fri, 26 Jan 2018 13:33:40 -0800 (PST)
Received: from google.com ([2620:0:100e:402:c861:974a:7ff5:46bb])
        by smtp.gmail.com with ESMTPSA id m67sm18894001pfi.157.2018.01.26.13.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jan 2018 13:33:39 -0800 (PST)
Date:   Fri, 26 Jan 2018 13:33:38 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 05/27] upload-pack: factor out processing lines
Message-ID: <20180126213338.GB17576@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-6-bmwill@google.com>
 <CAGZ79kYbhR-y7WkhFgQ-YBkWaNXWuadDAGXaAzWDyJBzDSqc2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYbhR-y7WkhFgQ-YBkWaNXWuadDAGXaAzWDyJBzDSqc2w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/26, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> > Factor out the logic for processing shallow, deepen, deepen_since, and
> > deepen_not lines into their own functions to simplify the
> > 'receive_needs()' function in addition to making it easier to reuse some
> > of this logic when implementing protocol_v2.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  upload-pack.c | 113 ++++++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 74 insertions(+), 39 deletions(-)
> >
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 2ad73a98b..42d83d5b1 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -724,6 +724,75 @@ static void deepen_by_rev_list(int ac, const char **av,
> >         packet_flush(1);
> >  }
> >
> > +static int process_shallow(const char *line, struct object_array *shallows)
> > +{
> > +       const char *arg;
> > +       if (skip_prefix(line, "shallow ", &arg)) {
> 
> stylistic nit:
> 
>     You could invert the condition in each of the process_* functions
>     to just have
> 
>         if (!skip_prefix...))
>             return 0
> 
>         /* less indented code goes here */
> 
>         return 1;
> 
>     That way we have less indentation as well as easier code.
>     (The reader doesn't need to keep in mind what the else
>     part is about; it is a rather local decision to bail out instead
>     of having the return at the end of the function.)

I was trying to move the existing code into helper functions so
rewriting them in transit may make it less reviewable?

> 
> > +               struct object_id oid;
> > +               struct object *object;
> > +               if (get_oid_hex(arg, &oid))
> > +                       die("invalid shallow line: %s", line);
> > +               object = parse_object(&oid);
> > +               if (!object)
> > +                       return 1;
> > +               if (object->type != OBJ_COMMIT)
> > +                       die("invalid shallow object %s", oid_to_hex(&oid));
> > +               if (!(object->flags & CLIENT_SHALLOW)) {
> > +                       object->flags |= CLIENT_SHALLOW;
> > +                       add_object_array(object, NULL, shallows);
> > +               }
> > +               return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int process_deepen(const char *line, int *depth)
> > +{
> > +       const char *arg;
> > +       if (skip_prefix(line, "deepen ", &arg)) {
> > +               char *end = NULL;
> > +               *depth = (int) strtol(arg, &end, 0);
> > +               if (!end || *end || *depth <= 0)
> > +                       die("Invalid deepen: %s", line);
> > +               return 1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int process_deepen_since(const char *line, timestamp_t *deepen_since, int *deepen_rev_list)
> > +{
> > +       const char *arg;
> > +       if (skip_prefix(line, "deepen-since ", &arg)) {
> > +               char *end = NULL;
> > +               *deepen_since = parse_timestamp(arg, &end, 0);
> > +               if (!end || *end || !deepen_since ||
> > +                   /* revisions.c's max_age -1 is special */
> > +                   *deepen_since == -1)
> > +                       die("Invalid deepen-since: %s", line);
> > +               *deepen_rev_list = 1;
> > +               return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int process_deepen_not(const char *line, struct string_list *deepen_not, int *deepen_rev_list)
> > +{
> > +       const char *arg;
> > +       if (skip_prefix(line, "deepen-not ", &arg)) {
> > +               char *ref = NULL;
> > +               struct object_id oid;
> > +               if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
> > +                       die("git upload-pack: ambiguous deepen-not: %s", line);
> > +               string_list_append(deepen_not, ref);
> > +               free(ref);
> > +               *deepen_rev_list = 1;
> > +               return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> >  static void receive_needs(void)
> >  {
> >         struct object_array shallows = OBJECT_ARRAY_INIT;
> > @@ -745,49 +814,15 @@ static void receive_needs(void)
> >                 if (!line)
> >                         break;
> >
> > -               if (skip_prefix(line, "shallow ", &arg)) {
> > -                       struct object_id oid;
> > -                       struct object *object;
> > -                       if (get_oid_hex(arg, &oid))
> > -                               die("invalid shallow line: %s", line);
> > -                       object = parse_object(&oid);
> > -                       if (!object)
> > -                               continue;
> > -                       if (object->type != OBJ_COMMIT)
> > -                               die("invalid shallow object %s", oid_to_hex(&oid));
> > -                       if (!(object->flags & CLIENT_SHALLOW)) {
> > -                               object->flags |= CLIENT_SHALLOW;
> > -                               add_object_array(object, NULL, &shallows);
> > -                       }
> > +               if (process_shallow(line, &shallows))
> >                         continue;
> > -               }
> > -               if (skip_prefix(line, "deepen ", &arg)) {
> > -                       char *end = NULL;
> > -                       depth = strtol(arg, &end, 0);
> > -                       if (!end || *end || depth <= 0)
> > -                               die("Invalid deepen: %s", line);
> > +               if (process_deepen(line, &depth))
> >                         continue;
> > -               }
> > -               if (skip_prefix(line, "deepen-since ", &arg)) {
> > -                       char *end = NULL;
> > -                       deepen_since = parse_timestamp(arg, &end, 0);
> > -                       if (!end || *end || !deepen_since ||
> > -                           /* revisions.c's max_age -1 is special */
> > -                           deepen_since == -1)
> > -                               die("Invalid deepen-since: %s", line);
> > -                       deepen_rev_list = 1;
> > +               if (process_deepen_since(line, &deepen_since, &deepen_rev_list))
> >                         continue;
> > -               }
> > -               if (skip_prefix(line, "deepen-not ", &arg)) {
> > -                       char *ref = NULL;
> > -                       struct object_id oid;
> > -                       if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
> > -                               die("git upload-pack: ambiguous deepen-not: %s", line);
> > -                       string_list_append(&deepen_not, ref);
> > -                       free(ref);
> > -                       deepen_rev_list = 1;
> > +               if (process_deepen_not(line, &deepen_not, &deepen_rev_list))
> >                         continue;
> > -               }
> > +
> >                 if (!skip_prefix(line, "want ", &arg) ||
> >                     get_oid_hex(arg, &oid_buf))
> >                         die("git upload-pack: protocol error, "
> > --
> > 2.16.0.rc1.238.g530d649a79-goog
> >

-- 
Brandon Williams
