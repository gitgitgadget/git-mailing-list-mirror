From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] RFC/POC: patterns for branch list
Date: Wed, 27 Apr 2011 10:10:00 -0700
Message-ID: <7vvcxz8vtj.fsf@alter.siamese.dyndns.org>
References: <cover.1303906496.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8Fn-00067F-2r
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759590Ab1D0RKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 13:10:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab1D0RKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:10:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5132546E9;
	Wed, 27 Apr 2011 13:12:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c1iQ2zrSDCLoyZo95xqNn/OFESI=; b=mGOqVN
	K6+xqWEBX9EPN8kliEx7817F7uIIHnLw20x0/9sDR6j6OM5eO8H0ZLROago/H7MX
	9uwCulG4S6OGUVFcK8CiN32ryZ9MlApgcqRIBmII3BCq6wEPiSVQSGAl4RmUq8C0
	mOFqZO8sgEnGS9p2hzxuKVtmm0CZNX0Pi3kww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aE53jRaZKIeanHlaYPgUi7Lqt9Pqzeyy
	uXFjWi1quRkK2Yg50Lklo8NmwRu1Fl9m1d1B/Ma6AMv1jOLWd4vt2esZKOELE1/Y
	oxhJixvdaz73TzaIAgSrM0xbmE3zxN+7kSAAWnNO9NJNBK/KSpad+FlaNFh6ovOV
	koNnZtoEo28=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3066C46E2;
	Wed, 27 Apr 2011 13:12:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33FF446DC; Wed, 27 Apr 2011
 13:12:04 -0400 (EDT)
In-Reply-To: <cover.1303906496.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Wed, 27 Apr 2011 14:15:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B6B368A-70F1-11E0-8B31-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172246>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This mini series is about introducing patterns to the list mode of
> 'git branch' much like the pattern for 'git tag -l'.

I do find myself often typing

    git branch | grep mg/

so this would be a welcome addition, even though the above is not too ugly
nor cumbersome.

> '-l' is the natural short option name for '--list'. This is taken for the
> rarely used or needed 'create reflog' option. I'd change the latter to
> '-g,--create-reflog' (cmp. log) and take '-l,--list' but know the reaction
> already.

My reaction would be "As the eventual goal, it is the right thing to
do---if we were writing git from scratch today, we would probably have
done so. Present a reasonable migration plan.".  Perhaps like this?

 1. Introduce "--create-reflog", and deprecate "-l".  Make "branch -l"
    emit warning and advise to use "--create-reflog" instead, but still
    act as a synonym for "--create-reflog".

    Introduce "--list" but without any short option.

    Ship 1.7.6 with these changes.

 2. Introduce "-g" as synonym for "--create-reflog".  Make "branch -l" die
    and advise to use "-g" or "--create-reflog" instead.

    Ship 1.7.X series after 1.7.7 with these changes.

 3. In 1.8.0, make "-l" a synonym for "--list".

> '-v' and '-vv' both take considerable time (because they need to walk).
> It makes more sense to have '-v' display cheap output (upstream name)
> and '-vv' add expensive output (ahead/behind info). '-vvv' could add super
> expensive info (ahead/equivalent/behind a la cherry-mark).

Probably.  Would it be a solution to deprecate "git branch -v" and make
the behaviour of "git branch -l -v{1,3}" as you described?
