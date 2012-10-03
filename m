From: Shawn Pearce <spearce@spearce.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 12:41:38 -0700
Message-ID: <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
 <20121003185542.GA3635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIi-0001DP-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab2JCTl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:41:59 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:58489 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2JCTl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:41:58 -0400
Received: by qaas11 with SMTP id s11so1842968qaa.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2uEB7w3o7w6m8EhsNGI857iUfilobqeiWdeyJ+cu16I=;
        b=d1pJAPsJWxKDnHkSVPP0AHiNLHLJRp7weh4izwjjSM4EUCk8nemAu9pHE9UhsqhSld
         t04N/CH4WMb1pL9vDD3yGBxiHtRqHQZCQhSc6f/twUZrKv+ZaPn3wbcNH5GuFkAuQz3m
         kVG73OvaUNZsBBIFn4Hd0Od0hM/OJ8S+xwInI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=2uEB7w3o7w6m8EhsNGI857iUfilobqeiWdeyJ+cu16I=;
        b=MvIrVABQ+zQxGxdsKmfyEdq+jvQyVUhDpUIA4rXOSrQv66BYjDQt5/3gSufmIptATS
         k7t09HxMtJSZL9Ud/CpQWpdMgr86mwBvvrojfRRXp7jmrY5UHt2fH25sbREJzQYYl83k
         xBR0VNm2e7+jfUEsJKOHD5hYPK/uN1egx81oWUYNzvQYpbwAMPsZ3hj4rT76ByZeTymo
         8y+AZGz/8stfFBO7kVSUm98W2tuB7oYJqXqX8dQv5GwY8cSZTw4kLVX3nLqF7kfF3qtk
         jJx1hwgLLgs2BLg4A7+YUda2+Sdf8A95Klx3+FSQp8BGqbxGFXlkUecA0RpVsb9ZpFzF
         ZMgw==
Received: by 10.224.175.204 with SMTP id bb12mr9080959qab.14.1349293318235;
 Wed, 03 Oct 2012 12:41:58 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Wed, 3 Oct 2012 12:41:38 -0700 (PDT)
In-Reply-To: <20121003185542.GA3635@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmqc/Z0/2sfUrmyZNF2Oeiji/gnWC2WkLORAyZyQaoEkJ4WNaGD1vlqwp3DLinV8YidTfn8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206933>

On Wed, Oct 3, 2012 at 11:55 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 03, 2012 at 11:53:35AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>> >> Has there been any work on extending the protocol so that the client
>> >> tells the server what refs it's interested in?
>> >
>> > I don't think so. It would be hard to do in a backwards-compatible way,
>> > because the advertisement is the first thing the server says, before it
>> > has negotiated any capabilities with the client at all.
>>
>> That is being discussed but hasn't surfaced on the list.
>
> Out of curiosity, how are you thinking about triggering such a new
> behavior in a backwards-compatible way? Invoke git-upload-pack2, and
> fall back to reconnecting to start git-upload-pack if it fails?

Basically, yes. New clients connect for git-upload-pack2. Over git://
the remote peer will just close the TCP socket with no messages. The
client can fallback to git-upload-pack and try again. Over SSH a
similar thing will happen in the sense there is no data output from
the remote side, so the client can try again. This has the downside of
authentication twice over SSH, which may prompt for a password twice.
But the user can get out of this by setting remote.NAME.uploadpack =
git-upload-pack and thus force the Git client to use the current
protocol if they have a new client and must continue to work over SSH
with an old server, and don't use an ssh-agent.

Over HTTP we can request ?service=git-upload-pack2 and retry just like
git:// would, or be a bit smarter and say
?service=git-upload-pack&v=2, and determine the protocol support of
the remote peer based on the response we get. If we see an immediate
advertisement its still the "v1" protocol, if we get back the "yes I
speak v2" response like git:// would see, we can continue the
conversation from there.
