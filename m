From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-ref: place angle brackets around variables in usage string
Date: Mon, 31 Aug 2015 09:33:07 -0700
Message-ID: <xmqq8u8rxvss.fsf@gitster.mtv.corp.google.com>
References: <1440821924-4289-1-git-send-email-alexhenrie24@gmail.com>
	<47B9DE8756F943C0A0985F41D093340F@PhilipOakley>
	<xmqqd1y3xx3f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Alex Henrie" <alexhenrie24@gmail.com>, <git@vger.kernel.org>,
	<pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 18:33:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWS1C-0001J2-US
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 18:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbbHaQdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 12:33:10 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36707 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbHaQdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 12:33:09 -0400
Received: by pabpg12 with SMTP id pg12so11766665pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jCSCdtj7Awr7anwpy92z0JoEOdFSJrFb7joiUdmsiBU=;
        b=BHN/6xWc+edH2BvnkElUAVnS0cBCbElx2G6q66tqEg9YyMrNdo/YpX2dcE4thQmla/
         Zys+xssEXv/6LgBs5KdfOcnehqFD/fL++bpvOBvb2CFPa2P/QVA+ItyKE+3+V0LBop/0
         B16EKmIZB39eQVpvq5EBzYdEk5/dWrNu1Kz//HSEKdldvzOgsBGAWutcqocKqMRd8WYD
         OB4DNckxuCikKHwOcjve9qjlfYFmw4r1/yg/LGriJegEGf3qbICzDtbCGj41NhmxYGbX
         75njoR7lx9gb7YDoVLN88jXeUCrcz5EN0GTFT5U0YmCYtqA5oQ/PMo8j6+do9z7RnmJT
         9mjQ==
X-Received: by 10.66.62.163 with SMTP id z3mr39158229par.12.1441038788672;
        Mon, 31 Aug 2015 09:33:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id rh7sm4660453pdb.11.2015.08.31.09.33.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 09:33:08 -0700 (PDT)
In-Reply-To: <xmqqd1y3xx3f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 31 Aug 2015 09:05:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276888>

Junio C Hamano <gitster@pobox.com> writes:

>>> - N_("git show-ref --exclude-existing[=pattern] < ref-list"),
>>> + N_("git show-ref --exclude-existing[=<pattern>] < <ref-list>"),
>>
>> Should the '<' stdin redirection be shown?
>
> Hmm, that actually is an interesting thought,...

Having said all that (i.e. I agree dropping "< $anything" may be a
good idea in general), for this particular command, I suspect that
the feature may have outlived its usefulness.  It was introduced
(silently) in ed9f7c95 (git-fetch: Avoid reading packed refs over
and over again, 2006-12-17) as an optimisation that is very specific
to the way how "git fetch" scripted Porcelain happened to be written
back then.

The way the feature is misdesigned clearly shows that it was not
designed for general consumption---if it were, we would have made
"show-ref" to be usable as a filter even when we are not excluding
anything with "--exclude-existing" option.

Of course, it is OK and definitely a lot safer to keep the "can work
as a filter" feature for possible third-party uses, but if we were
to go that route, it is not too late to extend the machinery so that
"work as a filter" is not tied too closely to "exclude-existing".
