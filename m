From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Wed, 02 Sep 2015 10:41:34 -0700
Message-ID: <xmqq37ywoh0x.fsf@gitster.mtv.corp.google.com>
References: <20150831204444.GA4385@sigill.intra.peff.net>
	<20150831204831.GB10338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXC2W-0004Ud-R5
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 19:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbbIBRlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 13:41:36 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33186 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbIBRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 13:41:36 -0400
Received: by pacex6 with SMTP id ex6so13190530pac.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NDI6Eo8ZJ16tOi8ksdT6d4QkH6zDhjeoWUKMwk/oDPw=;
        b=gRgaOn1fVzDt/BV+g8o/eBT98ViRh14VdyUk21mo61aUgCNYLjEgquYwKSd0sGMxVe
         KpEwX2XF2lxU/AHN8b4ZExsxuOQsKc6z2HYLovtHXlXOTfzqhO8trXoMH4yfhJ7M3BPJ
         qI3msdbiwRfEgs4vYUzdqPyuKnzJ2mIEHfbPfQNUXXzd4M4tp1bTI/MOYOVou9Ool3qz
         4hb7mJDl/ApqYVhRULwaNVGBRPvzh6jumO6lPMg6hHWjY6DaktCtfA3o7x9kRss8YYfp
         a27KNIKmHMhpg5kcgPJMDrhEXqREvYa5b2AgHFMTPOK3ELpasOXxcWO8P70C5yrSRiQn
         7XcA==
X-Received: by 10.66.190.99 with SMTP id gp3mr57175970pac.113.1441215695672;
        Wed, 02 Sep 2015 10:41:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id fp5sm22302174pbb.94.2015.09.02.10.41.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 10:41:35 -0700 (PDT)
In-Reply-To: <20150831204831.GB10338@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 31 Aug 2015 16:48:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277111>

Jeff King <peff@peff.net> writes:

> +	/* historical alias */
> +	if (!strcmp(format, "local"))
> +		format = "default-local";
> +
> +	mode->type = parse_date_type(format, &p);
> +	mode->local = 0;
> +
> +	if (skip_prefix(p, "-local", &p)) {
> +		if (mode->type == DATE_RELATIVE)
> +			die("relative-local date format is nonsensical");
> +		mode->local = 1;
> +	}

I notice that we give something funny like this:

    $ git show --date=short-locale
    fatal: unknown date-mode modifier: e

What is the intention here?  In other words, what kind of things can
plausibly follow "--date=short-local" in enhanced versions of Git in
the future?  "--date=short-local:some other magic"?
