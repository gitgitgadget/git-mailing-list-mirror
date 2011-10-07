From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 07 Oct 2011 13:59:43 -0700
Message-ID: <7vobxstt4w.fsf@alter.siamese.dyndns.org>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
 <4E8EBDA7.2040007@drmicha.warpmail.net>
 <20111007091636.GA22822@elie.hsd1.il.comcast.net>
 <4E8ECA25.205@drmicha.warpmail.net>
 <20111007100646.GA23193@elie.hsd1.il.comcast.net>
 <4E8EED39.1060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCHWU-0000E9-Be
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 23:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab1JGU7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:59:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab1JGU7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 16:59:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA1A55FCD;
	Fri,  7 Oct 2011 16:59:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Ae+WTdW6UpatlBioPRmjmIP09o=; b=Qbedni
	R6UcXiUkxioJ4b2mo/DBjgQGf8aLSJfNzm0inGS7IcwmO9Q8XcP1XTil1jBaivlL
	eLPUGxvsmHlR3yRkC87RGpTRysHwclHKknBM3LCparx+h+qb+M5Q84lzDcAFwy8/
	vFaqoF64JuZtlmW4lUTeRZCGUg09+W0bEIeng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XrPl5QYBgnmvESFWe/xzHgjeTkIW2bQU
	1ZYkkbEHGob7KX/FfNG8NHUsctaVmM3eFJazn/KoaqeXtkuvfaioVEe/KfbkLpTY
	p7mu2BBU/wc1DwrzG1Cxn9CTnD7CuY/kGyUvCk3UI6lxXgbTGmBtT3IqPBp5CspF
	YeKm1HO/qcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E17785FCC;
	Fri,  7 Oct 2011 16:59:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649CF5FCA; Fri,  7 Oct 2011
 16:59:45 -0400 (EDT)
In-Reply-To: <4E8EED39.1060607@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 07 Oct 2011 14:14:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 492426F8-F127-11E0-BD7B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183110>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Alternatively, one could store the description in a blob and refer to
> that directly, of course. I.e., have
>
> refs/description/foo
>
> point to a blob whose content is the description of the ref
>
> ref/foo
>
> That would be unversioned, and one could decide more easily which
> descriptions to share. (A notes tree you either push or don't.)

If refs/descriptions/foo were to point at a commit object and its commit
log message is used to store the description you could make it versioned.

A history that records forest of descriptions where its commit contains a
tree whose leaves are branch names is slightly better than notes based
approach in that it does not have to violate "notes are for objects"
design principle, but it shares the same "branch names are local" issue as
your "lone refs/description/foo describes 'foo' and 'foo' only".

In addition, it shares with the notes based approach that exchanging a
description on a single branch will inevitably pull in descriptions of all
the other branches you happen to have in the forest, which was one of the
reasons that recording "push -s" certificates in notes tree failed whether
the v2 or v3 approach was used.

You should be able to make a few changes to jc/request-pull-show-head-4 to
move the description to such a "refs/desc/$name" from completely local
"branch.$name.description". The machinery to edit the description is
localized to edit_branch_description() introduced in b7200e8 (branch:
teach --edit-description option, 2011-09-20), and the machinery to read
the description is localized to read_branch_desc() in 6f9a332 (branch: add
read_branch_desc() helper function, 2011-09-21); the remainder of the
series could be used unmodified.

But it remains that any of these approaches assume branch names are
universal. Unlike other systems, what we call branches do not have their
own identity, so if you really want to go that route (and we _might_ need
to in the longer term, but I am not convinced at this point yet), you
would first need to define how that local namespace would look like, how
people interact with it, etc. It might be just the matter of declaring a
convention e.g. "Among people who meet at this central repository,
everybody must map the branches identically to their local branch
namespace, and all sharing must go through the central repository", and
calling a tuple <central repository URL, branch name in that repository>
with a name that cannot be confused with "branch" (so "remote branch" is
out), such as "(development) track".
