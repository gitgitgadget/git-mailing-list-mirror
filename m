From: Jeff King <peff@peff.net>
Subject: [PATCH 0/9] corrupt object potpourri
Date: Mon, 25 Mar 2013 16:14:27 -0400
Message-ID: <20130325201427.GA15798@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDnK-0003uy-P0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207Ab3CYUOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:14:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39320 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801Ab3CYUOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:14:31 -0400
Received: (qmail 27759 invoked by uid 107); 25 Mar 2013 20:16:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:16:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:14:27 -0400
Content-Disposition: inline
In-Reply-To: <20130324183133.GA11200@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219077>

I started these patches with the intent of improving clone's behavior
on corrupt objects, but my testing uncovered some other nastiness,
including two infinite loops in the streaming code!. Yikes.

I think 1-7 are good. We might want to tweak the die() behavior of patch
8, but I think it should come on top. Patch 9 has some pretty ugly
performance implications.

At the end of the series, all of the introduced tests pass except for
one, which is that "git clone" may silently write out a bogus working
tree entry. I haven't tracked that one down yet.

  [1/9]: stream_blob_to_fd: detect errors reading from stream
  [2/9]: check_sha1_signature: check return value from read_istream
  [3/9]: read_istream_filtered: propagate read error from upstream
  [4/9]: avoid infinite loop in read_istream_loose
  [5/9]: add test for streaming corrupt blobs
  [6/9]: streaming_write_entry: propagate streaming errors
  [7/9]: add tests for cloning corrupted repositories
  [8/9]: clone: die on errors from unpack_trees
  [9/9]: clone: run check_everything_connected

-Peff
