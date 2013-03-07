From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of
 string
Date: Thu, 07 Mar 2013 15:59:15 -0800
Message-ID: <7vvc92kbho.fsf@alter.siamese.dyndns.org>
References: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
 <7vobeulw4d.fsf@alter.siamese.dyndns.org>
 <CADgNjakrBCD2jMNUz95E-7FkyKmNgcQeuz8grDWczb-hM6yHhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 00:59:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDkiv-0000MZ-CO
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 00:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759872Ab3CGX7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 18:59:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758814Ab3CGX7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 18:59:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5FA3B1B7;
	Thu,  7 Mar 2013 18:59:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8UwEKHImc2q+W+a80kI3c7V3TBw=; b=PQh9ZvVl4SzeWxjCjiIF
	1Yn9R2AqXQdbDHetYpAmf/Xb9ILJJ9tlrcWHUJaj+fv6jXiMbEpi6282vSsZMI+c
	zbTGqf3CERFg6rQ5bk/o9IsMOPTLK7MzRcqGLt1k5B1VlFgtc44mWUIK3RxySaHb
	nav7qaU1ULKhN5tpkrjmreo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KjUp+EEIGOKDW3DFxsArDOraA6XZi+a7lOqYTY8WZ8s9Tu
	7mFZI8upc9ppYk2ATxQPzQFjF1T2xmcKAEenL5jebc0+ufoRLsNi1hdE49Ct9mYP
	kL2BPowxT1oEqTj2+V6OEXWiMZ+vHkxY8spEmFLlYrGoBbR120fjzyGeMbnX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A901BB1B6;
	Thu,  7 Mar 2013 18:59:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B71AB1B5; Thu,  7 Mar 2013
 18:59:17 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05236A24-8783-11E2-8929-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217632>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On 3/7/13, Junio C Hamano <gitster@pobox.com> wrote:
>> The parser that goes past the end of the string may be a bug worth
>> fixing, but is this patch sufficient to diagnose such an input as an
>> error?
>
> Yea, the patch should fix the passing end of string too. The parser
> was going past end of string because the nextat is set to "copyfrom +
> len + 1" for the '\0' case too. Then "+ 1" causes the parser to go
> pass end of string. If we handle the '\0' case separately, then the
> parser ends properly, and shouldn't be able to go pass the end of
> string.

This did not error out for me, though.

    $ cd t && git ls-files ":(top"
