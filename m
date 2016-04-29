From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 03/19] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 29 Apr 2016 14:46:57 -0400
Organization: Twitter
Message-ID: <1461955617.4123.37.camel@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
	 <1461787481-877-4-git-send-email-dturner@twopensource.com>
	 <xmqq60v15zmq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awDRT-0004RS-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbcD2SrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 14:47:03 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35827 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcD2SrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:47:00 -0400
Received: by mail-qk0-f176.google.com with SMTP id q76so44137583qke.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/b+4g7THy6YT+YjDujdBNI6F3dTHDHYI6AfBx0tWsQc=;
        b=AuWoyHbhCXIYP17biGLABLMHRec9OCiyHgy7uUZmufWetsY9a/G6WgNpeC2i4fC7Pt
         FnC/RfwuqsmEcGmt6ETmw8omYqPCuI0WrD4pj1o++bzgaoWtD4wTODy51B3bk/Pu5Xkp
         zgYlty+p0cNSv1/XBcedOPtatHm4v3HuS9VqkJKRlY/F7fxXKyvQK+lwCwGxzydNSQo0
         WkAmVZVtixchc8uW4z26ZYz1bTVZEMLiQyOiqQKjtuAyrRvXcA001+OgdM9G7qpI5jEA
         Ygg/il1vVy70whqx2zQvUldtLCE5/an8e8z1kHTnjLMSLAt3jwbKQyZGBwV9nSyQnH7+
         LUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/b+4g7THy6YT+YjDujdBNI6F3dTHDHYI6AfBx0tWsQc=;
        b=SRLQHNL+wamki0JPajGMsjcnzm5DX4qE/3Qkf2HNEjRqsA8IpWdfg5wSzL/IXii//v
         v9+GSPL8/hsozpv/3Kq788fQ5f+/SrtHQSAL9QY9LLHhjPqALj5GoApsHhLeKTdB4Th5
         AYkJsPRhgx3HT7+fTLR2kExXt4t/ixmGnKKGx2uBZdcmSyMINUZRiEkMB+JoE8+8G5ja
         1Tb2g+LeU8MYDlBgm533VyDjDBNslTjfYPek7Kx+47ZnpHy2ojb4QuaUVtag//OLEc3B
         iv/eY40TTqZQVP4fR1633A+4e7PMzhEGmG28ZsI5aNQwzGVu+cHjMd3NV+CxlTXM3bHv
         41wg==
X-Gm-Message-State: AOPr4FXP+UzwodCQ00TXph5ZB+OjaJ6gIjv+09uWvKFz4qT9znADSzaylNSaozWaeZ0x7w==
X-Received: by 10.55.117.12 with SMTP id q12mr21991115qkc.192.1461955619363;
        Fri, 29 Apr 2016 11:46:59 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y16sm4815434qhb.39.2016.04.29.11.46.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 11:46:58 -0700 (PDT)
In-Reply-To: <xmqq60v15zmq.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293046>

On Thu, 2016-04-28 at 11:58 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> > ...
> > The biggest gain is not having to verify the trailing SHA-1, which
> > takes lots of time especially on large index files. But this also
> > opens doors for further optimiztions:
>=20
> optimizAtion
>=20
> > Git can poke the daemon via unix domain sockets to tell it to
> > refresh
> > the index cache, or to keep it alive some more minutes. It can't
> > give
> > any real index data directly to the daemon. Real data goes to disk
> > first, then the daemon reads and verifies it from there. Poking
> > only
> > happens for $GIT_DIR/index, not temporary index files.
>=20
> Is this limited to "poking", or the helper daemon is not involved in
> codepaths that handle temporary index at all?  It makes sense if it
> is the latter, and it doesn't if it were the former, but it is
> unclear in this paragraph.

It is in fact the latter.  Will clarify.

> > $GIT_DIR/index-helper.sock is the socket for the daemon process.
> > The
> > daemon reads from the socket and executes commands.
> >=20
> > Named pipes were considered for portability reasons, but then
> > commands
> > that need replies from the daemon would have open their own pipes,
>=20
> "would have TO open"?

