From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 3/5] Introduce new pretty formats %g[sdD] for reflog information
Date: Fri, 16 Oct 2009 10:50:30 +0200
Message-ID: <200910161050.32378.trast@student.ethz.ch>
References: <cover.1255645570.git.trast@student.ethz.ch> <012c71c4eab143691bc5e2d62b421f8c84effa0e.1255645570.git.trast@student.ethz.ch> <20091016053230.GB10629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 10:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myic4-0007FL-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbZJPIvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 04:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbZJPIvz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:51:55 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:33395 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbZJPIvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 04:51:54 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 10:51:07 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 10:51:05 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091016053230.GB10629@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130468>

Jeff King wrote:
> > +	if (shorten) {
> > +		if (last_ref != commit_reflog->reflogs->ref) {
> > +			free(last_short_ref);
> > +			last_short_ref = shorten_unambiguous_ref(commit_reflog->reflogs->ref, 0);
> > +		}
> > +		printed_ref = last_short_ref;
> 
> Clever. I hadn't considered caching, but you are right that
> shorten_unambiguous_ref is a bit heavyweight to be calling for every
> entry.

I had a slightly better idea today: We can just put an extra member
into the complete_reflogs struct, i.e., a short_ref to go along with
the ref.  It'll take a bit of auditing to verify that all allocations
are zeroed, but since the struct is local to the file that shouldn't
be so hard.

> A test for '%gd' would be nice. A squashable one is below. I am tempted
> to test all three forms in t6006, since the intent of that script is to
> test all format specifiers. However, those tests would be somewhat
> redundant with your t1411 tests.

Ah, yeah, I looked for "reflog" instead of something about pretty, so
I ended up with t1411.  t6006 is a better fit.  Thanks for the extra
test!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
