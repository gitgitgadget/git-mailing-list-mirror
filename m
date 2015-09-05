From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 08:24:05 -0700
Message-ID: <xmqqwpw4dh4a.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 17:24:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYFKJ-0006GD-90
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 17:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbbIEPYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 11:24:10 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34753 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbIEPYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 11:24:08 -0400
Received: by padhy16 with SMTP id hy16so49974014pad.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uBiLg5z3asDmZSrl+wFJyz4145NovcvTrbPjIUoz0k4=;
        b=JW2eORUaPahCMioYX+Ld3dWLncdFAQ8gq/Dzx8+yd77SfI23PSrk8nRE/ENjAoVlWo
         B6eX4WSfqz3kTzi4hPKLLZOEGCByhYOCNvHNdizxBsBfnKpFr9D5FqSwyy1vXGBE8qer
         fN3YGiELY0rAz9BcNijpO2xyyBP21Ws7xmxUhsb+nu0nNvExwspZBNoNCfxeQ3OUnZ/R
         WFlgqWdVNIiF6BvNbettXGYic9VKoieetKFfNsGUqcQ+MCa82DkoAFtcRi2AjeMfF708
         Nwgf6Pc/+yJnIyazpvpwmEnwjCR3p/lgzTbR/sMcj+kGNND4Ow/y931oyPS0stms8Stu
         1Bpg==
X-Received: by 10.66.244.230 with SMTP id xj6mr22261071pac.53.1441466648211;
        Sat, 05 Sep 2015 08:24:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id f10sm6171443pdk.20.2015.09.05.08.24.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 08:24:06 -0700 (PDT)
In-Reply-To: <55EA9A13.2050108@kdbg.org> (Johannes Sixt's message of "Sat, 5
	Sep 2015 09:30:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277384>

Johannes Sixt <j6t@kdbg.org> writes:

> Why do we need a new rule? The old git-am had a logic that pleased
> everyone, and it must have been implemented somewhere. Shouldn't it be
> sufficient to just re-implement or re-use that logic?

If you look at the helper the rewritten "am" calls, you will notice
that it is used by other things that wants to know whether a log
message has the final "trailer" block, and the reason why the
callers want to know is not limited to "I want to add a sign-off".

What your "just re-implement" means is "change the world order
drastically to other callers who do not want such a special casing
for sign-off".

That was why I tried to see if a slight tweak to the rule shared by
all callers that would be much less likely to break these other
callers can satisfy the need of "am".

Perhaps we would need to tell has_conforming_footer() function who
the caller is, and use a different logic (i.e. "just re-implement")
when the caller is append_signoff().
