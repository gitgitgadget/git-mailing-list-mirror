From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tag.c: move PGP verification code from plumbing
Date: Fri, 25 Mar 2016 01:23:57 -0400
Message-ID: <CAPig+cQe5bwHXq4_qegBCM8Kqoqiz7K2ZtVk0FGMSEUPWQHyYA@mail.gmail.com>
References: <1458866017-15490-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Fri Mar 25 06:24:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajKE7-0001Jm-LS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 06:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcCYFX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 01:23:59 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33379 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbcCYFX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 01:23:58 -0400
Received: by mail-vk0-f47.google.com with SMTP id k1so82268550vkb.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 22:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=x079Qdh8+ymJD7y02x675uo7JLAaYzfq0IqdioKNqg0=;
        b=FYBApxSdj3NzklmcS3Y3OhjrKGGOw0zjn/JU5HWMWaWZvknqIZw4i/KGXJLPlFmQnx
         uu3N/K3MCZbwsq514g0aeHWajt9nEH0afz+90UrvUBS2AvrSqhlL0Iyz2ji+KcY6dpMS
         EkjTWPkY8DDqdiXUMp3yEz3wZnzvidSB1k6+UoJp9iU20frBP1zzSs/1BRN0SZBOp9Ds
         7JR0IA2rvJ7cuSR88DoMu01pFX1PTLs5V4oRCk3XeDgO3nGRw3jspGuDYS8Rg+oXcVSz
         0uu7FhO9xVdVFKS6BAUpgGD1fXMcXd8TGVEq9JTgCllTUVFu83eAev+vYZQx8SpoiRfX
         Pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=x079Qdh8+ymJD7y02x675uo7JLAaYzfq0IqdioKNqg0=;
        b=hDY1eHm2DB8oYDjT6EFKmZTgp7YmtdVpw2G9wneUpJE33w41g4NYo1tM1D0IXORluN
         9BDl1joTE+V1vb+kLu1uCh2hVlQ9Mit6I7HrlY2vMU/fa3n5Rd7OBX+4wG4G00Od0hpy
         BA6AKMCFZWyY+sduV8ywnHG8qfTatohOUbz1AuWUrF1Xi21pid10eRM1w6i9XMNDO+dK
         u/9M47kDsZU3PV7dGfTXIeGiiMR/OUS7Yf2fAd3bpF3mF2Wh/4Gsr33RpOecWIKhtLep
         1VGCPZRUXDTm9ZKQDURvk+nQ+uXWEcbilOq/nJqYLCUPpWbxtJYnhyK8BUVvQ6ZXevbu
         lkBA==
X-Gm-Message-State: AD7BkJJv6if/pVIRder4S9I64srMyOwhqFYomyGEAhK1av6EGk37mfXwPOs0UzZr9n2vADb4p8isoqaDp3fIug==
X-Received: by 10.176.2.143 with SMTP id 15mr6674603uah.113.1458883437308;
 Thu, 24 Mar 2016 22:23:57 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 22:23:57 -0700 (PDT)
In-Reply-To: <1458866017-15490-1-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: ybizJH1fAmGIqohLRVJtUPpp6wE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289847>

On Thu, Mar 24, 2016 at 8:33 PM,  <santiago@nyu.edu> wrote:
> The verify tag function is just a thin wrapper around the verify-tag
> command. We can avoid one fork call by doing the verification inside
> the tag builtin instead.

Hopefully, the below review comments are meaningful, however, aside
from having just read Peff's review of the previous version of this
patch, I haven't been following this discussion, so it's possible some
comments may be off the mark. Caveat emptor.

> To do this, the run_pgp_verify() and verify_tag() functions are moved to
> tag.c. The definition of verify_tag was changed to support extra
> arguments that match the builtin/tag and builtin/verify-tag modules. The
> SIGPIPE ignore call in tag-verify was also moved to a more sensible
> place, now that both modules need it.

This patch is doing too much, thus making it difficult to review and
reason about. Based upon this paragraph alone, you may want to split
the patch into three or more patches. At the very least, have a patch
which does the code movement (and nothing else); one which adjusts the
argument lists; and one which adjusts SIGPIPE handling. More
generally, figure out the distinct conceptual changes being made here,
and give each such change its own patch.

> The function name was also changed to pgp_verify_tag to avoid conflicts with
> mktag.c's.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---

Right here below the "---" line is where, for the sake of reviewers,
you would explain what changed since the previous version. Also, as a
reviewer aid, provide a link to the previous discussion, like this[1].
Finally, indicate the version number of the patch in the subject, like
this [PATCH v3] (see git-format-patch's -v option).

More below...

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289803

> diff --git a/builtin/tag.c b/builtin/tag.c
> @@ -86,32 +87,22 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
>         return 0;
>  }
>
> -static int verify_tag(const char *name, const char *ref,
> -                               const unsigned char *sha1)
> -{
> -       const char *argv_verify_tag[] = {"verify-tag",
> -                                       "-v", "SHA1_HEX", NULL};
> -       argv_verify_tag[2] = sha1_to_hex(sha1);
>
> -       if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
> -               return error(_("could not verify the tag '%s'"), name);
> -       return 0;
> -}
>

This deletion inconsistently leaves an extra blank line between
functions; thus you'd want to delete one more (blank) line.

>  static int do_sign(struct strbuf *buffer)
>  {
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> @@ -95,11 +48,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>         if (verbose)
>                 flags |= GPG_VERIFY_VERBOSE;
>
> -       /* sometimes the program was terminated because this signal
> -        * was received in the process of writing the gpg input: */
> -       signal(SIGPIPE, SIG_IGN);
>         while (i < argc)
> -               if (verify_tag(argv[i++], flags))
> +               name = argv[i++];
> +               if (get_sha1(name, sha1))
> +                       return error("tag '%s' not found.", name);
> +
> +               if (pgp_verify_tag(NULL, NULL, sha1, flags))
>                         had_error = 1;

Meh, this isn't Python. Due to the missing braces, the only thing
inside the while() loop is the assignment to 'name'; all the other
indented code is outside the while().

Did you run the test suite following this change? Did it all pass? If
so, perhaps an additional test or two to catch this sort of error
would be warranted.

>         return had_error;
>  }
> diff --git a/gpg-interface.c b/gpg-interface.c
> @@ -232,6 +232,11 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>         if (gpg_output)
>                 gpg.err = -1;
>         args_gpg[3] = path;
> +
> +       /* sometimes the program was terminated because this signal
> +        * was received in the process of writing the gpg input.
> +        * We ignore it for this call and restore it afterwards */

I realize that the bulk of this comment block was merely relocated
from builtin/verify-tag.c, however, now would be a good time to fix
its style violation and format it like this:

    /*
     * This is a multi-line
     * comment.
     */

Also, the last line of the comment, which you added when relocating
it, merely repeats what the code itself already says clearly, thus is
not particularly useful and should be dropped.

> +       sigchain_push(SIGPIPE, SIG_IGN);
>         if (start_command(&gpg)) {
>                 unlink(path);
>                 return error(_("could not run gpg."));
> @@ -250,6 +255,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>         close(gpg.out);
>
>         ret = finish_command(&gpg);
> +       sigchain_pop(SIGPIPE);
>
>         unlink_or_warn(path);
