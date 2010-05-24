From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Mon, 24 May 2010 01:39:55 -0400
Message-ID: <20100524053955.GA4528@coredump.intra.peff.net>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
 <20100518194105.GA4723@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
 <4BF9C678.6010108@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Mon May 24 07:40:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGQOe-0007vM-Le
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 07:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab0EXFkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 01:40:00 -0400
Received: from peff.net ([208.65.91.99]:34604 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab0EXFkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 01:40:00 -0400
Received: (qmail 492 invoked by uid 107); 24 May 2010 05:40:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 May 2010 01:40:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 May 2010 01:39:55 -0400
Content-Disposition: inline
In-Reply-To: <4BF9C678.6010108@puckerupgames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147600>

On Sun, May 23, 2010 at 08:21:12PM -0400, John wrote:

> *.jpg  binary -delta
> *.png  binary -delta
> *.psd  binary -delta
> *.gz  binary -delta
> *.bz2  binary -delta
> .. and so on.
>
> [...]
>
> Is there any reason why someone would NOT want the above
> ".gitattributes" defined by default?

I delta jpgs in one of my repositories. It is useful if the exif
metadata changes but the image data does not. I assume you could do the
same with other formats which have compressed and uncompressed portions
(I also do it with video containers).  I don't think it would ever make
sense to try to delta gzip'd or bzip'd contents.

I also don't use "binary", as I use a custom diff driver instead (binary
implies "-diff").

As for what should be the default, until now the default has always
been that no gitattributes are defined by default. This is nice because
it's simple to understand; git doesn't care about filenames unless you
tell it to. The downside obviously is that it may not perform optimally
for some unusual workloads without extra configuration.

We could probably do defaults for some common extensions, but I'm not
really sure where such a thing should end up. For example, I consider
*.psd a uselessly obscure extension, as Adobe doesn't write software for
my platform of choice. Not that I mind having it in git, but rather that
we are inevitably going to miss somebody's pet extension, and then we
are right back where we started with them needing to configure, except
now they also have to figure out which extensions have default
attributes.

-Peff
