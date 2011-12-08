From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Thu, 08 Dec 2011 10:27:20 -0800
Message-ID: <7vvcpqj4vr.fsf@alter.siamese.dyndns.org>
References: <4EDBF4D5.6030908@pcharlan.com>
 <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EDF1631.5090906@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 19:27:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYigt-0006wi-NU
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 19:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab1LHS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 13:27:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab1LHS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 13:27:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A676B7DBC;
	Thu,  8 Dec 2011 13:27:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JO3pXoOu99WSowpMMB+e9b1Ki60=; b=m+qx9I
	Z4n/gyfK8Yj2aWoYUcZQwJsmc41OZ51sM5ELRb7QFxGUX/GSeP6f/R48Q128/GxH
	7yPS7Xlugca7LEdbUcaggdxP/D52Lsde62erb5uucOpGsU6qFui9b0XrN/cVexyZ
	pVs9Ab/bJkL3Qk2ag1lEn57WfgTdFqyaJgdC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qz0hikYHmRfFTz6fyudzs0qQP+Hht78E
	E1bJ0p5b6mWiUdADP5SSElm9SQAsVjL2oE2or6lyfYAo5PM8DWtIMhRV1LsU109W
	/5fBH2It37mrh89cBkeMYnVwS0Vyb59jokywfOGpNOOeDAcKsP9sdDjuM9Qv6RJh
	F0B+mN9KfO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1097DBB;
	Thu,  8 Dec 2011 13:27:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 310F77DBA; Thu,  8 Dec 2011
 13:27:22 -0500 (EST)
In-Reply-To: <4EDF1631.5090906@pcharlan.com> (Pete Harlan's message of "Tue,
 06 Dec 2011 23:30:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44F9093A-21CA-11E1-80EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186584>

Pete Harlan <pgit@pcharlan.com> writes:

> to "ours" and "theirs".  (The same thing happens in the 3-way merge
> case.)

That is entirely expected. "checkout -m" does not know or care _how_ the
index came to the conflicted state and reproduces the three-way conflicted
state in the file in the working tree solely from the contents of the
index which records only what the common thing looked like (stage #1),
what one side looked like (stage #2) and what the other side looked like
(stage #3) before the mergy operation began, so there is no way for it to
say "the other side came from foo/blah branch". There are even cases where
the conflict originally came not from any branch (think "am -3").
