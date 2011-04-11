From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git diff --quiet" handling.
Date: Mon, 11 Apr 2011 14:35:01 -0700
Message-ID: <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
References: <4DA36D95.6060108@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9OlV-0005WX-8f
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab1DKVfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:35:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1DKVfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:35:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8A014B2B;
	Mon, 11 Apr 2011 17:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UOjp3ko5BMWm7I7T1j8wV3xledo=; b=I6ys8i
	Uw0I168+jnVGTSnGKrOluilXJBkXttPXOsu9br/LQocpid0Ww8Uzvo54Ml1K1Evj
	Jm3JLQTTueTBUjQ+Edbz0F01gFFJIlfqGzruxHmvtAER/1L0K6zySXNemUIz2u0w
	6keVgFdfW4KHZesdFf84fIJ9Awq1tiawifRIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T2gHo4/1I5KiRpMKAa7rJJu59iX8/hr6
	G2RF3/vjzvSnjoVD4D5pMSXbm08BBmuWbnubRFNiznAekcJMpNc43kOcsnoO410V
	FLIhO3BnN/dUsLbhHAGuVlpGodzFG5sWCnFC5JNhqY/6Mnbe7H4u//NRWBpYitws
	luMuaHAAgN8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9236F4B2A;
	Mon, 11 Apr 2011 17:37:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9C8604B1F; Mon, 11 Apr 2011
 17:37:01 -0400 (EDT)
In-Reply-To: <4DA36D95.6060108@windriver.com> (Paul Gortmaker's message of
 "Mon, 11 Apr 2011 17:07:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7CDDFB0-6483-11E0-8845-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171358>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> I'm assuming this is a bug,...

Yeah, it sounds like you found an interesting one.

As far as I know, whatever "format-patch" does in response to "--quiet"
option is not a deliberate and designed behaviour, as squelching the patch
output in the context of the command does not make much sense [*1*]; the
current implementation simply writes anything off as an user error when
"format-patch --quiet" did anything "interesting" ;-).

A patch to make --quiet not to squelch the patch output, and instead
silence any progress output would be a good addition.

Thanks.

[Footnote]

*1* Also note that at least in the original design, the standard output
from "format-patch" was never meant to be squelched.  It was the only way
the calling scripts (and humans) can learn under what filenames the
patches were output, so that the command line to fire them off as e-mails
can be programatically formed without running "ls" and filtering non-patch
files manually (if you use "format-patch -o newdir" and newdir did not
have anythning in it before running the command, of course you can rely on
the output from "ls").
