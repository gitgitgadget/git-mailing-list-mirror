From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: build in platform independent directory
Date: Fri, 17 Sep 2010 11:41:02 -0700
Message-ID: <7vocbw2oxt.fsf@alter.siamese.dyndns.org>
References: <36e03068ded278b5145fdf82658c3270a25c2762.1284740217.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 17 20:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owfs5-0007Xb-1n
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 20:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0IQSlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 14:41:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab0IQSlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 14:41:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2E16D6F55;
	Fri, 17 Sep 2010 14:41:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TX0gKht8iZrBzWmEvCp07ESx+l8=; b=iodube
	Jxc6aZqLs4xM9gJpvCyMGlfoBgoBnA/5PwiawqyGYLneMpW1A81zWW+nZ5T44Rxn
	JsnSWHai7zWPzQfz8rBIip0Nuj2A90WfLH0Luxxaykr9RQGTCcqQ2RocnW9ZXESW
	K2XCRrMgTtLZVetV5PcwKuiuXL0ShlWJqnoFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NdI69sBJGnuHxJHii5cfwXfWLTsQt/3C
	lmJicIjFvn22n43Nupu1FjnuarAU5aOAMeAkUngLHXXy6jPueEs9FImcDBeCyN8k
	WqKLEBowei0WGs/CSs2mPOSIgdvIk9UDI84/YEda6tja4Rdqp4MgURndKfwcAVYT
	LVFXdkJWQJg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FFB1D6F51;
	Fri, 17 Sep 2010 14:41:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1E4DD6F4E; Fri, 17 Sep
 2010 14:41:03 -0400 (EDT)
In-Reply-To: <36e03068ded278b5145fdf82658c3270a25c2762.1284740217.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 17 Sep 2010 18\:17\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 224F6B80-C28B-11DF-9E71-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156408>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The build directory which is used by distutils depends on the platform
> (e.g. build/lib on Fedora 13, build/lib.linux-i686-2.6 on Ubuntu 9.04).
> But test-lib.sh expects to find the build in build/lib which can cause
> t5800-remote-helpers.sh to fail early.
>
> Override distutils' choice so that the build is always in build/lib.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  git_remote_helpers/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
> index 74b05dc..e8172d3 100644
> --- a/git_remote_helpers/Makefile
> +++ b/git_remote_helpers/Makefile
> @@ -26,7 +26,7 @@ PYLIBDIR=$(shell $(PYTHON_PATH) -c \
>  	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
>  
>  all: $(pysetupfile)
> -	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
> +	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build --build-purelib=build/lib --build-platlib=build/lib
>  
>  install: $(pysetupfile)
>  	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)

Hmm, wouldn't this interfere with the install target if you do not tell
the "setup.py install" where your built stuff lives?
