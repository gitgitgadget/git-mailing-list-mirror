From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Wed, 8 Jan 2014 02:32:10 +0530
Message-ID: <CALkWK0mGPhU-8vVg+xY-MGWNstxoXSU9MGQiNzyFN+-Q6Bw28A@mail.gmail.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com> <20140107204035.GA27932@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dnc-0002YK-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbaAGVCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:02:51 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51403 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbaAGVCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:02:51 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so1066875iej.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3OU06Dr3QVhFO/IQFASJ/7unNT/Ds08212xQVcn9ImQ=;
        b=C0qk1RRwPr5yUOOZn1oFdjaGtUmr3+3sHgW6H/wLMnnp4565W7DTnUGL0DJQDPoKLb
         NEjZrIJIg8EbNfxaoVhWCWSLDQkXhpxfWKV6Rdxu6DPoBA83TTBcsclLQ3zAxrvUWmzV
         iW4m0M9xc8qlB3MqRkhis8i2VFMbcSP+bY1WTPGqJKAE0JnoEqOD7xdHMSGvbHOoViEg
         t32h8LGaeIvwVxqI+Of989nGA5Uk4SISmuAJvJQvFBYWackuNm8hlN2tX89Zov/3c/so
         o8x9RfuX5nIBKtAxNxaoRfHlYugG6viTs7lvR08xK3DwJhbAWUr3et9eYUR15sUnE2XI
         ljLQ==
X-Received: by 10.42.44.9 with SMTP id z9mr2113974ice.88.1389128570683; Tue,
 07 Jan 2014 13:02:50 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 13:02:10 -0800 (PST)
In-Reply-To: <20140107204035.GA27932@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240153>

Jeff King wrote:
> I have not carefully read some of the later bits of the discussion from
> last night / this morning, so maybe I am missing something, but this
> seems backwards to me from what Junio and I were discussing earlier.
>
> The point was that the meaning of "@{upstream}" (and "branch.*.merge")
> is _already_ "forked-from", and "push -u" and "push.default=upstream"
> are the odd men out. If we are going to add an option to distinguish the
> two branch relationships:
>
>   1. Where you forked from
>
>   2. Where you push to
>
> we should leave @{upstream} as (1), and add a new option to represent
> (2). Not the other way around.

I have a local branch 'forkedfrom' that has two "sources": 'master'
and 'ram/forkedfrom'. 'ram/forkedfrom' isn't a "dumb" publish-point:
the relationship information I get between 'forkedfrom' and
'ram/forkedfrom' is very useful; it's what helps me tell how my
re-roll is doing with respect to the original series; I'd often want
to cherry-pick commits/ messages from my original series to prepare
the re-roll, so interaction with this source is quite high. On the
other hand, the relationship information I get between 'forkedfrom'
and 'master' is practically useless: 'forkedfrom' is always ahead of
'master', and a divergence indicates that I need to rebase; I'll never
really need to interact with this source.

I'm only thinking in terms of what infrastructure we've already built:
if @{u} is set to 'ram/forkedfrom', we get a lot of information for
free _now_. If @{u} is set to 'master', the current git-status is
unhelpful.
