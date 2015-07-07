From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Wed, 8 Jul 2015 03:25:12 +0800
Message-ID: <CACRoPnQdSaK0vWP=Qf9vR4W2HJQkSdSp4Wqbb4VPV6Bs33=nuw@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<xmqqvbdv3imw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:25:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCYUy-0004tm-2a
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 21:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbbGGTZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 15:25:21 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38568 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbbGGTZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 15:25:13 -0400
Received: by wibdq8 with SMTP id dq8so192642498wib.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T56Stl0bXGEJSKdS1aGH+P7z6OrlZpRed/PoB2XxwWQ=;
        b=uKdmx1VxzGBX05b2xdmsg4aC7RM0oSsk1UXhKt8/YPU8VraHLG7JnTEVjGQTqzwu+u
         b53Y4wfAnOtwICIIMsLignrUGmue2iiKgsNRgFh8gX2ZK6xrm1MfN0jgtCOd7mniYlb9
         NJuy+4Ikd8UYh5wXPIp55FfFh1OkjVZlgniRV33iHAiMUXD894OGZrBDyFkLgiVTgDsY
         8WeIVsVbvxZemt/Bmn+/F9Cp6gD3Ihu7h4p+CReoDMGEZYlnHU81rTGd9xlYjvXa+/9m
         nQtt/0QIYDxQkk5NmfVrS6dJqWA8uQ/S25uLLgNDQWN88RSAX7YMmfNztkeT9OYvCr58
         ewKg==
X-Received: by 10.180.101.233 with SMTP id fj9mr103344231wib.45.1436297112285;
 Tue, 07 Jul 2015 12:25:12 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Tue, 7 Jul 2015 12:25:12 -0700 (PDT)
In-Reply-To: <xmqqvbdv3imw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273595>

On Wed, Jul 8, 2015 at 2:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>> This patch series rewrites git-am.sh into optimized C builtin/am.c, and is
>> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].
>>
>> [1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1
>
> Is it really a rewrite into "optimized C", or just "C"?  I suspect
> it is the latter.

Well, "optimized" in comparison to the shell script ;-) We don't
replicate the shell script in its entirety, but optimize the code
where it is obvious and sensible. It's not the "most optimized" (and I
will gladly accept any suggestions where there are obvious
optimizations to be made), but I do consider it an improvement in
terms of efficiency, while keeping the overall structure of the code
close to the shell script for easy review.

I'll remove the word though, because it's true that the main purpose
of this patch series is to "make it work" first.

> This seems to apply cleanly to 'master' but fails to compile, as it
> depends on some new stuff that are not even in 'next' yet, e.g.
> argv_array_pushv() that is from pt/pull-builtin, and it does not
> apply cleanly on top of that branch, either.

I tried applying the series, and yeah it conflicts with 1570856
(config.c: avoid xmmap error messages, 2015-05-28) because the
pt/pull-builtin branch in pu is based on an old version of master.
That's the only conflict though, it applies cleanly otherwise.

> I'll see what's the cleanest way to queue this would be.  Perhaps
> merge pt/builtin-pull on a copy of 'master' and then apply these, or
> something like that.

Thanks.

Regards,
Paul
