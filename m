Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4331F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIMDfJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 23:35:09 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34341 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeIMDfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:35:09 -0400
Received: by mail-yb1-f196.google.com with SMTP id t10-v6so2484874ybb.1
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArX6l7ko5Y0AimehCofFjmsY9MKKAMWkelTDq5mkahw=;
        b=WYimr4eoWtNMx1kdwdctUeOwHOGz4EYE7Qekqp/t/oM/fiPnY/pkw7cDVYwwmsYkjH
         WK7dRYe3jSBqclK5YCiSk5H7Q4fti7q9nhHozqfhkNz6p2z6sSnQe9YxTkTk5XRwhgNB
         NVqHVPgCy5xfEq5N6ls3FzZZWMgO82wedHE9sf0ptGk3cCI3VBAyDYyNkcGRR/mFqBMG
         EoHDoZKdRZLt8UCJaioJXtoAkH9pQ027vR5TRtR0ylbTWyO8kUiBSXrICTXvMgmmgIiQ
         yK04wbxcc7zDjw4SNdRjf4c1JE7jcWNFWl7foCNq6oa0sdOtzOALTZEThlHwfDg6dFpL
         OXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArX6l7ko5Y0AimehCofFjmsY9MKKAMWkelTDq5mkahw=;
        b=sUpPgfDBeh2mDxjC4/ND6m/Frm4jTsPm89pHdrURdPRSQ3qxaq6HC+8OmbVLoC6eqU
         xqclnlvu7LvkJFSu0lsCdhoqWBZUoklFL6f7Q6VYTBaqDiVomMsEe1vM57tKBYL4OaFC
         GQMvrxh/9lSIxeOcM9Y1YeHOIebeTVLqYqeN2wG4xpc4/oDMywlav+9MybDfrvDWfN+T
         AQ+FVmQGsPJOIoYo9m/1arMHSMRN7r6fo0Ysdi50J5Lhiw79LeR1Md3kgxTm3Q2At8NW
         GL20iUuF1YQd9vllE1KkGQFibIl3y7xuEkwB1MKaiJTXca5PzwrAzyEJ9Nnrm1/RbIJh
         7BCg==
X-Gm-Message-State: APzg51D3Lx10sKLqjC5KDhc8eSQgs92bYz2qtY06XnLbvKzXhNIKBecv
        +hDZ2HD8vREDNnUUr1liJEne96sgU+5erk9YCG/hdA==
X-Google-Smtp-Source: ANB0VdbRvMblRqoUeLr4HmbH6sKkmGsgCyA5LYt7nzu+X1MpgtUFnHdu2VK0enukTSVkzLuj4FBblt445yz/PdSQryo=
X-Received: by 2002:a25:41c3:: with SMTP id o186-v6mr2017184yba.493.1536791313542;
 Wed, 12 Sep 2018 15:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180912053519.31085-3-steadmon@google.com>
