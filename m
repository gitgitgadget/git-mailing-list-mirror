From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFD] annnotating a pair of commit objects?
Date: Thu, 03 Jan 2013 11:23:38 +0100
Message-ID: <50E55C2A.1090204@kdbg.org>
References: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 11:24:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqhxw-0006ds-BU
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 11:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab3ACKXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 05:23:41 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:13508 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751134Ab3ACKXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 05:23:40 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 42A93130068;
	Thu,  3 Jan 2013 11:23:38 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 297D119F45D;
	Thu,  3 Jan 2013 11:23:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212579>

Am 03.01.2013 08:03, schrieb Junio C Hamano:
> The intended use case is to "go beyond rerere".  Given a history of
> this shape:
> 
>     o---o---o---I      mainline
>    / 
>   O---o---X---o---A    topic A
>    \
>     o---Y---o---o---B  topic B
> 
> Suppose in the original O we had a function "distimmed_doshes()" to
> tell if doshes are already distimmed, with some call sites.  On the
> branch leading to A, at commit X, this function was renamed to
> "doshes_are_distimmed()", and all existing call sites were adjusted.
> On the side branch leading to B, however, at commit Y, a new call
> site to the old function was added in a file that was not touched
> between O..A at all.
> 
> When merging either the topic A or the topic B (but not both) to the
> integration branch that did not touch this function or use of it, no
> special care needs to be taken, but when merging the second topic
> after merging the other one, we need to resolve a semantic conflict.
> Namely, the callsite to "distimmed_doshes()" introduced by commit Y
> needs to be adjusted to call "doshes_are_distimmed()" instead.

I guess this issue comes up when you rebuild pu. Perhaps you (and other
integrators with a similar workflow) are sufficiently served with
something that resembles rebase -p --first-parent, as proposed here:

http://thread.gmane.org/gmane.comp.version-control.git/198125/focus=198483

(A proposal of the same idea appeared already years earlier:

http://thread.gmane.org/gmane.comp.version-control.git/62782/focus=62794

but its implementation only re-did the merge, which would not help your
case.)

-- Hannes
