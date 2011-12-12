From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 12:19:15 -0600
Message-ID: <20111212181915.GD31793@elie.hsd1.il.comcast.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:19:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaATI-0007LN-7m
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab1LLSTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:19:23 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61955 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1LLSTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:19:23 -0500
Received: by ghbf16 with SMTP id f16so19103ghb.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xCZ9qPi+c9ZvOPJfVRZXDvfzVwwrmamA7KDDubyipSQ=;
        b=rSkm9keyK5ke1poLk39vtIXz97CP4VgHWhon0FMneNWMfY02orZCN2Oz1fFKOp/3zN
         aGICTZvtZF1VyS15txtNIcK8jv7T0TEuocsbqVW3xD1ZSfett3ZAo6CLoKfkSyHOcgAP
         5y4+Z18CkR/MbA2Oi58trsyR+knM5gcpJ9ePQ=
Received: by 10.236.180.100 with SMTP id i64mr26167463yhm.34.1323713962651;
        Mon, 12 Dec 2011 10:19:22 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i22sm31925951yhm.10.2011.12.12.10.19.20
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 10:19:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186926>

Hi,

Thomas Rast wrote:

> --- a/t/test-terminal.perl
> +++ b/t/test-terminal.perl
> @@ -4,14 +4,16 @@
>  use warnings;
>  use IO::Pty;
>  use File::Copy;
> +use POSIX ();
>
> -# Run @$argv in the background with stdio redirected to $out and $err.
> +# Run @$argv in the background with stdio redirected from $in and to $out and $err.

I'm not thrilled about this change.  The original purpose of
test_terminal was to test commands like "git log" that need to check
whether stdout is a tty in order to decide whether to use color and to
paginate their output.  Perhaps whether stdin is a tty _should_ affect
those decisions, but it currently doesn't (for example, "echo HEAD |
git log --stdin" works) and that would deserve a separate test, I'd
think.

The testsuite bug you mentioned sounds like a real one and worth
fixing, though.  Maybe there would be some way for test_terminal to
give the caller some control over which file descriptors to replace
with a terminal.

Just musing,
Jonathan
