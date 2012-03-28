From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetools: fail if display needed but not present
Date: Wed, 28 Mar 2012 14:02:58 -0700
Message-ID: <7vmx70tp4t.fsf@alter.siamese.dyndns.org>
References: <1332964693-4058-1-git-send-email-tim.henigan@gmail.com>
 <1332964693-4058-2-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD01M-0000Dm-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459Ab2C1VDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:03:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758014Ab2C1VDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:03:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8886A91;
	Wed, 28 Mar 2012 17:03:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C7OQbEdGQpLQ1+4+g/qSoklYHvk=; b=LIygN3
	9YEttvq+pz7eYHv613pPK5Z8vDj7kha58OcQaqOwPrX0xG33YCMrXERRdNx61MvV
	qnUn2t5GJppHxmt9z4nj36kVBXCI1tuAReBQ6i5VcF7i9oOgN4Dypt3AOjAZn5Nd
	r8m5CgwvlL00VsigBBsQuBXqQpv3phWFsdNq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bJzx5RzqxYLdNRg+K1lu61jsJsH2E/V1
	5x9IHRmnoUW6W+u6EdXSrY4DOiCbzQbVStF4ld78iIUNa2ZyJKJ0SEXMZI3AG1f2
	KkrL/X/42gAswbRNnCd3XgEEK6WMfRlurN0N0CKPnx6GYlJWh4CgKzECYD/+q3Em
	4rzgs40rwxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D46FA6A90;
	Wed, 28 Mar 2012 17:03:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2993F6A8F; Wed, 28 Mar 2012
 17:03:00 -0400 (EDT)
In-Reply-To: <1332964693-4058-2-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 28 Mar 2012 15:58:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66B07E7C-7919-11E1-BE31-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194198>

Tim Henigan <tim.henigan@gmail.com> writes:

> Prior to this commit, if 'git mergetool' or 'git difftool' were run in a
> terminal-only session, they might still try to open a tool that required
> a windowed environment.

When you say "The command does X.  X is bad for such and such reasons.
Make it do Y instead, because it is nicer for such and such reasons.",
everybody would understand that the command does X without your patch.
Maybe it is just me, but I find the phrases like "Prior to this commit" or
"Currently" somewhat irritating.

> This commit teaches 'git-mergetool--lib.sh' to test for the presence of
> a display prior to opening tools that require one.

Hrm, why not make it more general, so that mergetool--lib does not have to
know anything about DISPLAY but allow the tool scripts to inspect their
environment and make their own decision, i.e. after loading the tool
scriptlet, the caller can call "can_run [--quiet]" and the scriptlet can
either return 0/1 and optionally issue the help message?
