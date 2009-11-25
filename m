From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 18:22:10 -0500
Message-ID: <20091125232210.GA15538@coredump.intra.peff.net>
References: <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <7vtywiqmbs.fsf@alter.siamese.dyndns.org>
 <20091125222625.GB2861@coredump.intra.peff.net>
 <4B0DB29D.5010101@gmail.com>
 <20091125225318.GA10127@coredump.intra.peff.net>
 <4B0DB894.7010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:22:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRBi-0005CO-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118AbZKYXWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758914AbZKYXWE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:22:04 -0500
Received: from peff.net ([208.65.91.99]:45256 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758902AbZKYXWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:22:03 -0500
Received: (qmail 17274 invoked by uid 107); 25 Nov 2009 23:26:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 18:26:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 18:22:10 -0500
Content-Disposition: inline
In-Reply-To: <4B0DB894.7010800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133699>

On Wed, Nov 25, 2009 at 06:07:00PM -0500, A Large Angry SCM wrote:

> <semi rhetorical>
> So, what's the solution?
> 
> Have every command command take a list of configuration options to
> ignore/respect?
> 
> Have every command take an option to ignore/respect _all_
> configuration options?
> 
> Have inconsistency between commands, like we have now
> 
> Have commands have all kinds of hidden/undocumented default settings?
> </semi rhetorical>

I don't know. All of those options suck. ;

Probably we would want something flexible, but with sane defaults. Like
an environment variable to ignore all (or most) config options, but then
the ability to opt into specific ones. Something like:

  GIT_PLUMBING=1; export GIT_PLUMBING
  git log ;# does not respect any non-plumbing config
  git --respect='log.showroot' ;# respect just the one variable
  git --respect='color.*' log ;# you get all color

But there are two big obstacles (besides the obvious issue that
introducing this in itself needs a gentle transition plan):

  1. We need to annotate every config option with whether it is
     potentially problematic. For example, core.filemode should probably
     be respected no matter what (but I'm not sure if it is simply true
     for core.*).

  2. Script writers need to actually use the system, which is somewhat
     more verbose and annoying than what they have to do now. But at
     least it defaults to safety when they are lazy, and then they can
     re-add options. Of course, they are stuck on an upgrade treadmill
     of analyzing and approving each new option that appears in git.

-Peff
