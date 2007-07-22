From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [PATCH] Added 'git-rev-list --igrep' option for case insensitive grep
Date: Sun, 22 Jul 2007 00:52:12 -0700
Message-ID: <a1bbc6950707220052v3b9b5032sd1b95d7b9c229a84@mail.gmail.com>
References: <a1bbc6950707212233h6047ecfas645b71b9b4c6317e@mail.gmail.com>
	 <7v8x99t25s.fsf@assigned-by-dhcp.cox.net>
	 <7vwswtrmhe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 09:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICWEk-00068Z-Uj
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 09:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbXGVHwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 03:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbXGVHwP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 03:52:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:62107 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbXGVHwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 03:52:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1585620wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 00:52:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bK3s+sdh4YLN1su89N4D+kijYPYrWMbXQPBz7/g8QLEb/V+iiD4t5IbW/o7pG2O69nRHTe1QlA8qxIaj07wnT5E+HsCmmDYbJy63EFik4CG4AhcgJzzdyGrcjudCGIRQTGWptKQLza0H0rTIvuH6W0sPAmwqZZhcsHdR3EGsmiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pPhMP75ol35QzvTUG2EMn4rehpRX6LJvsxozZ5p9J6WWr+GIBTxY8weVgpw0XvPRVSwVm9wMlyVTJmWo7mkbBBeT2EY48HCpoIEcme/gO17DQUpsdKbwHyesRKJA/H0DBMOYwDBgZOojTH1KuHpYqEHwAs+4F2v/Hg/a9wzlfCo=
Received: by 10.141.19.16 with SMTP id w16mr613498rvi.1185090732992;
        Sun, 22 Jul 2007 00:52:12 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Sun, 22 Jul 2007 00:52:12 -0700 (PDT)
In-Reply-To: <7vwswtrmhe.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53231>

Sounds good to me.
Let's just put short option names in front of long names in the doc to
be consistent with other sections.

On 7/21/07, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Are there notable side effects you would need to warn users
> > about?
> >
> > For example, what is the difference between "--igrep=foo
> > --author=bar" and "--grep=foo --author=bar"?
>
> Nah, let's not try to be too subtle.  It does not work.
>
> What I am wondering is if there is an unintended option name
> conflict if we simply accept "-i" and "-E" as synonyms to
> "--regexp-ignore-case" and "--extended-regexp".  The option
> parser for log family in revision.c is used from many places,
> so it is a bit hard to verify everobody to be absolutely sure,
> but I do not think of any offhand.  There indeed are commands
> that take "-i" to mean something other than ignore-case, but
> ignore-case would not be meaningful for their operation.
>
> So I would rather prefer this replacement patch.
>
> -- >8 --
> Synonyms: -i == --regexp-ignore-case, -E == --extended-regexp
>
> These options to log family were too long to type.  Give them
> shorter synonyms.
>
> Fix the parsing of the long options while at it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rev-list.txt |    7 ++++---
>  revision.c                     |    6 ++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 08e7573..f9fadaf 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -27,7 +27,8 @@ SYNOPSIS
>              [ \--cherry-pick ]
>              [ \--encoding[=<encoding>] ]
>              [ \--(author|committer|grep)=<pattern> ]
> -            [ \--regexp-ignore-case ] [ \--extended-regexp ]
> +            [ \--regexp-ignore-case | \-i ]
> +            [ \--extended-regexp | \-E ]
>              [ \--date={local|relative|default|iso|rfc|short} ]
>              [ [\--objects | \--objects-edge] [ \--unpacked ] ]
>              [ \--pretty | \--header ]
> @@ -227,11 +228,11 @@ limiting may be applied.
>         Limit the commits output to ones with log message that
>         matches the specified pattern (regular expression).
>
> ---regexp-ignore-case::
> +--regexp-ignore-case, -i::
>
>         Match the regexp limiting patterns without regard to letters case.
>
> ---extended-regexp::
> +--extended-regexp, -E::
>
>         Consider the limiting patterns to be extended regular expressions
>         instead of the default basic regular expressions.
> diff --git a/revision.c b/revision.c
> index 7036cf2..00b75bc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1165,11 +1165,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>                                 add_message_grep(revs, arg+7);
>                                 continue;
>                         }
> -                       if (!prefixcmp(arg, "--extended-regexp")) {
> +                       if (!strcmp(arg, "--extended-regexp") ||
> +                           !strcmp(arg, "-E")) {
>                                 regflags |= REG_EXTENDED;
>                                 continue;
>                         }
> -                       if (!prefixcmp(arg, "--regexp-ignore-case")) {
> +                       if (!strcmp(arg, "--regexp-ignore-case") ||
> +                           !strcmp(arg, "-i")) {
>                                 regflags |= REG_ICASE;
>                                 continue;
>                         }
>
>
