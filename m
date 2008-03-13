From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 10:04:15 -0400
Message-ID: <20080313140415.GB30348@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213916.GK26286@coredump.intra.peff.net> <47D8DCC0.9090303@viscovery.net> <20080313124103.GC19485@coredump.intra.peff.net> <47D9332C.4020904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:05:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZo3F-0000wp-Js
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 15:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYCMOES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbYCMOES
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 10:04:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2896 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbYCMOER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 10:04:17 -0400
Received: (qmail 2352 invoked by uid 111); 13 Mar 2008 14:04:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 10:04:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 10:04:15 -0400
Content-Disposition: inline
In-Reply-To: <47D9332C.4020904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77089>

On Thu, Mar 13, 2008 at 02:59:08PM +0100, Johannes Sixt wrote:

> > +	status = run_command_v_opt(argv, 0);
> ...
> > +	return status == 0 ? 1 : -1;
> 
> grep can return 0 (success, something found), 1 (nothing found), and other
> values for "real" failures like usage errors or crashes. This conditional
> throws the latter two into the same pot, which makes git-grep unable to
> distinguish "nothing found" from failure; cf. the call sites of
> flush_grep(), where want to set the flag 'hit'.

I noticed that, as well, while writing it. But if you look at
external_grep, it just lumps the two cases together anyway. It only ever
compares "0 < status", so I think the behavior should be identical.

Which isn't to say that the code couldn't be _improved_ by noting grep
failures and crashes, but I don't think it is any worse.

-Peff