Oops.

> > since a named pipe should only have one reader.  Unix domain
> > sockets
> > don't have this problem.
>=20
> > diff --git a/Documentation/git-index-helper.txt b/Documentation/git
> > -index-helper.txt
> > new file mode 100644
> > index 0000000..77687c0
> > --- /dev/null
> > +++ b/Documentation/git-index-helper.txt
> > @@ -0,0 +1,47 @@
> > +git-index-helper(1)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +NAME
> > +----
> > +git-index-helper - A simple cache daemon for speeding up index
> > file access
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git index-helper' [options]
> > +
> > +DESCRIPTION
> > +-----------
> > +Keep the index file in memory for faster access. This daemon is
> > per
> > +repository.
>=20
> Not an objection but a question.  Does this mean "per index file"?
>
> What the users would need to be aware of is that it is not like
> running a single daemon instance helps the toplevel project with its
> entire 600 submodules checked out you have--you would need that many
> instances of the helper, which is already conveyed well with "per
> repository".  But I was wondering if it helps users experimenting
> with the multiple worktree feature if we said "per index file".  It
> would make it more clear that you would run two instances of the
> helper daemon when you use another worktree in addition to your
> primary repository.

Per working tree/repository, yes (not quite per-index because working
trees with split indexes have two).  But yeah, that's confusing; will
clarify.

> > +... The following commands are used to control the daemon:
> > +
> > +"refresh"::
> > +	Reread the index.
> > +
> > +"poke":
> > +	Let the daemon know the index is to be read. It keeps the
> > +	daemon alive longer, unless `--exit-after=3D0` is used.
> > +
> > +All commands and replies are terminated by a 0 byte.
>=20
> s/0/NUL/

Will fix.

