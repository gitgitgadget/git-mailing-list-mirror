From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: replace 'vi' for 'editor' to reflect
 build-time option
Date: Fri, 30 Mar 2012 09:46:50 -0700
Message-ID: <7viphmm3yd.fsf@alter.siamese.dyndns.org>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino> <7v398qq1ei.fsf@alter.siamese.dyndns.org>
 <20120330103326.272B040A067@cobalt.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	666250@bugs.debian.org, git@vger.kernel.org
To: Rodrigo Silva <linux@rodrigosilva.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeyc-0008HU-7Y
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab2C3Qq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:46:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab2C3Qq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:46:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD21B5B08;
	Fri, 30 Mar 2012 12:46:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AVtlnRgSdnUkqwrUUFbJfKEAQ7Q=; b=XsQDOH
	i6sgLUkmr7vO0mh9GxpV7eiW8i6EKq7luDtfy6cq4yp3BcFZli6i30LjbHhsIXvC
	Q1O3KNqtkC0t1bjg5ZfvKwdi8rdMA1RPpq9jUD5m/z2YUqxF9Wj/eOtO684+Ld9P
	Ny2zTN4szD04zK9JWIFrtOOwuLis/AzfgARsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZyf9CdHG304g49uRA4WuX76osMkVD6y
	2AHR0kgBgGKkH9wyMZcZj8iPC7wgBLCAHEuH54rprJ+SS2E8mQj6MyMAVW209l73
	aZ8ioe+401QLELd4KpkSVlTRg/wjUKtFgz79ttOgvvyldD8zbKnTE/fX0y+Y66V2
	/WePTiFAoFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B92785B04;
	Fri, 30 Mar 2012 12:46:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2769F5B01; Fri, 30 Mar 2012
 12:46:54 -0400 (EDT)
In-Reply-To: <20120330103326.272B040A067@cobalt.pobox.com> (Rodrigo Silva's
 message of "Fri, 30 Mar 2012 07:33:21 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4A954D2-7A87-11E1-A75D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194380>

Rodrigo Silva <linux@rodrigosilva.com> writes:

> At 23:16 29/3/2012, Junio C Hamano wrote:
> ...
>>I've already rejected this patch once, but that was primarily because the
>>patch was not justified with the above "I read everybody else's git uses
>>'vi' on the Interweb, and even though my distro's manual page says it uses
>>'nano', I didn't bother to read it." scenario.
>
> @Jonathan: I'm really sorry for this confusion...
> ... Junio suggested me to send this patch to
> Debian, that's why I filled the bug in Debian BTS. It was meant to be a
> Debian-only patch.

It is a Debian package bug that the git_*.diff patch they use to customize
the upstream source ends up making a resulting binary to use different
editor and pager but does so without editing Documentation/ files to match
the description to what their executable does.  The resulting package is
not self consistent.

But we aren't making it particularly easy for Debian to do so.

The debian/rules (the Makefile that invokes our Makefile) file in the
git_*.diff patch merely overrides DEFAULT_EDITOR and DEFAULT_PAGER,
instead of patching editor.c and pager.c to replace the fallback hardcoded
defaults "vi" and "less".  But these Makefile variables only affect that
goes in the executable, and they do not affect the documentation.

So in the shorter term, I think Jonathan's patch would be OK for me to
carry in my tree, but even in that case I think Debian still needs to
replace the "vi/less" in the documentation to tell what they chosen for
their users.

In the longer term, it may make more sense to let these Makefile variables
replace "vi" and "less" with whatever values set to them, while keeping
the "default chosen at the build time, usually" wording.

In any case, I'd appreciate it if either of you can turn Jonathan's "How
about something like this?" into the final version to be fed to "git am".

Thanks.
