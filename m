From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Fix ranges with git-show
Date: Wed, 20 Jun 2012 09:39:09 +0200
Message-ID: <87bokexwiq.fsf@thomas.inf.ethz.ch>
References: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch>
	<a598bb8c20221679e295caa743197c86219eda68.1340136145.git.trast@student.ethz.ch>
	<7vhau7ypk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 09:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShFVX-0001J7-6O
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 09:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab2FTHjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 03:39:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26055 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab2FTHjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 03:39:14 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 20 Jun
 2012 09:39:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 20 Jun
 2012 09:39:10 +0200
In-Reply-To: <7vhau7ypk6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 19 Jun 2012 14:11:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200287>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think it is sad at all.  If we were told to walk, we should
> walk just like "git log" does, and otherwise we just show them one
> by one.  It might be even cleaner if we separate the command line
> parsing and showing into separate phases, instead of the current
> loop structure of parsing one object and deciding how to show.
>
> How about doing it this way without applying your 2/2?
[...]
>  	opt.tweak = show_rev_tweak_rev;
>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
>  
> +	if (!rev.no_walk)
> +		return cmd_log_walk(&rev);
> +
>  	count = rev.pending.nr;
>  	objects = rev.pending.objects;
>  	for (i = 0; i < count && !ret; i++) {

Clever.  But it eliminates all possibility of *simultaneously* showing a
range and some other objects, of which

> Among your new tests:
>
> 	git show ^side3 annotated
>
> must change, as it is not asking to show individual objects (in
> other words, I think the test expects a wrong thing), but everything
> else should work as expected (I didn't check).

is just a symptom of.  Do you want to change it?  I'd be all for it, but
it changes the meaning somewhat.  So far, showing "anything plus ranges"
is broken only as far as the ranges are concerned.

If you do make this change, can we merge the log and show code?
Granted, show defaults to -p --cc --no-walk, and log does not, but can
we then unify the main logic?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
