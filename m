From: Junio C Hamano <junio@pobox.com>
Subject: Re: To page or not to page
Date: Sun, 11 May 2008 10:15:39 -0700
Message-ID: <7vhcd469tw.fsf@gitster.siamese.dyndns.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
 <20080502054508.GA28506@sigill.intra.peff.net>
 <20080502060930.GA1079@sigill.intra.peff.net>
 <7vd4o5xm62.fsf@gitster.siamese.dyndns.org>
 <20080502125553.GB2923@sigill.intra.peff.net>
 <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org>
 <20080506055128.GA26311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 19:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFA8-0001wY-W2
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959AbYEKRPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756302AbYEKRPx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:15:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbYEKRPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:15:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B85754521;
	Sun, 11 May 2008 13:15:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0A100451C; Sun, 11 May 2008 13:15:45 -0400 (EDT)
In-Reply-To: <20080506055128.GA26311@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 May 2008 01:51:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7918B84-1F7D-11DD-80F8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81799>

Jeff King <peff@peff.net> writes:

> So how about this:
>
>  - keep a global use_pager = { 0 (explicit no), 1 (explicit yes), -1
>    (unknown) }
>
>  - if git-foo, lookup config for pager.foo
>
>  - otherwise we have "git [options] foo"; look for -p / --no-pager; if
>    none found, then lookup config for "foo"
>
>  - before proceeding further, "commit" the pager choice by running it
>    (if 1), munging GIT_PAGER=cat (if 0), or doing nothing (if -1)
>
>  - before handling an internal command, if use_pager is -1 and the
>    command defaults to a pager, we run it then
>
> The patch below implements this.
>
> It would be nice to actually defer running the pager until we are about
> to run a git command. I.e., never "commit" to the pager until we are
> actually running an internal command or exec'ing an external command.
> That way it would be safe to make an alias that called "--no-pager"
> (which is currently disallowed).

Ok, I agree that this is a less nice (as you mention ablve) but a workable
compromise with the reality.
