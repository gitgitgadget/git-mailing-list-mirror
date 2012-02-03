From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Thu, 02 Feb 2012 22:00:37 -0800
Message-ID: <7vr4ycsbga.fsf@alter.siamese.dyndns.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org> <20120202201226.GA1032@thunk.org>
 <7vvcnou40u.fsf@alter.siamese.dyndns.org> <20120203020743.GE1032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 03 07:00:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtCCV-0008If-C7
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 07:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab2BCGAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 01:00:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab2BCGAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 01:00:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6AD277E1;
	Fri,  3 Feb 2012 01:00:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f9Qv19Ov3jLaDtKkiPaO9nWCwoc=; b=tA4gUr
	nnbCbVqy17W26m/jqAWpX3R33Y+MMvc8jbQ63qNGdjqvHCFnS6MT56vn0HZTrk/N
	fA4xGU6FnyFXzc7xKYguJKmbFTyGCG9k9g5ehehGlOK9K9wHJf/4/kVWccOf1Q0/
	9x2yJzbOE+cxEWQuxsTx6BGWK1NIb8s8eeCSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WVD2e+AiHtfIiS13aHcWnYUpLgze4zzr
	XqEgJDmU30Ps0fcxsT5xHIisl88YY+zYsK8SeT5C+d/CaH657LGbBiTY5wmetGZD
	sRdexTKSZ9SaaG8rVNmSYENoNUWrT+UZN2Dmokd3x7j/jj8BovxVGPfpB+2c8Z2C
	7wmrzbNvHEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEF2C77E0;
	Fri,  3 Feb 2012 01:00:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B23677DF; Fri,  3 Feb 2012
 01:00:39 -0500 (EST)
In-Reply-To: <20120203020743.GE1032@thunk.org> (Ted Ts'o's message of "Thu, 2
 Feb 2012 21:07:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65FE0106-4E2C-11E1-BA3C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189739>

Ted Ts'o <tytso@mit.edu> writes:

> What do you think of this?  I'm still running a test build --- "make
> PROFILE=BUILD all" takes quite a long time, so this is still an RFC; I
> figure there will still be some places where people will point out
> more nits to be polished.  :-)
>
> (In particular, I just noticed I left the V=1 for debugging purposes
> in this version....)

Thanks.

Three comments:

 * I am happy that this version handles this well:

   $ make PROFILE=BUILD install

   even though you did not advertise as such in INSTALL ;-).

 * However, I think "clean" target should remove *.gcda unconditionally.

   $ make PROFILE=BUILD install ; make clean ; git clean -n -x | grep gcda

 * Running "make PROFILE=BUILD install" immediately after another one,
   without "make clean" in between, resulted in full rebuild and test
   before the second "install", which somewhat surprised me.  I however do
   not think this is a big show-stopper problem.
