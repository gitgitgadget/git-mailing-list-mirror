From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 14:22:57 +0000
Message-ID: <7963bbbe-9b85-492c-ad10-24a80e4eb1b8-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <20110420064318.GF28597@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:27:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCYNE-00024p-EN
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 16:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab1DTO1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 10:27:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49874 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab1DTO1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 10:27:15 -0400
Received: by pwi15 with SMTP id 15so418972pwi.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=vZeKlLiFQZtJKCYDMmkCEbKb2c4hqXDzeEul0+F3IU4=;
        b=es2J3P3wtTlPX8cUi6o+GLOsncm1JixC6ozGgI3wKccg0LmQvzJZzj7QSC2/vRvbLD
         Qs/s4xRKNogfsWeq0S49UD5OunojTKDtNdBA2gComgbhDqQPFdmqqQQs1KVdv4+mZ9ro
         wF+KSY+JFq2rELEJ4Nqtu8nPNs65RQbhVsN28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=RXAHcSKAIfLFJuM4M9Sco8DRY2p55SPG5kEczCBEx8kOo53lAiE+CWXE07PEO/Kvlx
         xLo5NLQRmUdL5d+HwF4DJrkzYVJ6GcSukHHmjAScwHH0P/YTA3ClQ+6MUbi2oGeVRrRi
         FWJsi1xMmpG72FedQQTnGouLB29d26JFjnqFE=
Received: by 10.68.40.39 with SMTP id u7mr286560pbk.430.1303309634915;
        Wed, 20 Apr 2011 07:27:14 -0700 (PDT)
Received: from gmail.com (tor-exit-router45-readme.formlessnetworking.net [199.48.147.45])
        by mx.google.com with ESMTPS id a4sm660826pbf.56.2011.04.20.07.27.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 07:27:09 -0700 (PDT)
In-Reply-To: <20110420064318.GF28597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171865>

On Wed, 20 Apr 2011 02:43:18 -0400, Jeff King wrote:

> On Wed, Apr 20, 2011 at 02:53:36AM +0000, Michael Witten wrote:
>
>> These patches apply cleanly to the current tip of Junio's `next' branch:
>
> Why not "master"? Usually we try to develop features independently on
> top of master, and then merge them. That way topics can graduate
> independently to master, and it is easier to see which topics are
> responsible for breakages. If you really need something in another topic
> (because you are directly building on it, or the merge would just be too
> painful), then build straight on that topic's commits, not on top of
> next (and of course tell everyone which topic it's built on).

Interesting points.

I was building on `master', but I figured I would expedite the testing
of my patch by making sure that it applies to the recent tip of `next'
without trouble.

In fact, when I did rebase onto `next', there were a couple of minor
conflicts that I had to resolve, so I can safely say that the current
patch series depends upon the following 2 topics:

  commit 84393bfd731c435120dc1dda63432a70124821cb
  Author: Namhyung Kim <namhyung@gmail.com>
  Date:   Wed Apr 6 11:20:50 2011 +0900

      blame: add --abbrev command line option and make it honor core.abbrev
      
      If user sets config.abbrev option, use it as if --abbrev was given.  This
      is the default value and user can override different abbrev length by
      specifying the --abbrev=N command line option.
      
      Signed-off-by: Namhyung Kim <namhyung@gmail.com>
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

  commit ef803fd4b09bca707c7c27669a2789bb050b488c
  Author: Michael J Gruber <git@drmicha.warpmail.net>
  Date:   Fri Apr 1 11:20:31 2011 +0200

      builtin/log.c: separate default and setup of cmd_log_init()
      
      cmd_log_init() sets up some default rev options and then calls
      setup_revisions(), so that a caller cannot set up own defaults: Either
      they get overriden by cmd_log_init() (if set before) or they override
      the command line (if set after). We even complain about this in a
      comment to cmd_log_reflog().
      
      Therefore, separate the two steps so that one can still call
      cmd_log_init() or, alternatively, cmd_log_init_defaults() followed by
      cmd_log_init_finish() (and set defaults in between).
      
      No functional change so far.
      
      Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

Those look likely to go into master, so it actually seems like a good idea to
have gone ahead and taken care of the conflict. However, in the future, I will
send patches to `master' only.
