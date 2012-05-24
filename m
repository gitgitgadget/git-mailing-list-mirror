From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH v2] checkout: no progress messages if !isatty(2).
Date: Thu, 24 May 2012 14:49:40 -0400
Message-ID: <CAHqTa-0y0ETeq2G2FPMWgAwkXF_LSLN=VqnijF-m3q2YT0z4mQ@mail.gmail.com>
References: <20120524061000.GA14035@sigill.intra.peff.net> <1337839944-4651-1-git-send-email-apenwarr@gmail.com>
 <7vy5ohwhy7.fsf@alter.siamese.dyndns.org> <20120524183457.GA11841@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 20:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXd6v-0004wc-E9
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab2EXSuD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 14:50:03 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59374 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757145Ab2EXSuB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 14:50:01 -0400
Received: by vbbff1 with SMTP id ff1so88981vbb.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Hz4qfhmqONPPE2oFaVFmP/ZfadmNesqEcyCuNKJzPfI=;
        b=fSAynSwzwj1Nd+th/7QmSyKBBfGBVSaVo6EWUjXqTzsPt0bB6hFq0qbNk6Mdhnk0NQ
         JfYteBMFON62wj33aUE4csgTcMx9n6tcQ8Ta7slehk8y4ad2sPh75keRCzQGR5T99wXN
         pFcQa1d5Mo/WrzP0hhbUsvww17wq72zpRbbVFp8/PQqz1FKly7QAbQnJy2gg13kea+QB
         Tv3w4kkjbDZ8L2xloYUzDFwgLKcEGXXcp2P6PidGoFcXF+UskkNK0x5VAanbATcXJEhS
         hTYwMj0LulWSJMY0LxefMGXTCdLLG0o+MfPq8Z3p7LFAwm+tO1lfyMl2xJyzSFHUC+hy
         dh8Q==
Received: by 10.52.35.15 with SMTP id d15mr345485vdj.128.1337885400590; Thu,
 24 May 2012 11:50:00 -0700 (PDT)
Received: by 10.52.38.200 with HTTP; Thu, 24 May 2012 11:49:40 -0700 (PDT)
In-Reply-To: <20120524183457.GA11841@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198407>

On Thu, May 24, 2012 at 2:34 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 24, 2012 at 11:29:52AM -0700, Junio C Hamano wrote:
>> I do not seem to find a sane justification for
>>
>> =A0 =A0 =A0 git $cmd --progress 2>output
>>
>> use case and I do not immediately see how that "output" file can be
>> useful. =A0But we've allowed it for a long time, so probably this ve=
rsion is
>> safer. =A0Besides, it is more explicit.
>
> Actually, I ran across a case of this just recently. If you are writi=
ng
> a graphical interface that wraps git, scraping "--progress" output fr=
om
> a pipe is the only way you can provide a progress meter within your
> interface. That is what the "GitHub for {Mac,Windows}" interfaces do
> (they also use libgit2 where possible, but it is far from feature
> complete).

This is why we have ptys, isn't it? :)

</halfkidding>

=46WIW, in bup we use environment variables for this.  bup's main
program automatically redirects stderr to a pipe (to keep overlapping
status messages from interfering with each other) and the subcommands
need to know that stderr "was" a tty.  Arguably, an environment
variable is a better place for this since a script would presumably
want progress messages or not, globally.  It would also have solved
the problem where git-new-worktree doesn't have a --quiet option.

Have fun,

Avery
