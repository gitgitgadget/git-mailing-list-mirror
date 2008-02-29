From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2] help: add "man.viewer" config var to use "woman" or
 "konqueror"
Date: Fri, 29 Feb 2008 03:00:18 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802290200.m1T20I7Z018030@localhost.localdomain>
References: <20080228051956.2f36edf0.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUv6L-0005wn-Fi
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYB2Ce1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbYB2Ce1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:34:27 -0500
Received: from master.uucpssh.org ([193.218.105.66]:59628 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbYB2CeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:34:22 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id DA1FFC8F66; Fri, 29 Feb 2008 03:32:54 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1T20Sw1018054;
	Fri, 29 Feb 2008 03:00:29 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1T20I7Z018030;
	Fri, 29 Feb 2008 03:00:18 +0100
In-reply-to: <20080228051956.2f36edf0.chriscool@tuxfamily.org> (message from
	Christian Couder on Thu, 28 Feb 2008 05:19:56 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.4,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -2.60,
	SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75503>

Hi (again),

   Note that "emacsclient" is used with option "-e" to launch "woman"
   on emacs and this works only on versions >= 22.

Here are more clues concerning emacsclient I found out when
trying to understand why it worked for you with >=22 and not for
me with a 23.x version.

   +
   +	/* emacsclient prints its version number on stderr */

As commented into another post, here the version is displayed on
stdout which is confirmed by reading the source code:

/* Display a normal or error message.
   On Windows, use a message box if compiled as a Windows app.  */

      FILE *f = is_error ? stderr : stdout;
      fputs (msg, f);
      fflush (f);

is_error is a boolean parameter to the function message.

   +	/*
   +	 * Don't bother checking return value, because "emacsclient --version"
   +	 * seems to always exits with code 1.
   +	 */

Almost, in fact, in emacsclient.c, we can read

	case 'V':
	  message (FALSE, "emacsclient %s\n", VERSION);
	  exit (EXIT_SUCCESS);
	  break;

So it always returns 0.

Regards

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
