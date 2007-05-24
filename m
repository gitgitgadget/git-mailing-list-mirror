From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 09:29:05 +0200
Message-ID: <81b0412b0705240029p1cdfaa28w7f70ee792c42ca4a@mail.gmail.com>
References: <11799589913153-git-send-email-skimo@liacs.nl>
	 <11799589922243-git-send-email-skimo@liacs.nl>
	 <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com>
	 <20070524071819.GN28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "skimo@liacs.nl" <skimo@liacs.nl>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Martin Waitz" <tali@admingilde.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 09:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7lK-000404-OR
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbXEXH3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758340AbXEXH3J
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:29:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758839AbXEXH3G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:29:06 -0400
Received: by ug-out-1314.google.com with SMTP id 70so831810ugb
        for <git@vger.kernel.org>; Thu, 24 May 2007 00:29:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bgzD5EF4h/Gr0iBAttIEKOzrjBIV9KrRU8/BADSwE3kTvDaKKO/Rh8AU7PSUovTPzv2HRTLxVMc8PvZ+bAyRZNOmCKqMTrCFbRJ6wjzsLGm86VgNPushEWpFEm1pCp8eytpyIHJGT1eSoXIIb9Vm46ZX0jZhbNC3cScfwDjHw0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jOCdltYBUhwKiUsk1/cbeUwp2j6yLnPrFkv2YP9gvyeUKgVd/mZYBQDRDlpDS7IyM7W3qNhlRsZZRo2D964q+2Vx24c+2c6FzxEYnSEtcwbvAg9EvkPrDNb6Z+CFg4jJv8prpbMDRe2NCn7AurY1GbO6RMZacgBjJHtqC5EDWCo=
Received: by 10.78.179.12 with SMTP id b12mr382294huf.1179991745566;
        Thu, 24 May 2007 00:29:05 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Thu, 24 May 2007 00:29:05 -0700 (PDT)
In-Reply-To: <20070524071819.GN28023@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48234>

On 5/24/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:
> >
> > >+       args[argc++] = "checkout";
> > >+       if (state->force)
> > >+           args[argc++] = "-f";
> > >+       args[argc++] = sha1_to_hex(ce->sha1);
> > >+       args[argc] = NULL;
> >
> > You should consider passing "-v" if the superprojects read-tree
> > had it. Some submodules will be annoyingly big
>
> In 1.5.2 that -v shouldn't be necessary.  The read-tree should

It is necessary. Progress meters may not stay forever the only
thing to show when verbose. The code just stripped a part of
users command, how _can_ this be ok?!

> start a timer, and if it has not reached 50% of its processing
> within 2 seconds it starts showing progress.  Unless !istty(2),
> in which case it just sits there, chugging away at your drive.
>
> I'm actually really unhappy with our !istty(2) means disable
> progress thing.  git-gui knows how to read and show the progress
> meters, but nobody prints them anymore as 2 is a pipe.  I have the

Somebody does: just because some stupid script in the middle
did a 2>&1.

> same problem with a Java build tool that sometimes starts up an
> expensive Git operation (like a clone over SSH of a 60+ MiB project).

That said, many tools have explicit --progress switch. Maybe _this_ is
what you need, and not an override whether STDERR is on a tty.

BTW, you could have used ptys, at least on UNIX-like platforms.
