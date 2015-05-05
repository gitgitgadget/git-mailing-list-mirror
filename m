From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/12] remote.c: provide per-branch pushremote name
Date: Tue, 5 May 2015 15:48:29 -0400
Message-ID: <CAPig+cQ+AbgTXAWKaN4obdGLWFDxjfr4yAaJZgvnLLzzoqdPRQ@mail.gmail.com>
References: <20150501224414.GA25551@peff.net>
	<20150501224644.GD1534@peff.net>
	<CAPig+cT7pSxZahd1hmcwCW8ifZfvQ4YW6L7xXUrD7dTJt76srQ@mail.gmail.com>
	<20150505193339.GF10463@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 21:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpipZ-0006w2-S8
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbbEETsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:48:33 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37435 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbEETsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:48:32 -0400
Received: by igblo3 with SMTP id lo3so108500988igb.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QGVrIwc3/avcuKCznEFCDgEGDknjsxUxJtxdV85GZJM=;
        b=I56nVNAQzPKz8dFnz4zMeB4C3F8gfro0KOut5jHpZAh5DtiMQuftYIEcALX52h/H5A
         DUy+l8yJW9c1J8qtEprryIOAXBxeRU7HqAYeX6ERAUTVdepMphNHH7hF1UavB9vbmxc9
         6/+9LLZb+TF4vi+758DAfnA8qQnLP4iX/91TLtXw2JvegKas2outUwhRTsDYcW9oqtqI
         krD+Pvr9gPCllTW+xxwbqwPkLdUgaa7y/gojR18xqBgB+vp2c2h4tZu0jfInUCPwiHWB
         3PD78IeLanV/Uu45WPagjxBkefqrR0Ye38H7G9Ts7eF0EMM1/9oY0Oibv212AZExPv/F
         FbCw==
X-Received: by 10.50.66.230 with SMTP id i6mr4000420igt.22.1430855310060; Tue,
 05 May 2015 12:48:30 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 5 May 2015 12:48:29 -0700 (PDT)
In-Reply-To: <20150505193339.GF10463@peff.net>
X-Google-Sender-Auth: BMdc9sMHXObk1Ryk9JsZ1In_T4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268421>

On Tue, May 5, 2015 at 3:33 PM, Jeff King <peff@peff.net> wrote:
> On Sun, May 03, 2015 at 12:51:13AM -0400, Eric Sunshine wrote:
>
>> > Versus v1, I did something a little clever by passing a function pointer
>> > around (versus a flag and letting the caller do a conditional based on
>> > the flag). Too clever?
>>
>> FWIW: I found this "clever" version easy enough to follow.
>>
>> However, if you push a tiny bit of the work into the callers of
>> remote_get_1(), then you can do away with the "cleverness" altogether,
>> can't you? Something like this:
>
> Yeah, it's just that it goes in the opposite direction I was trying for,
> which is to have as little code as possible in the wrapper functions (in
> fact, I think after my changes you could even bump the read_config()
> call into remote_get_1; before my changes, it depended on the pushremote
> config being set before the call).

I also noticed that read_config() could be moved into remote_get_1().
In fact, with that change, then the wrappers really do collapse nicely
to 1-liners, so the "clever" function pointer approach probably is
cleaner; and it's nicely generalized over the previous round with the
boolean argument to remote_get_1().
