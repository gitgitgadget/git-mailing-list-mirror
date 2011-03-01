From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] grep: make --full-tree work with pathspecs
Date: Tue, 01 Mar 2011 11:20:53 -0800
Message-ID: <7v8vwyejfu.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <3719d9a120eef618d875629662a87e715de55d4e.1298972832.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:21:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuV8C-00085H-OV
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110Ab1CATVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:21:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab1CATVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:21:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F0CF32FD;
	Tue,  1 Mar 2011 14:22:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDZ6uGpP2FXMsfUcC34JQcDHetU=; b=E0JrjY
	WqDOc9NPJ/CIKkbgHW5dqSDYgOp3IJN0uWXyoJutYPgRPblsxkePHpcuVd3zPA0+
	xYTTBAKVlXep0Pl4gC+IQmSv47tdm9QQDqdPKAcaCO1gVd5WWKHGSowvzwY13C8c
	O7rV4mH80Tn4mc/ND47bsT72rSRqjhZQhP3rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LcuAuxnEQBJ0IPdaWnzRw0mM6y2TD6/x
	PZYiJk4AZ6kpvs0dXcpM8XT4uOCnBL10xKmPAQwHqHW3pPoRIq5KWYal85eKKKd8
	zGfdOkb0DJZeKHIJdLtUv7iP3durSOR1I8Lk+z39w4/usOg351qeCSoYzodAFPa2
	tBnKI7u9Qo8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D29A132FC;
	Tue,  1 Mar 2011 14:22:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8788C32FA; Tue,  1 Mar 2011
 14:22:15 -0500 (EST)
In-Reply-To: <3719d9a120eef618d875629662a87e715de55d4e.1298972832.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\,  1 Mar 2011 10\:53\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A9BC302-4439-11E0-9F6B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168239>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When --full-tree is given, make the pathspecs be applied relative to the
> root. That way, "git grep --full-tree expr -- *.c" looks in all C files in
> the repo.

This is basically Ok, but I wonder if this has funny interaction with
rev/path disambiguation.  What happens to these two "git grep", and what
should happen?

	cd Documentation
        git grep --full-tree index technical
        git grep --full-tree index Documentation/technical

Once you said --full-tree, "technical" does not refer to Documentation/technical
so the first one should probably say "technical is not a rev and there is
no such path" while the second one should know Documentation/technical/ is
a pathspec, perhaps?