> > diff --git a/cache.h b/cache.h
> > index 4180e2b..43fb314 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -334,6 +334,8 @@ struct index_state {
> >  	struct cache_time timestamp;
> >  	unsigned name_hash_initialized : 1,
> >  		 keep_mmap : 1,
> > +		 from_shm : 1,
> > +		 to_shm : 1,
>=20
> keep_mmap bit had its own commit, which made it more-or-less
> unnecessary to have a separate explanation, but it is unclear how
> these two bits are envisioned to be used...

Will add comments.

> > diff --git a/index-helper.c b/index-helper.c
> > new file mode 100644
> > index 0000000..976e913
> > --- /dev/null
> > +++ b/index-helper.c
> > @@ -0,0 +1,285 @@
> > +#include "cache.h"
> > +#include "parse-options.h"
> > +#include "sigchain.h"
> > +#include "strbuf.h"
> > +#include "exec_cmd.h"
> > +#include "split-index.h"
> > +#include "lockfile.h"
> > +#include "cache.h"
> > +#include "unix-socket.h"
> > +#include "pkt-line.h"
> > +
> > +struct shm {
> > +	unsigned char sha1[20];
> > +	void *shm;
> > +	size_t size;
> > +};
> > +
> > +static struct shm shm_index;
> > +static struct shm shm_base_index;
> > +
> > +static void release_index_shm(struct shm *is)
> > +{
> > +	if (!is->shm)
> > +		return;
> > +	munmap(is->shm, is->size);
> > +	unlink(git_path("shm-index-%s", sha1_to_hex(is->sha1)));
> > +	is->shm =3D NULL;
> > +}
> > +
> > +static void cleanup_shm(void)
> > +{
> > +	release_index_shm(&shm_index);
> > +	release_index_shm(&shm_base_index);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	unlink(git_path("index-helper.sock"));
> > +	cleanup_shm();
> > +}
> > +
> > +static void cleanup_on_signal(int sig)
> > +{
> > +	/* We ignore sigpipes -- that's just a client being
> > broken. */
>=20
> Is it really "a broken" client, in which case we would want to know
> about the breakage so that we can fix it?  Or is it a case of "a
> client wasn't interested in what we had to say, which is perfectly
> fine"?

It's usually a client that's killed at an inopportune moment e.g.:
git diff=20
^C=20
#oops I meant=20
git diff --cached

I guess I'll reword to "suddenly dying".


> > +	if (sig =3D=3D SIGPIPE)
> > +		return;
> > +	cleanup();
> > +	sigchain_pop(sig);
> > +	raise(sig);
> > +}
> > +
> > +static int shared_mmap_create(int file_flags, int file_mode,
> > size_t size,
> > +			      void **new_mmap, int mmap_prot, int
> > mmap_flags,
> > +			      const char *path)
> > +{
>=20
> I can understand size, new_mmap and path, but do all others need the
> customizability?  It is hard to tell at this point in the series as
> there is only one caller, which gives a reasonable set of values to
> these parameters.  And each of all these "reasonable values" is the
> only reasonable value for each of these parameters-- you would ever
> want to have mmap_prot without PROT_WRIT as this is creating an
> empty region that is mapped to a newly created file, for example.
> It is inconceivable that a function named "shared_mmap_create" ever
> passes mmap_flags that lack MAP_SHARED, for another example, or
> file_flags that is not O_CREAT|O_EXCL|O_RDWR for that matter.

Yeah, good point.

> > + ...
> > +	if (ftruncate(fd, size))
> > +		goto done;
> > +	*new_mmap =3D mmap(NULL, size, mmap_prot, mmap_flags, fd,
> > 0);
> > ...
> > +static void share_index(struct index_state *istate, struct shm
> > *is)
> > +{
> > +	void *new_mmap;
> > +	if (istate->mmap_size <=3D 20 ||
> > +	    hashcmp(istate->sha1,
> > +		    (unsigned char *)istate->mmap + istate
> > ->mmap_size - 20) ||
> > +	    !hashcmp(istate->sha1, is->sha1) ||
> > +	    shared_mmap_create(O_CREAT | O_EXCL | O_RDWR, 0700,
> > +			       istate->mmap_size, &new_mmap,
> > +			       PROT_READ | PROT_WRITE, MAP_SHARED,
> > +			       git_path("shm-index-%s",
> > +					sha1_to_hex(istate
> > ->sha1))) < 0)
> > +		return;
> > +	release_index_shm(is);
> > +	is->size =3D istate->mmap_size;
> > +	is->shm =3D new_mmap;
> > +	hashcpy(is->sha1, istate->sha1);
>=20
> So "is" is expected to be a valid instance of shm that was obtained
> previously.  When we fail to map and return, does it make sense to
> retain it?  Because this function does not return any value, the
> caller wouldn't be able to tell that shared-mmap-create failed, and
> will keep using that stale instance of "is"--I cannot tell if that
> is OK in the caller of this thing or not from what I read so far in
> this series...

Honestly, if we fail to mmap, we should probably just die.  That's not
a normal circumstance, and there's not much point in keeping a non
-functioning index-helper around.

> > +static void refresh(void)
> > +{
> > +	discard_index(&the_index);
> > +	the_index.keep_mmap =3D 1;
> > +	the_index.to_shm    =3D 1;
>=20
> Again, mysterious to_shm appears here...

I expect that the explanation of to_shm will help here.

> > +		/* Wait for a request */
> > +		FD_ZERO(&readfds);
> > +		FD_SET(fd, &readfds);
> > +		result =3D select(fd + 1, &readfds, NULL, NULL,
> > timeout_p);
>=20
> I admit that I am old fashioned and am more familiar with select(2)
> than poll(2), but I think we try to avoid select(2) in new code.

I don't see that in Documentation/CodingGuidelines (although I admit
that I did not even consider checking it before writing this code, so
if it had been there, I would have missed it).

Why do we try to avoid select(2)?  It seems marginally less efficient
for small numbers of fds, and might not scale to large numbers of fds,
but we're not using it in a performance-critical way, and we only care
about one fd at a time.
