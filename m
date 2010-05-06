From: Jeff King <peff@peff.net>
Subject: Re: Feature request: relative paths
Date: Thu, 6 May 2010 05:04:19 -0400
Message-ID: <20100506090419.GB31873@coredump.intra.peff.net>
References: <19426.23330.525936.981066@winooski.ccs.neu.edu>
 <20100506083113.GA25993@progeny.tock>
 <20100506084607.GA9921@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 06 11:04:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9x0O-00027S-NG
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab0EFJEX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 05:04:23 -0400
Received: from peff.net ([208.65.91.99]:57666 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab0EFJEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:04:22 -0400
Received: (qmail 5124 invoked by uid 107); 6 May 2010 09:04:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 05:04:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 05:04:19 -0400
Content-Disposition: inline
In-Reply-To: <20100506084607.GA9921@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146464>

On Thu, May 06, 2010 at 10:46:07AM +0200, Bj=C3=B6rn Steinbrink wrote:

> > git show -- some-file
>=20
> That's the same as "git show HEAD -- some-file" though, which shows a
> commit with path-limited diff output. While ":some-file" (most likely=
)
> identifies a blob, so "git show :some-file" shows the contents stored=
 in
> that blob.

Yep. What Eli actually wants is to allow relative path specifiers in
tree-selectors. So you could do:

  git show :./some-file

or even

  git show HEAD~20:./some-file

and the "./" bit would magically expand into the current prefix within
the working tree.

This has come up several times on the list. It is a little bit of a
layering violation, because "treeish:path" may or may not bear any
resemblence to your current working tree. And the parsing of that synta=
x
happens in a fairly deep, library-ish place which doesn't know anything
about the working tree. However, in practice, I think it would be
extremely useful (because your working tree _does_ tend to be related t=
o
the tree-ishs that you look at, especially if that tree-ish is HEAD).

I think in the past there was some vague negative sentiment around the
issues I described above. I don't think an actual patch was ever
produced, but I might be wrong. I suspect the only way to move the
discussion forward would be to actually show a patch.

-Peff
