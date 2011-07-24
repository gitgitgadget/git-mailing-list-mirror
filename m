From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] tests: print failed test numbers at the end of the
 test run
Date: Sun, 24 Jul 2011 00:41:33 -0700
Message-ID: <7vmxg4w2fm.fsf@alter.siamese.dyndns.org>
References: <4E2B1DF2.4000003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 24 09:41:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QktJl-00020X-Dl
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 09:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1GXHlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 03:41:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab1GXHlg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 03:41:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64EC32B57;
	Sun, 24 Jul 2011 03:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KEzfnKJmUtZMmJ3pOc60OwZGnZ8=; b=Brotzk
	C9PMsqmWicAMM98kwJNauD6Z7sbKGe1MWrMThRyi0kSCzt43noTmLcbZ+BUQPrNO
	T/qLTIBeCcPvMIHeUZCpsyyrhhavYKypWLV7dXJ+ZhGRFNa0YZo1lGoIP8WUHui8
	/MmiFnXI9UcjwBjrBJVqt8MKk2WkD4kyrvqkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMu2zJHK12+HrW0NIXzhSIMk4qk/TGQU
	IgwR29shxtxakHhnTIhOx001cEaKZK+HSibeyBCfTA3Oa4ouVMFrcl+i5bQ/pkBg
	XA5I/a/X1P8fhQ5ULqz0fZAJTwgjKEXHZ6XRSx58JY4HjhYG/vafzuh3uYgrbEdG
	isfw2mzxG4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB922B56;
	Sun, 24 Jul 2011 03:41:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DADCB2B55; Sun, 24 Jul 2011
 03:41:34 -0400 (EDT)
In-Reply-To: <4E2B1DF2.4000003@web.de> (Jens Lehmann's message of "Sat, 23
 Jul 2011 21:16:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B2FE746-B5C8-11E0-A86D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177728>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Maybe I'm missing something completely obvious, but I always have a hard
> time finding out which test scripts did fail in a test run with -j30.

I run "ls -d t/trash*" for that ;-)

> +			if test $value != 0; then
> +				testnum=$(echo $file | cut -b 14-18)
> +				failed_tests="$failed_tests $testnum"
> +			fi

Somehow "cut" here feels dirty, as it hardcodes a mysterious offset that
cannot be guessed without knowing what string it is cutting from by
looking at t/Makefile.

	testnum=$(expr "$file" : 'test-results/\(t[0-9]*\)-')
