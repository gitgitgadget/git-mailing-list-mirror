From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Fri, 17 Oct 2014 00:49:11 -0400
Message-ID: <20141017044910.GA12624@peff.net>
References: <20141015223244.GA25368@peff.net>
 <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
 <20141016212112.GA16054@peff.net>
 <20141016213918.GA29397@peff.net>
 <CAPc5daX0AFv9jDrFyd_OnupW5AfZW9Je_rgzaViX_xxs3SG5zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 06:49:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XezTb-0005q0-A0
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 06:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaJQEtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2014 00:49:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:59525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbaJQEtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 00:49:14 -0400
Received: (qmail 15186 invoked by uid 102); 17 Oct 2014 04:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 23:49:13 -0500
Received: (qmail 5345 invoked by uid 107); 17 Oct 2014 04:49:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Oct 2014 00:49:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Oct 2014 00:49:11 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daX0AFv9jDrFyd_OnupW5AfZW9Je_rgzaViX_xxs3SG5zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 09:13:39PM -0700, Junio C Hamano wrote:

> Just being curious, but would the same bug, if allowed to be triggered
> cutting repacking of your repository, have corrupted the resulting bitmap?

I didn't test, but yes, almost certainly. The bug was in list-objects.c,
which is used by pack-objects to generate the list of objects to pack,
as well as to build the bitmaps. So not only would it have corrupted the
bitmaps, a `git repack -ad`[1] would have dropped the object completely,
corrupting the repository!

-Peff

[1] git-gc uses `repack -Ad`, of course. So assuming you had packed more
    recently than 2 weeks ago, it would have just been ejected to a
    loose object. Small comfort. :)

-Peff
