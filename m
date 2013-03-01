From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Fri, 01 Mar 2013 12:28:17 -0800
Message-ID: <7vfw0eg90e.fsf@alter.siamese.dyndns.org>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 01 21:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBWaC-0004Vy-8j
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 21:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190Ab3CAU2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 15:28:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab3CAU2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 15:28:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF577A791;
	Fri,  1 Mar 2013 15:28:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZVgm8GWKGET+jKdIUHNXdriM+eI=; b=scvhYI
	E8mMliBdnnAjnMIpWZ09NRDUdFYCi75PL/hHyoQuO5Subvka9xDo65GQKjZxXX8v
	fByrDGs/NHSseLee895Jmcz+shpcOlwtOkUAcy+iSN0hb+2gkpw8Jp8q0p7YVe6i
	2vY16KNcwENvfzyLi7t4a8WWgFfzPidDSNff0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o7K0tMMo9BoFU7sjmlO/YUD9OrHjs2Ip
	X4LUByDsgany7vY8abl9nvHlsjK9ZtOOHJ85GFc+Ss71GIi/MH3Kka8JhQJid8Kn
	5j7NmwTfwC6p07q2BM0qH4Kso/LelFvBZY3hwBsKEran5ahksS+9vSavNonhO+bH
	wVY56QS5sjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4E71A790;
	Fri,  1 Mar 2013 15:28:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B11A78F; Fri,  1 Mar 2013
 15:28:19 -0500 (EST)
In-Reply-To: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 1 Mar 2013 21:06:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DEEF082-82AE-11E2-8303-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217291>

Thomas Rast <trast@student.ethz.ch> writes:

> Before 82dce99 (attr: more matching optimizations from .gitignore,
> 2012-10-15), .gitattributes did not have any special treatment of a
> leading '!'.  The docs, however, always said
>
>   The rules how the pattern matches paths are the same as in
>   `.gitignore` files; see linkgit:gitignore[5].
>
> By those rules, leading '!' means pattern negation.  So 82dce99
> correctly determined that this kind of line makes no sense and should
> be disallowed.
>
> However, users who actually had a rule for files starting with a '!'
> are in a bad position: before 82dce99 '!' matched that literal
> character, so it is conceivable that users have .gitattributes with
> such lines in them.  After 82dce99 the unescaped version was
> disallowed in such a way that git outright refuses to run(!) most
> commands in the presence of such a .gitattributes.  It therefore
> becomes very hard to fix, let alone work with, such repositories.

Fixing the working tree is easy, but when we read from a history
that already records such an entry in an attribute file, it would
become somewhat cumbersome.  I wouldn't use "very hard to fix" to
describe such a case.

But the demotion to warning does make sense; let's do that in
v1.8.1.5.
