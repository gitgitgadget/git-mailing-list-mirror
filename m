From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 1/4] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Sat, 25 Mar 2006 18:58:59 -0500
Message-ID: <20060325235859.GO26071@mythryan2.michonline.com>
References: <11432834101430-git-send-email-normalperson@yhbt.net> <11432834102700-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>,
	Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sun Mar 26 01:00:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNIg1-0000ok-Kl
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 01:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWCZAAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWCZAAG
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 19:00:06 -0500
Received: from mail.autoweb.net ([198.172.237.26]:14545 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751979AbWCZAAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 19:00:01 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FNIfm-0002w3-GP; Sat, 25 Mar 2006 18:59:59 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FNIfr-0007Id-AI; Sat, 25 Mar 2006 19:00:03 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FNIfE-0005wc-Et; Sat, 25 Mar 2006 18:59:24 -0500
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <11432834102700-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060126
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18008>

On Sat, Mar 25, 2006 at 02:43:30AM -0800, Eric Wong wrote:
> Net::SMTP is in the base Perl distribution, so users are more
> likely to have it.  Net::SMTP also allows reusing the SMTP
> connection, so sending multiple emails is faster.

Overall, I like this set of cleanups, just one thing struck me as,
"why?"

>  	if ($quiet) {
> -		printf "Sent %s\n", $subject;
> +		print "Sent $subject\n";

This seems to be a pointless change, and actually, might be long-term
counterproductive.

Assumption: Eventually, we're going to want to internationalize git.

If that is true, we'll eventually do something like this to lines like
that:
	printf( gettext("Send %s\n"), $subject);

The alternative:
	print gettext("Send $subject\n");
does not work.

(The line that xgettext will see is 'Send $subject\n', but when the
program actually runs, gettext will see the interpolated version, which
fails.)

Internationalization may still be a ways off, but I think we're reaching
the point where it might be something we care to think about.

-- 

Ryan Anderson
  sometimes Pug Majere
