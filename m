From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] Speed up is_git_command() by checking early for
 internal commands
Date: Fri, 3 Jan 2014 10:44:26 -0500
Message-ID: <20140103154426.GA23534@sigill.intra.peff.net>
References: <52C58FD7.6010608@gmail.com>
 <52C59107.6080005@gmail.com>
 <xmqq38l6qii6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 16:44:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz6vK-0008Jj-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 16:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbaACPo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 10:44:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:54482 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752640AbaACPo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 10:44:28 -0500
Received: (qmail 30195 invoked by uid 102); 3 Jan 2014 15:44:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jan 2014 09:44:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jan 2014 10:44:26 -0500
Content-Disposition: inline
In-Reply-To: <xmqq38l6qii6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239914>

On Thu, Jan 02, 2014 at 11:41:05AM -0800, Junio C Hamano wrote:

>  - builtin/merge.c is the same, but it is conceptually even worse.
>    It has the end-user supplied string and wants to see if it is a
>    valid strategy.  If the user wants to use a custom strategy, a
>    single stat() to make sure if it exists should suffice, and the
>    error codepath should load the command list to present the names
>    of available ones in the error message.

Is it a single stat()? I think we would need to check each element of
$PATH. Though in practice, the exec-dir would be the first thing we
check, and where we would find the majority of hits. So it would still
be a win, as we would avoid touching anything but the exec-dir in the
common case.

-Peff
