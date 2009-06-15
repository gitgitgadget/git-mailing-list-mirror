From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: fix compiling with libcurl 7.9.2
Date: Sun, 14 Jun 2009 21:35:37 -0700
Message-ID: <7v63eyp10m.fsf@alter.siamese.dyndns.org>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Mike Ralphson <mike@abacus.co.uk>,
	Mike Hommey <mh@glandium.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 06:36:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG3vO-0005pJ-EZ
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 06:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbZFOEfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 00:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbZFOEfg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 00:35:36 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50571 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZFOEfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 00:35:36 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090615043538.PFCK25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Mon, 15 Jun 2009 00:35:38 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 44bd1c00C4aMwMQ044bdos; Mon, 15 Jun 2009 00:35:37 -0400
X-VR-Score: -80.00
X-Authority-Analysis: v=1.0 c=1 a=1syxHTCHuFQA:10 a=ddArZceFCXsA:10
 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8 a=YFSDL6jICiKw2ZE9QX4A:9
 a=IRwDjPlltdcfp2AxTGfYmYCkOE0A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245033541-15558-1-git-send-email-lodatom@gmail.com> (Mark Lodato's message of "Sun\, 14 Jun 2009 22\:39\:00 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121582>

Mark Lodato <lodatom@gmail.com> writes:

> Change the minimimum required libcurl version for the http.sslKey option
> to 7.9.3.  Previously, preprocessor macros checked for >= 7.9.2, which
> is incorrect because CURLOPT_SSLKEY was introduced in 7.9.3.  This now
> allows git to compile with libcurl 7.9.2.
>
> Signed-off-by: Mark Lodato <lodatom@gmail.com>
> ---
>
> This patch series is independent of my other password prompting patch
> series, and is based off 'next', which includes Tay Ray Chuan's recent
> http changes.

In other words, this needs to be queued on top of rc/http-push series, and
the review process should involve the original author (Cc'ed).

Tay, comments?

> Note that git still does not compile on libcurl before 7.9.1 or below,
> since CURLOPT_FTP_USE_EPSV (http.c:236) is defined in libcurl 7.9.2.

I think we didn't quite follow an old thread through, then.  

Cf. http://thread.gmane.org/gmane.comp.version-control.git/113985/focus=114014

Both Mike's in the thread Cc'ed.

> One question: In http.c, there are unnecessary #if LIBCURL_VERSION_NUM's
> surrounding the global variable declarations, in http_options(), and in
> http_init().  Is there a reason why these exist?  If not, I think
> removing them would make the code easier to read.

Yeah, as long as get_curl_handle() is still protected not to call
curl_easy_setopt() with an option that is unknown to the version of
libcURL, I think the config reader and variable declarations, and
definitions can lose conditional compilation and it would make the overall
code easier to read.

Thanks.
