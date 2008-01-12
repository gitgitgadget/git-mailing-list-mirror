From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: handle leading/trailing whitespace from svnsync revprops
Date: Sat, 12 Jan 2008 10:57:32 -0800
Message-ID: <7vprw6ub1f.fsf@gitster.siamese.dyndns.org>
References: <200801081738.56624.devurandom@gmx.net>
	<200801101813.45938.devurandom@gmx.net>
	<7v63y178a3.fsf@gitster.siamese.dyndns.org>
	<200801102213.04082.devurandom@gmx.net>
	<7vmyrd5p81.fsf@gitster.siamese.dyndns.org>
	<20080112071355.GA17021@soma>
	<7vzlvbv5m9.fsf@gitster.siamese.dyndns.org>
	<20080112091242.GA27109@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Schridde <devurandom@gmx.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlYf-0004GO-Gb
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232AbYALS5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756240AbYALS5r
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:57:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807AbYALS5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:57:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA7D5168;
	Sat, 12 Jan 2008 13:57:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD575165;
	Sat, 12 Jan 2008 13:57:39 -0500 (EST)
In-Reply-To: <20080112091242.GA27109@soma> (Eric Wong's message of "Sat, 12
	Jan 2008 01:12:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70346>

Eric Wong <normalperson@yhbt.net> writes:

> The statements are not equivalent, however.  I'd have to add
>
> 	$var = $1;
>
> too, because I needed to extract what was inside the ( ) since the '$'
> doesn't catch the trailing newline, either.

Ahh, _stupid me_.

Yes, you said '$', not '\Z', but somehow I mistook m|^(.*)$| as
a no-op "whole thing".  Sorry.

> Good points, I've been mindlessly taking "interesting" things from other
> Perl code I've seen over the years and using it in my own without
> thinking about it too hard :x
>
> I'll avoid them in the future.  Unfortunately, Git.pm also suffers from
> this as well.

Git.pm is even worse.  It uses the line-noise prototype which is
a very good and cute hack to allow people to (1) emulate Perl's
built-in and (2) come up with syntax sugars, but has a similar
issue that defeats old-school intuition as wantarray-return
subroutines does.

The caller needs to be careful about receiving return values
with wantarray-return subroutines.  The caller needs to be
careful about how to send in the parameters with line-noise
prototyped subs.

In any case, this kind of clean-up is not within the scope of
changes during rc cycle.  I'll take your bugfix as is.

Thanks.
