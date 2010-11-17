From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] t3404 (rebase -i): introduce helper to check
 position of HEAD
Date: Wed, 17 Nov 2010 09:55:46 -0800
Message-ID: <7vd3q3g7h9.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino> <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino> <20101031074030.GJ11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 18:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PImEl-0008Pc-13
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 18:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934983Ab0KQRz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 12:55:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934788Ab0KQRz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 12:55:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0B583D47;
	Wed, 17 Nov 2010 12:56:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8oJPZzE5r5oNQX5naNRUA8p6oGs=; b=YpT/HnUPi9H6uCzr6yXqd0m
	7QtTp7rgotCvynhTTbVlfcEodBQforlUYa5MTCTsBGywwELATzYBzloFJ7Imj5y6
	TdUXdhXI3kY33DUW7AqSHv8qYVISsnBoGuSdmSc9x52PsSs9nMhdipBraUftu9pL
	U5UMGXfloUfSYhwGZK5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RJJ7GaDVAoSDkjhusv3f+shYJ3Y0sBspwiDd4Uj8EUFLWWif1
	Ji9D5IkD7ZxAdFKEOTG27/MBXgHa92zCGflOWE/f2DGU+BjQ/qcxtQIAxhpDN0XC
	BSoc+VG0VbYrwMKEv1G6il+An9l9/heBvO0Ec+pYEEygws/SQkZmEFH1cU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3DC13D46;
	Wed, 17 Nov 2010 12:56:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5AB073D3F; Wed, 17 Nov 2010
 12:55:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F134B5DC-F273-11DF-96F7-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161629>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The same code to check the position of HEAD is used by several
> tests in this script.  Factor it out as a function and simplify it.

That rationale makes sense, but why use describe for it, especially if the
helper is called "cmp-rev"?  The tests here are not about catching
breakages in describe.

When we later want to move this helper to test-lib.sh, some potential
callers may find it inconvenient that use of describe robs the ability to
tell annotated tags from bare commits.

> +test_cmp_rev () {
> +	git describe --always --tags "$1" >expect.rev &&
> +	git describe --always --tags "$2" >actual.rev &&
> +	test_cmp expect.rev actual.rev
> +}
