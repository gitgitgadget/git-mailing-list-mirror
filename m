From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Documentation/remote-helpers: Add invocation section
Date: Tue, 30 Mar 2010 14:50:55 -0500
Message-ID: <20100330195055.GA10977@progeny.tock>
References: <f3271551003301218k4828c44id700b4865001baf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 21:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwhZn-0002sB-7b
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 21:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab0C3T6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 15:58:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57189 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab0C3T6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 15:58:06 -0400
Received: by pwi5 with SMTP id 5so8100657pwi.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XtFlKpjFU0Pgvu2csYP/r89u6WGnTrUwuLVphDJ60OY=;
        b=B1LXz3sIjbGneBVuFyaC2KOhNo+Qxuxxxcugdc2bUbyUZgkh/mbUM0YpvHn0MaUaOx
         c7+LLiBv9zyFSsvmo23G6OKpx+B4W4rwQ7TTyiAXp0J4kK1hlesjerS7Ex2z35e650QP
         em05ijvdzReUnqQC4PIutC30rT0ZdutWBSenk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h5a+wB+vane5KfRIwsKUho9OMcj8Vsuxjzq/dT9kVJC6PYDCWgg1Lj5gWM8N4ZaTCQ
         kRt2jhBlGjFw7uRcJcYLW0Bsm7fkcfn6iyK7kxvWXh4WEySeztJOb9TOldAc3A3EdRf9
         1yDWdC4zu8D8YhtMd/Juh22+HDvzTcRTu1lZc=
Received: by 10.143.24.14 with SMTP id b14mr316907wfj.92.1269978643797;
        Tue, 30 Mar 2010 12:50:43 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id y27sm1151956wfi.5.2010.03.30.12.50.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 12:50:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003301218k4828c44id700b4865001baf9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143594>

Ramkumar Ramachandra wrote:

> +INVOCATION
> +----------
> +
> +Remote helper programs are invoked with one or (optionally) two
> +command line arguments. The first argument specifies a remote
> +repository as it would be in git; typically, it is either the name o=
f
> +a configured remote or just a URL.

Yes, better.

> The second argument, if present, is
> +a URL, and serves to resolve ambiguities that may arise when only th=
e
> +first argument is specified (i.e. when a remote has more than one
> +configured URL).

This seems to suggest that the remote helper should pay attention
primarily to the first argument and then use the second argument to
figure out some detail.  But AFAICT that is not true.

As I understand it, there are two cases.  I will call them the
=E2=80=9CSubversion-like=E2=80=9D (URL-based) and the =E2=80=9CPerforce=
-like=E2=80=9D (no URL) cases.
See [1] for an example of where I am getting this from, or see [2] for
more explanation of what I mean.

A hypothetical =E2=80=98git remote-svn=E2=80=99 would not need to exami=
ne its first
argument at all, unless it wants to use it to name a store of additiona=
l
per-remote data.  From its perspective, the second argument is not to
disambiguate.  Instead, the second argument is all that matters.

A hypothetical =E2=80=98git remote-p4=E2=80=99 might not understand URL=
s at all.
If so, it should error out if the first argument does not correspond to
a [remote "foo"] stanza or a second argument is supplied.

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/125374/focus=
=3D125410
[2] Examples:

In the Subversion-like case, the remote vcs uses a URL to identify the
repository.  So the configuration might look like

	[remote "upstream"]
	vcs =3D svn
	url =3D http://svn.example.com/some/project
	svn-fetch =3D branches/*:refs/remotes/upstream/*:
	svn-fetch =3D trunk:refs/remotes/upstream/trunk
	svn-fetch =3D tags/*:refs/tags/*

or

	[remote "upstream"]
	url =3D svn://svn.example.com/some/project
	svn-fetch =3D trunk:refs/remotes/upstream/master

There may be some cases in which this supposed URL should not actually =
be
a URL, as in:

	[remote "upstream"]
	vcs =3D svn
	url =3D /path/to/local/repo
	svn-fetch =3D :refs/remotes/upstream/master

and for this reason, the rule is that the URL can be an arbitrary strin=
g.

In the Perforce-like case, there is additional configuration required t=
o
describe a repository _anyway_, so there is no need for a URL.  The
configuration looks like this:

	[remote "upstream"]
		vcs =3D p4
	[p4 "origin"]
		find-server-command =3D ssh bunch of complicated options
		random-p4-option =3D ...
		random-other-p4-option =3D ...

(or so I hear).  This case is quite weird in my opinion, but anyway,
there is no URL.
