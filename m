From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Tue, 14 Aug 2012 10:45:05 +0200
Message-ID: <877gt16ewe.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:45:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1CkY-0007bN-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 10:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab2HNIpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 04:45:11 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33121 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725Ab2HNIpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 04:45:08 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 10:45:04 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 10:45:06 +0200
In-Reply-To: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 13 Aug 2012 15:21:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203392>

Junio C Hamano <gitster@pobox.com> writes:

>  --topo-order::
> -
> -	This option makes them appear in topological order (i.e.
> -	descendant commits are shown before their parents).
> +	This option makes them appear in topological order.  Even
> +	without this option, descendant commits are shown before
> +	their parents, but this tries to avoid showing commits on
> +	multiple lines of history intermixed.

I don't think that is true in general.  Without any -order options, we
process commits in date order, which *usually* means topological order,
but not always.  You can easily verify this:

  $ git init
  $ date
  Tue Aug 14 10:39:49 CEST 2012
  $ echo initial >file
  $ git add file
  $ GIT_COMMITTER_DATE="Tue Aug 14 11:39:49 2012" git commit
  $ echo foo >file
  $ git commit -mfoo file
  $ git checkout -bside HEAD^
  $ echo bar >file
  $ git commit -mbar file
  $ git log --all --oneline
  8c71325 bar
  e5072d7 initial
  1be702c foo

So the --topo-order switch *ensures* that we process commits in
topological order even in the face of skewed clocks.

I suspect that

> +	their parents, but this tries to avoid showing commits on
> +	multiple lines of history intermixed.

is just a fortunate side effect of the topological sort.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
