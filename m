From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Wed, 10 Oct 2012 21:13:37 +0200
Message-ID: <035A66D9-FAF0-48EE-B161-7D0CAD92F2FB@zib.de>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com> <5072973D.4080703@op5.se> <7vtxu5lyjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:14:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM1jr-0000jA-22
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab2JJTO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 15:14:28 -0400
Received: from mailer.zib.de ([130.73.108.11]:55901 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab2JJTO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 15:14:27 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id q9AJDjed005810;
	Wed, 10 Oct 2012 21:13:50 +0200 (CEST)
Received: from [192.168.0.10] (91-64-48-32-dynip.superkabel.de [91.64.48.32])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id q9AJDhUq008697
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 10 Oct 2012 21:13:44 +0200 (MEST)
In-Reply-To: <7vtxu5lyjr.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207426>

On Oct 8, 2012, at 6:27 PM, Junio C Hamano wrote:

> Once we go into "want/have" phase, I do not think there is a need
> for fundamental change in the protocol (by this, I am not counting a
> change to send "have"s sparsely and possibly backtracking to bisect
> history, etc. as "fundamental").

I've recently discovered that the current protocol can be amazingly
inefficient when it comes to transferring binary objects.  Assuming two
repositories that are in sync.  After a 'git checkout --orphan && git
commit', a subsequent transfers sends all the blobs attached to the new
commit, although the other side already has all the blobs.

This behavior is especially annoying when (mis)using git to store binary
files.  I was thinking for a while that it might be a reasonable idea to
store binary files in a submodule and frequently cut the history in
order to save space.  The history would have little value anyway, since
diff and merge don't make much sense with binary files.

Eventually, I abandoned the idea due to the current behavior of the
protocol.  I had expected that git would be smarter and behave more like
rsync, for example, by skipping big blobs as soon as it recognizes that
they are already available at both sides.

Maybe the new protocol could include an optimization for the described
case.  I don't know whether this would be a fundamental change.

    Steffen
