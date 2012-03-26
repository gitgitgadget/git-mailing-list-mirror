From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7a 6/9] diff --stat: use a maximum of 5/8 for the
 filename part
Date: Mon, 26 Mar 2012 19:45:49 -0400
Message-ID: <20120326234549.GA10172@sigill.intra.peff.net>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
 <1330604806-30288-6-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJbr-0007Fv-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab2CZXpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 19:45:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60268
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab2CZXpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:45:54 -0400
Received: (qmail 19866 invoked by uid 107); 26 Mar 2012 23:46:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 19:46:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 19:45:49 -0400
Content-Disposition: inline
In-Reply-To: <1330604806-30288-6-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193987>

On Thu, Mar 01, 2012 at 01:26:43PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> ---
>  Documentation/diff-options.txt |   14 ++++---
>  diff.c                         |   90 ++++++++++++++++++++++++++----=
----------
>  t/t4052-stat-output.sh         |   16 +++----
>  3 files changed, 76 insertions(+), 44 deletions(-)

I am seeing test failures from t4052 in 'master'. Bisecting points to
1b058bc (diff --stat: use a maximum of 5/8 for the filename part,
2012-03-01). The output from the test script looks like this:

--- expect      2012-03-26 23:41:29.688039554 +0000
+++ actual      2012-03-26 23:41:29.696039549 +0000
@@ -1 +1 @@
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
 |    1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaa |    1 +
not ok - 8 diff: small change with long name gives more space to the na=
me
#      =20
#                       git $cmd $args >output &&
#                       grep " | " output >actual &&
#                       test_cmp expect actual
#              =20

There are a few other failures, but they all have the same mismatched
length (the output is slightly longer than expected). I know Junio won'=
t
push out a 'master' that doesn't pass the tests for him, so I'm
wondering if some environment information like the terminal width is
leaking through the test scripts.

I haven't actually investigated any further yet, but I thought I'd firs=
t
see if anything obvious occurs to you.

-Peff
