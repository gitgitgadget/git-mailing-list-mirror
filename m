From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Sun, 12 Jul 2015 23:52:24 -0400
Message-ID: <20150713035224.GA3315@peff.net>
References: <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net>
 <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net>
 <20150708183331.GA16138@peff.net>
 <559D9006.20102@kdbg.org>
 <559EDEE6.1040807@kdbg.org>
 <20150709224830.GA24998@peff.net>
 <BLU437-SMTP311678316C434857657D6BF69E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: X H <music_is_live_lg@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 05:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEUnB-0001m3-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 05:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbbGMDw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 23:52:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:59196 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbbGMDw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 23:52:26 -0400
Received: (qmail 10462 invoked by uid 102); 13 Jul 2015 03:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jul 2015 22:52:26 -0500
Received: (qmail 25294 invoked by uid 107); 13 Jul 2015 03:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jul 2015 23:52:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jul 2015 23:52:24 -0400
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP311678316C434857657D6BF69E0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273905>

On Sun, Jul 12, 2015 at 12:21:33AM +0200, X H wrote:

> How are the permission handled, is it git that is asking to create a file
> read only or rw on the remote or is it the environment with umask ans so on
> that decides it, or Windows when the drive is mounted with noacl?

Generally, git follows the umask when creating most files. However, for
the object files in the object database, it does drop the "w" bit, as
once written, they should never be changed (after all, the filename is a
hash of the contents). We don't ever open those files for writing, but
we may try to rename another file over them; that might behave
differently on Unix versus Windows (or even differently on Windows
between local and remote-mounted filesystems).

-Peff
