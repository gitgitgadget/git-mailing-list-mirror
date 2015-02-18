From: Jeff King <peff@peff.net>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 13:32:51 -0500
Message-ID: <20150218183251.GB6346@peff.net>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
 <CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
 <CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
 <CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
 <xmqqfva341sf.fsf@gitster.dls.corp.google.com>
 <CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:33:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9RF-0006or-VI
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbbBRScy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:32:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:50585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754353AbbBRScx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:32:53 -0500
Received: (qmail 2792 invoked by uid 102); 18 Feb 2015 18:32:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 12:32:53 -0600
Received: (qmail 19496 invoked by uid 107); 18 Feb 2015 18:33:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:33:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 13:32:51 -0500
Content-Disposition: inline
In-Reply-To: <CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264038>

On Wed, Feb 18, 2015 at 01:27:50PM -0500, Eric Frederich wrote:

> My immediate concern is not to fix the documentation but to get some
> sort of status or diff.
> I want to avoid using an index because I want to allow multiple
> processes to do different diffs at the same time.

If you only have one working tree, can't all of the processes use the
same index (that matches the working tree) and do different diffs
against it?

If you have multiple working trees, can you use one index per working
tree, and specify it using GIT_INDEX_FILE?

If you can persist the index file for each working tree, this will be
much faster in the long run, too (you can just refresh the index before
each diff, which means that git does not have to actually open the files
in most cases; we can compare their stat information to what is in the
index, and then the index sha1 with what is in the tree).

-Peff
