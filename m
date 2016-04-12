From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 12 Apr 2016 13:28:28 -0400
Organization: Twitter
Message-ID: <1460482108.5540.59.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	 <1460153784.5540.19.camel@twopensource.com>
	 <1460417232.5540.53.camel@twopensource.com>
	 <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 19:28:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq27A-00015p-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 19:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933896AbcDLR2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 13:28:32 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36381 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165AbcDLR2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 13:28:31 -0400
Received: by mail-qg0-f49.google.com with SMTP id f52so21783509qga.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ySwf/lUwGY6B52rnGk/9/cOVZrgwfKv9md6A5sHC2cs=;
        b=jNQnM2M3YxVH4oeX9SX0QpPjjfi9N5SGyiPhroByiY2dTbuF4WWYTz1gXW7n4lcxrD
         NBNhal/AnzP7jmzPwTfbv7iogfg3agBYW6Oa+HVEX816zt4dERLTsGOKdcETrArZ+92V
         Yi1/l3DXUdQDXbfXKWuQvAuny//zDoJhsHO4d6hrJpAB44YmslckM7W5DnPy5IHIIV1Y
         mI2wX0gYHcwlWkDsjZ3KfjB2MRUo1+LhOra/NdVd1aIUfDbnh4Zv1yutRBq42HRBAI5Z
         3gm8GjNpsWnesQnFtIKEUsuUON9OoBU8rg54pbfFiB5qb8/m1Q5etE5rc9vr9LrGMqdz
         A1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ySwf/lUwGY6B52rnGk/9/cOVZrgwfKv9md6A5sHC2cs=;
        b=Eu/hqGjHDEf5PrrjlHOyEacaT9t8s59O7sVAcLuZH9p9UzIIL4Whr6vEM0dmieSNoo
         7uJ1SOP/y5ekCPWRa1mNCvYdzX9dVZEHnKKd3QaN8Ug1kak2dN9Kem0h1Xvy+bQLi+w4
         tkECaWbkpzpwlIS1dzKY1EWmlJrN6coj+LFhIYbMaQG4W8ELCaBSfj19GImzU8LEnft+
         Z9pzylr8uh9vnvGnXEPA+DLe9QZlnx425tV82ymmV1nD/LP9qX3qOlYn2cwCDqgz4qvH
         5/jDG2Acr22yOhjWMewZ3h8hceCV3LUCMiGUn2Z/u+c4Zy38YEn5kb3rljP3aaG1mehv
         s0AQ==
X-Gm-Message-State: AOPr4FUq1s6rI7sKPnS7VzyCGX05vV/5bX9pscPJ3QytGNGznhUxIwnbmG91UThXww09wQ==
X-Received: by 10.140.141.6 with SMTP id 6mr5786633qhn.82.1460482110598;
        Tue, 12 Apr 2016 10:28:30 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm14042842qkb.39.2016.04.12.10.28.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 10:28:29 -0700 (PDT)
In-Reply-To: <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291284>

On Tue, 2016-04-12 at 16:40 +0700, Duy Nguyen wrote:
> On Tue, Apr 12, 2016 at 6:27 AM, David Turner <
> dturner@twopensource.com> wrote:
> > On Fri, 2016-04-08 at 18:16 -0400, David Turner wrote:
> > > And SHM on Macs works a bit differently than on Linux in at least
> > > two
> > > irritating ways.
> > > 
> > > So, uh, new version to come once I actually make it work on Mac.
> > > Probably Monday.
> > 
> > I was chatting with a friend about this and he mentioned that SHM
> > does
> > not really fit well into the Unix "everything is a file" model.  It
> > lives in a separate namespace, and still requires most of the file
> > -like
> > operations just with funny names and a separate namespace:
> > shm_open,
> > shm_unlink.  This weirdness is something I noticed in my porting
> > work:
> > on OS X, a shm name can only be 32 bytes long, requiring weird
> > hacks.
> > And on OSX, fstat on a shm fd is rounded up to the page size (!).
> >  There may also be other portability issues that I have not yet
> > discovered.
> > 
> > Instead, my friend suggests that we should just use files.  For
> > instance, we could do $TMPDIR/$index_helper_pid/shm-index.$sha.
> > 
> > (I'm proposing $TMPDIR because it's cleaned up on reboot so we
> > don't
> > need any manual intervention or complicated gc schemes)
> > 
> > What do folks think of this?
> 
> I avoided actual files for two reasons
> 
>  - disk error rate is higher than memory one, and we might need
> trailing SHA-1 back

This only matters if we ever *read* the mmap off disk.  But that will
rarely happen -- usually, everything will stay in memory.  Also, we
never worry about disk errors for other git objects (e.g. blobs,
commits, or trees), so it seems silly to worry for the index.

>  - access is slow (unless cached, but we can't be sure)

We could solve this (and the other problem) with mlock.

> If we can keep index-helper stuff on tmpfs or similar, then it would
> address both, but that's even more OS-specific than shm. If we have a
> good abstraction layer then people can put stuff on $TMPDIR on Mac,
> for example. But then it's not full POSIX file interface anymore...
> And you forgot Windows which does not strictly follow UNIX design.

As I understand it, Windows does support MAP_SHARED but not shm_open. 
 So Windows-specific stuff has to be done for shm_open but not for
files.
