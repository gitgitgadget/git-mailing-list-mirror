From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/17] trailer: add interpret-trailers command
Date: Fri, 31 Jan 2014 11:10:31 -0500
Message-ID: <CAPig+cRMBDr1D+3ad6y95ucxynO1qbRnsbUAfjtLkoR3+mjxZg@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.75845.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 17:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Gfs-0003Wm-V9
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 17:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbaAaQKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 11:10:32 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:41788 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbaAaQKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 11:10:32 -0500
Received: by mail-yk0-f170.google.com with SMTP id 9so24476397ykp.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=whRYZkzGqe14Mexzhv8qKhHNPFHOs0VE2YvWuBjt7Dk=;
        b=ps8zbMoaQ5l3JS0nAf/EFOOqm/HdhiIEwVTxTeJwOJCEsT4l5Evo12Eij8BlYAgWYO
         LIbUXV1/kbTHOMuzzjpEthWy+LSL/dl94qnCSza3xswv6cULUPkV0SqzchEnrSMKgXvC
         kJNZDSdRbb2igij2PNnV8Gl25OElLq1YcN5BuvM+T3D8v80VLQ46EpqZCIkkRrL0tHqK
         XEjQk8uTuRdjrWLAJbBd56sHYB+kDiQYw+SBzLohf44xu4Xt1B3ZOSLa34CSjMnet61X
         48bXMCLlhG/XJUo+wWxfTU97YEEuxkGdh798R01+R1X9WieTccZxL5IfuhZuRYTpyI5z
         Ng7A==
X-Received: by 10.236.129.198 with SMTP id h46mr19713380yhi.17.1391184631647;
 Fri, 31 Jan 2014 08:10:31 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Fri, 31 Jan 2014 08:10:31 -0800 (PST)
In-Reply-To: <20140130064921.7504.75845.chriscool@tuxfamily.org>
X-Google-Sender-Auth: f7YAijKkLDzj-EvCT6B_9Px-ThU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241300>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch adds the "git interpret-trailers" command.
> This command uses the previously added process_trailers()
> function in trailer.c.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> new file mode 100644
> index 0000000..04b0ae2
> --- /dev/null
> +++ b/builtin/interpret-trailers.c
> @@ -0,0 +1,36 @@
> +int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
> +{
> +       const char *infile = NULL;
> +       int trim_empty = 0;
> +
> +       struct option options[] = {
> +               OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
> +               OPT_FILENAME(0, "infile", &infile, N_("use message from file")),
> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                            git_interpret_trailers_usage, 0);
> +
> +       process_trailers(infile, trim_empty, argc, argv);
> +
> +       return 0;
> +}
> diff --git a/trailer.h b/trailer.h
> new file mode 100644
> index 0000000..9db4459
> --- /dev/null
> +++ b/trailer.h
> @@ -0,0 +1,6 @@
> +#ifndef TRAILER_H
> +#define TRAILER_H
> +
> +void process_trailers(const char *infile, int trim_empty, int argc, const char **argv);
> +
> +#endif /* TRAILER_H */

One might reasonably expect trailer.h and the process_trailers()
declaration to be introduced by patch 7/17 ("trailer: put all the
processing together and print") in which process_trailers() is defined
in trailer.c.
