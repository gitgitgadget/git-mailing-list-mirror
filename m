From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Fri, 10 Jul 2015 09:20:21 -0700
Message-ID: <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:20:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDb2N-0002B6-An
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 18:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbbGJQU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 12:20:27 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33260 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbbGJQUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 12:20:25 -0400
Received: by iggp10 with SMTP id p10so38627833igg.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ydb1mNi37cHAo3dnkOCxmbJi3qZbwl6xR4jzbKCZn6o=;
        b=C+Fav4nuJY0xZTk3efvLA0zGi9A2N2YSj4oLGn34eiw5ST6G2i1YDWGMoYP5P/aLv4
         SimuPoaRFphO9EgR6CsyEmSPrlvlGEG0AtJ+PwTbWgxL8i303KpnMKi7WqeID2jXNGMw
         4WniGR2w3M+COl0X/taUdpyljEyjIh5gs+qoKggwiYKQwPi3l/lFxiINX4qpkKpZ4MFa
         NlMtWtRNq+az4H2K2hkXpuDempAjiRp72dcH2PizMUZC7gC9OFXKS4Kya5GdO5svie35
         WHCGEZiy+A6xw2Hbj4LFaK7yWLRdl31xcNOQEuKY1hhWcJWG26wMKnK4IbL3K5GvFRuA
         70EQ==
X-Received: by 10.50.49.34 with SMTP id r2mr4228240ign.66.1436545224673;
        Fri, 10 Jul 2015 09:20:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id o19sm1682037igi.14.2015.07.10.09.20.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 09:20:22 -0700 (PDT)
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 9 Jul 2015 15:57:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273822>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add support for %(refname:shortalign=X) where X is a number.
> This will print a shortened refname aligned to the left
> followed by spaces for a total length of X characters.
> If X is less than the shortened refname size, the entire
> shortened refname is printed.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

This may be enough to support the various existing formats that are
offered by "git branch" and/or "git tag", but I do not think if this
is the right approach in the longer term, or if we are painting
ourselves in a corner we cannot cleanly get out of later [*1*].
Will the "refname" stay to be the only thing that may want alignment
padding appended in the future?  Will it stay true that we want to
align only to the left?  Etc., etc.

Cc'ed Duy as %< in the pretty-format was his invention at around
a5752342 (pretty: support padding placeholders, %< %> and %><,
2013-04-19).

> diff --git a/ref-filter.c b/ref-filter.c
> index dd0709d..3098497 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -10,6 +10,7 @@
>  #include "quote.h"
>  #include "ref-filter.h"
>  #include "revision.h"
> +#include "utf8.h"
>  
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  
> @@ -695,7 +696,23 @@ static void populate_value(struct ref_array_item *ref)
>  			int num_ours, num_theirs;
>  
>  			formatp++;
> -			if (!strcmp(formatp, "short"))
> +			if (starts_with(formatp, "shortalign=")) {

When adding a new thing to an existing list, we prefer to append it
at the end of the list, if there is no other reason not to do so
(e.g. "the existing list is sorted in this order, and the new
location was chosen to fit the new item to honor the existing
ordering rule" is a valid reason to put it at the beginning, if the
existing sorting rule dictates that the new thing must come at the
beginning).

> +				const char *valp, *short_refname = NULL;
> +				int val, len;
> +
> +				skip_prefix(formatp, "shortalign=", &valp);
> +				val = atoi(valp);

In newer code, we would want to avoid atoi() so that "foo:shortalign=1z"
that is a typo of "12" can be caught as an error.  Either strtol_i()
or strtoul_ui() may be better (we would need to adjust it further
when Michael decides to resurrect his numparse thing that has been
in the stalled bin for quite a while, though).

> +				refname = short_refname = shorten_unambiguous_ref(refname,
> +										  warn_ambiguous_refs);
> +				len = utf8_strwidth(refname);
> +				if (val > len) {
> +					struct strbuf buf = STRBUF_INIT;
> +					strbuf_addstr(&buf, refname);
> +					strbuf_addchars(&buf, ' ', val - len);
> +					free((char *)short_refname);
> +					refname = strbuf_detach(&buf, NULL);
> +				}

What should happen when the display column width of the string is
wider?  If a user wants to align the refs that are usually usually
short start the next thing at the 8th column, which should she use?

    "%(refname:shorta=7) %(next item)"
    "%(refname:shorta=8)%(next item)"

> +			} else if (!strcmp(formatp, "short"))
>  				refname = shorten_unambiguous_ref(refname,
>  						      warn_ambiguous_refs);
>  			else if (!strcmp(formatp, "track") &&
