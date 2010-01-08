From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 08:38:39 -0800
Message-ID: <7vr5q05z74.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:39:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHrd-0002gB-DS
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab0AHQi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953Ab0AHQi5
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:38:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab0AHQiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:38:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9848F566;
	Fri,  8 Jan 2010 11:38:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/uEPaEXmrWtk15iPBbIyVdoVs3M=; b=URLFRf
	7t7z+pkDP6x+Pv7wcSb9n0x4BoDuirvFiOKoLTjh1SiIFodXHAwr7kDkarnQIB5O
	P+bchRlMnsyG6ghfYYkaU7lxNMrlDkOPZnLQzuQlUpOb298V3kcB2ECUr8ufo6fo
	xikbjJvEONMA4RHVO2q6VYs5RrbeD0j69wiWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvKG58d9hXXPyxFm9LK2V3oT6VyZYGh6
	T+KUI7iORru/fSN1rEtOSXnCdDe0xP8PFTJxrrGsiPitZIen2U7IibLnJs0e5Jre
	+KwtGNjNKhfhXuD+U12Shtt/ljEIq/+WwTIla76jkXKYt9/isH26H+Tuyi9e31re
	DZ9oFP/EFBM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 784A28F55C;
	Fri,  8 Jan 2010 11:38:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 884DB8F556; Fri,  8 Jan
 2010 11:38:40 -0500 (EST)
In-Reply-To: <20100108162404.GA5799@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 8 Jan 2010 11\:24\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4A88FD9C-FC74-11DE-B330-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136455>

Jeff King <peff@peff.net> writes:

> Try this:
>
>   git init
>   touch base-cruft
>   mkdir subdir
>   touch subdir/cruft
>   echo subdir >.gitignore
>   git status ;# shows gitignore and base-cruft
>   git ls-files -o --exclude-standard ;# ditto
>   cd subdir
>   git status . ;# shows nothing, since everything in subdir is ignored
>   git ls-files -o --exclude-standard ;# BUG: shows cruft
>
> Yes, ls-files operates in the subdirectory, which means it should not
> show cruft from the root (and it does not). But it should respect
> .gitignore directives going all the way back to the root, and it
> doesn't.

Shouldn't the ls-files be run from the root with subdir/ as pathspec, if
you wanted to do apples-to-apples comparison between it and status?
