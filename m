From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] Documentation: enhance gitignore whitelist example
Date: Tue, 05 Apr 2011 15:43:17 -0700
Message-ID: <7vbp0kl3p6.fsf@alter.siamese.dyndns.org>
References: <1302041878-24426-1-git-send-email-eblake@redhat.com>
 <1302041878-24426-2-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org, jrnieder@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:43:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7EyG-0000PL-04
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab1DEWnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:43:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab1DEWna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:43:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F763539D;
	Tue,  5 Apr 2011 18:45:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3aZ/MoGqefMVRcsFq7g+H0TSsO8=; b=lu9eQf
	uEO9esYiMdmIrSuspYU6ySfrp9SbFuVmD25gKCgAzMaYhAV48VUVxUXTZdC8SIQJ
	UVOIMKCswKu5kwWw6m1CezWwLUOxxpCIv0oAQcWjLJFuGc/EjZDqfqKgHKTC1JFM
	bGTPzke7Q2MBs2T3p3JthbUFzEbGiw42o/+sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VnsOBjUOWYDfXaPrtLCODUxSlp/Lp4zb
	nUaxUg/GlFunKLEhR9LwG/9S43rH/PLDs0yhg3k/0hDd5ejduvpL7tXUHulMI34d
	cdJItg4BCWYT7+UkVfmu2Oa3YPFT2k9zZvwMt8svZMnUGdqWMlaTgEZB1Nu31Haf
	uN+2Ka3WCls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30ADA5399;
	Tue,  5 Apr 2011 18:45:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0F8F5394; Tue,  5 Apr 2011
 18:45:11 -0400 (EDT)
In-Reply-To: <1302041878-24426-2-git-send-email-eblake@redhat.com> (Eric
 Blake's message of "Tue, 5 Apr 2011 16:17:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60B3A952-5FD6-11E0-9954-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170932>

Eric Blake <eblake@redhat.com> writes:

> v3: split out fnmatch tweaks, don't tweak specification of patterns
> or existing examples but instead add an entirely new example, make
> the example use a deeper hierarchy

Somebody has to compare this vs making the existing example larger.
Generally speaking, I prefer to keep the number of examples smaller (the
less the beginner has to read, the better), but the end result might be
more readable with a separate example, like this patch does.

> +    $ cat .gitignore
> +    # Use anchoring, since `build' would ignore Documentation/build.

> +    # Do not ignore the directory itself, ...
> +    # /build/
> +    # rather ignore files in the top-level build directory, ...

Do you _really_ need these three lines?  I suspect that it is unclear to
the first reader that the second one is a _bad_ example that is commented
out.  That is, how about starting like this, without the above three?

> +    # Ignore files in the top-level build directory, ...
> +    /build/*
> +    # but permit child directories, ...
> +    !/build/*/
> +    # then ignore all nested files, ...
> +    /build/*/*
> +    # and finally white-list the special file

Nit; s/the special file/&./;

> +    !/build/foo/baz
> +    $ git status
> +    [...]
> +    # Untracked files:
> +    [...]
> +    #       Documentation/build/file
> +    #       build/foo/baz
> +    [...]

Other than that, as a free-standing example this was very straightforward
illustration.  I didn't check the flow-of-learning though.

Thanks.
