From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Extend sample pre-commit hook to check for non ascii filenames
Date: Fri, 15 May 2009 11:11:12 -0700
Message-ID: <7vbpputewv.fsf@alter.siamese.dyndns.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	<m3r5yukv6g.fsf@localhost.localdomain>
	<20090512214250.GA22974@macbook.lan>
	<200905122356.00659.jnareb@gmail.com>
	<20090514175850.GA26267@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 15 20:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51sS-0004L7-JQ
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbZEOSLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756764AbZEOSLN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:11:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57814 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbZEOSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:11:12 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515181112.PNDQ20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Fri, 15 May 2009 14:11:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id ruBC1b00b4aMwMQ04uBDJe; Fri, 15 May 2009 14:11:13 -0400
X-Authority-Analysis: v=1.0 c=1 a=d_odvaxKMEgA:10 a=bh4dO2YjhlsA:10
 a=Y7828TS4AAAA:8 a=IvZhBgcEoBpTsOQjL3IA:9 a=-kNK0kwFKdXsNxYN_hsA:7
 a=BgX9fmafnzdT0i4hX8LQvvKKuJ8A:4 a=IUdvcfx5MVUA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119273>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 0e49279..3083735 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -7,6 +7,26 @@
>  #
>  # To enable this hook, rename this file to "pre-commit".
>  
> +# If you want to allow non-ascii filenames set this variable to true.
> +allownonascii=$(git config hooks.allownonascii)
> +
> +function is_ascii () {

We do not say "#!/bin/bash" at the beginning (hopefully), so let's not say
"function " here.

> +    test -z "$(cat | sed -e "s/[\ -~]*//g")"

Do you need "cat | "?

Does this script run under LC_ALL=C?  Can an i18n'ized sed interfere with
what you are trying to do?

> +    return $?

Do you need this, or does the function return the result of the last
statment anyway?

> +		echo "Non-ascii filenames are not allowed !"
> +		echo "Please rename the file ..."

Can we make this sound more like a _sample_ project policy?  It's not like
we enforce that policy to other people's projects.

> +		exit 1
> +	fi
> +fi
> +
>  if git-rev-parse --verify HEAD 2>/dev/null
>  then
>  	against=HEAD
> -- 
> 1.6.3
