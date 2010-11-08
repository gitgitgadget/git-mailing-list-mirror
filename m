From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Run global hooks from the directory at hooks.dir
Date: Mon, 08 Nov 2010 12:39:59 -0800
Message-ID: <7v39rbpn1c.fsf@alter.siamese.dyndns.org>
References: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, s-beyer@gmx.net
To: Brian Collins <bricollins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYVr-0000TQ-Hg
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab0KHUkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:40:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0KHUkN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:40:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3A8B3FF2;
	Mon,  8 Nov 2010 15:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k4n2N7kB5pFnazNZzKv5H1V7J4A=; b=ABKoXr
	Lped6y2kx98OQMEDFvFLgKDT54zvRf8LZMpqD1bl2A5+QuDIWWadzfT+pIICoixg
	1xLQiC1ext3hHn5GyH7Lhl5l2r7Vr27Kk0zd0lewJj+PwDTrBRtPzaM79KQwNPub
	94yu/PgLdYZxVL2gSSkL1dxIJ2soW4B+KGkVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bw07fAsS68vU1WmcZ5KZWjbknqQCP9Hy
	dA1RrdDU94XgDcDtYI+MdsXy6vTzdWeX4ARytSGlXR9FrTOjBQj2e7K0f0JtmJ3S
	7hq/+iKJd/xd7ELvjDFs80kjhKLEYY7bTS/PFuP3q2lhkpoc9EVAvCJGcIp5roKm
	W7i3f15tBpg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 900163FF1;
	Mon,  8 Nov 2010 15:40:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 823ED3FF0; Mon,  8 Nov 2010
 15:40:04 -0500 (EST)
In-Reply-To: <1289219520-37435-1-git-send-email-bricollins@gmail.com> (Brian
 Collins's message of "Mon\,  8 Nov 2010 04\:32\:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 601C2F78-EB78-11DF-BF34-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160986>

Brian Collins <bricollins@gmail.com> writes:

> Run global hooks in the directory specified by the config variable
> hooks.dir before every attempt at running a local hook. If the
> global hook fails, the local hook will not run. If the global hook is
> absent, the local hook runs normally.

It is left unspecified what happens when the global hook exists and it
succeeds.  Watch out for hooks that read from their standard input.

In any case, the above is totally backwards from the usual practice and
expectation of local things overriding the global default.  If you want a
site-wide policy suggestion, default templates would be a more acceptable
way (and the implementation of hooks you install to developer repositories
can choose to look at $GIT_DIR/hooks/local-foo-hook).

By the way, with a distributed scm, anything-wide policy enforcement at
the level of developer's individual working repositories is a lost cause.
You are giving freedom to do anything on their own copy of the history to
the developers; the project-wide policy is to be enforced at the perimeter
of your authoritative repository of the project.
