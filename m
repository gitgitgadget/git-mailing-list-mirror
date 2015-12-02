From: Jeff King <peff@peff.net>
Subject: Re: arbitrary memory allocation
Date: Wed, 2 Dec 2015 01:09:42 -0500
Message-ID: <20151202060942.GA8212@sigill.intra.peff.net>
References: <1a012fc79a55cae8b948b28d1259be0c.squirrel@sdfeu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ytrezq@sdf-eu.org
X-From: git-owner@vger.kernel.org Wed Dec 02 07:09:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a40bu-0001aR-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 07:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbbLBGJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 01:09:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:36151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751580AbbLBGJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 01:09:45 -0500
Received: (qmail 12505 invoked by uid 102); 2 Dec 2015 06:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 00:09:45 -0600
Received: (qmail 27217 invoked by uid 107); 2 Dec 2015 06:09:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 01:09:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2015 01:09:42 -0500
Content-Disposition: inline
In-Reply-To: <1a012fc79a55cae8b948b28d1259be0c.squirrel@sdfeu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281880>

On Thu, Nov 26, 2015 at 05:06:35AM +0100, ytrezq@sdf-eu.org wrote:

> First, something I still don t understand, should I always ulimit ram
> usage for security purposes when I m manage a public server?

You didn't define "public" here. For serving fetches, the memory tends
to be fairly bounded and dependent on the repo you're serving. For
accepting pushes, it's trivial to convince the server to allocate a lot
of memory (you can send an unbounded set of ref updates, or you can
simply send a 50GB object that compresses down to a tiny size).

Git does not have any internal memory controls, and will generally rely
on malloc() to tell it when it is not being reasonable. I'd suggest
using OS-level memory controls like cgroups if you're hosting something
public.

-Peff
