From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [RFC 1/1] Add new indent-with-tab whitespace check
Date: Thu, 01 Apr 2010 12:02:11 -0700
Message-ID: <7voci3ov2k.fsf@alter.siamese.dyndns.org>
References: <1269698881-26443-1-git-send-email-chris@arachsys.com>
 <1269698881-26443-2-git-send-email-chris@arachsys.com>
 <7vwrwstq8r.fsf@alter.siamese.dyndns.org>
 <7vsk7fovjx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 21:03:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxPes-0007EP-DX
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 21:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab0DATCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 15:02:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab0DATCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 15:02:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80A3AA6E61;
	Thu,  1 Apr 2010 15:02:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oLBKc0jyNyxTNMDrJbFOUqCY8m4=; b=x5ad+t
	jJBCsxmfSYLgxqII0rl2NrCIXRk6yQhSzqRZvUTE/WJyV6NutERN3+51nqzL+bwi
	0dn9HOaJdZQN1gpk2vdQ3v8iMI732lxrTToProjIELB7MUe7AcRsq0PlPNyJHMl+
	bDBSL15ADqiw1K4BHsWlmGDNRYKRYCPiBJgYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YPSHzfapM1pJDjHpC4FH0HRNUjkXSgmZ
	EqyXfnAaLW17X54MfFdk+FQLhATLrp2cPH2rRXNWwRVkY0WViKEkCrr04W8ecSAc
	cH+SqSIVARPmqVeekLXmn2kfIfL45dEBqJsRY8UGGGSg8YnDHhuYF3JAnKbBYap5
	e9KBpJwYLyg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 489A4A6E5F;
	Thu,  1 Apr 2010 15:02:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C897A6E55; Thu,  1 Apr
 2010 15:02:12 -0400 (EDT)
In-Reply-To: <7vsk7fovjx.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 01 Apr 2010 11\:51\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16043562-3DC1-11DF-A647-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143741>

Junio C Hamano <gitster@pobox.com> writes:

I need to make some clarification, as the following is misleading.  This
clarification fortunately does not have to change the patch I sent
earlier.

> There is another issue with this change.  Because "whitespace" without any
> string in .gitattributes are defined to cause all the whitespace breakages
> known to git to be caught, and tab-in-indent is inherently incompatible
> with indent-with-non-tab, this cannot be supported without changing the
> definition of "default set of whitespace breakage classes".

I said "default" but that is totally incorrect.  We catch "trailing-space"
and "space-before-tab" by default (i.e. the user does not have any custom
"whitespace" attribute), and that will not change.

> The intention of allowing .gitattributes to say "*.txt whitespace" is to
> let the users and projects say:
>
>     I trust the competence and good judgement made by git developers
>     regarding whitespace issues.  They may devise a new algorithm to catch
>     common whitespace errors that the current tool may not catch, and when
>     that happens, I'd like my project to take advantage of the new code
>     and catch the newly defined classes of errors.
>
> and that is why we include all whitespace-rule except for the ones that
> loosens error conditions to the set of breakages we catch for such a
> specification.

A corollary to the above clarification on "default" is that people who do
not trust us but want to rely on the traditional "Only trailing-space and
space-before-tab, nothing else" need to do _nothing_.  If they do not have
"whitespace" attribute defined for paths, the default is honored.  People
who want to catch the set of maximal whitespace breakage classes that is
internally consistent are the only ones that already have entries like
"*.txt whitespace" in their attributes file, and we keep our promises to
them.  If we take the "all errors known to git" too literally to include
incompatible rules in them, the end result would become useless to them,
and that is what the earlier update fixes.
