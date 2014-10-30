From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 6/8] receive-pack.c: add a receive.preferatomicpush
 configuration variable
Date: Thu, 30 Oct 2014 14:36:50 -0700
Message-ID: <CAL=YDWmNXpe=0UxbHD-5pwNW-hdp=Ja1Xy8gXAKcbSkoJhpgRw@mail.gmail.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-7-git-send-email-sahlberg@google.com>
	<xmqq7fzhuxlh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxOq-0004HM-1d
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbaJ3Vgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:36:52 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:48738 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161089AbaJ3Vgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:36:51 -0400
Received: by mail-qg0-f44.google.com with SMTP id q107so4809167qgd.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M+/Sz20t6cY/gQbNQ6flqNewq5dtyencYGm2fevsfCY=;
        b=d+3IrjF8HYSZJ7CVrKkM6PYGrXx69Ze3vAJoAOaBmVmXKODzwftXFBGUwUay/NhTcM
         gpZH9YoMu/LJg61ki72fsUxRFYKX7ZmYQ29kYno04pxZvx3nHjsVaccid/5jvhEIs+z8
         G6ioPS//mhYwEhoOS9pny9coTl9spnfeHyiz/LtotkBMx7dw6RBePhPzkSd0ly18o8W5
         q6Etr7bY/3bmlAcgPYDiz4In64R9vEPYXkG1s6za/SKtUFPjisE9/y0SllRb7wuiZTWm
         4shZXxgzDCk14kXCC182MKcSbxaIrmoeIZnppWMyUxEh9x29KhPaXeqYU4Vh/MnABJiy
         a1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M+/Sz20t6cY/gQbNQ6flqNewq5dtyencYGm2fevsfCY=;
        b=I0wUCgRv262+NUhKeQZn2tVnsErBeuZfxvpIkGayPqrwl39/FmpDfxcsn9+l9PUo4m
         MYEkMenck1G2KavTymNt7BZITaucz01DKfsetjLKP3S5LT98vcGEWdU3oBruNocyqdyr
         PE4p5y4GroTEv80aFV/SPAT/Ki3rDPJh+jxvFQNKJ11v0yFEKrdgJID35ubuZxdeQJlc
         l9GSfirkzRmqwaK7PnTB8KCC8o7NQ9PgEHoZSTu/PTfrawaqYmo51X+8Clu1YPd3Ud7k
         VvPoIv3N3yQ0o0ROwQU+whcp0cQXgtpbDpvBLSGXAucO78TO/HmhkKFqTrnUfU12Roaq
         CNtA==
X-Gm-Message-State: ALoCoQm+AVxakIHHoWs29VqkHGF/CYKevUcMP1w94cy4J87CJmxDNtVZeLdvqxG5t6hBTiylIKu3
X-Received: by 10.229.40.71 with SMTP id j7mr30521309qce.21.1414705010909;
 Thu, 30 Oct 2014 14:36:50 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 30 Oct 2014 14:36:50 -0700 (PDT)
In-Reply-To: <xmqq7fzhuxlh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Add receive.preferatomicpush setting to receive-pack.c. This triggers
>> a new capability "prefer-atomic-push" to be sent back to the send-pack
>> client, requesting the client, if it supports it, to request
>> an atomic push.
>
> I can understand a configuration that says "We take only atomics
> when a push tries to update more than one", but this one is iffy.
>
> If the receiver accepts non-atomic from older send-pack, those with
> newer send-pack should have a way to say "the receiving end may
> prefer atomic, but I choose not to."  Is there a way to do so?

There is no way to do so right now.
I can add a --no-atomic-push argument to the client to make it ignore
this hint from the server.

>
> And if there is such a way, what value does the preference add to
> the user experience and the server's operation?
>

The reason for this preference was to make it possible to flag a
repository to always try to make all pushes atomic, when possible.
A preference for convenience. You could set on the server to try to
make all pushes atomic so that clients do not have to specify
--atomic-push all the time.


Currently this is just a hint on from the server and is not enforced
for backward compatibility reasons.
If the client does not have atomic push support, the client will
ignore this hint and just do a normal push instead.


This is the least important part in this patch series so I am open for advice :
1, I can remove this patch/preference if you prefer.
or
2a, I can add a --no-atomic-push flag to send-pack to have a way to
force the client to do a normal nonatomic push even if the server
indicates it wants atomic pushes.
and/or
2b, I can add another preference  receive.requireatomicpush to the
server so that the server can reject any push outright if it is not
atomic.


At some stage it may becomes too many preferences and over-engineered.
Maybe I should drop this patch and then just require the plain "if you
want a push to be atomic, then use --atomic-push. end." and we have
simple and easy to understand semantics.


Please advise.


Regards
Ronnie Sahlberg
