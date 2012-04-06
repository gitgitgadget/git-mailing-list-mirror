From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 6 Apr 2012 16:19:26 -0400
Message-ID: <20120406201926.GA1677@sigill.intra.peff.net>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 22:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGFd9-0000eH-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 22:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918Ab2DFUTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 16:19:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757899Ab2DFUTa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 16:19:30 -0400
Received: (qmail 10462 invoked by uid 107); 6 Apr 2012 20:19:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 16:19:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 16:19:26 -0400
Content-Disposition: inline
In-Reply-To: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194902>

On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:

> Something is better than nothing.

Yes, but...

> --- /dev/null
> +++ b/t/t9902-completion.sh
> @@ -0,0 +1,198 @@
> +#!/bin/bash

Won't this test break "make test" on systems without bash (or with bash
elsewhere)?

I think you need to start with something like:

  #!/bin/sh

  if ! type bash; then
          echo '1..0 # SKIP skipping bash tests, bash not available'
          exit 0
  fi

  bash <<\END_OF_BASH_SCRIPT

  test_description='test bash completion'
  . ./test-lib.sh

  [... actual tests ...]

  test_done

  END_OF_BASH_SCRIPT

You could also run the main harness in the outer sh script, and just run
bash inside each test, but I suspect that would end up cumbersome. I
don't really care strongly which, as long as it gracefully skips on
non-bash systems.

-Peff
