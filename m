From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 09:27:56 -0700
Message-ID: <7v39271j3n.fsf@alter.siamese.dyndns.org>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
 <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de>
 <7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:28:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGBVy-0002l7-Qi
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 18:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab2IXQ2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 12:28:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab2IXQ17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 12:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE50A9453;
	Mon, 24 Sep 2012 12:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vjDlQLh9WHNi74PqOD2h0A4zVGA=; b=TFXhIr
	UTAaQJ3Fi2Opg0rR8QPrDSnPOL5626PUpkf0F9wZNMZeY00543Qn/TSyxRDTAcs4
	D0yGBJf3Z1OsTKrMV+bb7aOo6V+lj021HmR4AqyA/BQyHgNPre2ISJc5YrffXBjj
	nDaDfX7cAkKYFBB42/OJLLxSJeMlL4E9AegDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p1xo9Df8hXh6zbVBiBCwysGVTa2nz6t5
	oRgOxDyqHTMvqTXJ4ZU4BrCYfaR8YDnDqnA35/pLsFGd2Jwq047qIWEl/zPIcHO3
	hAY/a5Z4uDtW6hVKuOHgG+hMJ2rJHmIOF9gCidIwm+QbcDNlvrLAyFXJJdMwBNhR
	hqgwEHD5bbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DACB39451;
	Mon, 24 Sep 2012 12:27:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B5DF9450; Mon, 24 Sep 2012
 12:27:58 -0400 (EDT)
In-Reply-To: <7vmx0g0xpm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 23 Sep 2012 22:57:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD20C1D4-0664-11E2-AD87-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206296>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>>> Jens, what do you think?  I see no reason for anybody other than
>>> "submodule init" to call gitmodules_config() that reads from the
>>> in-tree .gitmodules file.
>>
>> I think the copying on init is not what we should do here because
>> it sets the user's customization to what ever happened to be in
>> .gitmodules at the time he initialized the submodule.
>
> Hrm, why does the user have submodule.$name.$whatever customized
> before saying "submodule init $whategver" for that copying to be
> problematic?
>
>> So I think Orgad's change is sane and should go in.
>
> Matching what cmd_commit() does to what cmd_status() does, i.e. grab
> submodule.$name.ignore from somewhere, is not something I questioned.
> The patch is a good change to make them consistent.
>
> What I was wondering was if that is a consistently wrong thing to do
> to read from .gitmodules not $GIT_DIR/config.
>
> In any case, the log message I suggested in the review needs to be
> updated in the reroll to make it clear that this is about reading
> from .gitmodules, not "configuration".  AFAICS, gitmodule_config()
> does not even read from $GIT_DIR/config, right?

OK.  gitmodule_config() does not read $GIT_DIR/config, but
cmd_status() and cmd_commit() call git_diff_basic_config() that is
called from git_diff_ui_config() to read submodule.$name.ignore from
it.  So Orgad's patch is _only_ about submodule.$name.ignore that is
in in-tree .gitmodule; the log message shouldn't mention "config",
as setting configuration variables work for both status and commit
just fine.
