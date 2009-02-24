From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2009 Prospective student
Date: Tue, 24 Feb 2009 22:08:11 +0100
Message-ID: <200902242208.14199.jnareb@gmail.com>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com> <200902241638.08300.jnareb@gmail.com> <20090224155539.GU22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4XE-0000lo-FY
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbZBXVIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756813AbZBXVIV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:08:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:31006 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbZBXVIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:08:20 -0500
Received: by fg-out-1718.google.com with SMTP id 16so157133fgg.17
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cGYRw/87yurddP0NbSqt6f3LI5k/v/PCcVustOWL3mo=;
        b=j7bqiOsfO/mJTNj1Fboqb4l0iiAQkuODsCH+LUFq47owInTRawfJfio3cPf2jHMyIG
         ArlTCVKrqax9ojyKfnvNulkqyXGR69F83KQBqIjQ+ZEHHpdXsGAsXnS3bkSbOHI0A3my
         F4e28V4QzQWRPjjpXnOoPxE91u1IzjNDdUko4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gQhcQS4u8tLpiy+Cktu1Hk6PWj3CB5WUF/v7Yvct/3IYQWLuTVpVnBFYgP5ElKN3ZU
         wQAGnF0FFGQ6+0Iks8nk0+aXDjv7PxZiYc7wMdJE7sJ9l88tZYzoC9wJTfeCr+G9PVpM
         3VO9tSL7xgIH/HAv5ERbeVEJ21Vhs7DCjeo8s=
Received: by 10.86.28.2 with SMTP id b2mr14350fgb.75.1235509696457;
        Tue, 24 Feb 2009 13:08:16 -0800 (PST)
Received: from ?192.168.1.15? (abvk114.neoplus.adsl.tpnet.pl [83.8.208.114])
        by mx.google.com with ESMTPS id e11sm1751994fga.30.2009.02.24.13.08.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:08:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090224155539.GU22848@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111340>

On Tue, 24 Feb 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > 
> > I (and Nicolas) by 'sorting order' mean here ordering of objects and
> > deltas in the pack file, i.e. whether we get _exactly_ the same (byte
> > for byte) packfile for the same want/have exchange (your proposal), or
> > even for the same arguments to git-pack-objects (which is a necessary,
> > although I think not sufficient condition).
> 
> I know.
> 
> My proposal though didn't require the same byte-for-byte pack file.
> Only that the objects were in a predictable order.  It didn't permit
> resuming in the middle of an object.  If the last object in the pack
> was truncated the client would resume by getting that object again,
> and may get a different byte sequence for that object representation.

Ah, so you meant skipping first N _objects_, and not first N _bytes_
of a re-generated pack.  That's better.

Although in the case when packfiles are cached, I think you can support
resuming on a byte.  But I guess only in such case (where exactly
byte-for-byte the same packfile is resend / reused).

> 
> Its a b**ch to know where you stopped though, as you could be in
> a long string of deltas whose base is in the portion you didn't
> yet receive.  Which means you can't identify that string that you
> already have, and pack-objects on resume can't assume you have
> those objects, because you only have the deltas for them and are
> lacking a way to restore them.

Moreover from what I understand the want/have exchange is about 
_commits_, and it assumes that if you 'have' a commit, you have all
its ancestors, and all trees (including those of ancestors), and all
blobs (including those of ancestors).  Not only delta without base.
Besides if I remember correctly we always write base before delta; or
am I mistaken here?

But one could take a look at patches (present in git mailing list
archive) which tried to add 'lazy clone' / 'remote alternates' support.
IIRC there was 'haveonly' extension to exchange protocol, which was
to meant that you have (in full) only given object, but not necessary
its prerequisites.  Then you can filter out those 'haveonly' objects
from list of objects to pack fed to git-pack-object, isn't it?

> 
> > Can we assume that packfiles are named correctly (i.e. name of packfile
> > match SHA-1 footer)?
> 
> Wrong.
> 
> The hash in "pack-$hash.pack"/"pack-$hash.idx" is *not* the 20 byte
> SHA-1 footer.  Its the 20 byte SHA-1 of the sorted object names who
> are in that pack.
> 
> We should try not to assume that the pack's file name matches the
> sorted object names, but we can assume that the pack file name is
> "pack-$hash.pack" where $hash is a 40 character hexadecimal string.
> The dumb commit walkers already have this restriction built into
> them, and have for quite some time.
> 
> Any pack writers, including fast-import, honor this naming standard
> in order to ensure they are compatible with the existing dumb
> commit walkers.

Ah. So it is a _bit_ harder (for "dumb" protocols) than I thought.
Still much easier than resumable clone for smart (pack generating)
protocols.

>  
> > Therefore I think that restartable clone for "dumb" (commit walker)
> > protocols is easy GSoC project, while restartable clone for "smart"
> > (generate packfile) protocols is at least of medium difficulty, and
> > might be harder.
> 
> Probably quite right.  Unfortunately the majority of the git
> repositories out there are served with the smart protocol, because
> it is more efficient.  :)

Long, long time ago rsync:// protocol was recommended for initial clone.
It has serious disadvantage of possibly returning silently corrupted
repository, as it didn't ensure that references and objects were fetched
in correct sequence, and is thus deprecated, and support for it
bit-rotten ;) in places...

I wonder if it is possible to make rsync:// more robust...

[...]
> > I'll try to add 'pack file cache for git-daemon' proposal to 
> > GSoC2009Ideas page... but I cannot be mentor (or even co-mentor) for
> > this idea.
> 
> The pack file cache project is likely easier than restarting a
> pack file.  Especially in the face of the threaded delta code.
> 
> There are difficult details about making the cache secure so we can't
> overwrite repository data due to a buffer overflow.  Or making
> the cache prune itself so it doesn't run out of disk.  Etc.
> We've talked about a cache before on list.

Well, this is _cache_. OTOH having pack cache would make it easy to have
resumable clone if you hit one of cached packfiles on resume...

On the other hand I wonder what improvements it would give, as generating
packs with delta reuse is, I think, quite fast...

-- 
Jakub Narebski
Poland
