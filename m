From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Mon, 20 Aug 2012 12:22:03 +0200
Message-ID: <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 12:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3P7h-0005vO-J2
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 12:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab2HTKWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 06:22:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58951 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2HTKWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 06:22:09 -0400
Received: from DualCore (dsdf-4db55923.pool.mediaWays.net [77.181.89.35])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lz0gC-1ThG6n3Bmy-014lVp; Mon, 20 Aug 2012 12:22:06 +0200
In-Reply-To: <7v628epzia.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDOVyBT4AA==
Content-Language: de
X-Provags-ID: V02:K0:QcwMipyRZ/c6zLCsFxGzSZDNWmSs5ZJABUWtwCtaGw7
 nIFAtzDW5qa3Icb9qAOOZdFCbpyoaeV1ucmWGH6sEFtJW7bDRw
 hKyk+kWGk5iwqhZc6BRQkRwUUYAp1Q+tQ637rZ+fqfxh43KXdZ
 X4xTAI8sLuw8Zsiuyb/ywKHlDqMtd6FbHLIVw/XwS87DDm4msu
 e+FSlfS8Lw8UgpDvuXAvMOM6myXrm2edkgMY3BMLf8dhQwpWrS
 +IPT43YxLDkn0AFWD04hxDRmmvxPPtMr+kmYz2EqqF4YOI3YpN
 8A1TV+H2rffd45i5DIUdsuDWC8RiGjnudvvwSAu5HrLywL09gk
 fo6zvD0Kr8R9R6b4oU0nmB1/fZq2yYsJMENSWxiz+/3x84YcXD
 oKDtkXqHx+R1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203766>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Sunday, August 19, 2012 7:23 PM
> To: Joachim Schmitz
> Cc: 'Shawn Pearce'; git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Found the problem: our mkdir(dir,flags) fails with ENOENT when dir
> > ends with a '/'.
> > Not sure whether this us a bug on out platform or just allowed by
> > POSIX and as such a wrong assumption in git though?
> >
> > [shortly after]
> > A bit of googleing revealed that there is a GNUlib solution for this,
> > which claims that at least NetBSD 1.5.2 has the same problem.
> > (http://www.opensource.apple.com/source/gpatch/gpatch-2/patch/mkdir.c)
> >
> > And apparently this has been discussed on the git mailing list too, 2
> > years
> > ago:
> > http://lists-archives.com/git/728359-git-s-use-of-mkdir-2.html,
> > there's a patch too.
> 
> Given that newer BSDs have fixed libc to accept directory name with a
trailing
> slash, and that we use mkdir(2) in many places, I think the right way to
do so is
> still what I suggested in that old thread in the last paragraph of my
message
> 
>   http://thread.gmane.org/gmane.comp.version-
> control.git/155812/focus=155876
> 
> That is, have compat/tandem.c and define a replacement mkdir(2) in a way
> similar to how MinGW does so.

OK, I'll go for a compat/mkdir.c though.
We shouldn't call it tandem.c as Tandem, the Company, doesn't exist anymore
and since more than a decade (bough by Compaq, then HP), only the __TANDEM
survived in our compiler and headers/libraries. Could call it NonStop.c, but
I don't really like that idea either, I'd rather keep it more generic, just
in case someone else might need it too, or that issue someday gets fixed for
NonStop.

> > For now I've fixed it like this:
> > /usr/local/bin/diff -EBbu ./builtin/init-db.c.orig ./builtin/init-db.c
> > --- ./builtin/init-db.c.orig    2012-08-19 03:55:50 -0500
> > +++ ./builtin/init-db.c 2012-08-19 03:39:57 -0500
> > @@ -25,7 +25,16 @@
> >
> >  static void safe_create_dir(const char *dir, int share)  {
> > +#ifdef __TANDEM /* our mkdir() can't cope with a trailing '/' */
> > +       char mydir[PATH_MAX];
> > +
> > +       strcpy(mydir,dir);
> > +       if (dir[strlen(dir)-1] == '/')
> > +               mydir[strlen(dir)-1] = '\0';
> > +       if (mkdir(mydir, 0777) < 0) {
> > +#else
> >         if (mkdir(dir, 0777) < 0) {
> > +#endif
> 
> Move that part inside #ifdef __TANDEM to define
> 
> 	int tandem_mkdir(const char *dir, mode_t mode)
>         {
> 		...
> 	}

I'll go for git_mkdir(), similar to other git wrappers, (like for mmap,
pread, fopen, snprintf, vsnprintf, qsort). Could call it gitmkdir() too
(like for basename, setenv, mkdtemp, mkstemps, unsetenv, strcasestr,
strlcpy, strtoumax, strtoimax, strtok_r, hstrerror, memmem, strchrnul,
memcpy), Opinions?
It seems the ones without the "_" are for missing APIs and the ones with "_"
to wrap existing APIs (not sure about mmap and pread)?

Here it's current state:
$ cat compat/mkdir.c
#include "../git-compat-util.h"
#undef mkdir

/* for platforms that can't deal with a trailing '/' */
int git_mkdir(const char *dir, mode_t mode)
{
        int retval;
        char *tmp_dir = NULL;
        size_t len = strlen(dir);

        if (len && dir[len-1] == '/') {
                if ((tmp_dir = strdup(dir)) == NULL)
                        return -1;
                tmp_dir[len-1] = '\0';
        }
        else
                tmp_dir = (char *)dir;

        retval = mkdir(tmp_dir, mode);
        if (tmp_dir != dir)
                free(tmp_dir);

        return retval;
}
$
 
There is room for improvement though: it only removes one trailing slash. By
far not as advanced and generic as GNUlib's mkdir wrapper, but should be
good enough for git's usage.

> in your new file compat/tandem.c, add
> 
> 	#ifdef __TANDEM
>         #define mkdir(a,b) tandem_mkdir((a), (b))
> 	#endif
> 
> to git-compat-util.h

Again, git_mkdir, see above

> and then add compat/tandem.o to COMPAT_OBJS in the
> top-level Makefile.

For now I've added it to the (new) NOSTOP_KERNEL section. 

We may want it to go along with some
MKDIR_DISLIKES_TRAILING_SLASH or MKDIR_BOGUS_TRAILING_SLASH some such.
Opinions, Ideas?

> That way we do not have to keep an ugly platform specific ifdef in the
very
> generic codepath.

Agreed, it was my quick and dirty fix for it.

Bye, Jojo
