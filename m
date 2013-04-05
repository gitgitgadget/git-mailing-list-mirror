From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 22:53:40 +0530
Message-ID: <CALkWK0nVbn7hTEU=decDDdwKXP1-sZakxQpTw4ce6nx3uHO3ag@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
 <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
 <7vy5cyexuf.fsf@alter.siamese.dyndns.org> <CALkWK0kpf+AAzrLuqKQx5iv3nNKJ48R5etcBrcdoG46Z1ipgbQ@mail.gmail.com>
 <7vli8xgahc.fsf@alter.siamese.dyndns.org> <CALkWK0mcii_YGqiQTxhSOfgzn7MOHO0TEO3Rx3cRQLOi1ij5Tg@mail.gmail.com>
 <7vfvz4dhy9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWLs-0002u6-EO
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162198Ab3DERYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 13:24:24 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:39937 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162129Ab3DERYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 13:24:22 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so4481809ieb.8
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iBXnvEePzVghXyUmxqjtN185Mz7Yz0veimSXMaTGnqY=;
        b=iF831gMCUbbQflpuSg6odJ/O8E0zCTGVY3r65oSSO1KOUud/XrHzzknuPHsTqSOEQs
         f1bVPt1VVNuqaAD4hiSFTXKj8abBEwv62+gRbb+9PYkK+jfV3cQTo6CgVgZcWtnQ2DLO
         6ApdcjmesD/Yb5E033MTr+UCKAPEEMbRE0RCYKmiiXoJDdKis3JhA9tzwZ7hCkQZzdYS
         aKgdAg5jiSXMq1LHOBk3VEcl+HHPHc99vtnyJx1vmzH1KrTg8hiWFFssheNUxz914TuP
         gNM7yQBxRX9ahw+iQwcCOxvAnXGSWPaQtJa3PbYexUImC5/A+hIjGwb0bXteCASWQSIo
         D/JA==
X-Received: by 10.50.50.71 with SMTP id a7mr57075igo.14.1365182662023; Fri, 05
 Apr 2013 10:24:22 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 5 Apr 2013 10:23:40 -0700 (PDT)
In-Reply-To: <7vfvz4dhy9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220170>

Junio C Hamano wrote:
> Once you start recording the latter also at path "A", it becomes
> unclear what "git diff A" should show.
>
> That is what I said in the message, to which you invented "diff-link"
> as a solution to the "unclear"-ness.

I just thought it would be a stopgap until we get diff to support
links natively.  Obviously, when we get native diff support, 'log -p'
will be able to show differences as well.  As it turns out from my
little experiment with cat-link, it's really easy to get native diff
support, and I'm targeting that directly instead of a scripted
solution.

As for the unclearness issue, it's a little more complicated than
that: a non-floating submodule could've previously been a floating
one, or vice-versa.  As of this moment, I'm only planning to show
differences between link buffers.  In the case when two consecutive
commits change a link checkout_rev (where floating is set to 0), we
can come up with something like the current diff.submodule = log.  I
see no cause to worry about the interface of that now.
