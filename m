From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 10:32:41 -0700
Message-ID: <7vlixu4reu.fsf@alter.siamese.dyndns.org>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
 <SNT124-W39164C74A457129811245DC4740@phx.gbl>
 <BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
 <SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
 <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
 <20110525132816.GA6709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elazar Leibovich <elazarl@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 19:33:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHx4-0002TO-PY
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab1EYRcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 13:32:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1EYRcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:32:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92FA15A45;
	Wed, 25 May 2011 13:35:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4pbSv5l5F39MxcP7mIyXurWcSVQ=; b=lCwoMg
	KsUs2PtCH43EQBWnlurXOio9biIB4Uvf4xzEG80ed95xi4EdpBlBTN9HYSZDrNyA
	E8TYRAku5qxIVpJ+jgeLAaLotkdcYrLU+w69zQ9tigOOqCft/Nm0StbXiURYf5Np
	Le7LtxDg+rYqOXEUwW57JekeYYO62T23B+8so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yKLd8c8Q1PbmzGoDdhqjeBPJ3YkhM9dH
	nauneu3trO8dEXLVqbfD4pE4QwB+O90hzcwjJCv3sEHgjcXkMgThzS2ijs20H7AA
	x1zNdcuoW5cuBPYp0P4/uwExEW7JcehDLhaqqwKsy1UApUkFaIsiJ4Mqk+WVytvy
	jJVXr/TSUj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CB715A44;
	Wed, 25 May 2011 13:34:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED9A45A43; Wed, 25 May 2011
 13:34:50 -0400 (EDT)
In-Reply-To: <20110525132816.GA6709@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 25 May 2011 09:29:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E72301A-86F5-11E0-98A2-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174436>

Jeff King <peff@peff.net> writes:

> The problem is that "--not" already has a meaning, and the scope of that
> meaning is different than what you propose. That is, in this command:
>
>   git log a --not b c
>
> The "--not" applies to both "b" and "c". So you are changing the meaning
> of the existing:
>
>   git log a --not --grep b c
>
> (which now means "grep for b, but do not include commits in c"). And
> even if we wanted to do that, there is a parsing ambiguity. Does the
> "--not" apply _just_ to the grep, or does it also include "not c"?
>
> Which is a shame, because we already have all of the code for "--and",
> "--or", and "--not" in git-grep.

True, that has always been an accepted limitation.

You could add --grep="-e A --and --not -e B --all-match", split_cmdline()
and then give the result to append_grep_pattern(), or something like that,
but I do not think it is worth doing.
