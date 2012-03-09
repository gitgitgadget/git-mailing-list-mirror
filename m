From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rerere.autoupdate that wouldn't
Date: Fri, 09 Mar 2012 14:46:30 -0800
Message-ID: <7vd38l4cl5.fsf@alter.siamese.dyndns.org>
References: <4F5A8580.1010807@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68aE-0001dH-SV
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900Ab2CIWqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:46:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964830Ab2CIWqc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:46:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 277BC7448;
	Fri,  9 Mar 2012 17:46:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XIEfnIycGEuQstrWT89GE9D6rpo=; b=yW9hUG
	FEKwsXV81uO0VLPVqV99w55oCe/7GHq0CCYu4+W4HT/I8+SdR8zkOUBIgrbbinuS
	MKub2E44cnzJWvAcMQ7Tz9Hi+tlRQoEeGVzkr0sDHj+qDf9WcgpZc7MFEpYBZYpm
	USCqpWrl/uJSQNdAQbHWPHFovQFDEzGLm8f+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FpMmApsIVSWDVXDHzEfeahAX8PT/MtYn
	QX0FEDXbecs2PBRCH8NeO3/g4S7epUzGtnxu48QAjXH9zIMNKyGUzEWzGtkUbEy2
	IG/MxlBgQCvzH+Yx32yRet8bTVBu7mNaaHlIzk4agICdVdhuAMZ/SBreOVYQcVAL
	v60YxbtJc1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E0457447;
	Fri,  9 Mar 2012 17:46:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A91AA7444; Fri,  9 Mar 2012
 17:46:31 -0500 (EST)
In-Reply-To: <4F5A8580.1010807@cisco.com> (Phil Hord's message of "Fri, 09
 Mar 2012 17:34:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B73247E8-6A39-11E1-AC7B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192751>

Phil Hord <hordp@cisco.com> writes:

> Is this what is supposed to happen?  Should I look into adding
> 'rerere.autoContinue=true'?

"Yes", and "Perhaps, but there may be a better alternative".

Whatever rerere did, "git merge", "git am", and friends should
report the fact that the result is not just a trivial conflict-free
merge, so that the user can take an appropriate action.  Otherwise
you will be robbing the last chance to eyeball the result from
people who have been using rerere.autoupdate=true and doing so
before committing.

And a better alternative to make "rerere.autoupdate" stronger may be
to make the variable tri-valued, instead of adding a new variable
that does not make any sense when rerere.autoupdate is not set.
