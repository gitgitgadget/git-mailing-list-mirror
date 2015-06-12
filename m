From: Augie Fackler <augie@google.com>
Subject: Re: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Fri, 12 Jun 2015 12:54:24 -0400
Message-ID: <CAHcr6HZsevG+RyRb3+hghgeRhMY7kmcRZBwt1D8JWn0RfSuHSQ@mail.gmail.com>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
	<1434049168-10613-1-git-send-email-augie@google.com>
	<557A7ABA.2000404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 18:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3SDv-0005nc-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 18:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbbFLQy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 12:54:26 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34109 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbFLQy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 12:54:26 -0400
Received: by wgv5 with SMTP id 5so28534554wgv.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rIgYNddBZZGLzwMMkd64DcbIVE2GctjuziqYVZ7amt8=;
        b=IDN3jySVv/d4Y9QyE/xV52gFpCrIJYbfKboAKzIf9mVdYaW655eMhIGFP8LVkpX36A
         d22Ej9YwtceMfDpx65dzA50KsVQnyD1qgwuoJ5mReYegldQ4TmPp/nzeJAE01iG5eZWL
         u29wigNcrKXYOzAL+M1pvqWAcDshM8nRN8ycT/xIHYX66uYn1NTc2pXHUOX2uqhWzw8r
         PLpkm7Si5W19js/IuGXNobSbjjtYc7Kmi3hYMsOGEbR4iGwP2oST+fi9kcwKt5tLxLhd
         fkxW1+cX1Kl7TKlR7RvpriXYwsIxDZkdWuT8WUk/dELa8jO6v1CUy3AfAE1fQMLA7Iab
         SlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rIgYNddBZZGLzwMMkd64DcbIVE2GctjuziqYVZ7amt8=;
        b=akQ76pW0zN6aX32GU8rTV67p4PiqcwIbt1OT13BypBjAAWN3xpvY/djsATdwrXv42O
         tlvGc8YVgHF9vw2jdg53p6lMSLttf6ha0Czgpso4g4CG9XXAIJP0tgk65G+7YZh0yNeJ
         GSH0juA7Vd9xMa2uLyb6kqoYJgRphW9yBPXEqw3wvSUCNzqowcwGUxa99XtDyxzyItQ/
         EwwTDJMsnGVD68TMyxfEtGWOsohhfc60+tmVU68hnlFEjUBt3ki0sE4wGFwQTdz1oxhC
         IMmZPe2NJmEl/baHGSfHcQRugNfHRWeWHb1Jnv3ZvRT1ftJOUYr1Cv2atkuiR06mhWyJ
         dsYg==
X-Gm-Message-State: ALoCoQntzy/r/zdP7Emx4xb4HIX2DifTxRyvPf/uCAFWaj4mEM07S/V2Bd3CMjoV1hDZAZwXAgkM
X-Received: by 10.194.200.228 with SMTP id jv4mr27430136wjc.157.1434128064693;
 Fri, 12 Jun 2015 09:54:24 -0700 (PDT)
Received: by 10.28.146.143 with HTTP; Fri, 12 Jun 2015 09:54:24 -0700 (PDT)
In-Reply-To: <557A7ABA.2000404@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271498>

On Fri, Jun 12, 2015 at 2:22 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 11.06.2015 um 20:59 schrieb Augie Fackler:
>>
>> When developing server software, it's often helpful to save a
>> potentially-bogus pack for later analysis. This makes that trivial,
>> instead of painful.
>
>
> When you develop server software, shouldn't you test drive the server via
the bare metal protocol anyway? That *is* painful, but unavoidable because
you must harden the server against any garbage that a potentially malicous
client could throw at it. Restricting yourself to a well-behaved client
such as fetch-pack is only half the deal.


We do that too, but sometimes I've encountered an edge case that's
trivially reproduced from an existing repo, and going through the work to
manually drive the server is a monumental pain in the butt, and all I
*really* need is to see the bytes sent from the server to the client. If it
weren't for SSL-everywhere, I'd probably just do this with wireshark, but
that's not the world I live in.

>
>
> That said, I do think that fetch-pack could learn a mode that makes it
easier to debug the normal behavior of a server (if such a mode is missing
currently).
>
> What is the problem with the current fetch-pack implementation? Does it
remove a bogus packfile after download? Does it abort during download when
it detects a broken packfile? Does --keep not do what you need?


fetch-pack doesn't store the pack anywhere - it's sending it to index-pack
(or unpack-objects) using --stdin, which means that the raw bytes from the
server currently are never materialized anywhere on disk. Having index-pack
do this is too late, because it's doing things like rewriting the pack
header in a potentially new format.

