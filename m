From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] remote-helpers: add exec-path links
Date: Tue, 28 May 2013 13:06:02 -0700
Message-ID: <7vfvx6zx79.fsf@alter.siamese.dyndns.org>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
	<1369449507-18269-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 22:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhQ9r-0007Qa-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 22:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab3E1UGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 16:06:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab3E1UGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 16:06:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2543225F0;
	Tue, 28 May 2013 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=z+l/UFxKxlz8zDl05zjHwOSfwd0=; b=TMg61U6g+NhR+5N5NjsP
	zC38ZoH4uRYgtVEWNfLtE5VbCkVNfuBV2rkZQJughcJcwOcnYad2bBchPyJjiVUC
	XklPeod+xw72BjJHoezsN5kTZVOwdb+VlgcuqVPBR279HUoaQ+62035VyZt5jbZ0
	Y6dZJPXREOg//sIMkuABpVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xN/6R6Is0HfOnI/LMmss17ECym3HAXmJGiiuWRUxolnPCe
	+PBW9Ef+iP72FedPr4IRN7L37M2h8txt0wrDNzy/jHCuxOmeWd8nlVCJZaepK/Ft
	sDd6FRCY67CNy5ysSMncR3jwoZTO9sFrpOK+rZH7EkkReTWOKrJz88+5O/MDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 960E7225EF;
	Tue, 28 May 2013 20:06:04 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2631225EB;
	Tue, 28 May 2013 20:06:03 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 066C91C8-C7D2-11E2-88E3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225684>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This way we don't have to modify the PATH ourselves and it's easier to
> test without 'make'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  .gitignore                      |  2 ++
>  contrib/remote-helpers/Makefile | 13 +++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)

If we teach the top-level .gitignore that some contrib/ stuff might
contaminate the top-level directory (which is a good idea), we
should also teach the top-level Makefile how to get rid of the built
cruft upon "make clean", no?

> diff --git a/.gitignore b/.gitignore
> index 10aee94..a79b412 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -119,11 +119,13 @@
>  /git-reflog
>  /git-relink
>  /git-remote
> +/git-remote-bzr
>  /git-remote-http
>  /git-remote-https
>  /git-remote-ftp
>  /git-remote-ftps
>  /git-remote-fd
> +/git-remote-hg
>  /git-remote-ext
>  /git-remote-testgit
>  /git-remote-testpy
> diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
> index 55abf0b..98150b4 100644
> --- a/contrib/remote-helpers/Makefile
> +++ b/contrib/remote-helpers/Makefile
> @@ -1,9 +1,9 @@
>  TESTS := $(wildcard test-*.t)
>  SCRIPTS := $(wildcard git-remote-*.py)
> +LINKS := $(addprefix ../../,$(patsubst %.py,%,$(SCRIPTS)))
>  
>  export T := $(addprefix $(CURDIR)/,$(TESTS))
>  export MAKE := $(MAKE) -e
> -export PATH := $(CURDIR):$(PATH)
>  export TEST_LINT := test-lint-executable test-lint-shell-syntax
>  export TEST_DIRECTORY := $(CURDIR)/../../t
>  
> @@ -15,10 +15,15 @@ all: $(SCRIPTS)
>  install:
>  	$(MAKE) -C ../.. install-python-script
>  
> -test: all
> +links: all $(LINKS)
> +
> +test: links
>  	$(MAKE) -C ../../t $@
>  
> -$(TESTS): all
> +$(LINKS):
> +	ln -sf contrib/remote-helpers/$(notdir $@) ../..
> +
> +$(TESTS): links
>  	$(MAKE) -C ../../t $(CURDIR)/$@
>  
> -.PHONY: all install test $(TESTS)
> +.PHONY: all install test links $(TESTS)
