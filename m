From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] revert.c: Allow to specify -x via git-config
Date: Wed, 19 Feb 2014 11:57:37 -0800
Message-ID: <xmqqy51698pa.fsf@gitster.dls.corp.google.com>
References: <20140218192039.GC7855@google.com>
	<cover.1392758057.git.agx@sigxcpu.org>
	<85b9fa68b1a5542817489ddbe186cbb7600599b0.1392758057.git.agx@sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
X-From: git-owner@vger.kernel.org Wed Feb 19 20:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDHC-0003mg-L5
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 20:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbaBST5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 14:57:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbaBST5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 14:57:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D33CE6CD76;
	Wed, 19 Feb 2014 14:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D+xsJHkBnmY6
	I7mQ1eugOyfTHWw=; b=nHBg0m5VDCCtwIIjvzti4wKKHIlDG2FOHT2e12w/KFbZ
	pgFgldbpiy5gLI705+GJKwPoa00QNhkOdmmfEvDXlmvNrYvJLhv+gzJeES6SB7Aa
	sQ5DLr+FE1yE2GT2OSU8y0nFlKpHNCnHMcfMpXdgnKIMF9gk08KtLKACaXDyeWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FqYnLN
	acHsozXA6ffEl11pHJvN606rGILFotA9HFASqWps9i5VV/i2F44crCfq0phAIXi/
	uV1sOImz2QH0Gv158e5Q20Tli5QrSzwyQmRixCeSk/biPEGOCS0UIMVznJHJOPpV
	It4LMOnb4iytRZlOonyHlPpXyKFW85gUotAj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C15F76CD75;
	Wed, 19 Feb 2014 14:57:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 672AE6CD6A;
	Wed, 19 Feb 2014 14:57:39 -0500 (EST)
In-Reply-To: <85b9fa68b1a5542817489ddbe186cbb7600599b0.1392758057.git.agx@sigxcpu.org>
	("Guido =?utf-8?Q?G=C3=BCnther=22's?= message of "Tue, 18 Feb 2014 22:27:40
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16029C72-99A0-11E3-9F74-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242400>

Guido G=C3=BCnther <agx@sigxcpu.org> writes:

> Without this when maintaining stable branches it's easy to forget to =
use
> -x to track where a patch was cherry-picked from.
> ---
>  Documentation/config.txt          |  4 ++++
>  Documentation/git-cherry-pick.txt |  8 ++++++++
>  builtin/revert.c                  | 14 +++++++++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)

Hmph.  Does this round address the issues raised in the previous
discussion in any way?

How does it affect people's existing scripts that use cherry-pick
and rely on it not doing the unwanted -x thing if such a
configuration variable is introduced as the first step in the
series, without even giving them to override the configured default
from the command line?

=46or that matter, I do not think a new override option from the
command line is a great solution, as that approach forces people's
existing script to be adjusted.

I personally found the way Jonathan explained why "git backport"
alias is the best solution (not just a usable workaround) very
compelling, especially his point (3):

 (3) The caller explicitly specifies their intent by running "git
     backport".  It doesn't affect unrelated uses of cherry-pick on
     other branches.

I do not even mind throwing something like this:

	#!/bin/sh
	# "git backport" - cherry-pick with -x always on.
        exec git cherry-pick -x "$@"

in contrib/ somewhere, which feels like a far more appropriate
solution to your "easy to forget" problem, at least to me.
