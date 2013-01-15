From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix a portability issue with git-cvsimport
Date: Tue, 15 Jan 2013 15:43:34 -0800
Message-ID: <7vobgq107t.fsf@alter.siamese.dyndns.org>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvGAl-0006ZX-5e
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033Ab3AOXni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:43:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932541Ab3AOXnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:43:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3447CB9F9;
	Tue, 15 Jan 2013 18:43:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvXdZb0lBOs4T53TJBicFyWbFyw=; b=kErBsr
	J1HtadBkxzWdrVsYH9USjF+boopZiQQFthQNim4+IYAthiuXBVGDbn3PFzrc/hi4
	zumYGY+pF/ifHZ7/u/8AHOH8c+lWjwmYGmcZiHT5qhiV7d/nH8wO+0rG6bp7A/Mj
	LG7GWu1gyrF+x6zunfMaZjqzrWZI7+nHvnV1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HsqenLJS6QC1SfV0t4IayFYK3Ph8zU3i
	47uciKqo2FuD4oxTdNHm014bF7K8mnZNwYAKYisLLiadzWI4XFmWkxIBscVItx9X
	jqWbNmDPWHLmhOBINM2z+N5u/TwtUWDxToRCOsaofPsVPYP0XiWuOiifGoL9YQ1u
	E67rCYwAzMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28AE4B9F8;
	Tue, 15 Jan 2013 18:43:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D99AB9F4; Tue, 15 Jan 2013
 18:43:35 -0500 (EST)
In-Reply-To: <1358291405-10173-1-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Tue, 15 Jan 2013 23:10:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60DF98DA-5F6D-11E2-AF34-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213691>

Ben Walton <bdwalton@gmail.com> writes:

> This patch series started as a quick fix for the use of %s and %z in
> git-cvsimport but grew slightly when I realized that the get_tz
> (get_tz_offset after this series) function used by Git::SVN didn't
> properly handle DST boundary conditions.
>
> I realize that Eric Raymond is working to deprecate the current
> iteration of git-cvsimport so this series may be only partially
> worthwhile.  (If the cvsps 2 vs 3 issue does require a fallback
> git-cvsimport script then maybe the whole series is still valid?)

There is my reroll of Eric's patch [*1*], that is in 'pu'. The topic
ends at 12b3541 (t9600: adjust for new cvsimport, 2013-01-13).

I think the folks on the traditional Git side prefer the approach
taken by it to keep the old one under cvsimport-2 while adding
Eric's as cvsimport-3 and have a separate version switcher wrapper
[*2*, *3*].  Also Chris Rorvick, a contributor to cvsps-3 & new
cvsimport combo, who already has patches to Eric's version, agrees
that it is a foundation we can build on together [*4*].

Eric hasn't spoken on the topic yet, but I think what the rest of us
agreed may be a reasonable starting point.

I think I can apply your patches on top of 12b3541 with "am -3" and
have it automatically update git-cvsimport-2.perl ;-)


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/213170/focus=213460
*2* http://thread.gmane.org/gmane.comp.version-control.git/213170/focus=213432
*3* http://thread.gmane.org/gmane.comp.version-control.git/213170/focus=213466
*4* http://thread.gmane.org/gmane.comp.version-control.git/213537/focus=213595
