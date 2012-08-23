From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] specifying ranges: we did not mean to make ".." an empty
 set
Date: Thu, 23 Aug 2012 10:51:42 -0700
Message-ID: <7vobm14hu9.fsf@alter.siamese.dyndns.org>
References: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
 <20120823082916.GA6963@sigill.intra.peff.net>
 <874nntq0sb.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 23 19:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4bZc-0001nr-CG
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 19:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759003Ab2HWRvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 13:51:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758633Ab2HWRvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 13:51:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 535AC9070;
	Thu, 23 Aug 2012 13:51:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hHQlXBONSnTVxB/Art5yC4K7Ujk=; b=xxPiFp
	qvDcCgD0EBEApi5eafoszuiTrVLcbBqu0KAlr2rhgilkJAqMzMpfzHcmqdGy+KMK
	L1a81CcSKMGRIbrLYGvQrD5/uMUDt4rIndoynJ5W4ckRm8ut7NIKvliYx3qJNxGx
	PCYGd/gOw4uiLaWU0h9aM501peVE3v6Nhwpsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cx2szW3TACExl1HD7+ThmI/9xW9eSiP7
	jALQEzgzNfIP+B4sdHO1hYCtyDqST8j4lC2ljH6gyvsxBjFaHkzQNXf9mX56ITzj
	LTc1LxzpwFMG895M1lvMZi94DjuylBho1E67DRG/2bLSU/Sv1gbn3r21aERoOiu5
	rwzJVOXkXvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4083F906F;
	Thu, 23 Aug 2012 13:51:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF51A906E; Thu, 23 Aug 2012
 13:51:43 -0400 (EDT)
In-Reply-To: <874nntq0sb.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 23 Aug 2012 13:56:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 335364BC-ED4B-11E1-850B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204160>

Thomas Rast <trast@student.ethz.ch> writes:

> I don't think that ".." is really a no-op.  It is true that HEAD..HEAD
> does not itself result in any revisions, but it *could* be used as a
> silly shorthand to introduce ^HEAD into the objects being walked.  This
> can make a difference if it then excludes other objects, too.
>
> I would argue that such use is misguided, and I am in favor of the
> patch, but in theory it is possible.

You could say "log --all .. --" when you mean "log --all ^HEAD",
because .. === HEAD..HEAD === ^HEAD HEAD and HEAD is already
contained in --all.  So it is a valid point.

You however cannot say "log --all .." without double-dash to
disambiguate, as you would get:

    $ git log --all ..
    fatal: ambiguous argument '..': both revision and filename

Any existing practice that used to produce useful results couldn't
have been using ".." without an explicit "--", I think, and with the
disambiguation that favors to take ".." as the parent directory,
"log --all .. --" still means "log --all ^HEAD".

So I think we are still OK.
