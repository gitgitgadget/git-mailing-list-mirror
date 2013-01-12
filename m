From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 3/8] git_remote_helpers: Force rebuild if python version
 changes
Date: Sat, 12 Jan 2013 18:30:44 -0500
Message-ID: <20130112233044.GB23079@padd.com>
References: <cover.1358018078.git.john@keeping.me.uk>
 <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 13 00:31:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuAXc-0002S1-Kc
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 00:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab3ALXar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 18:30:47 -0500
Received: from honk.padd.com ([74.3.171.149]:41428 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab3ALXaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 18:30:46 -0500
Received: from arf.padd.com (50-52-235-227.drr01.drhm.nc.frontiernet.net [50.52.235.227])
	by honk.padd.com (Postfix) with ESMTPSA id 1442EE9A;
	Sat, 12 Jan 2013 15:30:46 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8E4E827CDB; Sat, 12 Jan 2013 18:30:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213314>

john@keeping.me.uk wrote on Sat, 12 Jan 2013 19:23 +0000:
> When different version of python are used to build via distutils, the
> behaviour can change.  Detect changes in version and pass --force in
> this case.
[..]
> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
[..]
> +py_version=$(shell $(PYTHON_PATH) -c \
> +	'import sys; print("%i.%i" % sys.version_info[:2])')
> +
>  all: $(pysetupfile)
> -	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
> +	$(QUIET)test "$$(cat GIT-PYTHON_VERSION 2>/dev/null)" = "$(py_version)" || \
> +	flags=--force; \
> +	$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build $$flags
> +	$(QUIET)echo "$(py_version)" >GIT-PYTHON_VERSION

Can you depend on ../GIT-PYTHON-VARS instead?  It comes from
96a4647 (Makefile: detect when PYTHON_PATH changes, 2012-12-18).
It doesn't check version, just path, but hopefully that's good
enough.  I'm imagining a rule that would do "clean" if
../GIT-PYTHON-VARS changed, then build without --force.

		-- Pete
