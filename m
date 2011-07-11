From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/5] generation numbers for faster traversals
Date: Mon, 11 Jul 2011 12:13:32 -0400
Message-ID: <20110711161332.GA10057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:13:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJ77-0005PU-2D
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020Ab1GKQNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:13:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57683
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757954Ab1GKQNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:13:34 -0400
Received: (qmail 2594 invoked by uid 107); 11 Jul 2011 16:13:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 12:13:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 12:13:32 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176861>

So here's my series for using cached generations with "tag --contains".
I already posted some numbers here:

  http://article.gmane.org/gmane.comp.version-control.git/176807

But to recap, this seems to be about as fast as limiting by timestamp,
but without the skew issues. It uses 24 bytes per commit of disk
storage for the cache (about 6 megabytes for linux-2.6).

If we like this approach, we could do something similar for "branch
--contains", and possibly move "name-rev" to use generations instead of
timestamps with a timestamp slop.

These patches are built on top of ffc4b80 (tag: speed up --contains
calculation, 2011-06-11), the first commit from jk/tag-contains-ab.

  [1/5]: decorate: allow storing values instead of pointers
  [2/5]: add object-cache infrastructure
  [3/5]: commit: add commit_generation function
  [4/5]: pretty: support %G to show the generation number of a commit
  [5/5]: limit "contains" traversals based on commit generation

-Peff
