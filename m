From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 21:09:13 -0500
Message-ID: <20140123020913.GF17254@sigill.intra.peff.net>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
 <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
 <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
 <52DFE882.2040605@atlas-elektronik.com>
 <xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
 <CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
 <xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
 <20140122203030.GB14211@milliways>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Ken Moffat <zarniwhoop@ntlworld.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 03:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W69jL-0006yO-Kc
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 03:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbaAWCJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 21:09:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:37271 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752201AbaAWCJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 21:09:15 -0500
Received: (qmail 7994 invoked by uid 102); 23 Jan 2014 02:09:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 20:09:15 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 21:09:13 -0500
Content-Disposition: inline
In-Reply-To: <20140122203030.GB14211@milliways>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240895>

On Wed, Jan 22, 2014 at 08:30:30PM +0000, Ken Moffat wrote:

>  Two questions: Does regenerating (e.g. if the tarball has dropped
> out of the cache) change its sums (md5sum or similar) ?  In (beyond)
> linuxfromscratch we use md5sums to verify that a tarball has not
> changed.

The tarballs we auto-generate from tags are cached, but they can
change if the cached version expires _and_ the archive-generation code
changes.

We use "git archive" to generate the tarballs themselves, and then gzip
the with "gzip -n". So it should be consistent from run to run. However,
very occasionally there are bugfixes in "git archive" which can affect
the output. E.g., commit 22f0dcd (archive-tar: split long paths more
carefully, 2013-01-05) changes the representation of certain long paths,
and generating a tarball with and without it will result in different
checksums (for some repos).

So if you are planning on baking md5sums into a package-build system, it
is much better to point at "official" releases which are rolled once by
the project maintainer, rather than the automatic tag page.

Junio, since you prepare such tarballs[1] anyway for kernel.org, it
might be worth uploading them to the "Releases" page of git/git.  I
imagine there is a programmatic way to do so via GitHub's API, but I
don't know offhand. I can look into it if you are interested.

-Peff
