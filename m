From: Jeff King <peff@peff.net>
Subject: Re: move detection doesnt take filename into account
Date: Wed, 9 Jul 2014 02:45:21 -0400
Message-ID: <20140709064521.GA14682@sigill.intra.peff.net>
References: <53B105DA.30004@gmail.com>
 <287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
 <xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
 <53B2CE4A.9060509@gmail.com>
 <xmqq61jhxb0g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elliot Wolk <elliot.wolk@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4ld9-0005hG-BA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 08:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaGIGpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 02:45:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:58530 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751114AbaGIGpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 02:45:23 -0400
Received: (qmail 28171 invoked by uid 102); 9 Jul 2014 06:45:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 01:45:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 02:45:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61jhxb0g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253071>

On Tue, Jul 01, 2014 at 10:08:15AM -0700, Junio C Hamano wrote:

> I didn't think it through but my gut feeling is that we could change
> the name similarity score to be the length of the tail part that
> matches (e.g. 1.a to a/2.a that has the same two bytes at the tail
> is a better match than to a/2.b that does not share any tail, and to
> a/1.a that shares the three bytes at the tail is an even better
> match).

The delta heuristics in pack-objects use pack_name_hash, which claims:

        /*
         * This effectively just creates a sortable number from the
         * last sixteen non-whitespace characters. Last characters
         * count "most", so things that end in ".c" sort together.
         */

which might be another option (and seems like a superset of the basename
check, short of basenames that are longer than 16 characters).

-Peff
