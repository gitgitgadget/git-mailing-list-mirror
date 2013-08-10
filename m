From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 16:28:58 +0700
Message-ID: <CACsJy8CBBy+T4XtRSRT4WONRfGEuZbXPaNGAbROeRUPvyNHU3Q@mail.gmail.com>
References: <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net> <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net> <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
 <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85UM-0005wT-7B
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968489Ab3HJJ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:29:29 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33298 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968484Ab3HJJ32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 05:29:28 -0400
Received: by mail-ob0-f180.google.com with SMTP id up14so1562245obb.11
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aMQVgp1TqX4OX2c9hnCLkknNf3B1kQWMk9YgwgJagUQ=;
        b=WvVi9Izn2oUKxc+t/X63vf/wZ4Np9iUYZKtztORYI4QJmmk0DwSWoWuYy+HgM54v7I
         O3ADAoGKdU5Eq+YJpsQdkuu34xVTvM4JrfF+IC48SwJOeFgbTxrvwrzRytbTmFjonJc3
         cFz1qL1RKcVj9/J/hmqA4oFeOUITsSe+jPOxWgoP9+uQenyGZQlQhOsKuJXGRCX53HUH
         /HRNa6Efwa9ngunDK4FpCsP7mLEuWqArtlAVXx2buKTz1F2kjWC41+9dyk2rMi3X5czQ
         Q50GiycKfJR+vIV4JHNPUM/USQV0iTnAbr5ZVPvtCRaZLP1jXj9+LseOamOR1XMwbodi
         nbNw==
X-Received: by 10.60.132.113 with SMTP id ot17mr3626900oeb.104.1376126968307;
 Sat, 10 Aug 2013 02:29:28 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 10 Aug 2013 02:28:58 -0700 (PDT)
In-Reply-To: <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232080>

On Sat, Aug 10, 2013 at 4:24 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> push has --thin turned off by default favoring server resources over
> network traffic, see a4503a1 (Make --no-thin the default in git-push
> to save server resources - 2007-09-09)

Side note, I think the server should be able to control the default
behavior. Maybe if the server advertises "thin-pack" capability and
the user does not explicitly specify --no-thin, then --thin is
automatically turned on at the client.
-- 
Duy
