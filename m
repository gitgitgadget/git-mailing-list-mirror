From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Mon, 26 Jul 2010 18:35:27 +0000
Message-ID: <AANLkTilDKIwcQ0OmXAihq8AkS7v31HseEI3BGTUyzl9v@mail.gmail.com>
References: <201007231518.31071.trast@student.ethz.ch>
	<20100726154041.GA18762@coredump.intra.peff.net>
	<AANLkTikmFVHeMVEgj_G5h8VMNaw0zIm0Ol-vC1ffc45v@mail.gmail.com>
	<AANLkTimRrpiv7cu=j598K3x4h3UGW7-Hik6-6jA8R_5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: "Jasper St. Pierre" <jstpierre@mecheye.net>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSWT-000767-6c
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab0GZSf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:35:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42490 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab0GZSf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:35:28 -0400
Received: by yxg6 with SMTP id 6so177372yxg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XAFQ3p58okI3b3ItjrojABr9+7ZrnGEKgYK4MicQKIY=;
        b=dpdOOQxvwbllXxuCEN6fNtcZNmRgrKgP+EzSMdvpB9DuP0lu7udIem5H00BM/3ULBh
         lEAN49PjlqT3kTALA4kF6QPrCp8N6mo2aU0XGte0/BtOJSJbArqK+57lAOAeHvzm1O/e
         rNs1sxmUUH+AR4pNsyJEhdQ0yNkrEEEa0Xq4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Cku7cw+ASDamibpiH+7T/fHnoVq/v6Dn5u7g78X7Ms7lkiA+98Z79AfiNNwcIgcnCs
         +gAA9L4qxH74RWeD4XDxkkUiOc0/vMkz4ObVvvOze2Vkyuq4nK/ZXboqaC2uvuAPaeaW
         zgRYN/Z7Y5KR0qaPTTmhQVKoR25jNGbc9QEtc=
Received: by 10.151.52.4 with SMTP id e4mr635360ybk.243.1280169327139; Mon, 26 
	Jul 2010 11:35:27 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 11:35:27 -0700 (PDT)
In-Reply-To: <AANLkTimRrpiv7cu=j598K3x4h3UGW7-Hik6-6jA8R_5J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151876>

On Mon, Jul 26, 2010 at 18:22, Jasper St. Pierre <jstpierre@mecheye.net> wrote:
> Where is '+' used in the URL context? I don't see that it's a
> replacement for '+'
> aside from formencoded, which is from CGI, not HTTP or the URI spec.

In my example? Nowhere, but I used : and @, which are also reserved
characters.

> I also can't access something called "test 2.txt" from Apache with
> "http://localhost/test+2.txt", so I don't think it's unescaping the '+'.

Yes, that's not supposed to work. But you should be able to access
"test+2.txt" using /test+2.txt and /test%2B.txt and
/%74%65%73%74%2B2%2E%74%78%74 for that matter.

git-daemon only seems to handle the first form. Which is probably a
bug, maybe it doesn't *have to* URI unescape its arguments, but it's
probably a good idea anyway. E.g. some systems that handle URIs will
convert : to %3A automatically when passing them through. That would
break a git URL.

> I don't think we should do anything about the '+' case, except where used in
> formencoded parameters (aka the "query string"), where it is used.

I don't really have an opinion on what we should do. It's not a
problem for me, I'm just noting how it could break, and that maybe we
should try harder and support URI escaping where we handle URLs.
