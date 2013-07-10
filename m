From: Jeff King <peff@peff.net>
Subject: [PATCHv2 00/10] cat-file formats/on-disk sizes
Date: Wed, 10 Jul 2013 07:34:47 -0400
Message-ID: <20130710113447.GA20113@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwsfg-00007x-W4
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab3GJLex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:34:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:47720 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3GJLew (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:34:52 -0400
Received: (qmail 24787 invoked by uid 102); 10 Jul 2013 11:36:08 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:36:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:34:47 -0400
Content-Disposition: inline
In-Reply-To: <20130707100133.GA18717@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230041>

Here's a re-roll of the cat-file --batch-disk-sizes series.

The main change is that it replaces the --batch-disk-sizes option with a
format string for --batch-check, syntactically modeled after the
for-each-ref format string.

  [01/10]: zero-initialize object_info structs
  [02/10]: teach sha1_object_info_extended a "disk_size" query

These two are the same as before.

  [03/10]: t1006: modernize output comparisons

New. Cleanup since I add some related tests later on.

  [04/10]: cat-file: teach --batch to stream blob objects

New. I think this is a sane thing to be doing, and it helps reorganize
the code for later changes. But note the performance caveat in the
commit message.

  [05/10]: cat-file: refactor --batch option parsing
  [06/10]: cat-file: add --batch-check=<format>

These ones add the formatting code.

  [07/10]: cat-file: add %(objectsize:disk) format atom

And this is the format analog of my original 3/4.

  [08/10]: cat-file: split --batch input lines on whitespace

New. This makes certain types of analysis simpler when you pipe
"rev-list --objects" into "cat-file --batch-check", because you can
retain the object paths through the pipe.

  [09/10]: pack-revindex: use unsigned to store number of objects

New. Addresses the 2^31 bug that Brandon noticed.

  [10/10]: pack-revindex: radix-sort the revindex

>From the old 4/4, but with cleanups and addressing comments from the
list (details along with the patch).

-Peff
