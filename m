From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] help: implement multi-valued "man.viewer" config option
Date: Wed, 12 Mar 2008 08:23:37 +0100
Message-ID: <200803120823.38100.chriscool@tuxfamily.org>
References: <20080311085113.176df1af.chriscool@tuxfamily.org> <200803120100.m2C105YM010496@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 08:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZLEU-0006XC-Tp
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 08:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYCLHSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2008 03:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYCLHSA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 03:18:00 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60704 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYCLHR7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2008 03:17:59 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 69C421AB2E8;
	Wed, 12 Mar 2008 08:17:57 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ED3FF1AB2F2;
	Wed, 12 Mar 2008 08:17:56 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803120100.m2C105YM010496@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76933>

Le mercredi 12 mars 2008, Xavier Maillard a =E9crit :
>
> Tested-by: Xavier Maillard <xma@gnu.org>

Thanks.

> Though, I thought that when one entry had failed we would have
> switched to the next until none could be found thus
>
> I (voluntary) made a typo in my .git/config file as reflected by:
>
> [xma@localhost 23:57:18 git]$ git config --get-all man.viewer
> woma  <- TYPO HERE
> konqueror
> man
>
> and I then tried git config --help. I thought it would have tried
> all entries and as a last resort would have failed back to man
> but it did not act like this:
>
> [xma@localhost 23:57:11 git]$ git config --help
> error: 'woma': unsupported man viewer.
> fatal: bad config file line 16 in .git/config
>
> Ok, woma in not supported here and it is reported like this but
> would it be possible to just throw an error on stdout and try
> another viewer ?=20

Yes, with the following patch on top:

diff --git a/help.c b/help.c
index 5da8c9c..ecaca77 100644
--- a/help.c
+++ b/help.c
@@ -139,7 +139,7 @@ static int add_man_viewer(const char *value)
        else if (!strcasecmp(value, "konqueror"))
                do_add_man_viewer(exec_man_konqueror);
        else
-               return error("'%s': unsupported man viewer.", value);
+               warning("'%s': unsupported man viewer.", value);

        return 0;
 }

> We could even imagine something even more=20
> general like the possibility for the user to write his own man
> viewer (a bash script for example) and set it as a candidate.

I will do that in a latter patch, it has been suggested a lot of times=20
already.

> By the way, I do not see any reason to put man as a candidate.
> "man" should be the default when nothing is specified or when all
> candidates have failed.

It may be more explicit.

Thanks,
Christian.

> Anyway, thank you for this implementation.
>
> 	Xavier
