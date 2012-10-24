From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] pretty: support padding placeholders, %< %> and %><
Date: Wed, 24 Oct 2012 04:25:12 -0400
Message-ID: <20121024082512.GA22127@sigill.intra.peff.net>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-1-git-send-email-pclouds@gmail.com>
 <1348391433-11300-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 10:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQwHO-0002Si-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 10:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933575Ab2JXIZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 04:25:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53795 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933565Ab2JXIZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 04:25:16 -0400
Received: (qmail 27774 invoked by uid 107); 24 Oct 2012 08:25:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 04:25:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 04:25:12 -0400
Content-Disposition: inline
In-Reply-To: <1348391433-11300-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208299>

On Sun, Sep 23, 2012 at 04:10:31PM +0700, Nguyen Thai Ngoc Duy wrote:

> +	else {
> +		int sb_len = sb->len, offset;
> +		switch (c->flush_type) {
> +		case flush_left:
> +			offset = padding - len;
> +			break;
> +		case flush_right:
> +			offset = 0;
> +			break;
> +		case flush_both:
> +			offset = (padding - len) / 2;
> +			break;
> +		case no_flush: /* to make gcc happy */
> +			break;
> +		}
> +		/*
> +		 * we calculate padding in columns, now
> +		 * convert it back to chars
> +		 */
> +		padding = padding - len + local_sb.len;
> +		strbuf_grow(sb, padding);
> +		strbuf_setlen(sb, sb_len + padding);
> +		memset(sb->buf + sb_len, ' ', sb->len - sb_len);
> +		memcpy(sb->buf + sb_len + offset, local_sb.buf,
> +		       local_sb.len);
> +	}

gcc complains (rightly, I think) that offset can be used uninitialized
in the final line (looks like it is from the no_flush case). If it is a
"can never happen" case that is there to appease gcc in the switch
statement, should we drop a die("BUG: XXX") there? If so, what would the
XXX be?

-Peff
