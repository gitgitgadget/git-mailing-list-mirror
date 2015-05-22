From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 00:29:53 -0400
Message-ID: <CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 06:30:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yveat-0001Td-8O
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 06:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbbEVE3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 00:29:54 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35077 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbEVE3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 00:29:53 -0400
Received: by igbyr2 with SMTP id yr2so26890074igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=j6TTdKY8rqm9zvZxZPoGuLRoVlhYXYLXW+0E2WVqqNo=;
        b=kR7o2XXIahWzVNLmFNdHaoUALBIfGJssli/Oglh5gnKX1lQGX9cCwVXRFtyfxTBm44
         ZcxFyf2aQxc95X2+TP55DWbK1TrZ0qk7B0FWRxL+RDuHs+vOhMvca229PgypV/s6ut6t
         NkHG83mlhEKxWtK9s2n45R/NLhCOlwQfkBN+7S56kbxuh7poiEPzivEdmuIc4tugOIRs
         tFLryasfLsGte/SRMv0ab5Ot+FWEnIZSC/QMg5vBypRjNnv83BSvfA0+OwYRvXc5Cpor
         ygyslzkefqZ9jBuQZUY0Bc6f3hQmHulRHWCXvfSLcxrpw6dipYPhql0t0TiqeR1lozZg
         3msA==
X-Received: by 10.107.137.80 with SMTP id l77mr1677361iod.92.1432268993305;
 Thu, 21 May 2015 21:29:53 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 21:29:53 -0700 (PDT)
In-Reply-To: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
X-Google-Sender-Auth: TqoLCdA67yQ6HkCdMwlaTTngnFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269689>

On Thu, May 21, 2015 at 11:40 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> This format is more simple than the other alias file formats, so it may
> be preferred by some users. [...]
> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 804554609def..38ade31e0c28 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -383,7 +383,29 @@ sendemail.aliasesFile::
>
>  sendemail.aliasFileType::
>         Format of the file(s) specified in sendemail.aliasesFile. Must be
> -       one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> +       one of 'simple', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> ++
> +If the format is 'simple', then the alias file format is described below.
> +Descriptions of the other file formats to the following formats can be found in
> +the documentation of the email program of the same name.

The second sentence probably needs some proof-reading.

> ++
> +This 'simple' format is is as follows.
> ++
> +       <alias>: <address|alias>[, <address|alias>...]
> ++
> +Aliases are specified one per line.  There is no line splitting.  Anything on a
> +line after and including a `#` symbol is considered a comment, and is ignored.
> +Blank lines are ignored.

I'm not convinced that gratuitously diverging from the
sendmail/postfix 'aliases' format is warranted. In particular, that
format recognizes a comment line only when '#' is the first
non-whitespace character[1]; and does not consider '#' a
comment-introducer anywhere else in the line. By recognizing '#'
anywhere as a comment-introducer, you may be painting this format into
a corner rather than leaving it open for someone later to extend it to
be more sendmail/postfix-like by, for instance, supporting name
quoting and line-continuation[1].

For the same reason, I'm not convinced that "simple" is a good name.
"sendmail" may indeed be a more appropriate name, even if it means
that this early implementation documents it as (currently) a subset of
the richer sendmail/postfix 'aliases' format. By doing so, we leave
the door open so a future person can implement additional features to
bring it closer to that format.

[1]: http://www.postfix.org/aliases.5.html

> ++
> +Example of the 'simple' format:
> ++
> +       alice: Alice W Land <awol@example.com>
> +       bob: Robert Bobbyton <bob@example.com>
> +       # this is a comment
> +          # this is also a comment
> +       chloe: chloe@example.com
> +       abgroup: alice, bob # comment after an alias
> +       bcgrp: bob, chloe, Other <o@example.com>
