From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/8] test_terminal: give priority to
 test-terminal.perl usage
Date: Fri, 22 Oct 2010 15:42:52 -0400
Message-ID: <20101022194252.GC13059@sigill.intra.peff.net>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
 <1287254223-4496-6-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:42:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9NVJ-0005YW-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab0JVTmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 15:42:12 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54298 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777Ab0JVTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:42:10 -0400
Received: (qmail 22618 invoked by uid 111); 22 Oct 2010 19:42:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 19:42:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 15:42:52 -0400
Content-Disposition: inline
In-Reply-To: <1287254223-4496-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159740>

On Sun, Oct 17, 2010 at 02:37:00AM +0800, Tay Ray Chuan wrote:

> The outcome depends on whether stdout was already a terminal (in which
> case test_terminal is a noop) or not (in which case test_terminal
> introduces a pseudo-tty in the middle of the pipeline).
> 
> 	$ test_terminal.perl sh -c 'test -t 1 && echo >&2 YES' >out
> 	YES
> 	$ sh -c 'test -t 1 && echo >&2 YES' >out
> 	$
> 
> How about this?
> 
>  - use the test_terminal script even when running with "-v"
>    if IO::Pty is available, to allow commands like
> 
> 	test_terminal foo >out 2>err
> 
>  - add a separate TTYREDIR prerequisite which is only set
>    when the test_terminal script is usable

Is it even worth keeping the direct-to-tty code at all? Yes, it means
that people without IO::Pty can use _some_ terminal tests with "-v". But
it creates a headache for test writers in understanding the subtle
difference between TTY and TTYREDIR.

-Peff
