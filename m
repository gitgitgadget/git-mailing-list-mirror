From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git interpret-trailers'
Date: Sun, 26 Jan 2014 19:52:59 -0500
Message-ID: <CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
	<20140126170011.24291.26146.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jan 27 01:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7aRm-0008I8-Hk
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 01:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbaA0AxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 19:53:03 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:37587 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0AxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 19:53:01 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so3966953lab.2
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 16:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+gR1mgpzxatozJS1raCfVuZsOmCDKRU/g0Qr93UqJ/s=;
        b=xROIHAQQl8WDTUa2Iohi+kOUegVs+PAVblYRW+e+2Z1SeZJri7Ckh6Kj5t9AGQ5e5h
         Xs0fkNLhXU/Njg+02gfB3VP7nBlTxMpMl/Loq4tIE99UNpzjykd1DrmnydP82kqo92B3
         /vRKTIVJr4xk5y2BSKysfT6QgYBoUGtQUk8D33eAw83DyDvs4fMUr4ZqTPF73wdy5eWE
         OZDcBasEJBRL3cbAUm3BHMW2THkkPduT+ardsC5gcA3uHGWO/IFr1Tmc67Cl31hT6tpy
         MaUeKUuomRfAy+KbSiwq5qbOhcIVGlH6vFz3fOWZEI62Zhv437UgrL40PTqlrMfwd+l4
         2CAw==
X-Received: by 10.152.3.10 with SMTP id 10mr819288lay.35.1390783979741; Sun,
 26 Jan 2014 16:52:59 -0800 (PST)
Received: by 10.114.181.228 with HTTP; Sun, 26 Jan 2014 16:52:59 -0800 (PST)
In-Reply-To: <20140126170011.24291.26146.chriscool@tuxfamily.org>
X-Google-Sender-Auth: 36HlETjCFtBk6XiTuxU1CH7ckeo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241124>

On Sun, Jan 26, 2014 at 12:00 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> new file mode 100644
> index 0000000..f74843e
> --- /dev/null
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -0,0 +1,137 @@
> +git-interpret-trailers(1)
> +=========================
> +
> +NAME
> +----
> +git-interpret-trailers - help add stuctured information into commit messages
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git interpret-trailers' [--trim-empty] [--infile=file] [<token[=value]>...]

Would it be more consistent with existing documentation to format this as so?

  [--infile=<file>] [<token>[=<value>]]...

> +DESCRIPTION
> +-----------
> +Help add RFC 822 like headers, called 'trailers', at the end of the

s/822 like/822-like/

Was the suggestion, early in the discussion, to use "footer" rather
than "trailer" dismissed?

> +otherwise free-form part of a commit message.
> +
> +Unless `--infile=file` is used, this command is a filter. It reads the
> +standard input for a commit message and apply the `token` arguments,

s/apply/applies/

> +if any, to this message. The resulting message is emited on the
> +standard output.
> +
> +Some configuration variables control the way the `token` arguments are
> +applied to the message and the way any existing trailer in the message
> +is changed. They also make it possible to automatically add some
> +trailers.
> +
> +By default, a 'token=value' or 'token:value' argument will be added
> +only if no trailer with the same (token, value) pair is already in the
> +message. The 'token' and 'value' parts will be trimmed to remove
> +starting and trailing white spaces, and the resulting trimmed 'token'

Other git documentation uniformly spells it as "whitespace" rather
than "white spaces".

> +and 'value' will appear in the message like this:
> +
> +------------------------------------------------
> +token: value
> +------------------------------------------------
> +
> +By default, if there are already trailers with the same 'token' the
> +trailer will appear just after the last trailer with the same

It might be a bit clearer to say "the _new_ trailer will appear...".

> +'token'. Otherwise it will appear at the end of the message.
> +
> +Note that 'trailers' do not follow and are not intended to follow many
> +rules that are in RFC 822. For example they do not follow the line
> +breaking rules, the encoding rules and probably many other rules.
> +
> +Trailers have become a de facto standard way to add helpful structured
> +information into commit messages. For example the well known
> +"Signed-off-by: " trailer is used by many projects like the Linux
> +kernel and Git.

This "justification" paragraph might make more sense near or at the
very the top of the Description section.

> +OPTIONS
> +-------
> +--trim-empty::
> +       If the 'value' part of any trailer contains onlywhite spaces,

s/onlywhite spaces/only whitespace/

> +       the whole trailer will be removed from the resulting message.
> +
> +----infile=file::
> +       Read the commit message from `file` instead of the standard
> +       input.
> +
> +CONFIGURATION VARIABLES
> +-----------------------
> +
> +trailer.<token>.key::
> +       This 'key' will be used instead of 'token' in the
> +       trailer. After some alphanumeric characters, it can contain
> +       some non alphanumeric characters like ':', '=' or '#' that will
> +       be used instead of ':' to separate the token from the value in
> +       the trailer, though the default ':' is more standard.
> +
> +trailer.<token>.where::
> +       This can be either `after`, which is the default, or
> +       `before`. If it is `before`, then a trailer with the specified
> +       token, will appear before, instead of after, other trailers
> +       with the same token, or otherwise at the beginning, instead of
> +       at the end, of all the trailers.
> +
> +trailer.<token>.ifexist::
> +       This option makes it possible to chose what action will be

s/chose/choose/

> +       performed when there is already at least one trailer with the
> +       same token in the message.
> ++
> +The valid values for this option are: `addIfDifferent` (this is the
> +default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
> ++
> +With `addIfDifferent`, a new trailer will be added only if no trailer
> +with the same (token, value) pair is already in the message.
> ++
> +With `addIfDifferentNeighbor`, a new trailer will be added only if no
> +trailer with the same (token, value) pair is above or below the line
> +where the new trailer will be added.
> ++
> +With `add`, a new trailer will be added, even if some trailers with
> +the same (token, value) pair are already in the message.
> ++
> +With `overwrite`, the new trailer will overwrite an existing trailer
> +with the same token.
> ++
> +With `doNothing`, nothing will be done, that is no new trailer will be
> +added if there is already one with the same token in the message.
> +
> +trailer.<token>.ifmissing::
> +       This option makes it possible to chose what action will be

s/chose/choose/

> +       performed when there is not yet any trailer with the same
> +       token in the message.
> ++
> +The valid values for this option are: `add` (this is the default) and
> +`doNothing`.
> ++
> +With `add`, a new trailer will be added.
> ++
> +With `doNothing`, nothing will be done.
> +
> +trailer.<token>.command::
> +       This option can be used to specify a shell command that will
> +       be used to automatically add or modify a trailer with the
> +       specified 'token'.
> ++
> +When this option is specified, it is like if a special 'token=value'
> +argument is added at the end of the command line, where 'value' will
> +be given by the standard output of the specified command.

What happens if the text returned by the command has multiple lines?
Should the documentation say something about this?

> +If the command contains the `$ARG` string, this string will be
> +replaced with the 'value' part of an existing trailer with the same
> +token, if any, before the command is launched.
> ++
> +The following environment variables are set when the command is run:
> +GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME,
> +GIT_COMMITTER_EMAIL.
> +
> +SEE ALSO
> +--------
> +linkgit:git-commit[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> --
> 1.8.5.2.201.gacc5987
