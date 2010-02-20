From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: How to create patches for a merge?
Date: Sat, 20 Feb 2010 18:39:10 +0100
Message-ID: <20100220173910.GA4095@localhost>
References: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
 <20100218203738.GB8110@coredump.intra.peff.net>
 <83d7aaa41002190225o3255248re1581a86e1346f28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Geoffrey Lee <geoffreyj.lee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 19:46:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NitIc-0003RX-64
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 18:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab0BTRjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2010 12:39:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:11342 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732Ab0BTRjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 12:39:20 -0500
Received: by qw-out-2122.google.com with SMTP id 8so209785qwh.37
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RimQMRzH0IBqKDJKU9gTJxHWENLHNKCK/77urZIX5aM=;
        b=IGXK44lxoltfpCyRHKlj5ehoXC5J+B0MH+q1OXW1AxSEzoaThGk98YxNmPgvc9txxI
         +Sx/5qJeW21WajpuRii1AZgCRnXZOqI1WzLTAJpIJGJT1S4abgKgG7NAn0CJ3NXChGHZ
         mU/MdcodnEtAKssFiGXUmhPA6CnOLZi2gr/JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=TIeQcA2dQ8NlQmHXZGmytlDJ0IC54T0FTO+XEtBNdKSO8GVBRjp49px/xV4el3b3fL
         BEDnFRB1f5Nrnyq0npmaCcBvWmRJokk7CNsAXOuXyq2h4o+qLFiGiibUwKLtVE25SVmh
         mFUHC9n4BoRy+c9M09w0yhNurOMVcSu5B0gG4=
Received: by 10.224.104.106 with SMTP id n42mr41540qao.82.1266687558694;
        Sat, 20 Feb 2010 09:39:18 -0800 (PST)
Received: from darc.lan (p549A7DE9.dip.t-dialin.net [84.154.125.233])
        by mx.google.com with ESMTPS id 8sm3922276qwj.1.2010.02.20.09.39.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 09:39:17 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1NitIM-0001cO-42; Sat, 20 Feb 2010 18:39:10 +0100
Content-Disposition: inline
In-Reply-To: <83d7aaa41002190225o3255248re1581a86e1346f28@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140538>

On Fri, Feb 19, 2010 at 02:25:14AM -0800, Geoffrey Lee wrote:
> On Thu, Feb 18, 2010 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Feb 18, 2010 at 03:40:07AM -0800, Geoffrey Lee wrote:
> >
> >> When I use=A0"git format-patch", it doesn't seem to include merges=
=2E How
> >> can I perform a merge and then e-mail it to someone as a set of
> >> patches?
> >
> > Is it important that it be patches, or simply that it go over email=
? In
> > the latter case, you can use "git bundle" to create a set of commit=
s,
> > including merges, and send them to the remote.
>=20
> I was not aware of "git bundle". That does exactly what I need. Thank=
s!

Below is git-send-bdl, a small wrapper I use for git bundle. It creates
bundles only for the commits which are not already known to the origin =
and
mails them to a configured address. It requires mutt for sending emails=
 (the
-m option is just for show).  It should probably use sendmail. But mayb=
e
this is still useful as a reference.

Have fun,
Clemens
---

#!/bin/bash

usage ()
{
	echo "`basename $0`: [-t <address>] [-m <mailer>] [-r <remote>] [<repo=
>...]" >&2
	exit 1
}

if ! test -x `which getopt`
then
	echo "fatal: getopt required but not found" >&2
	exit 2
fi

OPT=3D`getopt -o et:m:r: -- "$@"`
code=3D$?
if test $code -gt 0
then
	usage
	exit 1
fi
eval set -- "$OPT"

mailer=3D${GIT_SEND_BDL_MAILER:-mutt}
remote=3Dorigin
addr=3D
edit=3D
while test "$1" !=3D "--"
do
	case "$1" in
		-r) remote=3D"$2"; shift;;
		-m) mailer=3D"$2"; shift;;
		-t) addr=3D"$addr $2"; shift;;
		-e) edit=3DYesPlease;;
		-h) usage;;
		*) echo "unkown option: $1" >&2; exit 2;;
	esac
	shift
done
shift

if test -z $addr
then
	addr=3D"$GIT_SEND_BDL_TO"
fi

if test $# -eq 0
then
	cdup=3D`git rev-parse --show-cdup 2>/dev/null`
	if test $? -gt 0
	then
		echo "fatal: no repositories specified and none found" >&2
		usage
	fi
	set -- "$PWD/${cdup}"
fi

if test -z "$addr"
then
	echo "fatal: no recipients specified" >&2
	usage
fi

if ! test -x `which $mailer`
then
	echo "fatal: mailer not found: $mailer" >&2
	usage
fi

bundle=3D()
while test $# -gt 0
do
	path=3D$1
	shift
	cd $path
	name=3D`basename "$PWD"`
	echo " * $name"
	target=3D/tmp/${name}.git
	if ! git remote | grep -q "^$remote\$"
	then
		echo error: unknown remote: $remote >&2
		continue
	fi
	refs=3D"--branches"
	remote_refs=3D`git show-ref | cut -f2 -d' ' | \
			grep ^refs/remotes/$remote/`
	if test -n "$remote_refs"
	then
		refs=3D"$refs --not $remote_refs"
	fi
	refs=3D"$refs --tags"
	git bundle create $target $refs
	cd - >/dev/null
	bundle[${#bundle[@]}]=3D$target
done

attachments=3D
for i in ${bundle[@]}
do
	if test -f $i
	then
		attachments=3D"$attachments $i"
	fi
done

exec 3</dev/null
if test -n "$edit"
then
	exec 3<&0
fi
$mailer -s 'git bundles' -a $attachments -- $addr <&3
ret=3D$?
exec 3<&-
if test $ret -gt 0
then
	echo "fatal: mailer exited with status $ret" >&2
	exit 1
fi

rm -f ${bundle[@]}
