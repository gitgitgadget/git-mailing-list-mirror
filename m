From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] revert: plug memory leak in "cherry-pick root commit"
 codepath
Date: Tue, 16 Aug 2011 11:31:48 -0700
Message-ID: <20110816183147.GA10117@sigill.intra.peff.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
 <20110814131303.GF18466@elie.gateway.2wire.net>
 <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
 <20110814152204.GJ18466@elie.gateway.2wire.net>
 <7v39h1i6rr.fsf@alter.siamese.dyndns.org>
 <20110816181633.GB10336@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 20:32:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtOQh-0006Y1-Ua
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab1HPSbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 14:31:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59210
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367Ab1HPSbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 14:31:55 -0400
Received: (qmail 5175 invoked by uid 107); 16 Aug 2011 18:32:34 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 14:32:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 11:31:48 -0700
Content-Disposition: inline
In-Reply-To: <20110816181633.GB10336@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179467>

On Tue, Aug 16, 2011 at 01:16:33PM -0500, Jonathan Nieder wrote:

>  static struct tree *empty_tree(void)
>  {
> -	struct tree *tree = xcalloc(1, sizeof(struct tree));
> -
> -	tree->object.parsed = 1;
> -	tree->object.type = OBJ_TREE;
> -	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
> -	return tree;
> +	return lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
>  }

Much nicer. But doesn't your dab0d41 (correct type of
EMPTY_TREE_SHA1_BIN, 2011-02-07) make the cast unnecessary?

-Peff
