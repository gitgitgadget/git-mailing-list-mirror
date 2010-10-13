From: Kevin Ballard <kevin@sb.org>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Wed, 13 Oct 2010 15:49:25 -0700
Message-ID: <54F2B62F-E768-49D8-96CB-780DA3ECBF0E@sb.org>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org> <1287006523.13553.4.camel@drew-northup.unet.maine.edu> <24AC771D-07A7-49D7-8824-28E6156C90B4@sb.org> <m27hhld8d9.fsf@igel.home>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Drew Northup <drew.northup@maine.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6A8f-0005Dr-SZ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab0JMWta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:49:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43871 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab0JMWta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 18:49:30 -0400
Received: by pxi16 with SMTP id 16so859279pxi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:49:29 -0700 (PDT)
Received: by 10.142.203.1 with SMTP id a1mr8117266wfg.203.1287010169693;
        Wed, 13 Oct 2010 15:49:29 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x35sm4698846wfd.1.2010.10.13.15.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 15:49:29 -0700 (PDT)
In-Reply-To: <m27hhld8d9.fsf@igel.home>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158999>

On Oct 13, 2010, at 3:40 PM, Andreas Schwab wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> I've been investigating this on the emacs side as well. At the moment, my suspicion is that ^G causes emacs to trigger (keyboard-quit), but at the same time the surrounding environment (e.g. git) is sending a SIGINT to emacs, which normally acts like ^G but in this case may be triggering the emergency exit mode of emacs. Is there some reason that the interactive add would be sending SIGINT to emacs when I type ^G?
> 
> If you are using text mode (-nw) then Emacs redefines the INTR character
> of the terminal to ^G.  On the other hand it should also put itself into
> its own process group, so the parent should not receive the terminal
> signals.  And this is what happens here when I try it.

I am indeed using text mode. And when I test, invoking `emacs` directly gives it its on process group, but invoking emacs from `git add -p`+e doesn't.

kevin@Brandybuck:~> ps -jp 34581 34540
USER    PID  PPID  PGID   SESS JOBC STAT   TT       TIME COMMAND
kevin 34540 34539 34538 7d29d68    1 S+   s001    0:00.08 /usr/bin/perl /usr/local/libexec/git-core/git-add--interactive --
kevin 34581 34540 34538 7d29d68    1 S+   s001    0:00.61 /usr/bin/emacs /Users/kevin/Dev/Work/Standard9/inkling-ipad/.git/

Any idea why this would be?

-Kevin Ballard