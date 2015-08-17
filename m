From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 13:34:58 -0700
Message-ID: <xmqqy4h9bqml.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
	<xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
	<CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
	<xmqqtwrxesqa.fsf@gitster.dls.corp.google.com>
	<CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
	<xmqq614deoq8.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRPxkdOgAo=0+_f8bcFoL70MSvLDJ_OjrFtVMKtcqVV_A@mail.gmail.com>
	<xmqq7fotd71o.fsf@gitster.dls.corp.google.com>
	<CAD0k6qS9qA2vrrxF6SQJ-RsX01rryCuZ0zPn4k+OP__TOPR2gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:35:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRR7b-0001lE-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 22:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbbHQUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 16:35:00 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35261 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbHQUfA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 16:35:00 -0400
Received: by pacgr6 with SMTP id gr6so115590885pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LqvttdEePdytpzQ/X5ckKOYK5dTymHxfRfDmT3iveOA=;
        b=n3ErlkaIVOJL4sO89Fr/OMTAONesPd9lduHAYZ9Fr/rmWxzwjd2NizGY7moP4JEoB6
         gsuwR8hEjNWAFd2a0Q2EXvHlpW3Wf3gJQPjo/Zo8UC5NaQb/TozWKWJ4gFYERKmzJ04O
         +wXLxFHghPc+ZW6Y++svM7mZh2LbWcAD69EzfsaM8mSrg0b3W6eRi05Fms5cLpvPq2gb
         gxVEHbLXIfhzHc1xQntNHSDa8FJ9cToyMiYlyDeOZO6gvuTsVk1Wjp1b2hwHASnV+RbP
         HIzG6oXSwIz0Wr0BfW+bkm67H4lUI9g0uQH7lRRZQcGlAPAybD3aCzlmIXFwMxWlQcUT
         gZcA==
X-Received: by 10.66.219.102 with SMTP id pn6mr6024255pac.80.1439843699848;
        Mon, 17 Aug 2015 13:34:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id e2sm15639530pdk.61.2015.08.17.13.34.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 13:34:59 -0700 (PDT)
In-Reply-To: <CAD0k6qS9qA2vrrxF6SQJ-RsX01rryCuZ0zPn4k+OP__TOPR2gg@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 17 Aug 2015 16:00:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276091>

Dave Borowitz <dborowitz@google.com> writes:

> Slight digression for a question that came up during reworking the
> series: would it be reasonable to rewrite option parsing in
> builtin/send-pack.c to use the options API?

Surely.  The part of the system whose option parsing predates
parse-options may not have been converted to do so yet, but as long
as the result is correct, why not.  After all APIs were invented to
be used.

> That way we can easily
> reuse the option callback from builtin/push.c. (It would have some
> side effects like making --no-* variants work where they did not
> before; I assume that's a good thing, but it's marginally inconsistent
> with some other plumbing commands like receive-pack.)

As long as people are not deliberately feeding --no-something and
relying on it to fail, we'd be ok ;-).
