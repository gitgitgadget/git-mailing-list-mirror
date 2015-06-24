From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 5/5] bisect: allow any terms set by user
Date: Wed, 24 Jun 2015 10:46:01 -0700
Message-ID: <xmqqa8vp9ezq.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:46:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7oki-0006hh-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbbFXRqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:46:06 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33591 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbFXRqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:46:04 -0400
Received: by ieqy10 with SMTP id y10so38356914ieq.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vR5OB7my5rbgkylDRPkEczDTsmTGVBbZ7g7rW8Oroqk=;
        b=OLkm8tZmad91xvzSFhRfmTEtg8uvYT4exWiepWY5ajlFwXFPuHTsao6rsQXZKJSSnr
         in+8WBew8DxVOXev+LUOG6hV2h2pWXXQqtUOIZU8gVVKRsiYbOT0PVlHSB7SG+XPwQBA
         7pq8oC/mTNtMbMk7mzY5qCCntU8Vxz87dGessB1UsWxOB3/knfHrE231CSjmNKepLqUi
         iC9o2IHQgzb8eWWlgrBXZNpbW2SCeoB8SlLIbbb0Yc3I02LW6o/1107KdA5wYkr+E11W
         /pl3xoJkaE3n4PHU1sJQHuDbyl7Uarvbtpov2RuQ2ejQRvv/j1ghVIfLc/CZeL5lMVkb
         zyZw==
X-Received: by 10.50.79.129 with SMTP id j1mr1337982igx.32.1435167963621;
        Wed, 24 Jun 2015 10:46:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id j3sm1479126ige.0.2015.06.24.10.46.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 10:46:02 -0700 (PDT)
In-Reply-To: <1435159062-23468-6-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 24 Jun 2015 17:17:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272572>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +Alternative terms: use your own terms
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If the builtins terms bad/good and new/old do not satisfy you, you can
> +set your own terms.
> +
> +------------------------------------------------
> +git bisect terms term1 term2
> +------------------------------------------------
> +
> +This command has to be used before a bisection has started.
> +The term1 must be associated with the latest revisions and term2 with the
> +ancestors of term1.

While this is not incorrect per-se, it would be more helpful to tell
the readers that they are hunting for a commit that changes the state
they would call "term2" into "term1" somewhere.  e.g.

	-ancestors of term1.
	+ancestors of term1.  For example, if something was buggy in
        +the old part of the history, you know somewhere the bug was
	+fixed, and you want to find the exact commit that fixed it,
        +you may want to say `git bisect terms fixed broken`; this
        +way, you would mark a commit that still has the bug with
        +`broken`, and a newer one after the fix with `fixed`.

or something?

> -USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
> +USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
>  LONG_USAGE='git bisect help
>  	print this long help message.
>  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
> @@ -11,6 +11,8 @@ git bisect (bad|new) [<rev>]
>  git bisect (good|old) [<rev>...]
>  	mark <rev>... known-good revisions/
>  		revisions before change in a given property.
> +git bisect terms term1 term2
> +	set up term1 and term2 as bisection terms.

This will not help those who cannot remember which one between these
two they want:

	git bisect terms new old
        git bisect terms old new

I am wondering (together with the documentation patch) if it would
be better to be more explicit, instead of term[12], like this:

	git bisect terms new old

or even

	git bisect terms bad good

assuming that the only reason they use 'terms' is because they are
sufficiently familiar with 'git bisect' and (intellectually) know
that 'bad' is more recent and 'good' is what it used to be, but have
trouble remembering which one is which during a hunt for a fix.

> +bisect_terms () {
> +	case "$#" in
> +	0)
> +		if test -s "$GIT_DIR/BISECT_TERMS"
> +		then
> +			{
> +			read term1
> +			read term2
> +			}<"$GIT_DIR/BISECT_TERMS"
> +			gettextln "Your current terms are $term1 and $term2."

The same comment on this part.  Instead of "git bisect terms" that
just says "You are using $term1 and $term2", the users would benefit
if it said "You are using $term1 for newer state and $term2 for
older state" [*1*].

Thanks.


[Footnote]

*1* It is funny that I had to rewrite this "if it said..." a few
times to make sure I got newer and older right, even though I had
the relevant pieces (and only releavant pieces) of information for
the doc and help text in a single patch form while composing this
response.  I suspect that an end user without such material would be
a lot more confused than I was.