(Junio also covered this well, thanks!)

>
>
> Instead of your approach (which forks off tee to dump a copy of the
packfile), would it not be simpler to add an option --debug-pack (probably
not the best name) that skips the cleanup step when a broken packfile is
detected and prints the name of the downloaded packfile?
>
>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index a912935..fe6ba58 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -684,7 +684,7 @@ static int get_pack(struct fetch_pack_args *args,
>>         const char *argv[22];
>>         char keep_arg[256];
>>         char hdr_arg[256];
>> -       const char **av, *cmd_name;
>> +       const char **av, *cmd_name, *savepath;
>>         int do_keep = args->keep_pack;
>>         struct child_process cmd = CHILD_PROCESS_INIT;
>>         int ret;
>> @@ -708,9 +708,8 @@ static int get_pack(struct fetch_pack_args *args,
>>         cmd.argv = argv;
>>         av = argv;
>>         *hdr_arg = 0;
>> +       struct pack_header header;
>>         if (!args->keep_pack && unpack_limit) {
>> -               struct pack_header header;
>> -
>>                 if (read_pack_header(demux.out, &header))
>>                         die("protocol error: bad pack header");
>>                 snprintf(hdr_arg, sizeof(hdr_arg),
>> @@ -762,7 +761,44 @@ static int get_pack(struct fetch_pack_args *args,
>>                 *av++ = "--strict";
>>         *av++ = NULL;
>>
>> -       cmd.in = demux.out;
>> +       savepath = getenv("GIT_SAVE_FETCHED_PACK_TO");
>> +       if (savepath) {
>> +               struct child_process cmd2 = CHILD_PROCESS_INIT;
>> +               const char *argv2[22];
>> +               int pipefds[2];
>> +               int e;
>> +               const char **av2;
>> +               cmd2.argv = argv2;
>> +               av2 = argv2;
>> +               *av2++ = "tee";
>> +               if (*hdr_arg) {
>> +                       /* hdr_arg being nonempty means we already read
the
>> +                        * pack header from demux, so we need to drop a
pack
>> +                        * header in place for tee to append to,
otherwise
>> +                        * we'll end up with a broken pack on disk.
>> +                        */
>
>
>                         /*
>                          * Write multi-line comments
>                          * like this (/* on its own line)
>                          */
>
>> +                       int fp;
>> +                       struct sha1file *s;
>> +                       fp = open(savepath, O_CREAT | O_TRUNC |
O_WRONLY, 0666);
>> +                       s = sha1fd_throughput(fp, savepath, NULL);
>> +                       sha1write(s, &header, sizeof(header));
>> +                       sha1flush(s);
>
>
> Are you abusing sha1write() and sha1flush() to write a byte sequence to a
file? Is write_in_full() not sufficient?


I didn't know about write_in_full. I'm very much *not* familiar with git's
codebase - I know the protocols and formats reasonably well, but have
needed only occasionally to look at the code. That works, thanks.

>
>
>
>> +                       close(fp);
>> +                       /* -a is supported by both GNU and BSD tee */
>> +                       *av2++ = "-a";
>> +               }
>> +               *av2++ = savepath;
>> +               *av2++ = NULL;
>> +               cmd2.in = demux.out;
>> +               e = pipe(pipefds);
>> +               if (e != 0)
>> +                       die("couldn't make pipe to save pack");
>
>
> start_command() can create the pipe for you. Just say cmd2.out = -1.
>
>> +               cmd2.out = pipefds[1];
>> +               cmd.in = pipefds[0];
>> +               if (start_command(&cmd2))
>> +                       die("couldn't start tee to save a pack");
>
>
> When you call start_command(), you must also call finish_command().
start_command() prints an error message for you; you don't have to do that
(the start_command() in the context below is a bad example).

I looked around, and there are nonzero exit paths from start_command()
which do not print an error and die, so this seems safer. It's also in line
with the vast majority of uses of start_command in the codebase, so I left
this as-is. If you've got something specific you'd like to see here
instead, do let me know (presumably I still need to check the error code
from start_command()...)

>
>
>
>> +       } else
>> +               cmd.in = demux.out;
>>         cmd.git_cmd = 1;
>>         if (start_command(&cmd))
>>                 die("fetch-pack: unable to fork off %s", cmd_name);

[snip some good comments about test cleanups, all addressed]

>
> -- Hannes
>

I'll wait to mail a v3 until at least I know what's going on with
start_command() and error checking - perhaps until I get consensus on the
use of tee vs something else to save the bytes from the server.

https://github.com/durin42/git/commit/save-pack has the current version of
the patch if you want to see where it stands now.

Thanks for the review!

Augie
