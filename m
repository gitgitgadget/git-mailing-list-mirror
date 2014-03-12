From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Wed, 12 Mar 2014 12:43:35 +0100
Message-ID: <53204867.4010809@alum.mit.edu>
References: <531D9B50.5030404@alum.mit.edu> <531EEBCC.10409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 12:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNhZf-0004t8-AK
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 12:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbaCLLnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 07:43:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52903 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082AbaCLLnk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 07:43:40 -0400
X-AuditID: 12074414-f79d96d000002d2b-fa-5320486b6867
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 00.6E.11563.B6840235; Wed, 12 Mar 2014 07:43:39 -0400 (EDT)
Received: from [192.168.69.148] (p57A2455B.dip0.t-ipconnect.de [87.162.69.91])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2CBhZ2s023995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 12 Mar 2014 07:43:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531EEBCC.10409@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsUixO6iqJvtoRBs0DiX32LnOgmLrivdTBbz
	7u5islj47yi7xY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6PF5k1wAaxS3TVJi
	SVlwZnqevl0Cd8bfnr0sBbfkKyatncPUwPhEsouRk0NCwETix4lHbBC2mMSFe+uBbC4OIYHL
	jBJ3Jy9igXDOMUms/rmNHaSKV0BbYs/WdiCbg4NFQFXi63sDkDCbgK7Eop5mJhBbVCBYYvXl
	BywQ5YISJ2c+AbNFgFrnt95jApnJLHCQUeLMnNlgCWEBY4knLxaygthCAm4Sp9a9BdvFKaAu
	seDWNiaQXRIC4hI9jUEgYWYBHYl3fQ+YIWx5ie1v5zBPYBSchWTdLCRls5CULWBkXsUol5hT
	mqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREgUiOxiPnJQ7xCjAwajEwztDST5YiDWx
	rLgy9xCjJAeTkijvHDeFYCG+pPyUyozE4oz4otKc1OJDjBIczEoivLtsgXK8KYmVValF+TAp
	aQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK809yBGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBERxfDIxhkBQP0N4MkHbe4oLEXKAoROspRmOO222/PjFyfP727xOjEEte
	fl6qlDivL0ipAEhpRmke3CJY+nvFKA70tzDve5AqHmDqhJv3CmgVE9CqHwHyIKtKEhFSUg2M
	FZzuXspPah/uTUgrOccSlf1BuekEz9E3qU8CX/jN2WZ1MubvMWb+JZJy0c1dDM8c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243932>

Karsten,

Thanks for your feedback!

On 03/11/2014 11:56 AM, Karsten Blees wrote:
> Am 10.03.2014 12:00, schrieb Michael Haggerty:
>> 
>> Reference transactions ----------------------
> 
> Very cool ideas indeed.
> 
> However, I'm concerned a bit that transactions are conceptual
> overkill. How many concurrent updates do you expect in a repository?
> Wouldn't a single repo-wide lock suffice (and be _much_ simpler to
> implement with any backend, esp. file-based)?

I am mostly thinking about long-running processes, like "gc" and
"prune-refs", which need to be made race-free without blocking other
processes for the whole time they are running (whereas it might be quite
tolerable to have them fail or only complete part of their work in any
given invocation).  Also, I work at GitHub, where we have quite a few
repositories, some of which are quite active :-)

Remember that I'm not yet proposing anything like hard-core ACID
reference transactions.  I'm just clearing the way for various possible
changes in reference handling.  I listed the ideas only to whet people's
appetites and motivate the refactoring, which will take a while before
it bears any real fruit.

> The API you posted in [1] doesn't look very much like a transaction
> API either (rather like batch-updates). E.g. there's no rollback, the
> queue* methods cannot report failure, and there's no way to read a
> ref as part of the transaction. So I'm afraid that backends that
> support transactions out of the box (e.g. RDBMSs) will be hard to
> adapt to this.

Gmane is down at the moment but I assume you are referring to my patch
series and the ref_transaction implementation therein.

No explicit rollback is necessary at this stage, because the "commit"
function first locks all of the references that it wants to change
(first verifying that they have the expected values), and then modifies
them all.  By the time the references are locked, the whole transaction
is guaranteed to succeed [1].  If the locks can't all be acquired, then
any locks that were obtained are released.

If a caller wants to rollback a transaction, it only needs to free the
transaction instead of committing.  I should probably make that clearer
by renaming free_ref_transaction() to rollback_ref_transaction().  By
the time we start implementing other reference backends, that function
will of course have to do more.  For that matter, maybe
create_ref_transaction() should be renamed to begin_ref_transaction().
Now would be a good time for concrete bikeshedding suggestions about
function names or other details of the API :-)

Yes, the queue_*() methods should probably later make a preliminary
check of the reference's old value and return an error if the expected
value is already incorrect.  This would allow callers to fail fast if
the transaction is doomed to failure.  But that wasn't needed yet for
the one existing caller, which builds up a transaction and commits it
immediately, so I didn't implement it yet.  And the early checks would
add overhead for this caller, so maybe they should be optional anyway.
Maybe these functions should already be declared to return an error
status, but there should be an option passed to create_ref_transaction()
that selects whether fast checks should be performed or not for that
transaction.

Really, all that this first patch series does is put a different API
around the mechanism that was already there, in update_refs().  There
will be a lot more steps before we see anything approaching real
reference transactions.  But I think your (implied) suggestion, to make
the API more reminiscent of something like database transactions, is a
good one and I will work on it.

Cheers,
Michael

[1] "Guaranteed" here is of course relative.  The commit could still
fail due to the process being killed, disk errors, etc.  But it can't
fail due to lock contention with another git process.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
