From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Mon, 17 Oct 2011 23:34:22 -0700
Message-ID: <7vhb36iz9t.fsf@alter.siamese.dyndns.org>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
 <20111013155923.GA13134@sigill.intra.peff.net>
 <7vbotk6aae.fsf@alter.siamese.dyndns.org>
 <20111013183709.GB17573@sigill.intra.peff.net>
 <7v62js4sop.fsf@alter.siamese.dyndns.org>
 <20111013191457.GA18460@sigill.intra.peff.net>
 <20111013194432.GA20082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 08:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG3Fu-0005fb-TD
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 08:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab1JRGe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 02:34:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab1JRGeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 02:34:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB8CB2EE6;
	Tue, 18 Oct 2011 02:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6qS3qProXQM7mOQ/BQsOtdSzcOc=; b=voaVsU
	MfBDTR6mmKoI2dQ+7qGeSTZEeMA8DP0q836TLQlEPjJ11cNz8Y3TjqQ9Hxy/TkoZ
	ly54/0o8ZwNzQQxjk08GAXr477yPRvh4KE7lQSFdz42s6ZIXD4ZtL2N77z95sDxe
	ChiEyF6c3vzXJxRFySag85mh2gCX1WOIvtrlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbdnouPle05lMrc0XCIb2e6AZWdGkRzX
	x1lCrPBiJ1PESToEazu5CzWIxsJX+sbi7z1N0Gg4Su8RCUoeFsd29TTsTc1bHNG5
	/qMvD9DauvC7IPWmNdYiIUGA7ahI3fSP9nJHDPdjsAI33If65Z+iYtsVMZLvSeWn
	D/II0r72U84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E34322EE5;
	Tue, 18 Oct 2011 02:34:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DDD62EE4; Tue, 18 Oct 2011
 02:34:24 -0400 (EDT)
In-Reply-To: <20111013194432.GA20082@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Oct 2011 15:44:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 384D2DFA-F953-11E0-921F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183862>

Jeff King <peff@peff.net> writes:

>>   $ mkdir .git/tmp
>>   $ cd .git/tmp
>>   $ git rebase
>>   fatal: fatal: /home/peff/local/git/private/libexec/git-core/git-rebase
>>   cannot be used without a working tree.
>> 
>> So that case is already broken. The only change this would make is that
>> what used to fail would not actually take them to the top-level of the
>> working tree[1].
>
> Ugh. It does work if you do:
>
>   mkdir .git/tmp
>   cd .git/tmp
>   GIT_DIR=$PWD/.. git rebase

Actually, this one is OK. Presense of GIT_DIR combined with the lack of
GIT_WORK_TREE means that .git/tmp must be the top of the working tree, so
it is the script's responsibility to populate the directory with what
matches to $GIT_DIR/index between "mkdir" and "rebase" in the above
sequence.

So I suspect we won't have to worry about this case either.
