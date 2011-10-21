From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep --no-index and absolute paths don't work?
Date: Fri, 21 Oct 2011 10:00:21 -0700
Message-ID: <7vipni8el6.fsf@alter.siamese.dyndns.org>
References: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 19:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHISM-0002hs-5a
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab1JURAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 13:00:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab1JURAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:00:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BFEA5D2E;
	Fri, 21 Oct 2011 13:00:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rKm1OaYpxTJceuYFWZQ/liaqBQ4=; b=CPtoPs
	iZbydiApOlPXI3G6KMhhPg3LEKmlmxMGgcnpKu/sL1bVpTLPBNb3Ipj4hm7sUlRd
	hyMIR+x43qfzlY6HpEm9quaERW8QmnVuXFMOVA7oL9ALitIHkmM36pXblFL6h2mc
	KqQwaTW02553mGP61IbXDvi2dCDriScob1I+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EZcBOaqixi/vzKMqwy5S01X0f6zTS1Kt
	va8fvq1NRjNE3J9Y8UhaMUg993I6agd/kIhPG0MVsjqOwUdnIpyZO1gRE7MGKBac
	C3J7Nx59RAdrF8uqekpRm3mbqIUNTcNJwSZScU253yQcOwuynFQvM5t7Uf14Bw6a
	nv2tLfZHhlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 715665D2D;
	Fri, 21 Oct 2011 13:00:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E07DA5D2A; Fri, 21 Oct 2011
 13:00:22 -0400 (EDT)
In-Reply-To: <CAKPyHN138OZRt_3PT5ChuTpSEuOdybnyAj8Baqr=3OD=y==jgw@mail.gmail.com> (Bert
 Wesarg's message of "Fri, 21 Oct 2011 08:34:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A36207C-FC06-11E0-8192-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184067>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> I'm currently  totally confused, that a
>
>     git grep --no-index foo /usr/include
>
> does not work. I know that the documentation says "in the current
> directory" for the --no-index flag.

I think "in the current directory" is just contrasting with "in the work
tree, ..." at the beginning of the DESCRIPTION section. We could say "in
the files" instead for clarity, and then add "when pathspec is not given,
files in the current directory is searched" or something.

The intent of "--no-index", originating from "git diff --no-index", is to
allow git tools to be used in non-git context, i.e. to files on the
filesystem.

"git grep --no-index" which is a later invention in the 1.7.0 era didn't
fully ignore "git"ness, and one such instance you fixed in this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/181484/focus=181485

I think this path normalization is another instance of us knowing a bit too
much of "git" even when we are told with "--no-index" that we are not
operating on a working tree associated with git.
