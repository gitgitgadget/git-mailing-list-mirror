From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 15 Apr 2016 16:19:01 -0400
Organization: Twitter
Message-ID: <1460751541.5540.90.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com>
	 <1460573236.5540.83.camel@twopensource.com>
	 <CACsJy8CV4_AkcsmnWn4n1z15XesgHdw-g0UNMqm2EgsyQWDixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy =?UTF-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.co>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:19:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arACu-0007mt-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbcDOUTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:19:07 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34793 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcDOUTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:19:05 -0400
Received: by mail-qg0-f41.google.com with SMTP id c6so87868192qga.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ZJhsO+sZoIVTpvK1Mme8NObnFCcEAAl7xYjUJDQAJ6Q=;
        b=juhOMhRuiCUJqbVUFPzpe2eX9wrf0qObIl5Pic3B72g/lnwUpcc+d2hSjHheS+IHM9
         WV/rdjrVUl2yt4d28Fa4jSYClguqZBVWJiOkc7EE4XWkyR1z2Zdgtcasz79O5sCoF1lo
         CSt4Q71Fo1B5fTENYVWocEL2r2ENmjdqI4Bvu1BVrfjo2n5dpNw6LqwVhw++CKyoF8mc
         OvZucCtMWDEdli35h9RCWYcskAgddiCT5Id5DxAddlyXOgPwbAZKWLjMp9EScMKM/jTL
         Ir77D6nfscJU3cpznJbioyJi1fEIb7KUGR/AkPCe9vadNOely4dzxAjGrKYOT2Suc/Em
         r7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ZJhsO+sZoIVTpvK1Mme8NObnFCcEAAl7xYjUJDQAJ6Q=;
        b=M19eOvlD+nZZnuym78WJiQ9kGxZJAK8nypa1XmAC5BFn8qerHt/GsZVgqJU7qbQA3t
         +OQwPkQ9UdZjJAR3groz9ikftXliU5lDKeTzk1iRJGzBaTzJmL9vKMMlnyh06e1w5Wrv
         saAO3ZmJKGVaTF8H7Amjr19UDk8LROZt/g8C/ypWvdrlBcdfV+LWAZirlJpzNU95aTgF
         yYZAmpZyvpik6FxR3yXuzZQBMa4QDUXy1fAPHZ0s73tXQJe2R9thbmBY32r2mPa6O67G
         Jey+bOHE3+1yMg5YteQ69dLUf/D45XiwHAr4Jfln4fHRLbiwASk5F+jUMVTSwlsRBq6I
         gDfg==
X-Gm-Message-State: AOPr4FXQk6pdEfwQw50+E7wGemDTcs0X7OSmYPkad2TQNc1Cdqf+Naqs+NzEkxtz+zoPPg==
X-Received: by 10.140.27.182 with SMTP id 51mr27080025qgx.4.1460751544022;
        Fri, 15 Apr 2016 13:19:04 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p38sm3601467qgd.6.2016.04.15.13.19.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 13:19:02 -0700 (PDT)
In-Reply-To: <CACsJy8CV4_AkcsmnWn4n1z15XesgHdw-g0UNMqm2EgsyQWDixw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291654>

On Thu, 2016-04-14 at 17:04 +0700, Duy Nguyen wrote:
> On Thu, Apr 14, 2016 at 1:47 AM, David Turner <
> dturner@twopensource.com> wrote:
> > On Wed, 2016-04-13 at 20:43 +0700, Duy Nguyen wrote:
> > > On Wed, Apr 13, 2016 at 7:32 AM, David Turner <
> > > dturner@twopensource.com> wrote:
> > > > +NOTES
> > > > +-----
> > > > +
> > > > +$GIT_DIR/index-helper.path is a symlink
> > > 
> > > In multiple worktree context, this file will be per-worktree. So
> > > we
> > > have one daemon per worktree. I think that's fine.
> > > 
> > > > to a directory in $TMPDIR
> > > > +containing a Unix domain socket called 's' that the daemon
> > > > reads
> > > > +commands from.
> > > 
> > > Oops. I stand corrected, now it's one daemon per repository...
> > > Probably good to hide the socket path in $GIT_DIR though, people
> > > may
> > > protect it with dir permission of one of ancestor directories.
> > 
> > I'm not sure I understand what you're saying here.  It should be
> > one
> > daemon per worktree, I think.  And as far as I know, it is.
> 
> No you're right, it's still per worktree. I assumed
> $GIT_DIR/index-helper.path points to the same $TMPDIR, but it's not.
> 
> > Socket paths must be short (less than 104 chars on Mac).  That's
> > why I
> > do the weird symlink-to-tmpdir thing.
> 
> Is relative path in sun_path portable? We could just chdir() there,
> open the socket and chdir() back. Though if the current solution's
> already good enough, I don't think we need to change this again.
> 
> Hmm.. googling a bit pointed me back to Jeff's patch that does
> exactly
> that. The commit is 1eb10f4 (unix-socket: handle long socket
> pathnames
> - 2012-01-09). It does not mention Mac though, neither does the
> related discussion on mailing list..

In that case, I guess we can put the socket in $GITDIR and save the
annoyance of the temp dir.  Seems legit to me.
