From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin-branch: use strbuf in rename_branch()
Date: Tue, 18 Nov 2008 15:57:17 -0800
Message-ID: <7vbpwcvb8i.fsf@gitster.siamese.dyndns.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
 <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org> <5dee4e908190e7a4ed4a693fdf0fb3b3af88fc57.1226954771.git.vmiklos@frugalware.org> <225d83c1ead50340eed97c64fbb8995017bf1ca8.1226954771.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 00:59:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2aT8-0002rj-Ul
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 00:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYKRX5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 18:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYKRX5j
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 18:57:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbYKRX5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 18:57:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A3C27FE4E;
	Tue, 18 Nov 2008 18:57:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F26137FE3E; Tue,
 18 Nov 2008 18:57:24 -0500 (EST)
In-Reply-To: <225d83c1ead50340eed97c64fbb8995017bf1ca8.1226954771.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Mon, 17 Nov 2008 21:48:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD21014C-B5CC-11DD-AD30-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101294>

Miklos Vajna <vmiklos@frugalware.org> writes:

> In case the length of branch name is greather then PATH_MAX-11, we write
> to unallocated memory otherwise.

True for {old,new}section.

I'll apply three patches from you as-is.  Thanks.

Having said that,

> -	snprintf(logmsg, sizeof(logmsg), "Branch: renamed %s to %s",
> -		 oldref, newref);
> +	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
> +		 oldref.buf, newref.buf);

I am wondering why nobody has complained until now, but shouldn't this be
oldname and newname?  

    Reflog message: Branch: renamed refs/heads/master to refs/heads/naster

does not feel right, even though it is perfectly understandable to people
who know the internal (i.e. branches are implemented as a ref in
refs/heads hierarchy).

Rewording of the above, if it is ever done, has to be a separate commit,
and it is a behaviour change (if some third-party tool is reading and
parsing the reflog we will break it) which I do not particularly think is
worth doing.

I am mentioning this only because I just noticed it (and do not want to do
the thinking myself ;-).
