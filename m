From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 03/17] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 29 Mar 2016 17:51:59 -0400
Organization: Twitter
Message-ID: <1459288319.2976.16.camel@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
	 <1458349490-1704-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8Bk19NNacDwez6BzicThnVUDQEoGe3m+ThiorP8uP9+eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:52:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al1YX-0006GR-42
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 23:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206AbcC2VwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 17:52:04 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35871 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbcC2VwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 17:52:03 -0400
Received: by mail-qk0-f176.google.com with SMTP id i4so12209137qkc.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ppoG6cchfSvSYdA8jA6cLWIRH9laHgXuUlClFtpD9uo=;
        b=WcX/q1MU5+PvGpR7tlEXIotNH2J9gK+K7J3DzTjrISRqdVLIiLgU5U14mqDDLq28GW
         T2JbqsJDjicCiLUW9hfR8jukkl3QfOeq2h1D7/OxdJw5jJWI52FnzXEgeotEN4expbYB
         p8VYpNj/TTmWFR6TUaHn3zymwp48J+aRW+F7E7dBsqXkBj3/L8luAjlhgdlLFDmNOZuQ
         KP3MuYhb3LVg1SDTgwWwltIheye9ElFawJ4e3kBFIKm8xDb1wMRlz9t8heBPKRsLFZWX
         HKW+PAbHea/RakMKJXlA/1chKhMKZLV+YRvJRyvNMvRQ8jeGQQNBMpGlRkKkcwWZDE6C
         XdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ppoG6cchfSvSYdA8jA6cLWIRH9laHgXuUlClFtpD9uo=;
        b=XBiq+tZPKz7lgj2um2+PanCvXdwdjSrLDj16ODFykLFbdbC3mKCZxFyEU4qweu1z2i
         aQGcED5xtbR1sKtekX85lPLphz6av+vGCKMnZRMzaFjUtwxwG1F5LSI3OiOrYmNj4ZTS
         oWEpCoDhMfIiCu9jHZhTr5XgC017HV5uzymHrEAEt2AFnFm58CNmNA9rpm5CRK75z9WT
         kKJHlZwFBbZZG0aFZ3uuRfFERof46nOSI2xD0zKDQkRfATsL0kDTji9rLYASzxnHlbOx
         2KBylKpl24U/PD41bCu7O30orBYu5uEXrJqQW9BdVe0/KEo689j60u3gy46ahFq3R+hW
         SUQg==
X-Gm-Message-State: AD7BkJKFL0gVZ2MqBXVdAuXeV6Z2puvgREnHq4xzYh4Y9VRvd9174/RrlwF2x2cCZsTSGg==
X-Received: by 10.55.78.201 with SMTP id c192mr5911326qkb.9.1459288321309;
        Tue, 29 Mar 2016 14:52:01 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id b85sm365243qhc.23.2016.03.29.14.52.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2016 14:52:00 -0700 (PDT)
In-Reply-To: <CACsJy8Bk19NNacDwez6BzicThnVUDQEoGe3m+ThiorP8uP9+eA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290200>

On Tue, 2016-03-29 at 09:31 +0700, Duy Nguyen wrote:
> On Sat, Mar 19, 2016 at 8:04 AM, David Turner <
> dturner@twopensource.com> wrote:
> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> >=20
> > Instead of reading the index from disk and worrying about disk
> > corruption, the index is cached in memory (memory bit-flips happen
> > too, but hopefully less often). The result is faster read. Read
> > time
> > is reduced by 70%.
> >=20
> > The biggest gain is not having to verify the trailing SHA-1, which
> > takes lots of time especially on large index files. But this also
> > opens doors for further optimiztions:
> >=20
> >  - we could create an in-memory format that's essentially the
> > memory
> >    dump of the index to eliminate most of parsing/allocation
> >    overhead. The mmap'd memory can be used straight away.
> > Experiment
> >    [1] shows we could reduce read time by 88%.
>=20
> This reference [1] is missing (even in my old version). I believe
> it's
> http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=3D=
2
> 48771,
> comparing 256.442ms in that mail with v4 number, 2245.113ms in 0/8
> mail from the same thread.
>=20
> > Git can poke the daemon via named pipes to tell it to refresh the
> > index cache, or to keep it alive some more minutes. It can't give
> > any
> > real index data directly to the daemon. Real data goes to disk
> > first,
> > then the daemon reads and verifies it from there. Poking only
> > happens
> > for $GIT_DIR/index, not temporary index files.
>=20
> I think we should go with unix socket on *nix platform instead of
> named pipe. UNIX named pipe only allows one communication channel at
> a
> time. Windows named pipe is different and allows multiple clients,
> which is the same as unix socket.
>=20
>=20
> > $GIT_DIR/index-helper.pipe is the named pipe for daemon process.
> > The
> > daemon reads from the pipe and executes commands.  Commands that
> > need
> > replies from the daemon will have to open their own pipe, since a
> > named pipe should only have one reader.  Unix domain sockets don't
> > have this problem, but are less portable.
>=20
> Hm..NO_UNIX_SOCKETS is only set for Windows in config.mak.uname and
> Windows will need to be specially tailored anyway, I think unix
> socket
> would be more elegant.

One annoyance with unix sockets is that they must have short paths
(UNIX_PATH_MAX -- about a hundred characters).  This basically means
they should be in $TMPDIR.  I guess we could go back to pid files in
$GIT_DIR, and then have a socket named after the pid.  There's also
some security issues, but it actually looks like there's a simple
enough workaround for them.

I'll change this, but it might take a bit as I'm busy with other things
this week.

> > +static void share_index(struct index_state *istate, struct shm
> > *is)
> > +{
> > +       void *new_mmap;
> > +       if (istate->mmap_size <=3D 20 ||
> > +           hashcmp(istate->sha1,
> > +                   (unsigned char *)istate->mmap + istate
> > ->mmap_size - 20) ||
> > +           !hashcmp(istate->sha1, is->sha1) ||
> > +           git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate
> > ->mmap_size,
> > +                       &new_mmap, PROT_READ | PROT_WRITE,
> > MAP_SHARED,
> > +                       "git-index-%s", sha1_to_hex(istate->sha1))
> > < 0)
> > +               return;
> > +
> > +       release_index_shm(is);
> > +       is->size =3D istate->mmap_size;
> > +       is->shm =3D new_mmap;
> > +       hashcpy(is->sha1, istate->sha1);
> > +       memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
> > +
> > +       /*
> > +        * The trailing hash must be written last after everything
> > is
> > +        * written. It's the indication that the shared memory is
> > now
> > +        * ready.
> > +        */
> > +       hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20,
> > is->sha1);
>=20
> You commented here [1] a long time ago about memory barrier. I'm not
> entirely sure if compilers dare to reorder function calls, but when
> hashcpy is inlined and memcpy is builtin, I suppose that's
> possible...
>=20
> [1] http://article.gmane.org/gmane.comp.version-control.git/280729

Oh, right.  Will fix.
