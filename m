From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] repack: accept larger window-memory and
 max-pack-size
Date: Wed, 22 Jan 2014 20:26:56 -0500
Message-ID: <20140123012656.GC17254@sigill.intra.peff.net>
References: <1390420685-18449-1-git-send-email-gitster@pobox.com>
 <1390420685-18449-3-git-send-email-gitster@pobox.com>
 <20140123010642.GB17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 02:27:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W694h-0006xv-OQ
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 02:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbaAWB07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 20:26:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:37228 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751276AbaAWB06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 20:26:58 -0500
Received: (qmail 5573 invoked by uid 102); 23 Jan 2014 01:26:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 19:26:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 20:26:56 -0500
Content-Disposition: inline
In-Reply-To: <20140123010642.GB17254@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240888>

On Wed, Jan 22, 2014 at 08:06:42PM -0500, Jeff King wrote:

> But I think there is a subtle problem. Here (and elsewhere) we use the
> parsed value of "0" as a sentinel. I think that is OK for
> --max-pack-size, where "0" is not a reasonable value. But git-repack(1)
> says:
> 
>   --window-memory=0 makes memory usage unlimited, which is the default.
> 
> What does:
> 
>   git config pack.windowMemory 256m
>   git repack --window-memory=0
> 
> do? It should override the config, but I think it does not with your
> patch (nor with the current code). Using a string would fix that (though
> you could also fix it by using a different sentinel, like ULONG_MAX).

Here is a series that does that (and fixes the other issue I found). It
would probably be nice to test these things, but checking that they
actually had an impact is tricky (how do you know that --window-memory
did the right thing?).

  [1/3]: repack: fix typo in max-pack-size option
  [2/3]: repack: make parsed string options const-correct
  [3/3]: repack: propagate pack-objects options as strings

-Peff
