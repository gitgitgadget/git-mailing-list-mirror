From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] git_config_string janitorial conversions.
Date: Sun, 6 Jul 2008 05:47:18 +0200
Message-ID: <200807060547.19085.chriscool@tuxfamily.org>
References: <cover.1215234749.git.whee@smaertness.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brian Hetro <whee@smaertness.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFLAm-0004ZS-2T
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbYGFDnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jul 2008 23:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbYGFDnZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:43:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46825 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbYGFDnY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 23:43:24 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 83AF71AB2BA;
	Sun,  6 Jul 2008 05:43:22 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4EC5D1AB2AB;
	Sun,  6 Jul 2008 05:43:22 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <cover.1215234749.git.whee@smaertness.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87493>

Le samedi 5 juillet 2008, Brian Hetro a =E9crit :
> These patches are related to the git_config_string "janitorial" work.

Your patches look good to me.

By the way, your first patch in the series seems to fix a bug:

> int git_commit_config(const char *k, const char *v, void *cb)
> {
> -       if (!strcmp(k, "commit.template")) {
> -               if (!v)
> -                       return config_error_nonbool(v);

It should have been:
-                       return config_error_nonbool(k);

> -               template_file =3D xstrdup(v);
> -               return 0;
> -       }
> +       if (!strcmp(k, "commit.template"))
> +               return git_config_string(&template_file, k, v);

There is the same bug in "wt-status.c". I will send a fix for this one.

So (for the patch series):

Tested-by: Christian Couder <chriscool@tuxfamily.org>

Thanks,
Christian.
