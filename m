From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 10 Mar 2016 15:22:21 -0500
Organization: Twitter
Message-ID: <1457641341.13557.32.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-5-git-send-email-dturner@twopensource.com>
	 <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
	 <xmqqpov3fdb6.fsf@gitster.mtv.corp.google.com>
	 <CACsJy8CqOOB6C6bWkVSEvtPuHxZR_avSb7z7hgo-vtv3gu44Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 21:22:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae76M-0007i4-Na
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 21:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbcCJUW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 15:22:26 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34930 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbcCJUWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 15:22:24 -0500
Received: by mail-qk0-f171.google.com with SMTP id o6so39471553qkc.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lRZAh3rKzMYGsB9HVkYnYOQDTGiUaZ8Dk+uHzmV8nMs=;
        b=hCkXaUnywxncnvxOmBUIvnoHRK0kV32GERseZ3vsEgiZ+C8QTly4GnM6XlxuHHqlo8
         W+shn7+1Jy1f5h9bwVFSLJAcmgbGiiVhddsZtoXyfLpknBxLEvG8UwMM0V4SF0J9qMxh
         R8+SosPYIHw7z3E+61ht7A+vtpOC2M6vRsZ3/jy5SgN7gmiNpdzg+uXvnppGrMNQE+En
         IMoYHpo2kdqEAr2K3TZxRVUvf+fSCkmXtk7DKqJjV3YzZUtzIxEincx6VSVdx2kh3r4J
         BeuQYYFvAcjjeaSGisAa2x7nKufXYhvPLrqhmZOQREtbIck1xEZUVt8V7ddCOuDYsYHY
         KVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lRZAh3rKzMYGsB9HVkYnYOQDTGiUaZ8Dk+uHzmV8nMs=;
        b=TmWDs2yiAI+YGirCjaPooEldzvJoPP+Lwsix6jBoFbJCUd5OCn7RP3mZED9l0aBWc6
         AdgR/UNv/hjHFMvpc070CjT1VhGvhCQHLu5MUku6iEL6oHOFpxZAeganiXi5k9mjINXI
         S9p43ski+AFeFruseanvwaL4fcb0ejyEMnlTcWdipyUaRVdvBlUMKirha3dF+KARiZ9w
         pwUVM+BIg5IpxVmOxANlbDnXgsI8efI4KQxzGoia2+F6eEoBtFfP9XgdaAxBavykWzVp
         t5l0SYvZgQkTPQwuG4DymJV/PTN6+gtsPztZhX1AlbpJsNR+wCIQv3wffxMxQGKmtoTI
         HAcw==
X-Gm-Message-State: AD7BkJIUJaEpFdHoD0GycfTJ7bQLxZYmUyRpLAucddgh2Ucn2VBFfuqb9HVcY3PH4QhPpA==
X-Received: by 10.55.207.217 with SMTP id v86mr6788641qkl.16.1457641343324;
        Thu, 10 Mar 2016 12:22:23 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y206sm2415556qhc.0.2016.03.10.12.22.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 12:22:22 -0800 (PST)
In-Reply-To: <CACsJy8CqOOB6C6bWkVSEvtPuHxZR_avSb7z7hgo-vtv3gu44Cg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288636>

On Thu, 2016-03-10 at 18:17 +0700, Duy Nguyen wrote:
> On Thu, Mar 10, 2016 at 6:21 AM, Junio C Hamano <gitster@pobox.com>
> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > > David Turner <dturner@twopensource.com> writes:
> > >=20
> > > > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
> > > >=20
> > > > Instead of reading the index from disk and worrying about disk
> > > > corruption, the index is cached in memory (memory bit-flips
> > > > happen
> > > > too, but hopefully less often). The result is faster read. Read
> > > > time
> > > > is reduced by 70%.
> > > >=20
> > > > The biggest gain is not having to verify the trailing SHA-1,
> > > > which
> > > > takes lots of time especially on large index files.
> >=20
> > Come to think of it, wouldn't it be far less intrusive change to
> > just put the index on a ramdisk and skip the trailing SHA-1
> > verification, to obtain a similar result with the same trade off
> > (i.e. blindly trusting memory instead of being paranoid)?
>=20
> I'm straying off-topic again because this reminded me about lmdb :)
> For the record when I looked at lmdb I thought of using it as an
> index
> format too. It has everything we wanted in index-v5. Good enough that
> we would not need index-helper and split-index to work around current
> index format. Though I finally decided it didn't fit well.
>=20
> On the good side, lmdb is b+ trees, we can update directly on disk
> (without rewriting whole file), read directly from mmap'd file and
> not
> worry about corrupting it. There's no SHA-1 verification either (and
> we can do crc32 per entry if we want too). It's good.
>=20
> But, it does not fit well the our locking model (but we can change
> this). And we sometimes want to create temporary throw-away indexes
> (e.g. partial commits) which I don't think is easy to do. And the
> reading directly from mmap does not give us much because we have to
> do
> byte endian conversion  anyway.
>=20
> Hmm.. on second thought, even though lmdb can't be the default format
> (for a bunch of other limitations), it can still be an option for
> super big worktrees, just like index-helper being an optional
> optimization. Hm.. hm.. if we can support lmdb as index format in
> addition to the current format, bringing back some work from Thomas..
> We may still need a daemon or something to deal with watchman, but
> the
> underlying mechanism is exactly the same... David, Junio, what do you
> think?

LMDB makes writes faster, since we only have to write the stuff that's
changed.  That's good.

Reads (ignoring SHA verification) will be slightly slower (due to the
btree overhead).  If, in general, we only had to read part of the
index, that would be faster. But a fair amount of git code is written
to assume that it is reasonable to iterate over the whole index.  So I
don't see a win from just switching to LMDB without other changes.

(I guess we could parallelize index deserialization more easily with
lmdb, but I don't know=20

The original intent of the index was to be a "staging area" to build up
a tree before committing it.  This implies an alternate view of the
index as a diff against some (possibly-empty) tree.  An index diff or
status operation, then, just requires iterating over the changes.=20

I haven't really dug into merges to understand whether it would be
reasonable for them to use a representation like this, and what that
would do to speed there.

In general, git takes the commit side of the commit-diff duality. This
is generally a good thing, because commits are simpler to reason about.
But I wonder if we could do better for this specific case.

But I don't think switching to LMDB would replace index-helper.
