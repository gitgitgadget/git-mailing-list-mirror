From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv17 01/11] submodule-config: keep update strategy around
Date: Thu, 25 Feb 2016 10:21:54 -0800
Message-ID: <CAGZ79kaG+npqYDxABdUGrXH04nBF0_S+VLOHGrsa0jPcWMtiUQ@mail.gmail.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
	<1456369618-18127-2-git-send-email-sbeller@google.com>
	<xmqqwppsoeab.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:22:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ0Y4-0001Ym-3u
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423AbcBYSV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:21:56 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36716 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933304AbcBYSVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:21:55 -0500
Received: by mail-ig0-f182.google.com with SMTP id xg9so18919145igb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 10:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lOUfZB8bQ/iJvAvVUzsQ1n4uqpecgcPuupNNeadMLwA=;
        b=Bl/hMlzviJbZxxTVJ2xzU3lyPUy01H7MetxbrCyXxDSOfEr2quow+Q/ubmuH/XicQ5
         Z95Q3bb5g0Srgg6f38jg9LpyvoCrULNWvtJSFyuwdYmoNFUHv48vA/J0tLaEnheLrAug
         t5skw2Z0I/kHe7MJtKzNLxxFvw6m0PwQYok+7MocOR4Wr4ssx0gBSEq3fCWAU61vOqMh
         /Orh9z1GfRaWSQn09UdyIH2wMQYnCDzzc4S0WwkTYEih/036LQysPSH4NXesbcRvamup
         YKOPzMejIiE6FPmO+b+1TGqikDCsqtCOrRBW44KIxEsFYfAGZFLG4W7KuY8OHVkni0aV
         eD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lOUfZB8bQ/iJvAvVUzsQ1n4uqpecgcPuupNNeadMLwA=;
        b=XnKNC8ZhW4mPAmlkNz8TLiwrsG5YwmIwZoeFvbI6HUkUxtLs9JmxR9F+JBFaJhY28y
         6S8vfBBvnFdH1pm1c8rMaLOEOtAFMrkvwhGbllmN56OBNlRRzL/5LtNE+xwks8JY0Lf1
         eKRS2LnJcj5Kjn1Z2l29zonH+1NaNTo9N5wqLw8v2HgseV2UtK8ac7bsphXxrei7WLwe
         NYCvUeSalX4fyf8IDHiijzjcz9PuPaNDTmwOVLXEvE8hcUw0AwEFM1Dfj771jyGi4f3T
         hvxoj/3CrGLCJN6JFiixgOBs1p3qcAYS6RbCoePcueO8zhbhodK7raFalTdgfMKZXuDu
         FRIA==
X-Gm-Message-State: AG10YORp846XTP01+CHTt6LWY8pm+VgHMPDWXU9KI5S0axi3M9UsUdRtug87PnbziG6vyxrAX2zSX0IUoeQuPt9z
X-Received: by 10.50.55.71 with SMTP id q7mr38135igp.27.1456424514747; Thu, 25
 Feb 2016 10:21:54 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 10:21:54 -0800 (PST)
In-Reply-To: <xmqqwppsoeab.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287413>

On Thu, Feb 25, 2016 at 10:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +int parse_submodule_update_strategy(const char *value,
>> +             struct submodule_update_strategy *dst)
>> +{
>> +     free((void*)dst->command);
>
>         free((void *)dst->command);
>
> "git tbdiff" is quite handy; it didn't spot any other lossage of
> local tweak that was in 'pu', which is good.
>
> Thanks, will replace.


I usually use git diff <localbranch>.. origin/sb/feature to generate
the interdiffs,
so if you tweak things and I take these tweaks, then the interdiff is
not complete.

On the other hand if I miss the tweak, such a diff shows a revert of the tweak.

I remember applying this tweak; not sure how it got lost again.
