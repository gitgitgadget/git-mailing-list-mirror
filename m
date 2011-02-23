From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Wed, 23 Feb 2011 04:48:45 -0500
Message-ID: <20110223094844.GA9205@sigill.intra.peff.net>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
 <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
 <20110223080854.GB2724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 10:48:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsBL3-0005Bz-Ko
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 10:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1BWJss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 04:48:48 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab1BWJsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 04:48:47 -0500
Received: (qmail 10657 invoked by uid 111); 23 Feb 2011 09:48:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 09:48:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 04:48:45 -0500
Content-Disposition: inline
In-Reply-To: <20110223080854.GB2724@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167680>

On Wed, Feb 23, 2011 at 03:08:54AM -0500, Jeff King wrote:

> Yeah, I think the best path forward is:
> 
>   1. Stop feeding "pre-folded" subject lines to the email formatter.
>      Give it the regular subject line with no newlines.
> 
>   2. rfc2047 encoding should encode a literal newline. Which should
>      generally never happen, but is probably the most sane thing to do
>      if it does.
> 
>   3. rfc2047 should fold all lines at some sane length. As it is now, we
>      may sometimes generate long lines in headers (though in practice, I
>      doubt this is much of a problem).

So here is a series that does this. It still doesn't preserve subject
newlines in "format-patch | am", but I don't think that was ever a goal
of the code. If we want to add it as an optional feature on top (maybe
as part of "-k"?), it should be easy to do (since the rfc2047 encoding
will now preserve embedded newlines).

  [1/3]: strbuf: add fixed-length version of add_wrapped_text
  [2/3]: format-patch: wrap long header lines
  [3/3]: format-patch: rfc2047-encode newlines in headers

-Peff
