From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: support sorting branches by mtime
Date: Thu, 18 Nov 2010 11:13:51 -0500
Message-ID: <20101118161351.GA19011@sigill.intra.peff.net>
References: <1290090126-14471-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 17:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ77c-0000N4-An
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200Ab0KRQN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 11:13:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185Ab0KRQN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:13:56 -0500
Received: (qmail 16308 invoked by uid 111); 18 Nov 2010 16:13:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 16:13:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 11:13:51 -0500
Content-Disposition: inline
In-Reply-To: <1290090126-14471-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161680>

On Thu, Nov 18, 2010 at 09:22:06PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> I lost in my branches again while looking for a topic that I feel lik=
e
> working on tonight. Too old branches are out of question.
>=20
> This throwaway patch demonstrates the idea. I should have looked into
> reflog for this kind of information, but my laziness won over me.

I do something similar, but rather than using mtime, I sort by
authordate, which for-each-ref supports already. In fact, the script I
use is:

-- >8 --
#!/bin/sh

format=3D'%(refname:short)'
sortby=3Drefname
set -- $(getopt vt "$@")
while test $# -gt 0; do
	case "$1" in
	-v) format=3D'%(refname:short) %(subject)' ;;
	-t) sortby=3D-authordate ;;
	--) break ;;
	 *) echo >&2 "unknown option: $1"; exit 100 ;;
	esac
	shift
done

git for-each-ref --sort=3D$sortby --format=3D"$format" refs/heads |
egrep '^[a-z]{2,3}/' |
perl -pe '
  s/(\S+) /$1 . " " x (22 - length($1))/e; # line up subjects
  s/^(.{79}).*/$1/; # truncate long lines
'
-- 8< --

It might be nice if git-branch supported the same sortby that
for-each-ref does.

-Peff
