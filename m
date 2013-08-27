From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/11] Improve section "Manipulating branches"
Date: Tue, 27 Aug 2013 12:11:40 -0700
Message-ID: <xmqqbo4jc5jn.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1088240617.34545.1377626528726.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOgF-0003Uj-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab3H0TLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:11:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab3H0TLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:11:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 939B53CE02;
	Tue, 27 Aug 2013 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jLZKfOBuNB1jZ6W+a/wnNdBonl4=; b=UK3ldP
	9XNLblpjc/a8cL43u2Dc+I8S1n9CkoeXHg5vQSBbwnbV9OiYa4Y0lKKlk3dsRs1Q
	oUb6C809a2i6RFQKGwdxbunWOJmrF/2XAiJBumzLZdr4Gju/zTQdsiccTNZP2DXM
	ULsa51wk+K9M43wlllGvwkxMnvdy7oh1YXW2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TS6wQ3JbL5T010ajaxbeYGbfDwJLkhJs
	CyFbvN+a+toHP3GGQ/1FLf0B+ZKCb/hfEd6XKBQx3IkYm0htXGrU8lzMnP6Vp+rF
	R4u37Bqb7tBlN7IBVpvRnNqEmdi7hFEzu5/9Yb4GSFqFT1FsyYFM7phrjvJuQ3G6
	lmBiJD6rY7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 654403CE00;
	Tue, 27 Aug 2013 19:11:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01DC03CDF4;
	Tue, 27 Aug 2013 19:11:48 +0000 (UTC)
In-Reply-To: <1088240617.34545.1377626528726.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 20:02:08 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85630A54-0F4C-11E3-BEA1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233140>

Thomas Ackermann <th.acker@arcor.de> writes:

>  `git branch -d <branch>`::
> -	delete the branch `<branch>`; if the branch you are deleting
> -	points to a commit which is not reachable from the current
> -	branch, this command will fail with a warning.
> +	delete the branch `<branch>`; if the branch is not fully
> +	merged in its upstream branch or contained in the current branch, 
> +	this command will fail with a warning.

This is not a new problem, but it fails with an error, not a warning
(which often is a message to caution but operation gets carried out
anyway).  For that matter, it might be better to say "stops", as it
is not a failure but is saving the user from losing information (in
other words, that is a different kind of success ;-).

It also stops you from deleting the branch you are currently on.  I
wonder if we want to mention that, too?

>  `git branch -D <branch>`::
> -	even if the branch points to a commit not reachable
> -	from the current branch, you may know that that commit
> -	is still reachable from some other branch or tag.  In that
> -	case it is safe to use this command to force Git to delete
> -	the branch.
> +	delete the branch `<branch>` irrespective of its merged status.
>  `git checkout <branch>`::
>  	make the current branch `<branch>`, updating the working
> -	directory to reflect the version referenced by `<branch>`
> +	directory to reflect the version referenced by `<branch>`.
>  `git checkout -b <new> <start-point>`::
>  	create a new branch `<new>` referencing `<start-point>`, and
>  	check it out.
