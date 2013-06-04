From: Andreas Krey <a.krey@gmx.de>
Subject: fetch delta resolution vs. checkout (was: java zlib woes)
Date: Tue, 4 Jun 2013 12:18:36 +0200
Message-ID: <20130604101836.GH22784@inner.h.apk.li>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com> <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com> <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com> <20130522045131.GA6257@inner.h.apk.li> <CAJo=hJtkbCeJA4ao2CkPODrNX_QaKDo4uBS4qvBVTRQ=x-Os3A@mail.gmail.com> <20130527041146.GJ9448@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chico Sokol <chico.sokol@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 12:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjoKV-0005dX-Kd
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 12:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab3FDKS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 06:18:59 -0400
Received: from continuum.iocl.org ([217.140.74.2]:50903 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3FDKS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 06:18:57 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r54AIa318060;
	Tue, 4 Jun 2013 12:18:36 +0200
Content-Disposition: inline
In-Reply-To: <20130527041146.GJ9448@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226338>

On Mon, 27 May 2013 06:11:46 +0000, Andreas Krey wrote:
...
> 
> I now have a full test case (involving a generated repo just shy of 1GB)
> that will reproduce that hang. Will look up the existing jgit bug to
> report there.

On https://bugs.eclipse.org/bugs/show_bug.cgi?id=394078

A question: The delta decoding. If I understand correctly,
git and jgit do verify the packfile content after fetching/cloning,
and need to resolve any deltified files in the pack.

And when checking out a commit it needs this to again for the
files that are being checked out?

Because we now have the phenomenon that the packfile is fetched
ok, but a checkout then hangs (100%) CPU on one of the large files,
and on one that should, according to core.bigfilethreshold, not
even be deltified.

(Setting core.bigfilethreshold to 20m in the source repo (C git)
gets jgit to no longer hang in the fetch/delta resolution phase.
And it doesn't look like jgit would repack the pack file, and
uses it as it was received plus 20 bytes at the end.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
