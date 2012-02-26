From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] parse-options: allow positivation of options
 starting, with no-
Date: Sun, 26 Feb 2012 15:32:47 -0800
Message-ID: <7vy5rpcgrk.fsf@alter.siamese.dyndns.org>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49332E.7070003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1naJ-0002xs-N0
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 00:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab2BZXcv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 18:32:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2BZXcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 18:32:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81AE377E9;
	Sun, 26 Feb 2012 18:32:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pZcj5jyqkH44
	xyHqV3MYieiuyXQ=; b=v66GZToasZJKOlHIm89MfQkszFk7Uu4O0WxK/S6OL1At
	vnGZKjH4n8Hg9gA63DDSo5gjxENX83OYM0HGoY51TCM8zH5tPIhDoRV/UV8gN6Xy
	I5NAXaT7YWs+HBchjvh/VoY6/VjCeJEYDPB/Tv8MaoVi1cUei5IsZrutDUViNwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LzM+ub
	6qn+BfgWkZJ/NCAeARE9ziyD7yDLRxnbX2W11tKO678OSh2MYizGD9XFgoZzlb8x
	OfF6Pso5hMsDMtuBdxCiOxxJH/QJvAaGah5ehi1MV2TuV+LBhYgB1H+8ErjCGKZo
	y4PocbNjIvMsQ06X+nt5SaXx61Rw08/wP2tOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 781CB77E8;
	Sun, 26 Feb 2012 18:32:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D86CD77E4; Sun, 26 Feb 2012
 18:32:48 -0500 (EST)
In-Reply-To: <4F49332E.7070003@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 25 Feb 2012 20:14:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3193CCC6-60D2-11E1-A7A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191583>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Long options can be negated by adding no- right after the leading
> two dashes. This is useful e.g. to override options set by aliases.
>
> For options that are defined to start with no- already, this looks
> a bit funny. Allow such options to also be negated by removing the
> prefix.

True about "a bit funny", but the fact that the solution has to touch
parse-options.c confuses me.

I would na=C3=AFvely expect that it would be sufficient to update an ex=
isting
definition for "--no-frotz" that uses PARSE_OPT_NONEG to instead define
"--frotz" that by itself is a no-op, and "--no-frotz" would cause whate=
ver
the option currently means, with an update to the help text that says
something to the effect that "--frotz by itself is meaningless and is
always used as --no-frotz".

There must be a reason the patch had to take an approach in the opposit=
e
direction to allow removal of --[no-] prefix, but it is not obvious to =
me
what it is.

Note that I am _not_ saying that this is a bad change. I am just saying
that it is unclear why we still want two different ways to support the
"--no-frotz" option, one by defining "frotz" option that allows "no" to=
 be
prefixed, and the other by defining "no-frotz" that allows "no-" to be
stripped.
