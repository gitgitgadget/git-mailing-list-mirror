From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision
 <tree-ish> option
Date: Mon, 08 Oct 2012 23:12:05 -0700
Message-ID: <7v4nm4i37u.fsf@alter.siamese.dyndns.org>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
 <7v8vbgi3yz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLT3E-0001Wh-0T
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 08:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab2JIGMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 02:12:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293Ab2JIGMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 02:12:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E0965204;
	Tue,  9 Oct 2012 02:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bAHVCSBRmCiNsyPoyGH7inczWzQ=; b=U+Iw4l
	d4pwTq2V7DNiPyauscnpmyXVKB4crfJerPWuqnhtBFxrAPiwlKDD/joN7cCcPw0I
	tzZLzrw7niCNsGZRfiH1YfKETJbdTLdF6O1BZ8gf5QGR74ZlictTozLoPW3xI4CO
	/wzRqYnUxKhgrVMNjLlCIClSjrbU2XcEZXKF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=im/Z9eiikABJ4VWk2NgvmRdpoWnfVGdH
	qZhMvuKIuBcd8AyG7ii6NaCZpWje4sa+5mv1kjpPyV5K7CmzM/eEdLCBW/rkE+1c
	VRHqf2GcS1HiqAMgKeOl+yzw/CsYSA3pj6QJsL56rMm6aOgkXQwO9r5xbrjUm9My
	inMjUxsGN2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B7975203;
	Tue,  9 Oct 2012 02:12:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ACB25200; Tue,  9 Oct 2012
 02:12:06 -0400 (EDT)
In-Reply-To: <7v8vbgi3yz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 22:55:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4068FF48-11D8-11E2-9AB1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207302>

Junio C Hamano <gitster@pobox.com> writes:

> Assuming that the above guess is correct (which is a huge
> assumption, given the lack of clarity in the description), I think
> the feature might make sense.  The example would have been a lot
> easier to follow if it were something like this:
>
>     $ git submodule foreach --revision v1.0 'git grep -e frotz $sha1'

Imagine you have a checkout of v2.0 of the superproject in your
working tree, and you run "git submodule foreach --revision v1.0".
Further imagine a submodule S that used to exist back when the
superproject was at v1.0 no longer exists in the current codebase
(hence there is no such submodule in the working tree).

Shouldn't the above "foreach ... grep" still try to find 'frotz' in
the submodule S that was bound to v1.0 of the superproject?

Given that your patch does not touch the part of cmd_foreach where
it decides which submodule to descend into, it still will base its
decision solely on the set of submodules that are bound to and have
been "git submodule init"ed in the version of the superproject that
is _currently_ checked out, no?
