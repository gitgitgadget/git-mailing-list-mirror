From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Wed, 10 Jun 2015 15:19:20 -0700
Message-ID: <xmqq7frbi4uv.fsf@gitster.dls.corp.google.com>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:19:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2oLI-0000lr-3a
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 00:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbbFJWTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 18:19:24 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:33370 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbFJWTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 18:19:22 -0400
Received: by ierx19 with SMTP id x19so7477826ier.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cJIbgfFs9XYbs6sHEVwRZwYHovc3YoHTdNDbEicqLl4=;
        b=Grr9UBYQKfmiZtadtqX3D2Xe5lg48aZXNiKgrjD6BXd5XA8GsP+MDEVDIBjrIUDRe9
         PFJCpan/js9yGs+2uIf/meZKZJIflUD5MVPg9HTgBMjhMZ0bZmoTL+WdTmoCUTuHhLdj
         qWbCKVIa4BjXJ293OJVb2mfrOjoWqCRE0iJRgaPMQsV2PuHyuM9bqjaE2X2ejx0sLC4w
         LtZY2Ur3HE59pqJT5Labn/YVfR8ONM1F/mo4ef5EklgFQPX//Rvk8I6h8c5T/ajzLULJ
         anUqqm29Vrzq5iYBntcv7VS6ezPkbGVRcU0V1O3/WnG0Na6MF4/5X/41Jr9escnH191H
         BZUw==
X-Received: by 10.107.168.164 with SMTP id e36mr7164083ioj.87.1433974762051;
        Wed, 10 Jun 2015 15:19:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id l1sm6880658ioe.32.2015.06.10.15.19.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 15:19:21 -0700 (PDT)
In-Reply-To: <xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 14:16:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271362>

Junio C Hamano <gitster@pobox.com> writes:

> I like this change very much; it removes the mysteriously misnamed
> start-bad-good variable (because you do not really _care_ that
> 'start' was what implicitly decided that good/bad pair is the term
> we use in this session; what you care is that the terms are already
> known or not).
>
> That is another reason why I think it would be a better organization
> for the patch series to do without the intermediate "we now add new/old
> as another hardcoded values on top of the traditional bad/good".
>
> That is, I would think a reasonable progression of the series would
> look more like these three steps:
>
>  - preliminary clean-up steps (e.g. "correct 'mistook'");
>
>  - use $name_new and $name_old throughout the code, giving them
>    'bad' and 'good' as hardcoded values; finally
>
>  - add 'bisect terms' support.

Just in case I confused readers with a message that apparently
conflicts with what I said in the ancient thread:

  http://thread.gmane.org/gmane.comp.version-control.git/199758/focus=200025

I am admitting that I was wrong.  Or perhaps I was right back then,
but the world has changed ;-).

We have been hearing "bisect bad/good" is hard to use for the last 3
years since that thread discussed this topic, and that made me
realize that addition of single new/old may not be good enough, and
we should bite the bullet to support 'bisect terms' properly, making
bad/good and new/old even less special (contrary to what I said back
then in that thread "we only need these two pairs"), following the
suggestion by Phil Hord in that thread.

And the suggested three-step approach above reflects that new world
order in my mind.  We admit that the machinery should have been
built around a value-agnostic "old vs new" in the first place, but
unfortunately it wasn't.  So we belatedly update the system to use
these two terms internally to express the logic by naming the
variables name_old and name_new after these two value-agnostic
concepts, and then support the traditional "good vs bad" as a mere
default values for the names of old and new states.

One thing I forgot to say in the review of this patch:

> +bisect_terms () {
> +	test $# -eq 2 ||
> +	die "You need to give me at least two arguments"
> +
> +	if ! test -s "$GIT_DIR/BISECT_START"
> +	then
> +		echo $1 >"$GIT_DIR/BISECT_TERMS" &&
> +		echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
> +		echo "1" > "$GIT_DIR/TERMS_DEFINED"
> +	else
> +		die "A bisection has already started, please use "\
> +		"'git bisect reset' to restart and change the terms"
> +	fi
> +}
> +

I think "git bisect terms" is a good way to help a user to recall
what two names s/he decided to use for the current session.  So
dying 'already started' with suggestion for 'reset' is OK, but at
the same time, helping the user to continue the current bisection by
giving a message along the lines of "You are hunting for a commit
that is at the boundary of the old state (you are calling it
'$NAME_OLD') and the new state ('$NAME_NEW')" would be a good idea.

Thanks.
