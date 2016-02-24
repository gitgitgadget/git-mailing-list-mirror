From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Wed, 24 Feb 2016 15:37:22 -0500
Organization: Twitter
Message-ID: <1456346242.18017.16.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
	 <CACsJy8BQZCBpfmvXk+o5PqM7=zad7cxgA9B2995Rb0D0YBxEVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:37:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgBe-00010k-RU
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbcBXUh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:37:26 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36745 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbcBXUhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:37:25 -0500
Received: by mail-qg0-f53.google.com with SMTP id y9so24430726qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=2TTxUjakc5/u8AyTUGLo2g/2Zlime+EVgiB0u9p2P3U=;
        b=W2LtTnAePDiGrpM2SdCfMdgJdZwRG/uffxcHd+FL5LGtSOhDvtgryGgxn787PGNw8F
         Zv2DmxP5NPqR0MNOun9v3/77xJtoE7GFQN+Kfuw2Ejve5Kck3v8y6p53hNlNTXcw6b+/
         Enc9SiTS4HrOnc3BhR1nruMNEJYHOU8ArCOLvpLpqX+yswSt3BgT1SPfVROMqX/Vbe07
         UbwVZqKYEDN5yilzcI5FY5oVVwiFu2kvFuNT+HBpVTkpOziXsRGocHt9BLI2xvbmU7qc
         RANuiPG9tRcIlQYTDf+i/Qzm7981iX910ptOsQS5MwoH+Je7RF1m+bSmtzJB+P3P39CX
         DYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=2TTxUjakc5/u8AyTUGLo2g/2Zlime+EVgiB0u9p2P3U=;
        b=B+2JHk1Tq7N9ZcH4+MGd3kn1W5OxLJ4lAOsfbH6t9sPnqO25RFUVOsZQ2j/x3KM6/h
         BW8YykgpWx0kqXGLfFChGnQ6Z/NJidarBkhuhnzQzyobGNQdCFXkiItgcbP7PG7iD9jv
         wC1Vy2EqEqNwNHZuTHHNgIoqHl8Puuqxihv4nTnl4vo0y0NQ/8DhubjKxqqt53bJBEFp
         LcWlF3hf1IClP6fe8klZFWb6RTF7poBmr6ofhp2aQV0dENJ402zik5TukSCxrGOnZzGU
         G95/kKAPU+HHft//j3MOGCQRSXHPR5W9SkF8snigV7G0KNhB/yb5PkMrBSVBzoi9limn
         uf4w==
X-Gm-Message-State: AG10YOTaDoQcUU65nfrrTZBbBUFD5PgLh2LlMTe8AtU0MYPZ8NRFLOYcK+m0OCPyeVZI7Q==
X-Received: by 10.140.19.132 with SMTP id 4mr51346955qgh.56.1456346244438;
        Wed, 24 Feb 2016 12:37:24 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id u16sm1924444qki.15.2016.02.24.12.37.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 12:37:23 -0800 (PST)
In-Reply-To: <CACsJy8BQZCBpfmvXk+o5PqM7=zad7cxgA9B2995Rb0D0YBxEVw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287223>

On Sat, 2016-02-20 at 15:59 +0700, Duy Nguyen wrote:
> On Thu, Feb 18, 2016 at 12:17 PM, David Turner <
> dturner@twopensource.com> wrote:
> > LMDB has a few features that make it suitable for usage in git:
> > ...
> 
> I'm reading lmdb documents and hitting  the caveat section [1].
> Random thoughts
> 
> * "There is normally no pure read-only mode, since readers need write
> access to locks and lock file.".
> 
> This will be a problem for server side that serves git:// protocol
> only. Some of those servers disable write access to the entire
> repository and git still works fine (but won't when lmdb is used).
> Should we do something in this case? Just tell server admins to relax
> file access, or use MDB_NOLOCK (and when? based on config var?)

MDB_NOLOCK is a good idea. I'm going to add this to the "Weaknesses"
section of the docs and plan to fix it later, unless you feel strongly
otherwise.

> *  " Use an MDB_env* in the process which opened it, without
> fork()ing.". We do use fork on non-Windows in run-command.c, but it
> should be followed by exec() with no ref access in between, so we're
> almost good.
> 
> I notice atexit() is used in this for/exec code, which reminds me we
> also use atexit() in many other places. I hope none of them access
> refs, or we could be in trouble.

I don't think they should do that anyway -- it's too much complexity
for an atexit handler.

> * "Do not have open an LMDB database twice in the same process at the
> same time. Not even from a plain open() call - close()ing it breaks
> flock() advisory locking"
> 
> I wonder what happens if we do open twice, will it error out or
> silently ignore and move on? Because if it's the latter case, we need
> some protection from the caller and I'm not sure if
> lmdb-backend.c:init_env() has it, especially when it open submodule's
> lmdb.

I think LMDB could check this, but it doesn't seem to. I've refactored
some of the submodule transaction stuff so that now we have more
protection there.

> * "Avoid long-lived transactions...."
> 
> OK we don't have a problem with this. But it makes me realize lmdb
> transactions do not map with ref transactions. We don't open lmdb
> transaction at ref_transaction_begin(), for example. Is it simply
> more
> convenient to do transactions the current way, or is it impossible or
> incorrect to attach lmdb transactions to ref_transaction_*()?

That was what I did originally, but reviewers here noted that it had
some problems:
1. What if, while a transaction is open, git opens a subprocess that
wants to make its own transaction?  There can only be one writer
transaction open at a time.
2. As you note, long-lived transactions.

Also, the files backend also doesn't do any locking until the last
moment, and it's reasonable to try to be compatible with that.

> * "Avoid aborting a process with an active transaction. The
> transaction becomes "long-lived" as above until a check for stale
> readers is performed or the lockfile is reset, since the process may
> not remove it from the lockfile."
> 
> Does it mean we should at atexit() and signal handler to release
> currently active transaction?

Probably a good idea.

> * "Do not use LMDB databases on remote filesystems, even between
> processes on the same host. This breaks flock() on some OSes,
> possibly
> memory map sync, and certainly sync between programs on different
> hosts."
> 
> OK can't do anything about it anyway, but maybe it should be
> mentioned
> somewhere in Git documentation.

Sure.

> * "Opening a database can fail if another process is opening or
> closing it at exactly the same time."
> 
> We have some retry logic in resolve_ref_1(). Do we need the same for
> lmdb? Not very important though.
> 
> [1] http://symas.com/mdb/doc/

wat.

OK, I'll add a retry loop on that.  I guess we can just keep retrying
on EACCES or EAGAIN.
