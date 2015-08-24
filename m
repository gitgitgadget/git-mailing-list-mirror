From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 11:15:55 -0700
Message-ID: <xmqqlhd04ko4.fsf@gitster.dls.corp.google.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
	<1440436186-7894-1-git-send-email-gitster@pobox.com>
	<20150824174142.GA4794@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:16:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwHp-0003oz-RD
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbbHXSP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:15:58 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33168 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbbHXSP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:15:57 -0400
Received: by pacti10 with SMTP id ti10so29373614pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wxQZBArZz45RafpPeB11qfadLwID15RiVZUHFGGIZ5U=;
        b=CoAQXvIcnGUqY+dh3l62P5N1usZQ/a+Oes/WNjj35pJOC/edB+kX3om4Ql8RVV3Gtv
         ukEXQZWnt4HAh7nmEtAIMqMzcqaBfruc+Ie8hOTfoc23rvpm3KjTP43e3MBJ1FU3rXG5
         Owdp/CmbJtx8cOk9kuimAX6tuePN1o+6Kz5GD0iPekWPHGCx7WBFGRYlHlHXNCr9p9yU
         BJ2Hle9t7yYqLjMwHgy4apPrZN+uDkM17X2YJPTsqn0XI6jm1rjXxECzDt67zKhTZAfi
         X+ZBMBCzHNdoh3rTkx02cOJzi3CEqFfbgFy/Py7Aad27k9avj60E3p6lIZMdFHSEUows
         4mdA==
X-Received: by 10.68.135.161 with SMTP id pt1mr47831225pbb.47.1440440156767;
        Mon, 24 Aug 2015 11:15:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id da6sm18219604pdb.22.2015.08.24.11.15.55
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 11:15:56 -0700 (PDT)
In-Reply-To: <20150824174142.GA4794@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Aug 2015 13:41:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276474>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 24, 2015 at 10:09:41AM -0700, Junio C Hamano wrote:
>
>> So here is an solution based on the "write_file() is primarily to
>> produce text, so it should be able to correct the incomplete line
>> at the end" approach.
>
> This all looks good to me. The topics-in-flight compatibility stuff in
> patches 3 and 5 is neatly done. Usually I would just cheat and change
> the order of arguments to make the compiler notice such problems, but
> that's hard to do here because of the varargs (you cannot just bump
> "flags" to the end).

Actually, I think my compatibility stuff is worthless.  It would not
catch new callers that wants to only probe and do their own error
handling by passing 0 (and besides, assert() is a shoddy way to do
this---there is no guarantee that tests will trigger all the
codepaths in the first place).

We should deprecate and remove write_file() by renaming the one with
the updated semantics to something else, possibly with a backward
compatiblity thin wrapper around it that is called write_file(), or
without it to force a link-time error.

Thanks for a dose of sanity.
