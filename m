From: Jeff King <peff@peff.net>
Subject: Re: After stash pop, refs/stash become 40 zeroes
Date: Wed, 15 Jan 2014 03:51:39 -0500
Message-ID: <20140115085139.GA14335@sigill.intra.peff.net>
References: <CAHtLG6TmkYdGRF3H-6CoVvnxZqZBBk3ZUR-ohTVvgeAe9tTuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3MCP-0003F9-Kw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbaAOIvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 03:51:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:60933 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751010AbaAOIvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:51:40 -0500
Received: (qmail 10246 invoked by uid 102); 15 Jan 2014 08:51:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:51:41 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:51:39 -0500
Content-Disposition: inline
In-Reply-To: <CAHtLG6TmkYdGRF3H-6CoVvnxZqZBBk3ZUR-ohTVvgeAe9tTuOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240443>

On Wed, Jan 15, 2014 at 01:56:52PM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 w=
rote:

> what are the possible causes of this?
> After stash pop, refs/stash becomes 40 zeroes.
> This is the only stash, so refs/stash should be deleted after pop.
> However, it becomes 40 zeroes.
>=20
> git 1.8.x

I can't reproduce the problem here. Running this:

  git init -q repo && cd repo
  echo content >file && git add file && git commit -qm file
  echo more >>file

  echo "=3D=3D> stashed"
  git stash -q
  ls -l .git/refs/stash .git/logs/refs/stash
  git rev-parse --verify refs/stash

  echo "=3D=3D> popped"
  git stash pop -q
  ls -l .git/refs/stash .git/logs/refs/stash
  git rev-parse --verify refs/stash

yields:

  =3D=3D> stashed
  -rw-r--r-- 1 peff peff 153 Jan 15 03:49 .git/logs/refs/stash
  -rw-r--r-- 1 peff peff  41 Jan 15 03:49 .git/refs/stash
  7fb40812ac4aaf7fa31e584863fc52c4b4a67aa0
  =3D=3D> popped
  ls: cannot access .git/refs/stash: No such file or directory
  ls: cannot access .git/logs/refs/stash: No such file or directory
  fatal: Needed a single revision

Does running it reproduce the problem for you? If it does, can you be
more specific about your git version?  If it does not, can you show wha=
t
you are doing differently to reproduce?

-Peff
