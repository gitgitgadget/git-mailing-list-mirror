From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bad error message
Date: Thu, 04 May 2006 17:20:47 -0700
Message-ID: <7vac9x2ug0.fsf@assigned-by-dhcp.cox.net>
References: <200605041957.26194.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 02:21:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbo45-0005gY-CK
	for gcvg-git@gmane.org; Fri, 05 May 2006 02:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWEEAUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWEEAUw
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 20:20:52 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49807 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030289AbWEEAUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 20:20:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505002049.BOQS9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 20:20:49 -0400
To: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
In-Reply-To: <200605041957.26194.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Fri, 5 May 2006 01:57:26 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19588>

"Robin Rosenberg (list subscriber)"  <robin.rosenberg.lists@dewire.com> writes:

> @@ -43,8 +43,13 @@
>                 die("No such ref: %s", refname);
>
>         if (oldval) {
> -               if (memcmp(currsha1, oldsha1, 20))
> -                       die("Ref %s is at %s but expected %s", refname, sha1_to_hex(currsha1), sha1_to_hex(oldsha1));
> +               if (memcmp(currsha1, oldsha1, 20)) {
> +                       char sha1str1[41];
> +                       char sha1str2[41];
> +                       strcpy(sha1str1, sha1_to_hex(currsha1));
> +                       strcpy(sha1str2, sha1_to_hex(oldsha1));
> +                       die("Ref %s is at %s but expected %s", refname, sha1str1, sha1str2);
> +               }

Your patch looks correct, but probably is made unnecessary with
the "you can use up to 4 sha1_to_hex() safely" patch Linus did.

We have it in "master" and my plan is to cherry-pick it to
"maint" branch and included it in the next stale release 1.3.3,
along with core.prefersymlinkrefs patch also only in "master",
if we do not hear somebody scream in the next few days.
