From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor bug report
Date: Tue, 2 Jun 2015 23:48:30 -0700
Message-ID: <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
 <20150603062005.GA20580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:49:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02UC-0003n6-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbFCGtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:49:05 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34487 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbFCGsv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:48:51 -0400
Received: by obew15 with SMTP id w15so605028obe.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=obsPbc+6uj8m9NdMdya4UWLKL1iSP2fdMiEL5JqlClo=;
        b=MD0cB+TZF58SXoj+KmXjVwBOL2Z0OgMd1CG+l1FPnJXFMdNomOBVxN73l9Tq4aZGHS
         w9oSs5Tltwb+rKnTWI4rxwoJdHBLa/jbRbdpCGNePDQIbuYIRliQTIryG10eSpgKupTP
         elJtFDDlNIQFnSxnURLT3DjKnLVhHLcFVylSivWobqwhpvLJtnhDntGN9wKF7MdteI/b
         wYkLNzeIb8Au08Cl2uRFn9SedF53EaIusuJQhX+nLw2zWNC+DFWqB2k/DIeSc5EbIR6a
         FvHynO9UB8kUfIT0lVBYQxYAWD6CdNhkfw66lZ6d3tdL0oSIDGq6Fo+nDay4j2M1ZzVt
         i81A==
X-Received: by 10.202.98.193 with SMTP id w184mr24529086oib.96.1433314130485;
 Tue, 02 Jun 2015 23:48:50 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Tue, 2 Jun 2015 23:48:30 -0700 (PDT)
In-Reply-To: <20150603062005.GA20580@peff.net>
X-Google-Sender-Auth: I-hex1ppI9mr8Gq3n_ToedK-b4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270637>

On Tue, Jun 2, 2015 at 11:20 PM, Jeff King <peff@peff.net> wrote:
>
> Here are some prior discussions:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/75692
>
>   http://thread.gmane.org/gmane.comp.version-control.git/200504
>
> I just skimmed through them, but I expect the most desirable solution
> would involve:
>
>   1. We still die(), but just improve the error message (so we don't
>      have any regressions for people expecting "git log" to fail).
>
>   2. We use the message only when pointing to an unborn branch, and not
>      on other errors. The simplest way to do this is probably to make an
>      extra call to resolve_ref() in the error code-path.
>
> -Peff

I am kind of surprised after reading these two threads that my
take on this issue has changed over time, as my knee-jerk
reaction before reading them was the opposite, something
along the lines of "This is only immediately after 'git init'; why
bother?". Or depending on my mood, that "How stupid do you
have to be..." sounds exactly like a message I may advocate
for us to send. Perhaps I grew more bitter with age.

Jokes aside, I wonder why we did not pursue that "default to
HEAD only when HEAD points at a branch that exists"
approach, with the definition of "exists" being "either a file
exists under the $GIT_DIR/refs/heads directory with any
(including corrupt) contents, or an entry in the packed refs
file exists with any (including corrupt) contents". With or
without the error exit and warning, that sounds like a very
sensible way to set the default, at least to me.
