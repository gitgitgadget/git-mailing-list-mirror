From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Tue, 17 Apr 2012 13:09:09 -0700
Message-ID: <CA+55aFzLFA535CtjLJe1p62H=nunQ=vrL_mPYsYJB0e8U7mpdg@mail.gmail.com>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
 <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com> <7vzkaambre.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-2?Q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:10:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKEjG-00041b-2p
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab2DQUJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 16:09:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49741 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2DQUJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 16:09:31 -0400
Received: by wibhq7 with SMTP id hq7so1015932wib.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lZM7Xafd+p7R/Fcha7nkCt/+LOWLSUCLC/W5LMg/aVE=;
        b=sozGkY43rvK3y1qhnSGRYU5kGpdEKrBwOtru03IGBNKW4MTyGhYOVAxPwKDBdQsckz
         WIFFFijmiSLbMIi/ZZU1Izap58PDtCP5k4UdYC4zJIxa/Sc0BHAkrcpFRhSG8RrpAHfC
         oH/mkE/9Xm2QKZQw23VE7OwfeBxcYtPNERVtGNvciIsSzfkT6jZE2mK9q7y4WbIIVCkX
         mKlPKX3EdNPwGuT64mCmSCYx7go31AcalcfewFjU83piTV5nobP7l5yZva5AQ2iHDng2
         U8g720r61kqblrOf+eSq3O80fBDGQpvh6ag4EP2bBg73AGFjLe4uq3LozzqPOscDF97d
         HBzQ==
Received: by 10.180.102.100 with SMTP id fn4mr31648338wib.1.1334693369593;
 Tue, 17 Apr 2012 13:09:29 -0700 (PDT)
Received: by 10.216.221.167 with HTTP; Tue, 17 Apr 2012 13:09:09 -0700 (PDT)
In-Reply-To: <7vzkaambre.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 9nmLCannUmLjbPKzSNKoXekaRJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195797>

2012/4/17 Junio C Hamano <gitster@pobox.com>:
>
> If your current HEAD is an ancestor of one of the commit on that list=
, the
> above does not omit it from the parent list of the resulting merge co=
mmit,
> but if you performed the same merge while on one of the commit being
> merged, your current HEAD will be excluded with reduce_heads(), which
> would mean that you will end up recording a different history even th=
ough
> a merge is supposed to be symmetrical.
>
> In other words, isn't any solution that calls reduce_heads() only on
> remoteheads fundamentally wrong and merely papering over the problem?

I think Micha=C5=82's patch, together with my original one (but not the
fixups later) is actually the right thing to do.

Micha=C5=82's patch fixes the "log shown multiple times" problem. It al=
so
turns a certain class of octopus merges into trivial common merges,
which is good.

So I'd suggest:
 - undo the two top commits from lt/octopus-simplify
 - apply Micha=C5=82's patch on top of the remaining one commit

It's not perfect, and I really think we could simplify things a bit
more here, but I think the two commits together fix the problems in
practice.

Hmm?

                     Linus
