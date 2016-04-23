From: Jeff King <peff@peff.net>
Subject: Re: issue upgrading git from 1.8.2.1 to 2.8.0
Date: Sat, 23 Apr 2016 01:22:08 -0400
Message-ID: <20160423052208.GA25325@sigill.intra.peff.net>
References: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
 <20160422231452.GA10905@sigill.intra.peff.net>
 <CA+UAp06YMrVY8rK3jzWtLB=Zo8F=GTLQByYD-xR8+Lj=3=_hqg@mail.gmail.com>
 <20160423051116.GA21390@sigill.intra.peff.net>
 <CA+UAp04M+jxS1JBPuz78GovopKSjvgkEdOj2DYG6wF7inasvWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gennaro Torre <gtorre@tumblr.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 07:27:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atq6M-0003FW-79
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 07:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcDWFWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 01:22:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:54732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750757AbcDWFWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 01:22:11 -0400
Received: (qmail 21343 invoked by uid 102); 23 Apr 2016 05:22:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 23 Apr 2016 01:22:11 -0400
Received: (qmail 15289 invoked by uid 107); 23 Apr 2016 05:22:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 23 Apr 2016 01:22:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Apr 2016 01:22:08 -0400
Content-Disposition: inline
In-Reply-To: <CA+UAp04M+jxS1JBPuz78GovopKSjvgkEdOj2DYG6wF7inasvWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292300>

On Sat, Apr 23, 2016 at 01:18:50AM -0400, Gennaro Torre wrote:

> This is what I see:
> 
> 01:16:15.789969 pkt-line.c:80           packet:        fetch>
> git-upload-pack /tumblr.git\0host=<cache>\0
> 01:16:15.851231 pkt-line.c:80           packet:        fetch<
> a210029455476c3ae0d34748aeaeccf71864fd81 HEAD\0multi_ack thin-pack
> side-band side-band-64k ofs-delta shallow no-progress include-tag
> multi_ack_detailed symref=HEAD:refs/heads/master agent=git/2.8.0
> 01:16:15.851433 pkt-line.c:80           packet:        fetch<
> 511b1feab8d10b81777a75c02dabc94c7da9e0d4 refs/heads/263-fix
> .....
> 01:17:59.497259 pkt-line.c:80           packet:        fetch<
> cd63ca15d47b469e692faea2e04f32a241a6637a refs/tags/hotposts_v0.1
> 01:17:59.497265 pkt-line.c:80           packet:        fetch<
> 4749ee8a11ca093928c8a43fb0147d22177f1d71 refs/tags/hotposts_v0.1^{}
> 01:17:59.497282 pkt-line.c:80           packet:        fetch< 0000
> Server supports multi_ack_detailed
> Server supports side-band-64k
> Server supports ofs-delta
> Server version is git/2.8.0

So that's weird. The client gets the initial ref advertisement and
then...does nothing? It should drop into find_common() and start sending
want/have lines to the server (or decide it doesn't need any objects and
immediately send a flush packet).

Is the client chewing any CPU, or otherwise doing anything according to
"strace"? Is it possible to connect to it with gdb and get a backtrace?

-Peff
