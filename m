From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 09:56:55 +0800
Message-ID: <CALUzUxrfSEtkXfFbotb3XARt9e=oWF0xQRVU0hwnsCJn-Cn0Lw@mail.gmail.com>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, peff@peff.net, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:57:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCZ3-00014s-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2HFB44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:56:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41339 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab2HFB44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:56:56 -0400
Received: by yhmm54 with SMTP id m54so2026158yhm.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ILZXpjofAp43MYe/scNc7e9FLnrOyfeEZqxsZdSup8Q=;
        b=RXVL/uXJJsa/zDZvhHJckOUyqt+IMufTvnb6hPeCgKg4EpfUALIWwz7PZtQqYCY8dM
         5RtVhqhn1lBskY1xyVeRSAJ9IZq1aY816ZbLGLBwQwsF/OjCd3YmbKaA7BSm6oziJUL9
         a6AcnMZ+53CSVyClsxfZjq3c2OBKINa6FLKkXxdEneGz8wCmlIrofnqLxcOgGUWZGGsS
         72VTMssI4BvNbfsUrNVs8mUCueJ6mo+841EdKQYgM92wd2KAWHCfCmtgWgIZbqeg79UJ
         elJugyHbbh1Imz9/HOY2xJWnLU0/Px1YuAJOAVpqy6W0ULbJ5o8TMLsm5LHqOci7VIlu
         NbqQ==
Received: by 10.50.158.226 with SMTP id wx2mr4133643igb.18.1344218215168; Sun,
 05 Aug 2012 18:56:55 -0700 (PDT)
Received: by 10.43.110.202 with HTTP; Sun, 5 Aug 2012 18:56:55 -0700 (PDT)
In-Reply-To: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202950>

On Mon, Aug 6, 2012 at 7:17 AM, Ben Walton <bwalton@artsci.utoronto.ca> wrote:
> I've also briefly dabbled with getting Solaris to simply use the
> HAVE_DEV_TTY code path but the terminal echo stuff hasn't worked
> nicely for me just yet.  (It reads the password with nothing echoed
> but then displays the string after reading the newline.)  This might
> still be a better approach in the future, but for now, having long
> password reading capability will still be a benefit to users on this
> platform.

Replacing

	if (!echo) {
		putc('\n', fh);
		fflush(fh);
	}

with

	if (!echo)
		write(term_fd, "\n", 1);

fixed that. Using fd's instead of FILE* was mentioned at [1]. Perhaps
that is the direction to go in.

[1] http://mid.gmane.org/<7vsjc12j5o.fsf@alter.siamese.dyndns.org>

-- 
Cheers,
Ray Chuan
