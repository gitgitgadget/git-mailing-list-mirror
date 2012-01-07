From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] run-command: kill children on exit by default
Date: Sat, 7 Jan 2012 09:50:04 -0500
Message-ID: <20120107145004.GB2461@sigill.intra.peff.net>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jan 07 15:50:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjXb4-0005B9-Ov
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 15:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab2AGOuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 09:50:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60059
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab2AGOuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 09:50:07 -0500
Received: (qmail 16381 invoked by uid 107); 7 Jan 2012 14:56:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.2.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Jan 2012 09:56:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2012 09:50:04 -0500
Content-Disposition: inline
In-Reply-To: <1325936567-3136-3-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188081>

On Sat, Jan 07, 2012 at 12:42:44PM +0100, Clemens Buchacher wrote:

> It feels natural for a user to view git commands as monolithic
> commands with a single thread of execution. If the parent git
> command dies, it should therefore clean up its child processes as
> well. So enable the cleanup mechanism by default.

I'm not sure this is a good idea. run_command is used in ~70 places in
git, and I'm sure at least one of them is going to be unhappy (I see you
found one in credential-cache, but how many others are there). I'd
rather be conservative and leave the default the same, and then switch
over callsites that make sense.

-Peff

PS I thought this would certainly break the pager, since it should
   outlast us after we finish producing output. But I think at one point
   I switched the pager invocation so that the git wrapper lives and
   waits until the pager dies.
