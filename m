From: Jeff King <peff@peff.net>
Subject: Re: Deadlock during remote update
Date: Fri, 27 Feb 2015 08:21:13 -0500
Message-ID: <20150227132113.GB13005@peff.net>
References: <311995D1237EC0498D6D8FAFA73D6F458F1B67@G9W0762.americas.hpqcorp.net>
 <CACsJy8AG9ZdhZj_pAb3sZPntBt+GPLj06dXDAV=w+5HyL6D+0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Heald, Mike" <mike.heald@hp.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 14:21:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRKr2-0002JE-9P
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 14:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbB0NVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 08:21:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:54119 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752152AbbB0NVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 08:21:15 -0500
Received: (qmail 25762 invoked by uid 102); 27 Feb 2015 13:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Feb 2015 07:21:15 -0600
Received: (qmail 986 invoked by uid 107); 27 Feb 2015 13:21:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Feb 2015 08:21:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Feb 2015 08:21:13 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AG9ZdhZj_pAb3sZPntBt+GPLj06dXDAV=w+5HyL6D+0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264496>

On Fri, Feb 27, 2015 at 06:27:28PM +0700, Duy Nguyen wrote:

> > 31638 git-remote-https upstream https://git.openstack.org/openstack/nova
> >     has pipe:[170381707] (fd 1), waiting for read from pipe:[170384472]
> > 31642 git fetch-pack --stateless-rpc --lock-pack --include-tag --thin --no-progress https://git.openstack.org/openstack/nova/  efs/heads/master
> >     has pipe:[170384472] (fd 1), waiting for read from pipe:[170384471] (fd 0) which fd 7 on 31638
> >
> > 31638 and 31642 are both waiting to read from a pipe that the other has, and isn't writing to.
> >
> > This is git version 1.7.9.5, OS is ubuntu precise.
> 
> There's this commit 2a45520 (remote-curl: always parse incoming refs -
> 2013-02-20) that fixes a deadlock between remote-http(s) and
> fetch-pack. I'm not sure if it's the same problem. Jeff  knows more
> about this. The fix is available since v1.8.3

You are more optimistic about my memory than I am. :)

Given the symptoms of the deadlock above, I agree it is a likely
culprit. There was a spree of deadlock fixes around the same time, but I
think that is the only one that was found on the client side of a fetch.

-Peff
