From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 14:26:11 -0700
Message-ID: <7vy5ds5mz0.fsf@alter.siamese.dyndns.org>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 12 22:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFWia-0004oj-A0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 22:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618Ab3CLV0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 17:26:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932723Ab3CLV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 17:26:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93470A1A6;
	Tue, 12 Mar 2013 17:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vJ4atu00OGbrzjvlrpt86/tLoNU=; b=uiU+kD
	tqOZi/CCB8mYVI0sicOuS/lEwGeNtiS+XbRypjUnuCYkRNKmteM8UsM70p4RbOuJ
	tm6EjZJKLpaqQ31KTR4bk5IpAD01LFPVVN1NeiGBnc9X15VIh4bPvl88BoiqvWQN
	7WG16iij6Lc3183eoReQbcG6/8wovB6GJzZ5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rGrdhvFtayvuarCAL0XK0R3Yh9rYQI+t
	tPyXd+JV8rJqkvVk+IDoRUsJzpTyZwsD0GtsQFT28Q5rHlh9pRsiJaV5hpVzDbdR
	MgMee+01PajywoSsjlHNvC+Pcqa5JntJv2wgC7jr31eD4B0j8hdkUN956f4y4tc3
	lxv4eeYHFec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88184A1A4;
	Tue, 12 Mar 2013 17:26:13 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B93EA1A2; Tue, 12 Mar 2013
 17:26:12 -0400 (EDT)
In-Reply-To: <20130312210630.GF2317@serenity.lan> (John Keeping's message of
 "Tue, 12 Mar 2013 21:06:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7715C1E6-8B5B-11E2-AEAB-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217996>

John Keeping <john@keeping.me.uk> writes:

>> Does it even have to be conditional?  What is the situation when you
>> do not want symbolic links?
>
> When you're not comparing the working tree.

OK, so what you want is essentially:

 * If you see 0{40} in "diff --raw", you *know* you are showing the working tree
   file on the RHS, and you want to symlink, so that the edit made
   by the user will be reflected back to theh working tree copy.
 
 * If your working tree file match what is in the index, you won't
   see 0{40} but you still want to symlink, for the same reason.

 * If you are comparing two trees, and especially if your RHS is not
   HEAD, you will send everything to a temporary without
   symlinks. Any edit made by the user will be lost.

If that is the case, perhaps the safest way to go may be to write
the object out when you see non 0{40}, compare it with the working
tree version and then turn that into symlink?  That way, you not
only cover the second bullet point, but also cover half of the third
one where the user may find a bug in the RHS, update it in difftool.

I am assuming that you are write-protecting the non-symlink files in
the temporary tree (i.e. those that do not match the working tree)
to prevent users from accidentally modifying something there is no
place to save back to.

Hrm?
