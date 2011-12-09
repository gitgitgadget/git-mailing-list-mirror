From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Fri, 09 Dec 2011 10:24:48 -0800
Message-ID: <7v7h25ebni.fsf@alter.siamese.dyndns.org>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com>
 <20111208163946.GB2394@elie.hsd1.il.comcast.net>
 <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
 <20111208170319.GD2394@elie.hsd1.il.comcast.net>
 <CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
 <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <CALkWK0nCuFgS8PKkQLMzqpBsOWouSs5y=CEKS1r0x0=LkhqC9A@mail.gmail.com>
 <7viplqhbgs.fsf@alter.siamese.dyndns.org>
 <m34nx9j2fc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6zu-0001GN-K7
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab1LIUYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:24:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab1LIUYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:24:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1A616665;
	Fri,  9 Dec 2011 15:24:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=YbvYkFBr2luKiqxH3lQxya9EVCo=; b=QF8P6wkBzXlAg37H6UZZ
	f0EEIdj/aKQPC6I4bw90q+ktnYUFfpL8E0T+00HSBnE7TbiUONyEmkQ9JNkWDUlj
	qxKZokP1DfPB/UzdBXONUASCXcKl6U3gv7c/QMajnXoywNRYhtuPt/w9/GUfhCg3
	7QqvUOGNM2zyrA/0ui23WJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=u69sBEBJc8gq4ZtU4r813XMVqYDrQHAPTjL9G+MptjETDW
	96OlMnrsnQHlbT++hL3fZontSKv1FqJG6v6j4i9v68p/squMh+v5w1rsKwjl9qXc
	t2AEBbpaoCjTMu4tpLmuSnZwA7uTmlzK0BSlZ1mmgkK1qTb+AJsM8P9aYCcGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A80AC6663;
	Fri,  9 Dec 2011 15:24:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 310CB6661; Fri,  9 Dec 2011
 15:24:35 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF61C0C4-22A3-11E1-8DDC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186685>

Jakub Narebski <jnareb@gmail.com> writes:

> Well, I think it doesn't have to be true: there can be some options
> like e.g. '-n' / '--dry-run' that are common to all subcommands, and
> in my opinion they could come before subcommand name.

That is just a crazy talk.

If you have three subcommands a, b and c, and only a and b shares -n, c
must learn to reject the option that does not apply. If you have more
subcommands and you need to add an option to one of them, you are forcing
logic to reject that new option to all other subcommands.

That is not a proper way to share option specification. Different
subcommands support different options, and if you want to share some
options among them, you add a new facility to _allow_ them to share _some_
options, while still allowing them to keep their own option specification
table. Otherwise the resulting mess will be unmaintainable.
