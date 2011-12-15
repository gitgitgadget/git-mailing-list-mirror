From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Gitweb: Avoid warnings when a repo does not have a valid
 HEAD
Date: Thu, 15 Dec 2011 14:28:19 -0800
Message-ID: <7vty51lbb0.fsf@alter.siamese.dyndns.org>
References: <1323982737-19065-1-git-send-email-jratt0@gmail.com>
 <7v62hhmr2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJnB-0005Iw-Cl
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759618Ab1LOW2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:28:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756395Ab1LOW2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 17:28:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C8B2764F;
	Thu, 15 Dec 2011 17:28:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWxTLbE9dPHj7xrdWQE+ub9a9lA=; b=BEUIr7
	O5miTFt87uVntpUkY6eVF5a4FtT8/abrht+rCdmCZQa+WoT63ycS2qLnQZEDYk8+
	qkwJJHK/ejamu7Zz6WusnBoptSCnLPAGYaAATtqsccU0M2jXjyNO0t2ZsHmwUT2I
	5WgVEyFhBoR1t2urIB54BknoZtBt/K3nTKDYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYUSyzy781e6KoB1SaeEBgNFX1V+kEit
	u1BJ4ulFDlR+CTcuJqKIuHiyJg2hTg4bQ7JuDxq5YJFOqbApOsCvAhyWpYJ6sMFU
	eieTlYeJOZCyjLJeiTXnrKo9decTe62qaOI8ozOY38ppQmguugKNZ1MLU5BCfMso
	swijWSd/tDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 514A7764E;
	Thu, 15 Dec 2011 17:28:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8CE2764D; Thu, 15 Dec 2011
 17:28:20 -0500 (EST)
In-Reply-To: <7v62hhmr2s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Dec 2011 14:02:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17CC3480-276C-11E1-AC63-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187249>

Junio C Hamano <gitster@pobox.com> writes:

> Joe Ratterman <jratt0@gmail.com> writes:
>
>> It is possible that the HEAD reference does not point to an existing
>> branch.  When viewing such a repository in gitweb, a message like this
>> one was sent to the error log:
>>
>>   gitweb.cgi: Use of uninitialized value in string eq at /usr/src/git/gitweb/gitweb.cgi line 5115.
>>
> ..., but in that case a repository with
> a HEAD that points at an unborn branch _and_ have other refs that do point
> at existing commit is already screwed-up, so if we want to be extremely
> pedantic then perhaps ...
>
>     my $curr = ((defined $head && exists $ref{"id"} && defined $ref{"id"})
> 		? ($ref{"id"} eq $head)
>                 : 0);

Just in case, I was not suggesting to update the patch to look like the
above by "if we want to be extremely pedantic".

After all, that error message in the log may be a good thing that notifies
the site administrators about a suspicious repository so that it can be
fixed (even though it was not a designed "feature" but something that
happens to work).
