From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 3/8] git_remote_helpers: Force rebuild if python version
 changes
Date: Wed, 16 Jan 2013 19:27:08 -0500
Message-ID: <20130117002708.GA15517@padd.com>
References: <cover.1358018078.git.john@keeping.me.uk>
 <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
 <20130112233044.GB23079@padd.com>
 <20130113162605.GL4574@serenity.lan>
 <20130113171402.GA1307@padd.com>
 <20130113175238.GO4574@serenity.lan>
 <20130115225805.GA4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvdKQ-0003gS-6K
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 01:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252Ab3AQA1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 19:27:13 -0500
Received: from honk.padd.com ([74.3.171.149]:41700 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637Ab3AQA1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 19:27:12 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 64F5632C9;
	Wed, 16 Jan 2013 16:27:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0C82B2B95E; Wed, 16 Jan 2013 19:27:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130115225805.GA4574@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213829>

john@keeping.me.uk wrote on Tue, 15 Jan 2013 22:58 +0000:
> For reference, putting the version check in setup.py looks like this:
> 
> -- >8 --
> 
> diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
> index 6de41de..2c21eb5 100644
> --- a/git_remote_helpers/setup.py
> +++ b/git_remote_helpers/setup.py
> @@ -3,6 +3,7 @@
>  """Distutils build/install script for the git_remote_helpers package."""
>  
>  from distutils.core import setup
> +import sys
>  
>  # If building under Python3 we need to run 2to3 on the code, do this by
>  # trying to import distutils' 2to3 builder, which is only available in
> @@ -13,6 +14,24 @@ except ImportError:
>      # 2.x
>      from distutils.command.build_py import build_py
>  
> +
> +current_version = '%d.%d' % sys.version_info[:2]
> +try:
> +    f = open('GIT-PYTHON_VERSION', 'r')
> +    latest_version = f.read().strip()
> +    f.close()
> +
> +    if latest_version != current_version:
> +        if not '--force' in sys.argv:
> +            sys.argv.insert(0, '--force')
> +except IOError:
> +    pass
> +
> +f = open('GIT-PYTHON_VERSION', 'w')
> +f.write(current_version)
> +f.close()
> +
> +
>  setup(
>      name = 'git_remote_helpers',
>      version = '0.1.0',
> 

That's about the same overhead as doing it in the Makefile,
and a bit more obscure.  I don't mind your initial version
so much anymore.  Thanks for thinking about it.

		-- Pete
