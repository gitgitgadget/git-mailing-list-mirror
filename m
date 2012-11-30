From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 0/5] win32: support echo for terminal-prompt
Date: Fri, 30 Nov 2012 11:16:59 +0100
Message-ID: <CABPQNSZ7YRgvS1=SR=Nx0wcn+NXCVwqjVShk-ug3=yX62RH-oQ@mail.gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Nov 30 11:25:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeNnA-0005nW-UJ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 11:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab2K3KZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 05:25:41 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:61267 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757356Ab2K3KZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 05:25:39 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2012 05:25:39 EST
Received: by mail-vc0-f170.google.com with SMTP id fl11so28237652vcb.1
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fT7QZCNSZXUK9cUzALjdFXDSfSQmBmZOLQE/ZLE/GtA=;
        b=cvcxrZ2CBBwVVQ+h/BZ9RVWiUvuc/vx5mfGTvg+SZV8xiDXVy+/hwbncBdnXm8opwf
         QqIBNFJq11NhXB5d+M85DDSMOKxEUMFJJYQ3UgGdwwah0HfVtilIKWxNPgMW2xbpXEO+
         MHgX89arrAvYSkBb0EQUzlbrOMX4C4GUh+MRgOOCbfKjKpe2j9qBKiz1fEtbfLk+kALT
         df+rEX4/U3R8VPvl/17YzhiBNH/1/z88rbHi7PcUZ7wDPq5UGNhu2or65AUO4BMsKmgO
         abYU9zqa70DXtRs+RRoS/wBzGRv1xo6vAl9iG1me5vEcPynmmS4VrbhK5dUKNPORwZl7
         oveA==
Received: by 10.52.16.164 with SMTP id h4mr555508vdd.21.1354270659522; Fri, 30
 Nov 2012 02:17:39 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Fri, 30 Nov 2012 02:16:59 -0800 (PST)
In-Reply-To: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping?

On Tue, Nov 13, 2012 at 3:04 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> We currently only support getpass, which does not echo at all, for
> git_terminal_prompt on Windows. The Windows console is perfectly
> capable of doing this, so let's make it so.
>
> This implementation tries to reuse the /dev/tty-code as much as
> possible.
>
> The big reason that this becomes a bit hairy is that Ctrl+C needs
> to be handled correctly, so we don't leak the console state to a
> non-echoing setting when a user aborts.
>
> Windows makes this bit a little bit tricky, in that we need to
> implement SIGINT for fgetc. However, I suspect that this is a good
> thing to do in the first place.
>
> An earlier iteration was also breifly discussed here:
> http://mid.gmane.org/CABPQNSaUCEDU4+2N63n0k_XwSXOP_iFZG3GEYSPSBPcSVV8wRQ@mail.gmail.com
>
> The series can also be found here, only with an extra patch that
> makes the (interactive) testing a bit easier:
>
> https://github.com/kusma/git/tree/work/terminal-cleanup
>
> Erik Faye-Lund (5):
>   mingw: make fgetc raise SIGINT if apropriate
>   compat/terminal: factor out echo-disabling
>   compat/terminal: separate input and output handles
>   mingw: reuse tty-version of git_terminal_prompt
>   mingw: get rid of getpass implementation
>
>  compat/mingw.c    |  91 +++++++++++++++++++++++++++-----------
>  compat/mingw.h    |   8 +++-
>  compat/terminal.c | 129 ++++++++++++++++++++++++++++++++++++++++--------------
>  3 files changed, 169 insertions(+), 59 deletions(-)
>
> --
> 1.8.0.7.gbeffeda
>