In-Reply-To: <20180912053519.31085-3-steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Sep 2018 15:28:22 -0700
Message-ID: <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 10:36 PM Josh Steadmon <steadmon@google.com> wrote:
>
> This adds a new archive command for protocol v2. The command expects
> arguments in the form "argument X" which are passed unmodified to
> git-upload-archive--writer.
>
> This command works over the file://, Git, and SSH transports. HTTP
> support will be added in a separate patch.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/archive.c        | 45 +++++++++++++++++++++++++++-------------
>  builtin/upload-archive.c | 44 ++++++++++++++++++++++++++++++++++++---
>  t/t5000-tar-tree.sh      |  5 +++++
>  3 files changed, 77 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index e54fc39ad..73831887d 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -5,9 +5,11 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "archive.h"
> +#include "connect.h"
>  #include "transport.h"
>  #include "parse-options.h"
>  #include "pkt-line.h"
> +#include "protocol.h"
>  #include "sideband.h"
>
>  static void create_output_file(const char *output_file)
> @@ -23,6 +25,13 @@ static void create_output_file(const char *output_file)
>         }
>  }
>
> +static int do_v2_command_and_cap(int out)
> +{
> +       packet_write_fmt(out, "command=archive\n");
> +       /* Capability list would go here, if we had any. */
> +       packet_delim(out);
> +}
> +
>  static int run_remote_archiver(int argc, const char **argv,
>                                const char *remote, const char *exec,
>                                const char *name_hint)
> @@ -32,6 +41,7 @@ static int run_remote_archiver(int argc, const char **argv,
>         struct remote *_remote;
>         struct packet_reader reader;
>         enum packet_read_status status;
> +       enum protocol_version version;
>
>         _remote = remote_get(remote);
>         if (!_remote->url[0])
> @@ -41,6 +51,11 @@ static int run_remote_archiver(int argc, const char **argv,
>
>         packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
>
> +       version = discover_version(&reader);
> +
> +       if (version == protocol_v2)
> +               do_v2_command_and_cap(fd[1]);
> +
>         /*
>          * Inject a fake --format field at the beginning of the
>          * arguments, with the format inferred from our output
> @@ -56,22 +71,24 @@ static int run_remote_archiver(int argc, const char **argv,
>                 packet_write_fmt(fd[1], "argument %s\n", argv[i]);
>         packet_flush(fd[1]);
>
> -       status = packet_reader_read(&reader);
> -
> -       if (status == PACKET_READ_FLUSH)
> -               die(_("git archive: expected ACK/NAK, got a flush packet"));
> -       if (strcmp(reader.buffer, "ACK")) {
> -               if (starts_with(reader.buffer, "NACK "))
> -                       die(_("git archive: NACK %s"), reader.buffer + 5);
> -               if (starts_with(reader.buffer, "ERR "))
> -                       die(_("remote error: %s"), reader.buffer + 4);
> -               die(_("git archive: protocol error"));

Maybe we also want to support v1
(which is v0 prefixed with one pkt_line saying it is v1).

    If (version == protocol_v1)
        /* drop version v1 line, and then follow v0 logic. */
        packet_reader_read(&reader);

Do we care about v1, or do we just ignore it here? why?
(Don't answer me here, but rather put it in the commit message)

> +       if (version == protocol_v0) {
> +               status = packet_reader_read(&reader);
> +
> +               if (status == PACKET_READ_FLUSH)
> +                       die(_("git archive: expected ACK/NAK, got a flush packet"));
> +               if (strcmp(reader.buffer, "ACK")) {
> +                       if (starts_with(reader.buffer, "NACK "))
> +                               die(_("git archive: NACK %s"), reader.buffer + 5);
> +                       if (starts_with(reader.buffer, "ERR "))
> +                               die(_("remote error: %s"), reader.buffer + 4);
> +                       die(_("git archive: protocol error"));
> +               }
> +
> +               status = packet_reader_read(&reader);
> +               if (status != PACKET_READ_FLUSH)
> +                       die(_("git archive: expected a flush"));
>         }
>
> -       status = packet_reader_read(&reader);
> -       if (status != PACKET_READ_FLUSH)
> -               die(_("git archive: expected a flush"));
> -
>         /* Now, start reading from fd[0] and spit it out to stdout */
>         rv = recv_sideband("archive", fd[0], 1);
>         rv |= transport_disconnect(transport);
> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 25d911635..534e8fd56 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -5,6 +5,7 @@
>  #include "builtin.h"
>  #include "archive.h"
>  #include "pkt-line.h"
> +#include "protocol.h"
>  #include "sideband.h"
>  #include "run-command.h"
>  #include "argv-array.h"
> @@ -73,13 +74,53 @@ static ssize_t process_input(int child_fd, int band)
>         return sz;
>  }
>
> +static int handle_v2_command_and_cap(void)
> +{
> +       struct packet_reader reader;
> +       enum packet_read_status status;
> +
> +       packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
> +
> +       packet_write_fmt(1, "version 2\n");
> +       /*
> +        * We don't currently send any capabilities, but maybe we could list
> +        * supported archival formats?
> +        */
> +       packet_flush(1);
> +
> +       status = packet_reader_read(&reader);
> +       if (status != PACKET_READ_NORMAL ||
> +           strcmp(reader.buffer, "command=archive"))
> +               die(_("upload-archive: expected command=archive"));
> +       while (status == PACKET_READ_NORMAL) {
> +               /* We don't currently expect any client capabilities, but we
> +                * should still read (and ignore) any that happen to get sent.

/*
 * Makes sense to ignore the client capabilities here,
 * but the multi line comments take their opening
 * and closing line on a separate line. just like above.
 */

> +                */
> +               status = packet_reader_read(&reader);
> +       }
> +       if (status != PACKET_READ_DELIM)
> +               die(_("upload-archive: expected delim packet"));

This is upload-archive, which is a low level plumbing command
(see the main man page of git for an explanation of that category),
so we do not translate the error/die() calls. Besides, this is executed
on the server, which might have a different locale than the requesting
client?

Would asking for a setlocale() on the server side be an unreasonable
feature request for the capabilities (in a follow up patch, and then not
just for archive but also fetch/push, etc.)?

>  int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>  {
>         struct child_process writer = { argv };
> +       enum protocol_version version = determine_protocol_version_server();
>
>         if (argc == 2 && !strcmp(argv[1], "-h"))
>                 usage(upload_archive_usage);
>
> +       if (version == protocol_v2)
> +               handle_v2_command_and_cap();
> +       else {

So if the client asked for v1, we still fall back to v0 here,
which answers my question above.

> +               packet_write_fmt(1, "ACK\n");
> +               packet_flush(1);
> +       }
> +
>         /*
>          * Set up sideband subprocess.
>          *
> @@ -96,9 +137,6 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>                 die("upload-archive: %s", strerror(err));
>         }
>
> -       packet_write_fmt(1, "ACK\n");
> -       packet_flush(1);
> -
>         while (1) {
>                 struct pollfd pfd[2];
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 2a97b27b0..4be74d6e9 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -145,6 +145,11 @@ test_expect_success \
>
>  check_tar b
>
> +test_expect_success 'protocol v2 for remote' '
> +       GIT_PROTOCOL="version=2" git archive --remote=. HEAD >v2_remote.tar
> +'
> +check_tar v2_remote

Our current standard is to keep all executions inside
a test_expect_* block, but here it is hard to comply with
that as the check_tar function contains test_expect_*
and calling test_expect_* from within itself doesn't work
with our test suite.

So bonus points for a refactoring to bring t5000 up to
our current standard (c.f. t0020 for a reasonable new
code, and t2002 for older code, though that only covers
syntax, not functions)

The check itself is just testing that giving GIT_PROTOCOL=2
in the environment also let's you obtain an archive. It doesn't
test if the actual communication *is* v2.
See 5e3548ef161 (fetch: send server options when using
protocol v2, 2018-04-23) for an example how to sniff on the
network traffic in tests, i.e. use GIT_TRACE_PACKET=...
and grep on that?

Thanks,
Stefan
