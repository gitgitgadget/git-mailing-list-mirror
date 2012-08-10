From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their own file
Date: Fri, 10 Aug 2012 16:24:25 +0200
Message-ID: <87hasan7ty.fsf@thomas.inf.ethz.ch>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
	<1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
	<7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>,
	<robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 16:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szq9o-0004Dh-8k
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 16:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619Ab2HJOZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 10:25:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:56483 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758582Ab2HJOZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 10:25:36 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 10 Aug
 2012 16:25:24 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.80) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 10 Aug
 2012 16:25:30 +0200
In-Reply-To: <7vtxwbn2qe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 09 Aug 2012 15:02:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.80]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203217>

Junio C Hamano <gitster@pobox.com> writes:

> If you found that an entry you read halfway has an inconsistent crc,
> and if you suspect that is because somebody else was writing to the
> same index, it is a _sure_ sign that you are not alone, and all the
> entries you read so far to the core, even if they weren't touched by
> that sombody else when you read them, may be stale, and worse yet,
> what you are going to read may be inconsistent with what you've read
> and have in-core (e.g. you may have read "f" before somebody else
> that is racing with you have turned it into a directory, and your
> next read may find "f/d" in the index without crc error).

The intention for v5 (admittedly this probably requires a lot more
documentation) was to only allow an in-place update in two cases:

* updating the data fields (*not* the name) of a file entry,

* adding or removing conflict entries at the end.

The latter probably requires a bit more thought to make it safe, too.
But I think the idea always was that any write that changes the basic
layout of the file (so that you would read something wrong) will need a
full rewrite.  Otherwise we're too far in DB land.  Most updates will be
of the "update the stat and/or sha1 of a file" kind, anyway.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
