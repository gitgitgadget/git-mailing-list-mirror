From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Tue, 25 Aug 2015 12:43:44 -0700
Message-ID: <xmqqvbc3xifj.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
	<xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
	<xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
	<xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUK8O-0005xz-Vs
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 21:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbbHYTnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 15:43:46 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36042 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685AbbHYTnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 15:43:46 -0400
Received: by pacgr6 with SMTP id gr6so458622pac.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MYD+NGsLRq3HTt7ksZ/YzMXkxT/uiuQt7dIRW+F+Hx0=;
        b=Ahg/9QxK52PtcmrHvekgikl65NPFwSpEl8j91J7w1AVFIVZqjSGNET8qXElSLMo5fa
         6DnmgYsXltK2/Yax44tNGvg5Sh/ep/TdurYEm7X2KWcFexeo0xB2LUasg0xl6hnz0UV3
         hUg5TcB9OfOocK0M/+7XbBJK7pEiIrObmOTcAcK4+C0iu4N4eWGRrutQXkFOMsEW5eBT
         K9FctgZmtGN0MRV95D765MvKzwCKfbA4Ao7RyOGEAosuWKw9ZAtxXeefrzwocFOx8LyS
         hd9jfjuwQvFSJvDlWAerh7VA77q70EuLrxoRr4glaxHkpgGhEA9Iq91xOpXHcsGAQUVm
         yHSw==
X-Received: by 10.68.218.136 with SMTP id pg8mr60085484pbc.169.1440531825509;
        Tue, 25 Aug 2015 12:43:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id fx4sm21919812pbb.92.2015.08.25.12.43.44
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 12:43:44 -0700 (PDT)
In-Reply-To: <xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Aug 2015 12:16:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276565>

Junio C Hamano <gitster@pobox.com> writes:

> I didn't check how wide the original is supposed to be, but perhaps
> changing builtin/tag.c this way
>
> 		if (filter->lines)
> -			format = "%(align:16,left)%(refname:short)%(end)";
> +			format = "%(align:15,left)%(refname:short)%(end) ";
> 		else
> 			format = "%(refname:short)";
> 	}
>
> may be one way to fix it.  Check the original "tag -l" output for
> tags whose names are 14, 15, 16 and 17 display-columns wide and try
> to match it.

Heh, I did it myself.  %(align:15) with trailing whitespace is what
you want.

An alternative way to spell it would be

    "%(align:16,left)%(refname:short) %(end)"

I don't know which one is more readable, though.
