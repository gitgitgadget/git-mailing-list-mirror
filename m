From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Mon, 17 Nov 2014 17:01:16 -0800
Message-ID: <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 02:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXAX-00037n-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaKRBBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:01:18 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48316 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbaKRBBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:01:17 -0500
Received: by mail-ie0-f170.google.com with SMTP id tr6so4132666ieb.29
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rV2SSwQWMTMzlfpvFsPIju79AXv9LFpU5gXARhLSo/8=;
        b=bUz6Gd4/Z/bwGOYaFGmMWEnWB9Qzw7CyKcW7lrkh701jPi7vPzm+HYvqXoXGW0sqHI
         9vzCS//5XGtz0G7/nLKvyPHv6z2SBgYdJ3lhJTTqUghjI9prEseHmQ8EUgvc8NzCEQ6b
         aoptE1hc9t1qZfvfbnxWKI5R6kzABCPDa/7NBOsP5gnvNjEDAb6SdBATxnyEe85eVaOh
         yX7UWukXqWvOhpSYyLqyV9tkj153ftdeOZgOZBkk3/yAXDbInPd3nhL/S/ArLG2yob0q
         kQRxJgNmhP0vBXabVeJdWS/cVmYjm7sOsj1xpY6BnirOX0RxE8sCdS8vQ9rL+hONZWvy
         gWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rV2SSwQWMTMzlfpvFsPIju79AXv9LFpU5gXARhLSo/8=;
        b=fgoGDC/xcQJcsARDOZBacH5g3PNhpzQEHVa2QKLZ8atAv0V/jCIr+l72NvDFUiPGdL
         x2sPgoMwONeewtDb2NlniahgyKuJ783zh8HYht5Yy95/HWvNsEnCg7nLdFubshN8fv+m
         TrypphuCrY9k1l0Anzwy8ov9+aYuATo3LIXEgWbgcnf7ARnGWtCYg1YOWX2uM2VgfeVN
         eiEQzUM6i0hK9diojI0nFe/2nq8Bli9U/gIm87C0fCAu8hVHHVbDJOq0xs5xF/E4xoSA
         N57TYkD+HgqZNtUUnw+UdO+DIZwb8o5HgqcN3C8rZsxABGR3t/YdE4NEx9GBFi3sJ6QN
         TZ8w==
X-Gm-Message-State: ALoCoQl5vh8G/OqNvXq9IK6UHWL/2R1YTsbv7anNCemqNaxFOyClsnwL3M+47YGZNbvsnJ6Y7VRY
X-Received: by 10.107.137.33 with SMTP id l33mr649137iod.38.1416272476969;
 Mon, 17 Nov 2014 17:01:16 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Mon, 17 Nov 2014 17:01:16 -0800 (PST)
In-Reply-To: <20141118004841.GE4336@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 4:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (meta-comment: please snip out the context you are not responding to,
>  to make reading easier)

will do

>
> After this patch, setting errno is not part of the contract of
> copy_fd, so the bug Ronnie was fixing is gone.
>
> But it's a little more invasive.  What do you think?
>

I really like that approach and would be happy if we'd take it instead
of the one I sent.
