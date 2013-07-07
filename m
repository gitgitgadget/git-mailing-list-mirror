From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] cat-file --batch-disk-sizes
Date: Sun, 7 Jul 2013 06:01:34 -0400
Message-ID: <20130707100133.GA18717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 12:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvlmo-0001O0-A7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 12:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab3GGKBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 06:01:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:46766 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab3GGKBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 06:01:37 -0400
Received: (qmail 12412 invoked by uid 102); 7 Jul 2013 10:02:51 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 05:02:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 06:01:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229761>

When I work with alternates repositories that have the objects for many
individual forks inter-mixed, one of the questions I want to ask git is
how much space particular forks are taking up in the object database.
This is easy enough to script with `rev-list --objects $fork1 --not
$fork2`, as long as you can convert the object names into their on-disk
sizes.

Unfortunately, it's hard to get the on-disk object sizes for packs. You
can do it directly with `verify-pack -v`, which is incredibly slow. Or
you can sort and subtract offsets from the output of `show-index` (i.e.,
the same thing the pack-revindex code does internally). Instead, this
patch series exposes the revindex-generated sizes on the command line.

The fourth patch does not need to be built on top of this series, but
the early parts provide a convenient way to measure the revindex code.

  [1/4]: zero-initialize object_info structs
  [2/4]: teach sha1_object_info_extended a "disk_size" query
  [3/4]: cat-file: add --batch-disk-sizes option
  [4/4]: pack-revindex: radix-sort the revindex

-Peff
