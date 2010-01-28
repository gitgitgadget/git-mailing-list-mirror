From: Junio C Hamano <gitster@pobox.com>
Subject: Re: show/diff --check clarification needed
Date: Thu, 28 Jan 2010 12:25:22 -0800
Message-ID: <7vmxzykmdp.fsf@alter.siamese.dyndns.org>
References: <d26982ce92a061ee24d04aba6e314fa4.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 21:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naavp-0001JR-S1
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 21:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab0A1UZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 15:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042Ab0A1UZc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 15:25:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0A1UZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 15:25:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA6C3957E1;
	Thu, 28 Jan 2010 15:25:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y8jHfciOSUGelqDFmOdFWPogEo8=; b=N0LX3p
	T1E0v2Q9eSR3LQria2obKjDRIpDCO6bXdAAOIXzbyfyTdIJdeTY/XzvVvVF/GZh4
	1ENVlhcCg1Pl2CB0H+UwKIeiV/4mXFwJazaVKOze0sRFKsIuMsIufTdIuE9jtPwq
	fd10McZ739+0xR3uyD4WI+BhYAiqCtAZ6fKac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dauv5kGHncEnh8KaUnGV5d4koCYdR+S6
	KKfM+70PZiA4TVz6z7OS7YUhh9GrlUK/ktkxE21hcjRcBk0fUZYOwxuu8bcT9ufs
	5AlkeHNbAyzRUEiwSlISp4Q4XsgyAPlaA8CvT4ZrQv1DuULd6q+tibpE5RXoJMSF
	j6GTx/+PhK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86901957DD;
	Thu, 28 Jan 2010 15:25:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6078957DC; Thu, 28 Jan
 2010 15:25:23 -0500 (EST)
In-Reply-To: <d26982ce92a061ee24d04aba6e314fa4.squirrel@intranet.linagora.com> (Yann
 Dirson's message of "Wed\, 27 Jan 2010 11\:41\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 451017EC-0C4B-11DF-9347-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138267>

"Yann Dirson" <ydirson@altern.org> writes:

> Unless I missed something, I suggest the following plan:
>
> - document in maint that --check only takes worktree into account when
>   looking for .gitattributes, and more globally add a note to the
>   gitattributes manpage to explicitely say that too.

It is not limited to "diff --check".  The current implementation reads
attributes only from the checked out work tree and/or from the index,
depending on the direction of operation (e.g. checking out files to work
tree reads from the index, I think).  The same issue would affect "git
archive" when generating a tarball from an older revision.

The exception is $GIT_DIR/info/gitattributes, and for your particular
purpose, I think it is the right one to use, because the entries in that
file will apply regardless of which version you are examining patches
from.

> - add a global flag to allow something like
>   "git --attributes-tree=<treeish> <command>"

I am not sure if this is what we really want.  It seems to me that it
would make more sense to read from a relevant tree that the <command>
is operating on, if we are to enhance the attributes implementation.  If
that <treeish> is a fixed one, it is not much better than having necessary
entries in your $GIT_DIR/info/gitattributes file.

> - adjust defaults to agreed-upon values
> - add any config entries that would be meaningful

Sorry, I have no idea what you mean by these two points.

Thanks.
