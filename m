From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Thu, 17 Dec 2015 19:26:45 +0700
Message-ID: <CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com> <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
 <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com> <20151216024605.GA618@sigill.intra.peff.net>
 <xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com> <xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
 <20151217074443.GA4830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 13:27:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9XeV-0003Wc-Fv
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 13:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966616AbbLQM1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 07:27:18 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34432 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966602AbbLQM1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 07:27:17 -0500
Received: by mail-lf0-f50.google.com with SMTP id y184so50542804lfc.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 04:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N9BFu/uavLNh2fp/J9b37cNaNhGfVkeDyr7K61xytvg=;
        b=pH+MYHXixFhfzIdC6ZuljgQKv1xSWscV5D2AyFrogrOwhMI02y0SGeIVbxNmOhP9lq
         BZ2eqUnOpt22d0gohxNB6eXai5klev8uRSdgKsBl9FhHj4BZDONMYAgvyoUZSRa0fuM+
         jEPc1UzrgZMfdiZf2Vz9ADKEcBBMTcZdsf9AigdRPQOrwhAPnd0kpUGE4uFag23f/deh
         LFTgAt7QFIh8+gkFSJFz/nMHvIUWcNxAYUfa2TufJv8MgM3QFunIqm+V7WcsTrkIlYA4
         usA7udf4Ti16DQdyQMt/f0r5RLaTOTiZHhTqZIjIjJ+eBBchQ0KIIRrmgTISnPoQ9zIB
         zl7A==
X-Received: by 10.25.33.4 with SMTP id h4mr17418040lfh.3.1450355235721; Thu,
 17 Dec 2015 04:27:15 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 17 Dec 2015 04:26:45 -0800 (PST)
In-Reply-To: <20151217074443.GA4830@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282650>

On Thu, Dec 17, 2015 at 2:44 PM, Jeff King <peff@peff.net> wrote:
> I think we may actually be thinking of the same thing. Naively, I would
> expect:
>
> ..
>   - if there is cache data in the index but that config flag is not set,
>     presumably we would not update it (we could even explicitly drop it,
>     but my understanding is that is not necessary for correctness, but
>     only as a possible optimization).

No, if somebody adds or removes something from the index, we either
update or drop it, or it's stale. There's the invalidate_untracked()
or something in dir.c that we can hook in, check config var and do
that. And because config is cached recently, it should be a cheap
operation.

Apart from that the idea is fine.

> You could have a config option for "if there is a cache there, pretend
> it isn't and ignore it", but I don't see much point.
-- 
Duy
