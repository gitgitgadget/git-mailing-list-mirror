From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Buggy handling of non-canonical ref names
Date: Wed, 24 Aug 2011 11:40:24 -0700
Message-ID: <7vaaayps9z.fsf@alter.siamese.dyndns.org>
References: <4E551D70.9080509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwINL-0003go-Vq
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 20:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab1HXSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 14:40:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab1HXSk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 14:40:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B0764BC6;
	Wed, 24 Aug 2011 14:40:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0kB/wTiS/xjmcZGwrbykWGEjhnE=; b=BZf3Xb
	hF8jc+fFCeX+q0g+qmYl7Z1cYUyf2f/AyuW+BDvruDkeAIZdEInxzpVbO107mJWj
	hIN6JMFTL+aVSQwzOVbWEnPLenyDeELGJ6X1s6wRML/IPSwl87wxc9lu1dYLuO/G
	Rno4WyXB2EIZNQr5cerNNgZzDf6WN1FgVBzEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gwrr9n/JY5FBi0lwoF5sgtvglqaEYBnf
	ZpXpmROoSCDGLlEmw7HBl4upPymWmpob24OoH6safIVjtbZpVr55+d3eHqK2tWVL
	qCkESvEyB2l85VekWCbUQWpf0xZjI1e+nwc8fn1ovBC2J9LO5gxX7sRsc8SzgufS
	R7qMUm9l8IM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DA94BC5;
	Wed, 24 Aug 2011 14:40:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B93BB4BC4; Wed, 24 Aug 2011
 14:40:25 -0400 (EDT)
In-Reply-To: <4E551D70.9080509@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 24 Aug 2011 17:49:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 883915C0-CE80-11E0-8408-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180024>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> What is the policy about reference names and their canonicalization?

The overall policy has been that we care about well-formed input, and
everything else is "undefined", even though as you found out some of them
try to work sensibly.

>     $ git check-ref-format /foo/bar ; echo $?
>     0
>
>     $ git check-ref-format --print /foo/bar
>     /foo/bar

I think these are bogus. Patches welcome.

> However, creating a reference with such a name is equivalent to creating
> a reference without the leading slash:
>
>     $ git update-ref /foo/bar HEAD
>     $ cat .git/foo/bar
>     ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd
>     $ git branch /bar/baz
>     $ git for-each-ref | grep baz
>     ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd commit refs/heads/bar/baz

These are just examples of "undefined being nice to the user as a bonus".
