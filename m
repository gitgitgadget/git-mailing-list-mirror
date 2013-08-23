From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] fix t3010 failure when core.ignorecase=true
Date: Fri, 23 Aug 2013 14:00:06 -0700
Message-ID: <xmqqob8onmw9.fsf@gitster.dls.corp.google.com>
References: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 23:00:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCySv-0003jJ-In
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 23:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab3HWVAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 17:00:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756017Ab3HWVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 17:00:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF01A3BF2D;
	Fri, 23 Aug 2013 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C8G6FwF3Jh2uC9hnQPHUkdR7MI8=; b=N+CRcF
	Wc++mxcOHJJC3H1xCOuYB0cAeaJDPiTmzwQ8B2piM6R2Gjv0CzbM7Yu3fT6xT2DS
	Mw/7zvBmK62e+1rDdA64b9XKvdT4LWEvDpjhZcDjFJL7dQPWRDweurwOeGbNAb00
	Gu+ZXP9/G3uyvWbcrsrP0LWPt8ctjEP8pnRQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TFxn/8EQnz+uuVXWS/uU1XyvTXOvU1zw
	153uatWmy4LFUEG2VAVwMx9QU+MLIIyKpYKssAIgVogSZK6IPHM+aN6dXYQ0ngjM
	VmclkiKqTuBBSgu72cSZ1Z82dEhsqOedkIYtDZScD+xPBk5WLut2CtKoEuF81Ri7
	obI7JfmuXFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E41D43BF2C;
	Fri, 23 Aug 2013 21:00:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59A463BF29;
	Fri, 23 Aug 2013 21:00:09 +0000 (UTC)
In-Reply-To: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 23 Aug 2013 16:29:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FECB92EE-0C36-11E3-8B6B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232837>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Recent mailing list discussion [2][3] suggests that changes at a more
> fundamental level (if they pan out) would be a more appropriate approach
> to resolving this bug.  Such an approach would (happily) make patch 2/2
> unnecessary, however, I'm posting this series for posterity since it was
> already written before [2][3].

Fair enough.

In the meantime, given the reaction from Peff, I am tempted to
squash your "work around in the caller side" as a fix to 2eac2a4c
(ls-files -k: a directory only can be killed if the index has a
non-directory, 2013-08-15) and squash in the patch to run "ls-files
-k" with "-c core.ignorecase=true" to 3c568751 (t3010: update to
demonstrate "ls-files -k" optimization pitfalls, 2013-08-15). That
way, the eventual fix of not adding '/' at the end do not have to
revert the changes to the caller, and the tests added to t3010 by
the latter will be "optimization pitfalls" as before.

Thanks.
