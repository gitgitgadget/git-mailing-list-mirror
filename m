From: Eric Montellese <emontellese@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Sat, 12 Mar 2011 20:53:53 -0500
Message-ID: <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net> <20110123141417.GA6133@mew.padd.com>
 <4D793C7D.1000502@miseler.de> <20110310222443.GC15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Miseler <alexander@miseler.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	schacon@gmail.com, joey@kitenet.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 13 02:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyaVm-0006ca-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 02:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab1CMByP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Mar 2011 20:54:15 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34898 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab1CMByO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Mar 2011 20:54:14 -0500
Received: by bwz15 with SMTP id 15so3623645bwz.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 17:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=F/8F9QGfLwMtVmpHDLZYA9OoK5BNDoBmIeQH4GoocQs=;
        b=oB+qXJLk5puqhjfS1JNCj9OWLOY9jE7H5H7yDBBpcGRuqxCDqrGxJlEce5Z4YiuVlX
         dj2mc1c0tvtlI0NF9zVDVQ+csnf3oXO+RmU3gPqu3MGezmNWROmFZ+WOl65wHzfWTNYz
         CsPDclbvzIew4pJqWMnKCbOHT+Crg4OTuvANY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vGkEhd8G6WSA5UtOryFt8hmN8prx0vGRk8OkJWL2G41b3/ElGVbJhTbJk0ttApcurR
         1xLmZEf+Dd1be4IhBwiBo+9CUQcD2LYEKs4VqsbmE+OOeEc/9BbhOssJJknH9r4BwRcx
         YQQpjTS809L6R0IyZ3xDfeiwYhXO2f4/4V0QE=
Received: by 10.204.20.74 with SMTP id e10mr2462875bkb.148.1299981253076; Sat,
 12 Mar 2011 17:54:13 -0800 (PST)
Received: by 10.204.14.210 with HTTP; Sat, 12 Mar 2011 17:53:53 -0800 (PST)
In-Reply-To: <20110310222443.GC15828@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168955>

This is a good point.

The best solution, it seems, has two parts:

1. Clean up the way in which git considers, diffs, and stores binaries
to cut down on the overhead of dealing with these files.
  1.1 Perhaps a "binaries" directory, or structure of directories, with=
in .git
  1.2 Perhaps configurable options for when and how to try a binary
diff? =A0(allow user to decide if storage or speed is more important)
2. Once (1) is accomplished, add an option to avoid copying binaries
from all but the tip when doing a "git clone."
  2.1 The default behavior would be to copy everything, as users
currently expect.
  2.2 Core code would have hooks to allow a script to use a central
location for the binary storage. (ssh, http, gmail-fs, whatever)

(of course, the implementation of (1) should be friendly to the additio=
n of (2))

Obviously, the major drawback to (2) without (2.2) is that if there is
truly distributed work going on, some clone-of-a-clone may not know
where to get the binaries.

But, print a warning when turning on the non-default behavior (2.1),
then it's a user problem :-)

Eric




On Thu, Mar 10, 2011 at 5:24 PM, Jeff King <peff@peff.net> wrote:
>
> On Thu, Mar 10, 2011 at 10:02:53PM +0100, Alexander Miseler wrote:
>
> > I've been debating whether to resurrect this thread, but since it h=
as
> > been referenced by the SoC2011Ideas wiki article I will just go ahe=
ad.
> > I've spent a few hours trying to make this work to make git with bi=
g
> > files usable under Windows.
> >
> > > Just a quick aside. =A0Since (a2b665d, 2011-01-05) you can provid=
e
> > > the filename as an argument to the filter script:
> > >
> > > =A0 =A0 git config --global filter.huge.clean huge-clean %f
> > >
> > > then use it in place:
> > >
> > > =A0 =A0 $ cat >huge-clean
> > > =A0 =A0 #!/bin/sh
> > > =A0 =A0 f=3D"$1"
> > > =A0 =A0 echo orig file is "$f" >&2
> > > =A0 =A0 sha1=3D`sha1sum "$f" | cut -d' ' -f1`
> > > =A0 =A0 cp "$f" /tmp/big_storage/$sha1
> > > =A0 =A0 rm -f "$f"
> > > =A0 =A0 echo $sha1
> > >
> > > =A0 =A0 =A0 =A0 =A0 =A0 -- Pete
>
> After thinking about this strategy more (the "convert big binary file=
s
> into a hash via clean/smudge filter" strategy), it feels like a hack.
> That is, I don't see any reason that git can't give you the equivalen=
t
> behavior without having to resort to bolted-on scripts.
>
> For example, with this strategy you are giving up meaningful diffs in
> favor of just showing a diff of the hashes. But git _already_ can do
> this for binary diffs. =A0The problem is that git unnecessarily uses =
a
> bunch of memory to come up with that answer because of assumptions in
> the diff code. So we should be fixing those assumptions. Any place th=
at
> this smudge/clean filter solution could avoid looking at the blobs, w=
e
> should be able to do the same inside git.
>
> Of course that leaves the storage question; Scott's git-media script =
has
> pluggable storage that is backed by http, s3, or whatever. But again,
> that is a feature that might be worth putting into git (even if it is
> just a pluggable script at the object-db level).
>
> -Peff
