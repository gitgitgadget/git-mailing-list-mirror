From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Thu, 2 Apr 2015 16:00:11 -0700
Message-ID: <CAGZ79ka9ficRLEV6KrG5qeAac0ZAQrj2nT=QF=_tFys5pq=5=w@mail.gmail.com>
References: <20150302092136.GA30278@lanh>
	<xmqqr3szql9r.fsf@gitster.dls.corp.google.com>
	<xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
	<1935847.zk75T7vt7M@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 01:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydo5x-00081t-MF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 01:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbbDBXAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 19:00:14 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38679 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbDBXAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 19:00:12 -0400
Received: by igbqf9 with SMTP id qf9so85271431igb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qeizxZ6iKvxBqxFBGlYlEhY7/EuXRpNA6QiuVANxEAs=;
        b=Tv6gUJfrTcHscYh17hfyTBlB++KHdvWGBBMkxZoMAjb68ggKQkPBsRcpAkEq93BX05
         MYJDaPfBXCCEOLYPXwbWy2tMkPcJrljdBPT9ZE39stsrdvBcVi6ajuYJfW7/qZtqQ8zV
         0YPrKZ/YEPrz+wud3AnSY8anL46G//+3AunPceZtsLuXaK015pvGS9gqjJy55bTuWykZ
         JJ3OrPXqculotDmJNeiqVp3GjfHiEVI6HOqOTWcBK8Ax8N0KGLUEkoRZUuz2cX60kStt
         45SzLnmVMtSwzZR48s7YdtktT1bHMSR8UtL8AHU03Yie9kYn/kBA5Kc8axgfIpeNBuuU
         7zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qeizxZ6iKvxBqxFBGlYlEhY7/EuXRpNA6QiuVANxEAs=;
        b=iZx2vto1J3tC4P8isitWgCZ5e4gFjgpOK1c+QR6aA3rHPSwHDjG29yPk1sZNpcdkGh
         nvqfxYv7jh0N9EiZNHJ4wgN/0rb0dbycYOEuQlipbnqq/kkh+VFfzfEmlNQuJ33JZDYd
         GT84a4nHsasP3/U+X/fq8gWE43Dy+atAyUw8StjRfT1dX9FdWLURiPMp6xODBxWpdWKU
         bsA0s++o0ZGzf5lIiNzpoQXgTM8lZX8AK0VHGIXc9RV8PhuiPOaRKqexetUOhGU1+Pgu
         EcqkK5jE6v/8tZmCEImUkWfMeLvfI0VPRxwvVF9Q7BEDqDH1wc8III+jpvuupB/RcSoO
         q8XQ==
X-Gm-Message-State: ALoCoQlaoevJDIdfEUXS8CeVZLGFQFDLW1tzi+rKLJ7mfjxk53Gd4rYo7B7SjsyJZIXvOPRyUbW3
X-Received: by 10.50.254.4 with SMTP id ae4mr370019igd.10.1428015611457; Thu,
 02 Apr 2015 16:00:11 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Thu, 2 Apr 2015 16:00:11 -0700 (PDT)
In-Reply-To: <1935847.zk75T7vt7M@mfick1-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266691>

On Thu, Apr 2, 2015 at 3:18 PM, Martin Fick <mfick@codeaurora.org> wrote:
>> The current protocol has the following problems that limit
>> us:
>>
>>  - It is not easy to make it resumable, because we
>> recompute every time.  This is especially problematic for
>> the initial fetch aka "clone" as we will be talking about
>> a large transfer. Redirection to a bundle hosted on CDN
>> might be something we could do transparently.
>>
>>  - The protocol extension has a fairly low length limit.
>>
>>  - Because the protocol exchange starts by the server side
>> advertising all its refs, even when the fetcher is
>> interested in a single ref, the initial overhead is
>> nontrivial, especially when you are doing a small
>> incremental update.  The worst case is an auto-builder
>> that polls every five minutes, even when there is no new
>> commits to be fetched.
>
> A lot of focus about the problems with ref advertisement is
> about the obvious problem mentioned above (a bad problem
> indeed).  I would like to add that there is another related
> problem that all potential solutions to the above problem do
> not neccessarily improve.   When polling regularly there is
> also no current efficient way to check on the current state of
> all refs.  It would be nice to also be able to get an
> incremental update on large refs spaces.

I think once the new protocol is in place, the server could advertise
the capability to send a differential of refs.

To make sure that works the capability phase should be strictly separated
from the rest, so you can think of any new fancy scheme to transmit
refs or objects, and once both client and server agree on that fancy scheme
both know when to expect the "new changed" protocol.

So from a high level perspective it should look like:
Phase 1) negotiation of capabilities
Phase 2) ref advertisement (i.e. changes in the DAG end points)
Phase 3) transmitting the missing blobs.

The crucial point now is to make sure Phase 1) is not growing to large in
transmission size / required compute power (/ complexity).

And as everybody out there wants to invent new schemes how to do 2) and 3)
efficient, I wonder if we need to do Phase 1) as a differential as well, so I'd
presume the optimum could look like

Client: Last time we talked the capabilities you advertised hashed to $SHA
Server: That's right, but additionally I have "push_cert_nonce=$value"

In the non-optimal case:
Client: Last time we talked the capabilities you advertised hashed to $SHA
Server: I don't know that value, here comes the list of all
capabilities I can do:
 ...
 ...

I like that approach as it would really break down to transmitting the minimal
amount of information most of the time. The downside is to know which
capabilities are cache-able and then hash-able, such that the remote side
only needs to maintain only a very small set of advertised capability lists
and their hash. For example the nonce for signed pushes will hopefully
never be the same, so it makes no sense to have them inside the capabilities
cache.

Having such a capabilities cache would give us a long time until the
phase to negotiate the capabilities will grow too large again (most of the
capabilities I'd assume are rather static per server)

And the way I understand the current situation, it's all about talking this
early negotiation phase, which then allows us to model the refs
advertisement and
the blob transmission later on as a response to upcoming problems in the future.

>
> Thanks,
>
> -Martin
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code
> Aurora Forum, hosted by The Linux Foundation
>
