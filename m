From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 11:50:59 -0700
Message-ID: <7va9p7sfl8.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
 <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
 <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPddN-0000en-8C
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935016Ab3DISvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:51:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760979Ab3DISvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:51:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E32015199;
	Tue,  9 Apr 2013 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yFm5qjG51ulrPhXekK78rQgXEnA=; b=cTEu+3
	ENgnKML/LuJhRTlFnUkD7m2vchuzNdmSw2ZS4eBO48i5+TVoTnOB0RncfWmiDI5J
	pdrOXvmmN3oe6/iAWKszhzKxmOfY8qFi2ywVK70A93HjpggS0v4zy/kif4vCimnX
	+o/pYrJexfC0Em8MpauOo3ilHPmN/rROFEleo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P0gSsLZ+Fi/ISYmjDhtVy1+F3s+E+v/j
	I0P+kZVYqD+wES9g9Hm8x1axBfO2uzv9W99bB6yBpL4woUy/fHMCrKUcixE/V1hi
	+y9WPSvz5wevUrlWncHZDxS+mLdhye+T6hUJnUxqyaS2orl7ls8nyOrmo8sHcrEF
	fUy2BtJ+O5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEC4D15198;
	Tue,  9 Apr 2013 18:51:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E6F715197; Tue,  9 Apr
 2013 18:51:01 +0000 (UTC)
In-Reply-To: <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 23:47:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C61F2C8-A146-11E2-8EA1-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220613>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The reader is now wondering what this could possibly be, and why you
> didn't send this patch earlier. 

Because it wasn't written back then?

> Perhaps clarify with: s/there are
> cases/there may be cases/ and append "One such case that we currently
> don't handle yet is a path inside another git repository in our
> worktree, as demonstrated by test tXXXX.X."

I think "we currently don't handle" is a misstatement.  It is not a
bug that we don't.
