From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Wed, 8 Aug 2012 16:13:03 +0200
Message-ID: <CABPQNSaUCEDU4+2N63n0k_XwSXOP_iFZG3GEYSPSBPcSVV8wRQ@mail.gmail.com>
References: <20120807003541.GA18219@sigill.intra.peff.net> <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v4nofxt89.fsf@alter.siamese.dyndns.org> <20120807040326.GA18682@sigill.intra.peff.net>
 <20120807041026.GA21918@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org,
	rctay89@gmail.com, schwab@linux-m68k.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 16:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz71F-0002ld-FM
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 16:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab2HHONr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 10:13:47 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65080 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab2HHONq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 10:13:46 -0400
Received: by vcbfk26 with SMTP id fk26so767465vcb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CKW+A1XpQFWaJpeeMNOMlkB7cDB7JJ7DlbN3ADEBM4o=;
        b=ONS1WffFZHVvtBlts0A3XyoMYMhEjOSq+hqrSJ76yXaGEXKdUkkoPbHogZlJZDqx6z
         kfnQv/Z8EmwQ911YK/1AoQ6mkmuAYZ3YmYIsZrOl0axeqmQqSreNDDxK24tnr0pLALs5
         F4gCCBbMNsg2HUkHhq6OX2o36TDoE+7yCa5oPg1l2mWIIgKUMwAniVvVeC1qT7mgmLBb
         E4UaLT2n8Eo9VQVzQMkHze9phNovi9c6NX1tXtv0iUZ40nGto+9wHe6zzkSl75YYstnz
         ugTK2OEUu1Ud9Kka3AmuoMq3D442DJkB6ZQ0PnbENi25OC4nAN1dbuV42WKUfrDgCOj5
         W/tw==
Received: by 10.58.137.197 with SMTP id qk5mr6135875veb.29.1344435224718; Wed,
 08 Aug 2012 07:13:44 -0700 (PDT)
Received: by 10.59.9.5 with HTTP; Wed, 8 Aug 2012 07:13:03 -0700 (PDT)
In-Reply-To: <20120807041026.GA21918@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203093>

On Tue, Aug 7, 2012 at 6:10 AM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] terminal: seek when switching between reading and writing
>
> When a stdio stream is opened in update mode (e.g., "w+"),
> the C standard forbids switching between reading or writing
> without an intervening positioning function. Many
> implementations are lenient about this, but Solaris libc
> will flush the recently-read contents to the output buffer.
> In this instance, that meant writing the non-echoed password
> that the user just typed to the terminal.
>
> Fix it by inserting a no-op fseek between the read and
> write.

My Windows-patches for git_terminal_prompt would probably also solve
this problem. Instead of opening a read-write handle to /dev/tty, they
open two handles to the terminal instead; one for reading and one for
writing. This is because the terminal cannot be opened in read-write
mode on Windows (we need to open "CONIN$" and "CONOUT$" separately).

You can have a look at the series here if you're interested:
https://github.com/kusma/git/tree/work/terminal-cleanup

That last patch is the reason why I haven't submitted the series yet,
but perhaps some of the preparatory patches could be worth-while for
other platforms in the mean time?
