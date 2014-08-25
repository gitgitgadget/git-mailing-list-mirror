From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Mon, 25 Aug 2014 13:52:17 -0700
Message-ID: <CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com> <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
 <xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com> <20140825194430.GI30953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1Fs-0008Fu-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933335AbaHYUwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:52:40 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:39841 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571AbaHYUwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:52:39 -0400
Received: by mail-la0-f54.google.com with SMTP id hz20so14007830lab.13
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=c1LCy8OHmC5V/trdHt6XMBfP6eO3xk4jnTp9/vempA8=;
        b=pHjoI8ohbqgluo4T00dPs6j9zjfj7ltyislt40QcXIjsZtuVghzyvDZ1gutkaICo87
         SSZH0BkmF9Ss3F2qsWHtIVnaolPGe86JOidCN13Ar1TAAQ4Hdd47uPFKNXMIuUO9APBX
         ShiH0aVFJVFE1Gwc3v4iHTjOOFiYxHjGwclSn+xU0Zi6gckDXbooNs4y41Zrx0SdVFa8
         O6yIJIZNV8fh2UQYXBisQLoLghz15cr7iLphLObZ5WkRxCBHqmISTa8HCpFxUhbh0FP3
         oLxpKzmDsCcCRDcybsKvsXFHlz7VOr3RAdoVRQoulY7QVlLCb5DqG9Ni1DYwg6Qn3g92
         osAg==
X-Received: by 10.153.11.162 with SMTP id ej2mr23378575lad.15.1408999957611;
 Mon, 25 Aug 2014 13:52:37 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Mon, 25 Aug 2014 13:52:17 -0700 (PDT)
In-Reply-To: <20140825194430.GI30953@peff.net>
X-Google-Sender-Auth: fxP7qosaWEzaof4wGr8C2B6h0T8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255866>

On Mon, Aug 25, 2014 at 12:44 PM, Jeff King <peff@peff.net> wrote:
> For my own curiosity, how do you get into this situation, and what does
> it mean to have multiple stage#1 entries for the same path? What would
> "git cat-file :1:path" output?

That is how we natively (read: not with the funky "virtual" stuff
merge-recursive does) express a merge with multiple merge bases.
You also should be able to read this in the way how "git merge" invokes
merge strategies (one or more bases, double-dash and then current
HEAD and the other branches). I think there are some tests in 3way
merge tests that checks what should happen when our HEAD matches
one of the stage #1 while their branch matches a different one of the
stage #1, too.
