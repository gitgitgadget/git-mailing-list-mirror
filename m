From: Mike Hommey <mh@glandium.org>
Subject: Re: Significant performance waste in git-svn and friends
Date: Thu, 6 Sep 2007 07:52:11 +0200
Organization: glandium.org
Message-ID: <20070906055211.GC5741@glandium.org>
References: <20070905184710.GA3632@glandium.org> <7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAIn-0006te-VR
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbXIFFxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbXIFFxN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:53:13 -0400
Received: from vawad.err.no ([85.19.200.177]:42703 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbXIFFxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 01:53:13 -0400
Received: from aputeaux-153-1-83-91.w86-205.abo.wanadoo.fr ([86.205.41.91] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ITAIZ-0002d7-Oa; Thu, 06 Sep 2007 07:53:05 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1ITAHj-0001bD-Jw; Thu, 06 Sep 2007 07:52:11 +0200
Content-Disposition: inline
In-Reply-To: <7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57822>

On Wed, Sep 05, 2007 at 01:40:42PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > The same things obviously apply to git-cvsimport and other scripts
> > calling git-hash-object a lot.
> 
> I *obviously* hate this patch, as it makes this Porcelain
> command to be aware of the internal representation too much.

The patch was not supposed to be applied. I said it was lame ;)
It was more of a proof of concept.

Anyways, thinking a bit more about it, I was wondering if it wouldn't be
a good idea to have Git.pm have a "native" implementation (by native I
mean a .so module) for low-level plumbing tools such as hash-object,
cat-file and such.

Obviously, reinventing the wheel is not good, so this native
implementation would be using a "git library" API, such as what has
been done under SoC (though I don't know if this API exposes low-level
plumbing functions)

> I wonder if letting fast-import handle the object creation is an
> option, though.

It could, probably. The reason I didn't use it is that it was way
quicker to hack a 10 lines patch to create the blobs by hand than it
would have been to fork a fast-import object at the correct place during
git-svn initialization and piping to it at the appropriate times.

My goal was only to check how faster this would make it not to fork a
git-hash-object per blob.

Mike
