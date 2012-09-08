From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 4/4] make poll() work on platforms that can't recv() on
 a non-socket
Date: Sat, 8 Sep 2012 13:31:47 +0200
Message-ID: <CABPQNSY1+3X3LE19mSm2398Kr9EvOxbmsoRLzo4fFTytiA3B+Q@mail.gmail.com>
References: <004201cd8d0f$8e9ad4f0$abd07ed0$@schmitz-digital.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sat Sep 08 13:32:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAJHB-0005oY-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 13:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab2IHLca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 07:32:30 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48779 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab2IHLc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 07:32:29 -0400
Received: by vbbff1 with SMTP id ff1so576592vbb.19
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mUdmxkTnBtNU0Kq2ijmrhkxi94gP6seTmoQsSXkpKIE=;
        b=h8ZjQsfLyEk7OMznE3MBLo+4rurIHihzOofRlIW68dD1zgUDlnziM1dAPd2eKk/Tih
         WzCGczBPj0Y0dCNFhc7WHXQskQqlrqZkLUpd5IL2QLDfFnz2asqRgKw2yydd+udbDWuK
         QIbxvqbKD+/adV20TqCzig+dZWt1bXM+VC/9NqY18038yC3t8PwKdEY/Orc3FWU9d13y
         /hlD1guARwz/MAWRq8M/mOC1DpTCoY7HWCXSP8jEmyyQhAe6X2MkdSvMBoEKsTTN/d4T
         zaxyFcA13JNLQKSKT6yEzdJnZH+cf8BuGshsz3HcoOTbJUSOGGYAZ/cIPpIIjsrPeUAv
         Ff6g==
Received: by 10.221.0.138 with SMTP id nm10mr10880708vcb.38.1347103949129;
 Sat, 08 Sep 2012 04:32:29 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Sat, 8 Sep 2012 04:31:47 -0700 (PDT)
In-Reply-To: <004201cd8d0f$8e9ad4f0$abd07ed0$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205011>

On Fri, Sep 7, 2012 at 5:43 PM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
> This way it gets added to gnulib too.
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  compat/poll/poll.c | 5 +++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index e4b8319..10a204e 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -306,6 +306,10 @@ compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
>                || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
>         happened |= POLLHUP;
>
> +      /* some systems can't use recv() on non-socket, including HP NonStop */
> +      else if (/* (r == -1) && */ socket_errno == ENOTSOCK)

Why add commented-out code ("(r == -1) && ")?
