From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH/RFC] Pro-Git thanks, Control-flow bug report
Date: Mon, 25 Jul 2011 14:50:38 +0200
Message-ID: <20110725125037.GA24198@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 14:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlKcY-0003Xl-Dm
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 14:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab1GYMuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 08:50:50 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59732 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1GYMus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 08:50:48 -0400
Received: by fxd18 with SMTP id 18so9040262fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        bh=dz1W+CJckfUX+OtDVevPVVliPDC3I33qkQx4S1hFD2o=;
        b=PiJU+n0sWGOWVZU22nBIan4+74IzvJM7ELxf9ujM7wyV0IAGUnAxSWG5TMm1ez2tMo
         L2/3Yhuut+Y40suALroKSpsk+LCKIYtbtq+4wMx80ptC5Nz40md/05Xkxd8KuQvQc735
         54ksjzW+vBIfvx+ghRCIWomEQnWWn4O/lrh3c=
Received: by 10.223.13.69 with SMTP id b5mr459348faa.1.1311598247624;
        Mon, 25 Jul 2011 05:50:47 -0700 (PDT)
Received: from sherwood.local ([89.204.137.199])
        by mx.google.com with ESMTPS id e10sm3772771fak.42.2011.07.25.05.50.42
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 05:50:46 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177792>

Hello git(1),

first of all i have to say thanks to the guy who brought up
Pro-Git on this list a few weeks ago!
*Thank you, man*!  I love this book, and i *adore* chapter 9!
Beep beep actually beeping software!  Yes!!
(I hope you do this with adorable software only ...
Such a beep.  Beep.)

So while exploring git(1) i recently tried out colours (it's oh
so coloured for a two, since 2011 three colors vim(1) user -
fascinating) and found a control flow bug:

  ?0%0[steffen@sherwood git.git]$ ./git --version
  git version 1.7.6.233.gd79bc.dirty
  ?0%0[steffen@sherwood git.git]$ ./git -c color.ui=auto -c color.pager=false diff 2> AU; cat AU
  git_config_colorbool(color.ui,auto,-1)
    [pager_in_use(): spawned:0, GIT_PAGER_IN_USE:0]
    auto_color:1
    color acc. 2 getenv(TERM)
  git_default_config(color.pager,false): 0

So the pager is spawned after the color config setting has been
queried (and the latter is never updated).
I'm not aware of the codebase, and so i can't offer a patch,
unfortunately.  I tried the following change in color.c first,
but that's not a solution for the real problem:

  jauto_color:
	if (pager_in_use())
		stdout_is_tty = pager_use_color;
	else if (stdout_is_tty < 0)
		stdout_is_tty = isatty(1);
	if (stdout_is_tty) {
		...

--Steffen
Ciao, sdaoden(*)(gmail.com)
ASCII ribbon campaign           ( ) More nuclear fission plants
  against HTML e-mail            X    can serve more coloured
    and proprietary attachments / \     and sounding animations
