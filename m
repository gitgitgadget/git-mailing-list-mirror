From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/9] handle alternate charsets for remote http errors
Date: Thu, 22 May 2014 05:28:25 -0400
Message-ID: <20140522092824.GA14530@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:28:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPIe-0001YS-2u
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbaEVJ21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:28:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:57227 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751322AbaEVJ20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:28:26 -0400
Received: (qmail 11423 invoked by uid 102); 22 May 2014 09:28:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:28:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:28:25 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249885>

On Wed, May 21, 2014 at 06:25:24AM -0400, Jeff King wrote:

> As of commit 426e70d (remote-curl: show server content on http errors,
> 2013-04-05), we relay any text/plain errors shown by the remote http
> server to the user. However, we were lazy back then and left this TODO
> in place:
> 
>        /*
>         * We only show text/plain parts, as other types are likely
>         * to be ugly to look at on the user's terminal.
>         *
>         * TODO should handle "; charset=XXX", and re-encode into
>         * logoutputencoding
>         */
> 
> This series actually implements that, along with a few other cleanups.

Here's a second version based on feedback from Kyle and Peter. Thanks
both for your comments.

It drops the "tolower" patches, which are not used anymore, and makes
the parsing of content-types and their parameters a bit more robust.

  [1/8]: test-lib: preserve GIT_CURL_VERBOSE from the environment
  [2/8]: t/lib-httpd: use write_script to copy CGI scripts
  [3/8]: t5550: test display of remote http error messages

    These three are the same as before.

  [4/8]: http: extract type/subtype portion of content-type

    Make our content-type matching more robust, both for the errors and
    for matching smart-http types.

  [5/8]: http: optionally extract charset parameter from content-type

    Feature work to support 7/8.

  [6/8]: strbuf: add strbuf_reencode helper

    Same as before (feature work to support 7/8).

  [7/8]: remote-curl: reencode http error messages

    The actual fix.

  [8/8]: http: default text charset to iso-8859-1

    This could be part of 5/8, but I floated it to the top of the heap
    to make it easier to discuss/adjust it.

-Peff
