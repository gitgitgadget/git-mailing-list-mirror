From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Thu, 25 Jun 2015 14:41:49 -0700
Message-ID: <xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:41:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8EuE-0004cl-8p
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbbFYVly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:41:54 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33301 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbbFYVlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:41:52 -0400
Received: by igbqq3 with SMTP id qq3so24932017igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=P9hbv6onwPNsRNXNIkV6U/xN82PeeU5r/scNaQhbT1Q=;
        b=DBEhVFHqt1QAj+b2DsqR13f3lTulrBPEcw2KRuGgr27M7+u1X6CMKDxlmWNU+k0GtD
         gb902miNhCmM4Tn28wB2I6fQgnwx3CuApMZa34x1gj1CCMDnYzXSg2Qu9/DmJUzxAC1N
         uXTMP3W26sTWJ4hxFELPcbfxnFPX/pKqgifKtkBHnbFjAremS+4he7LPnrNR3FSXIkhz
         6HFMXkJVD/5EuYyfqFCxRZGho3ufcwZUCa3wPXReif0yuz7eI4oYE961/FOGOq0p3x+P
         eG25LoDooY4Od27hAHz0zFNVRj5B8czXJR4OpKg8aLVhOSfLBhAtOWNG3WI7yTL1YB/e
         V5zA==
X-Received: by 10.43.164.66 with SMTP id mr2mr45129036icc.85.1435268511839;
        Thu, 25 Jun 2015 14:41:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id u38sm20395872ioi.0.2015.06.25.14.41.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 14:41:51 -0700 (PDT)
In-Reply-To: <1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 25 Jun 2015 20:50:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272738>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +------------------------------------------------
> +git bisect terms <term-new> <term-old>
> +------------------------------------------------

The mnemonic for "git bisect start bad good" is Bad comes before
Good (B = 0x42, G = 0x47) and this is same for "new/old", New comes
before Old (N = 0x4e, O = 0x4f).  "git bisect terms new old" follows
the same pattern, which is good.  Easy to remember.

> +This command has to be used before a bisection has started. <term-old>
> +must be associated with the latest revisions and <term-new> with the
> +ancestors of <term-old>.

Whoa?  This gets new and old mixed up, doesn't it?

> For example, if something was buggy in the
> +old part of the history, you know somewhere the bug was fixed, and you
> +want to find the exact commit that fixed it, you may want to say `git
> +bisect terms fixed broken`; this way, you would mark a commit that
> +still has the bug with `broken`, and a newer one after the fix with
> +`fixed`.

So, it used to be broken, it got fixed recently, so broken is old,
fixed is new, "bad/new and then good/old" mnemonic says you give
"fixed broken" to "bisect terms".  OK.

> +Only the first bisection following the `git bisect terms` will use the
> +terms. If you mistyped one of the terms you can do again `git bisect
> +terms <term-old> <term-new>`.

This is also the other way around, no?

> +git bisect terms <term-new> <term-old>
> +	set up <term-new> and <term-old> as terms (default: bad, good)

Good.
