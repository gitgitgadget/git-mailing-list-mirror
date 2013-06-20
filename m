From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty
 tree
Date: Thu, 20 Jun 2013 09:15:47 -0400
Message-ID: <20130620131547.GA11073@sigill.intra.peff.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
 <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpeiQ-0000Ek-P3
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab3FTNPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:15:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:56691 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273Ab3FTNPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:15:50 -0400
Received: (qmail 18365 invoked by uid 102); 20 Jun 2013 13:16:49 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 08:16:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 09:15:47 -0400
Content-Disposition: inline
In-Reply-To: <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228496>

On Thu, Jun 20, 2013 at 03:06:01PM +0200, Thomas Rast wrote:

> +test_expect_success 'pulling into void does not overwrite staged files' '
> +	git init cloned-staged-colliding &&
> +	(
> +		cd cloned-staged-colliding &&
> +		echo "alternate content" >file &&
> +		git add file &&
> +		test_must_fail git pull .. master &&
> +		echo "alternate content" >expect &&
> +		test_cmp expect file &&
> +		git cat-file blob :file >file.index &&
> +		test_cmp expect file.index
> +	)
> +'

I naively would have expected this to leave us in a conflicted state
over "file".  But I guess read-tree just rejects it, because we are not
doing a real three-way merge.  I'm not sure it is that big a deal; this
is more about safety than about creating a conflicted/resolvable state.

-Peff
