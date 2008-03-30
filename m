From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: Possible d/f conflict bug or regression
Date: Sun, 30 Mar 2008 00:51:26 -0400
Message-ID: <3e8340490803292151o58186b18y487ac6fc6d4353b4@mail.gmail.com>
References: <200803290813.08419.chriscool@tuxfamily.org>
	 <3e8340490803291829h6f9c39a5uf4a1b2a4e52103ca@mail.gmail.com>
	 <200803300644.15502.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio Hamano" <junkio@cox.net>,
	krh@redhat.com
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Mar 30 06:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfpWo-000314-KD
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 06:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbYC3Ev2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 00:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYC3Ev2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 00:51:28 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:39512 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbYC3Ev1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 00:51:27 -0400
Received: by py-out-1112.google.com with SMTP id u52so1460711pyb.10
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 21:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4CqSS8OQbsV9D9GCdaytKD2LTlN77WJ1mx04X7JckEU=;
        b=flJpVOXi2X/pha+YuGtiMCjJPvD5ILK9Q5irQIEf0d7BvMjK7cMEUJcIbZdYDw9/Jfk+CVQniymNWoU2Lto7i0tMqKGVh7yA+4nJzrUwU7t4QO3o4vTT60+5ZZh5R5zp3kX66TOyaGHBXXPj6M34oqsgIcrUnjhi/p3U/5rMKaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CQAaItEVRp3/645nM41w8+Yu20jtVdSk6CXnenYSoYTjNboU/Ekybars2eMvi0ARJY+yd38GSSzdf5IVXZ1j/1hRFg5FWeX1RcOGH7AAMpQLySgj/bUvUo/24324zUTsPy+zwkq/PefK+GfUDujsjESYYWpDnWVhGPgOnDcpzSw=
Received: by 10.65.205.16 with SMTP id h16mr10337362qbq.80.1206852687044;
        Sat, 29 Mar 2008 21:51:27 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Sat, 29 Mar 2008 21:51:26 -0700 (PDT)
In-Reply-To: <200803300644.15502.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78501>

On Sun, Mar 30, 2008 at 12:44 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Le dimanche 30 mars 2008, Bryan Donlan a =E9crit :
>
> > On Sat, Mar 29, 2008 at 3:13 AM, Christian Couder
>  > <chriscool@tuxfamily.org> wrote:
>  > >
>
> > >  Initialized empty Git repository in .git/
>  > >  Created initial commit 3f945ca: Initial commit.
>  > >   0 files changed, 0 insertions(+), 0 deletions(-)
>  > >   create mode 100644 foo
>  > >  fatal: unable to index file foo
>  > >
>  > >  I think it's quite bad that it doesn't work.
>  >
>  > What behavior would you expect this to have? IMO, it's not entirel=
y
>  > clear what the user means to do if they replace a file with an emp=
ty
>  > directory, as an empty directory cannot be added to the index. Eve=
n
>  > with a directory with contents, some of the contents may be junk (=
=2Eo
>  > for example) as far as the user is concerned.
>
>  I think Git should behave the same as when using "git rm foo" instea=
d of "rm
>  foo", that is the file "foo" should be deleted without errors. That'=
s what
>  version 1.5.3 did too.
>
>
>  > Would a clearer diagnostic be a good solution? Something like:
>  > fatal: foo: file replaced by directory.
>  > Use git rm --cached or git add to specify how this should be handl=
ed.
>
>  No, I think we should fix the regression. Using "git rm stuff" inste=
ad
>  of "rm stuff" should not be required.

This is inconsistent with git's behavior when replacing a file with a
symlink then - you can rm file; ln -s something file, and the symlink
will be checked in...

As-is, if you "rm stuff" but do not "mkdir stuff", you can commit
without problems. Likewise, you can "rm stuff", and "echo foo >
stuff", and the file will be updated. "rm stuff" -> "mkdir stuff; vim
stuff/bar.c" could equally imply that the user wants to replace
"stuff" with a directory, could it not?

I don't think git should be inconsistent in this case, but equally
it's difficult to know what the user wants to do if they put in an
empty directory... That's why I think it'd be more sensible to let the
user know so they can decide which action they want to take. It
shouldn't happen often anyway; I'd be interested in hearing about a
use-case that involves frequent replacement of files with directories,
though :)

Thanks,

Bryan
