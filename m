From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 13 Apr 2016 14:47:16 -0400
Organization: Twitter
Message-ID: <1460573236.5540.83.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy =?UTF-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.co>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqPoy-00047D-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 20:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbcDMSrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 14:47:20 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33201 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbcDMSrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 14:47:19 -0400
Received: by mail-qg0-f54.google.com with SMTP id j35so50149979qge.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=o+Q5PPhT9B0Eo7uFdctRWGY+wpfJgEItyYIdQTbhEu8=;
        b=1D5OE4LIHqe6LqOq9LK/Fazn4hvAfva5FIT7oiUd5xPmmVI7v17B62OBlztWQgign+
         B7Q87jQuo4ZkRRycXimWN8rwAFp9iLif1DAFtESVn4sDDJsm/1+/yzFodTGOktUKghNy
         eQGMk0ZablacSHcH2TPK0rOGCQRdearLjkUX0RwgtcfuDfyCS92vkhG9HWkMLupKxi9k
         APQZvOhlrhHQSpmBcGVECvxw9xlImd8n6tlaSGpvt9URsLeMCgTGO6V5b2veRH/DfQt2
         ifzC2fjLNxbwfXo2lulU/x4hvKi7a3bn5tNGIqKwLHBOI+11TbpQySS3H760+ibfwW2u
         tqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=o+Q5PPhT9B0Eo7uFdctRWGY+wpfJgEItyYIdQTbhEu8=;
        b=P2ximcU6Jy+sUNeZwKdslvmsyERkZQhMDYaRanrQWo7tXruG6/HqD14AmwdlvU/JxH
         qJr27u6G3EL82jX7K2CDnOGTc6hI8WNSYYR1J07sf4yTxfcMKpcDvgmPP2wZ65pstgTh
         D+euAWOdLmlkPZdLRmoWD/CLVw8b3DZYeX1t6lUfIFl6IGL4QmaCWgPLtGyN2GrhVPFG
         Mi99T/S8ku+cKc63zULZKwXJ72GNb0YTAvYISL7SlAe9RSbUHdlQJD0qr/rXBXuX5KSs
         CWcG2fRoFs22p9xjwMUHl0JzK+zCd0pBFFVsGMueIFtYMmL3dtvU2owNLEkEfII2osTe
         +Fvg==
X-Gm-Message-State: AOPr4FVl8zXSq2kg6kPC9/kLlnCipcJg6uuJ3kwSoUncFqBj/kf65WRUCq6eWGkJ2pi1Rw==
X-Received: by 10.140.20.204 with SMTP id 70mr13355122qgj.38.1460573238550;
        Wed, 13 Apr 2016 11:47:18 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 7sm16376017qhx.24.2016.04.13.11.47.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2016 11:47:17 -0700 (PDT)
In-Reply-To: <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291476>

On Wed, 2016-04-13 at 20:43 +0700, Duy Nguyen wrote:
> On Wed, Apr 13, 2016 at 7:32 AM, David Turner <
> dturner@twopensource.com> wrote:
> > +NOTES
> > +-----
> > +
> > +$GIT_DIR/index-helper.path is a symlink
> 
> In multiple worktree context, this file will be per-worktree. So we
> have one daemon per worktree. I think that's fine.
> 
> > to a directory in $TMPDIR
> > +containing a Unix domain socket called 's' that the daemon reads
> > +commands from.
> 
> Oops. I stand corrected, now it's one daemon per repository...
> Probably good to hide the socket path in $GIT_DIR though, people may
> protect it with dir permission of one of ancestor directories.

I'm not sure I understand what you're saying here.  It should be one
daemon per worktree, I think.  And as far as I know, it is.  

Socket paths must be short (less than 104 chars on Mac).  That's why I
do the weird symlink-to-tmpdir thing.

> > The directory will also contain files named
> > +"git-index-<SHA1>".  These are used as backing stores for shared
> > +memory.  Normally the daemon will clean up these files when it
> > exits
> > +or when they are no longer relevant.  But if it crashes, some
> > objects
> > +could remain there and they can be safely deleted with "rm"
> > +command.
> 
> Alternatively, we could store all these in $GIT_DIR/helper or
> something and clean up automatically when index-helper starts. But I
> guess at least with TMPDIR we have a chance to put them on tmpfs.
> > +#define UNIX_PATH_MAX 92
> > +#endif
> > +
> 
> This looks like dead code (or at least not used in this patch).

Yep, thanks.

> > +       fd = unix_stream_connect(socket_path);
> > +       if (refresh_cache) {
> > +               ret = write_in_full(fd, "refresh", 8) != 8;
> 
> Since we've moved to unix socket and had bidirectional communication,
> it's probably a good idea to read an "ok" back, giving index-helper
> time to prepare the cache. As I recall the last discussion with
> Johannes, missing a cache here when the index is around 300MB could
> hurt more than wait patiently once and have it ready next time.

It is somewhat slower to wait for the daemon (which requires a disk
load + a memcpy) than it is to just load it ourselves (which is just a
disk load). 
