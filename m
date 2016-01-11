From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Mon, 11 Jan 2016 12:17:34 -0800
Message-ID: <CAGZ79kb_XOReZZ8E+7QL8dAz6k7PR10Rg-kMgDczRQ6gPpp7Fw@mail.gmail.com>
References: <1450311999-3992-1-git-send-email-sbeller@google.com>
	<1450311999-3992-2-git-send-email-sbeller@google.com>
	<5673052F.7050000@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 21:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiuJ-0002Jq-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 21:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759365AbcAKURg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 15:17:36 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37939 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759160AbcAKURf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 15:17:35 -0500
Received: by mail-ig0-f180.google.com with SMTP id mw1so118040086igb.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 12:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F+SB+ASFd2AMSRZnAd6682hTJyNhGE3ifxKtfmW13dg=;
        b=N/0F305A+VbPE9gnHfk2hpdiYr/XGe8n3af4tdfjAXnmlpvD5803/+e6d8jHcLYBSQ
         PyUvPSGLhzVw1nR4BU7JXenw5p4P0A/jeooO+Rk/22O+L4g00U99VjWjDA4RgWUqIq8w
         HJKKU5JexEvyHbmmA00tg2FP/zyR5+NdahWiYdRXdr555J+gBL6z6oIrIb7CWv5uzKzN
         KCnhtBPuSTm6LN/uqDE0DjzBN5eHEFisJyXlBJYkCohybsmOTrQTi1sxhY6ya0P/aD3y
         v0K/K2K5q0doSmOmNVoE4NVt/A3cgt4I4RTv5L64t912eH0aun/MkG8j/EKn4rCnh+P7
         sGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=F+SB+ASFd2AMSRZnAd6682hTJyNhGE3ifxKtfmW13dg=;
        b=W+SgroFdJ8tp7985KyqxGthlyG1Htz6any7l3mwEK0O2rO28fVqIDVVxVKUlJvL58w
         jFmR5RCMFuUhZVubY+oFp3KJUJ7B4vQEcB/nFHfn/sO7RcZBpxAz1SYPc6yJFZ2jkTdz
         oz4ml66uL1hw9/GC7m/z6JQM8Ia9v5oTaMALSzXvMx/5bq+hymuXi0L06nw7H3OjT85H
         5TURnjmsmZ4AYSrWmT6YfbuYdRWjz6JnRI1UTG0biGCzKaCfNFiPxzLGofyLVlD+FwDD
         yIWsRbbsxH60p21Pxo6YLLQsI8zGZZiWbDsljPa1I+FiEhZdQQUuntzgkt/B+xL4/sLB
         on1w==
X-Gm-Message-State: ALoCoQk0uvpp+ATJwuU5Q/QhT0JXmAxW0vNo4TNJHttTEJc8Ckd9YAP3Je2hrWVVUZOwIFpnSIbMKxlkWXR6o/BARbjAWgehvjZqpMz86XAL4SNLOT2X7PY=
X-Received: by 10.50.60.6 with SMTP id d6mr14749433igr.94.1452543454410; Mon,
 11 Jan 2016 12:17:34 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 11 Jan 2016 12:17:34 -0800 (PST)
In-Reply-To: <5673052F.7050000@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283712>

I forgot to send out the draft last year.

On Thu, Dec 17, 2015 at 10:55 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> That's about 3%.
>
> I appreciate this effort as it should help us on Windows. Although the
> numbers (and my own timings) suggest that this is only a small step
> forward. That's not surprising as the patch removes only two forks.

ok. Probably the timings are not as important here anyways.

>
> As to the implementation, find a patch below that removes the ifdefs
> and a few other suggestions. It is a mechanical conversion without
> understanding what relative_url() does. I have the gut feeling that the
> two strbuf_addf towards the end of the function can be contracted and
> the temporarily allocate copy in 'out' can be removed.

I have the gut feeling, too. But I could not quite write down the solution.

>
> If there were a few examples in the comment above the function, it
> would be much simpler to understand.

I agree. So rewording the comment in the next reroll.
