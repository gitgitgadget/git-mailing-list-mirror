From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Tue, 15 Sep 2015 13:38:42 -0700
Message-ID: <CAGZ79kb5qWnOnJGY8JR3Z9UqT2xp390A6-LvNudBk=e3N2W41Q@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
	<55F8643D.6040800@ramsayjones.plus.com>
	<20150915184211.GA31939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 22:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbx04-00087b-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 22:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbIOUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 16:38:44 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34240 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbIOUin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 16:38:43 -0400
Received: by ykdg206 with SMTP id g206so198512805ykd.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NcqCEsIIPb8KdPSSYE/P2fiYqrdby+TXlODWUC78wws=;
        b=Cu5w4EkUA8izEQ8UK5S41BiLjpQEnbtfXBH7c36EYYwsnjnPG004AKAtze1TXbf96c
         HBIJoYkwFGkZVgbEO8rk9j/oYBJyPG3iXNYI1ILTTD7vu2IawksJDaGnccx8awMfPPng
         wR0Ka0KgH44DmZfxpfzwt8R1PvTaM9EAWmdHpoqm9odhwrnbuqA6tweBJorddYEtFtHi
         8cpGiNYyxsCBx+Hz3VK57vSD52inthm7g0wqKXH1lpFg8C7ME7n1Y04rllD+ofkfMRvM
         HHU0xycou6LR1mO5cLU/FJBicfpKrcGTL2lThFMqfmuLuZbPNCBdVHyisrin3nWqmqHl
         gAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NcqCEsIIPb8KdPSSYE/P2fiYqrdby+TXlODWUC78wws=;
        b=Po3gLErPFYj9I6j/A8dhFCXgPaeMEY3S2VbE6PBXFZD5gKgfPK7aNDL4U5WVz8TmUO
         ek+G6ta0vd/QomN64Qf/Tu5UxSB1QuU9wNcEQipJJWPFPmh+wAiRnjV7U5EERaRj48Zq
         eH4/vcUrPXkEu+RVd3jGDgBRfk7uQETvFJHDcCWfJGYi8TWQ1JyX+23x5/CGMnAMencg
         WyjtcbCevUG/05GVxuEHnVpDxhGIis2PGnH83OUkR1GYJCaXDaOfBh0GOGbl5j3u8ZbZ
         yAaL/V8+YhSTLZBd7zaEJw0BWegP1DPTJVGnnD20l2wEG93uJgQi7SndPwJjQaUhenXG
         JPlA==
X-Gm-Message-State: ALoCoQnr7daVe/4CIe0nSytRvGIDlbxkXa/1NUd1y30/E+nnuSFyKyjCwt+3cgXV9+UR5Qubq9Ij
X-Received: by 10.170.198.198 with SMTP id p189mr24345579yke.56.1442349522686;
 Tue, 15 Sep 2015 13:38:42 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 15 Sep 2015 13:38:42 -0700 (PDT)
In-Reply-To: <20150915184211.GA31939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277983>

On Tue, Sep 15, 2015 at 11:42 AM, Jeff King <peff@peff.net> wrote:
> That misses the "assert" behavior of xsnprintf.

When I saw the first patches of this series, I like them.

Some off topic thoughts:

Having an "assert" behavior is not a good user experience though
and should be fixed. To fix it we need stack traces. And the git
version. And telling the user to send it to the mailing list.

I wonder if we want to include a trace where possible (i.e.
when compiled with gcc or other precompiler conditions)
into these assertive behaviors.
I'd guess we have an assertive behavior if die("BUG:...") is called,
so maybe we can just check inside of die if we want to print
a stack trace additionally ?

In my dream world we would have a similar mechanism as in
the kernel, a "BUG:..." will be automatically sent to some
collection agency via UDP.
