From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sat, 8 Nov 2014 08:19:21 -0800
Message-ID: <CANiSa6gqu9cRJ4gY5M4ou_zQP=1+U2_C9nHDOoaX01yYn5C+aw@mail.gmail.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
	<20141108083040.GA15833@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 17:19:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn8jX-0008FC-HP
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 17:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbaKHQTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 11:19:23 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:50859 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaKHQTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 11:19:23 -0500
Received: by mail-vc0-f181.google.com with SMTP id hy10so2731428vcb.40
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g+XVuEHfSf/K0WZu3ZmgvmgchgDtkMbWWCmwQlpx8AY=;
        b=vUAdeWIFw7KKv6RgPgpCzlmZx9HPd5dFbiMDFaMMkyjSaHriYWmWoXKqgY6PNoem7A
         gglbV1YuPf+dGgSArFKqvmeUlzusBU4jUXrEx6CZlY6FA6gEX8RsUmZFUkzSjqXer2Jh
         lLep6sKNvFyZ+XphEnKlGT898dpaywg5NZQShypOre2lHdK0us4qRjMbB1BrFaV5GwB8
         e4Ni9rSdKCU2VYXBFwKrw16v4qXpzxWX6qzOvkIYcAGmvAUSnl/VjqB2UjhaKAgbbQoS
         bf0QcdfeWJMIcT3/9s6hU6rG8TQ9p3Csf3PXg+7p78u1FwyAxYt4oEU8nPzBk4e1wRVf
         THOw==
X-Received: by 10.221.74.131 with SMTP id yw3mr6221313vcb.20.1415463562037;
 Sat, 08 Nov 2014 08:19:22 -0800 (PST)
Received: by 10.221.37.74 with HTTP; Sat, 8 Nov 2014 08:19:21 -0800 (PST)
In-Reply-To: <20141108083040.GA15833@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thanks again for spending time on this.

On Sat, Nov 8, 2014 at 12:30 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 07, 2014 at 11:35:59PM -0800, Junio C Hamano wrote:
>
> So just to be clear, the behavior we want is that:
>
>   echo foo >some-new-path
>   git add some-new-path
>   git checkout HEAD -- .
>
> will delete some-new-path (whereas the current code turns it into an
> untracked file).

Yes, I think that's what I would expect.

> What should:
>
>   git checkout HEAD -- some-new-path
>
> do in that case? With the current code, it actually barfs, complaining
> that nothing matched some-new-path (because it is not part of HEAD, and
> therefore we don't consider it at all), and aborts the whole operation.
> I think we would want to delete some-new-path in that case, too.

I don't think we'd want it to be deleted. I would view 'git reset
--hard' as the role model here, and that command (without paths) would
not remove the file. And applying it to a path should not change the
behavior, just restrict it to the paths, right?
