From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: SVN clone on Cygwin drops a / and reports "not a complete URL"
Date: Tue, 15 Mar 2016 16:23:44 +0000
Message-ID: <20160315162344.GM29016@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:23:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afrlC-0000CH-0B
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbcCOQXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:23:50 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37092 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbcCOQXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:23:49 -0400
Received: by mail-wm0-f42.google.com with SMTP id p65so34438094wmp.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZF1XtaMQUEzdvn5sqFkNIP1DwAGvg8Z+RZpfmOOH4jo=;
        b=GRUdiDQa2WyXrtqh+r3l1iuo2WaJz2jAeGOBmyHCdhC/lW5xWSJKfdTIAJmWyGBE2t
         OY1U8l5WmAH/CyVwKPhpnlnF0A99CXyLKWiafeNr5Bf8cBzNksqP9YorZDj/Jx+bxphP
         PUhnOtvtFfm1UQ9MpOCzSp+mIT8pTKrtG4Dik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZF1XtaMQUEzdvn5sqFkNIP1DwAGvg8Z+RZpfmOOH4jo=;
        b=GH6fCawX1eqJyv63A3pl+aqJtKvPa3GB7Jlkgoz8nk9C5BdA1cnJEe5DcUNZNa9GYj
         ONlnr5D0ySfTPigGnroVwq3dXjQiXYkBDbdXunxUzd3c86Qx0zHMkOaZ3ZeOlkArEOya
         wQYnlMhcnFb1rZ/bT6cRkokqx0LcbQyg5pFhCnbb2XbcDuXm3aXM/OafhNqH9LUEPPi5
         /6+xFPuXzGSQiTC9mLGpUHQazqkFMVciVrpdYdV4cCvoZACP3wfzPSFWNqY4BdTu0erS
         CtyU/mUTr8ezYLglsDIs8R4V1ouldpPFyLYQrcm4jbkbc6lpMg3zoDQr4IDS8pWlxw21
         0Frw==
X-Gm-Message-State: AD7BkJJaPAZZUAp/G2pT/ORbo8jXTXxerJla8w8oWCkptzZ0UxllwocXzUEkl43avnYTfw==
X-Received: by 10.28.19.204 with SMTP id 195mr26401722wmt.1.1458059027197;
        Tue, 15 Mar 2016 09:23:47 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id ls5sm27653591wjb.33.2016.03.15.09.23.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:23:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288859>

Hi all,

Currently, attempting to clone a Subversion repository using an svn://
or https:// URI specified with -T fails on Cygwin:

    $ git svn init -T svn://svn.code.sf.net/p/squirrelmail/code/trunk
    Initialized empty Git repository in /home/add/tmp/.git/
    E: 'svn:/svn.code.sf.net/p/squirrelmail/code/trunk' is not a complete URL  and a separate URL is not specified

I don't think this is a problem in Git itself -- I see the same
behaviour on clean builds of both v2.7.0 and v2.2.0, and I'm pretty sure
this used to work, so that would imply there's something in the Cygwin
environment that's changed.  Nonetheless I'm reporting here in the hope
that somebody else will have seen a similar problem or have an idea what
might be going wrong.

Interestingly, the below _does_ work:

    $ git svn init svn://svn.code.sf.net/p/squirrelmail/code
    Initialized empty Git repository in /home/add/tmp/.git/

    $ git config svn-remote.svn.fetch trunk:refs/remotes/origin/trunk

    $ git svn fetch
    r1 = 12dc820c417dc5f12723307a3fcfa4629ea972fb (refs/remotes/origin/trunk)
            A       squirrelmail/ATHORS
            A       squirrelmail/login.php3
            A       squirrelmail/signout.php3
    ...

There are no obvious test case failures, either.

Does anyone have any ideas about what might be going wrong?
