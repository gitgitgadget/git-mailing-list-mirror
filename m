From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Tue, 11 Mar 2014 14:00:20 -0400
Message-ID: <20140311180020.GA28154@sigill.intra.peff.net>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
 <1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
 <20140310200756.GC24568@sigill.intra.peff.net>
 <CA+SSzV04KCGyTkFTtSx_9sYAZyh=UzHOPV6tf9JT82w_DsSLHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jun Hao <jhao12@bloomberg.net>, git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 19:00:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNQyc-0000ke-OI
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 19:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbaCKSAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 14:00:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:37499 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753621AbaCKSAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 14:00:22 -0400
Received: (qmail 19276 invoked by uid 102); 11 Mar 2014 18:00:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Mar 2014 13:00:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2014 14:00:20 -0400
Content-Disposition: inline
In-Reply-To: <CA+SSzV04KCGyTkFTtSx_9sYAZyh=UzHOPV6tf9JT82w_DsSLHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243874>

On Tue, Mar 11, 2014 at 06:56:02PM +0100, Benoit Pierre wrote:

> According to the original commit, the change to GIT_EDITOR is only
> here for hooks:
> 
> commit 406400ce4f69e79b544dd3539a71b85d99331820
> Author: Paolo Bonzini <bonzini@gnu.org>
> Date:   Tue Feb 5 11:01:45 2008 +0100
> 
>     git-commit: set GIT_EDITOR=: if editor will not be launched
> 
>     This is a preparatory patch that provides a simple way for the future
>     prepare-commit-msg hook to discover if the editor will be launched.
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> So there is really no reason to set it earlier, and not just in the
> hook subprocess environment.

Ah, you're right. I was thinking that our invocation of launch_editor
also respected it. It does, but we never get there at all because
use_editor is set to 0. So yeah, it really is just needed for the hook.

Your patch, even though it is a bigger change, keeps the setting to the
minimal area, which is cleaner and more maintainable in the long run.

-Peff
