From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 00/10] bisect terms
Date: Mon, 29 Jun 2015 09:44:33 -0700
Message-ID: <xmqq4mlqcvm6.fsf@gitster.dls.corp.google.com>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9cAj-0001I5-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 18:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbbF2Qoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 12:44:37 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33640 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbbF2Qof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 12:44:35 -0400
Received: by igcur8 with SMTP id ur8so41710751igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fMtlDbpivmoJiKFvaZUczMsVR/HO/gXR/z39GhNVVD0=;
        b=Foq/vV+qgQSFhD4rmNN7ggsNiyw2z1loDtdvs0Ub2PezNOx0ztj44voqS0X3sIELSs
         M6LRxV+dg8mu+q8xuqAe4K1wVly4ibz32I0JClIQIuDjfp4KO/n8j4aJZHfJGJ7mk//T
         FkhMi7AWOSyad8rFmH4awDKCtBba3q8cEdKI+FwlOg80QPZYnw5KMgRyqPXnTSEyWHG9
         FyN4pO4aLzd6ZYc/HAS8l3X4UDgWBbY1lgmYHcwiKa73u7b6SWEZaGxltRIcF+yT4gpy
         C76wGSPtNcVdosy0svMHADExh7m7BzZGw/gebj01X75LmLYfFKnvjzVoD6mArsinTSgg
         tgjQ==
X-Received: by 10.50.43.227 with SMTP id z3mr16701823igl.12.1435596274753;
        Mon, 29 Jun 2015 09:44:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id h138sm28031156ioe.2.2015.06.29.09.44.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 09:44:34 -0700 (PDT)
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 29 Jun 2015 17:40:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272972>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> So, here's a reroll that tries to address the ongoing discussion.
>
> The first patches are preparatory steps, which are IMHO good
> regardless of the features. I kept the user-interface to chose terms
> at the end, and tried to keep the UI patches as small as possible.
>
> I have the feeling that "bisect: add the terms old/new" should be
> dropped, but I have no strong opinion on that. If you like the
> feature, say so. If you think the feature doesn't bring enough, and
> should eventually be obsoleted by "guess which commit is old and which
> is new", say so too.

I personally do not mind having old/new, as long as it does not make
it harder to build on top of the codebase (and existing user
experience) to eventually transition to "you can always say good or
bad and we'll figure out which of old/new they map to".  Obviously
we will never guess which is old/new when the user uses old/new as
the chosen terms, and having to special case that might complicat
things, which is where that "as long as it does not make it harder"
above comes from.

> The beginning of the series didn't change much since v10. The major
> change is that I gave up using "git bisect terms <foo> <bar>", and
> implemented the same feature in "git bisect start". We're losing the
> ability to run "git bisect terms" several times to change the terms
> before we use them, but I'm not sure this was a useful feature. OTOH,
> we're back to the principle "git bisect start" starts from a fresh
> state, this avoids confusing the situation where the user has leftover
> from yesterday's "git bisect terms". And the code is much, much
> simpler.

I like that direction.  But let's first wait to see what others say.

Thanks.

>
> Antoine Delaite (4):
>   bisect: correction of typo
>   bisect: replace hardcoded "bad|good" by variables
>   bisect: simplify the addition of new bisect terms
>   bisect: add the terms old/new
>
> Matthieu Moy (5):
>   Documentation/bisect: move getting help section to the end
>   bisect: don't mix option parsing and non-trivial code
>   bisect: sanity check on terms
>   bisect: add 'git bisect terms' to view the current terms
>   bisect: allow setting any user-specified in 'git bisect start'
>
> Michael Haggerty (1):
>   Documentation/bisect: revise overall content
>
>  Documentation/git-bisect.txt | 236 ++++++++++++++++++++++++++++-----------
>  bisect.c                     |  94 ++++++++++++----
>  git-bisect.sh                | 255 +++++++++++++++++++++++++++++++++++--------
>  revision.c                   |  19 +++-
>  t/t6030-bisect-porcelain.sh  | 137 ++++++++++++++++++++++-
>  5 files changed, 612 insertions(+), 129 deletions(-)
