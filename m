From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 01/11] grep: teach --debug option to dump the parse
 tree
Date: Fri, 14 Sep 2012 10:09:22 -0700
Message-ID: <7vr4q45y65.fsf@alter.siamese.dyndns.org>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
 <eb5e7055691692e8a60adf8edbb3b8d2aab9d02b.1347615361.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:09:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZOY-0002rF-U9
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab2INRJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:09:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2INRJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:09:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1648892B;
	Fri, 14 Sep 2012 13:09:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIPUTToSYdwVNHB8X5FTymYSs9k=; b=BTpsZ4
	zhx2hcC2SeJ4fwpyPTzKOmfXZn4vnDD1d/e50uqFqQlZ2JcHZgQUuadusYsV2j4u
	NMI1cNowHH22lcAHDtuqk11r3DkCVWPVPmpOnwaYck3EZZmq5/JmMJ1rUmKLE7vb
	LCOaMbF6Ub7PIjuGEjsrTWP8vQp1vjKmxIGrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJmOcWsdJUZ1fo3QGUQryKPK6TxF1sOo
	nUZx2RLwqdzTwVYLJkdUBsQqfI8ty+EoOwutConUnxniJ+7+kRbw8GWYXKd5IQ0U
	+Ta8CzAA+B3PdzIraewoY//GB1Cv1cr3NDK9PDyX1ScEvB29kjk95O406MnEL5zo
	DSD11b3HtSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE815892A;
	Fri, 14 Sep 2012 13:09:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2A158929; Fri, 14 Sep 2012
 13:09:23 -0400 (EDT)
In-Reply-To: <eb5e7055691692e8a60adf8edbb3b8d2aab9d02b.1347615361.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 14 Sep 2012 11:46:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE8AA3AE-FE8E-11E1-8CF3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205505>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Our "grep" allows complex boolean expressions to be formed to match
> each individual line with operators like --and, '(', ')' and --not.
> Introduce the "--debug" option to show the parse tree to help people
> who want to debug and enhance it.
>
> Also "log" learns "--debug-grep" option to do the same.  The command

This was actually a leftover incorrect message.

When we introduce the equivalent of

    $ git grep -e foo --and --not \( -e bar -e baz \)

to the log family in some distant future, we may end up having to
disambiguate the "--not" (which means something completely different
for the log family) meant for the grep part by doing

    $ git log --grep=foo --grep-and --grep-not \
    	--grep-\( --grep=bar --grep=baz --grep-\)

or something like that, and the code says --grep-debug because that
would fit better than --debug-grep.

Other than that, the patch looks good ;-)
