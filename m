From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool sends malformed path to exernal tool on Windows
Date: Fri, 21 Feb 2014 02:38:22 -0800
Message-ID: <20140221103821.GA21414@gmail.com>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Lotz <plotz@lsst.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 11:38:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGnVB-00023t-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 11:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbaBUKig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 05:38:36 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:52785 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbaBUKif (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 05:38:35 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so3266265pbc.4
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dcAbMxCeEcc6nDKLFqNu9lDjcifKviqiE/Ol2gMnxjQ=;
        b=gaTHdkjXb5YpJzu9DLVFW8pDRoP33PebLhD2kB5mox8+XqDXLg9C+wwpqfuk+snWyA
         eI3tsiwMFP6rPsm4ZUe95wWJ3Dt8Rc8IdlqmNUbn2N6F0ST1BJiPJYA/ItKWorbmu1O9
         rmEtifyBOSojEKYgQs0OFIaa6kicrmPeJaAZBUvkajOgWjiNefHTBsYHzZB9ThkncD8D
         K/hHfHn1uIbib5upFGU6KuTcm/UGk3evNXGH8RtkfRnCoaxrGqsykyqO9OHXsB8FIC4T
         MeDkEiiS8IvK2hBhCVix03nsystxwtCxcuieK9caeA5v5vNmTw/fwSqAfR5/kxCWLBdq
         KgLA==
X-Received: by 10.68.163.3 with SMTP id ye3mr8473323pbb.78.1392979114454;
        Fri, 21 Feb 2014 02:38:34 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kc9sm20001075pbc.25.2014.02.21.02.38.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 02:38:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <011301cf2c2d$90442810$b0cc7830$@lsst.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242461>

On Mon, Feb 17, 2014 at 03:14:01PM -0700, Paul Lotz wrote:
> From the Git Bash command line, I enter
> $ git difftool
>=20
> and type =C2=91y=C2=92 when the file I want to difference appears.=C2=
=A0 Git correctly
> calls the external diff tool (LVCompare.exe), but the path for the re=
mote
> file Git passes to that tool is malformed (e.g.,
> C:\/Users/Paul/AppData/Local/Temp/QCpqLa_calcLoadCellExcitation.vi).=C2=
=A0
> Obviously the \/ (backslash forwardslash) combination is incorrect.

If this is the case then difftool is not the only one with this problem=
=2E

We use the GIT_EXTERNAL_DIFF mechanism to run difftool under "git diff"=
,
so it may be that the paths are mangled by "git diff" itself.
I don't really know enough about msysgit to know for sure, though.

What do you see if you create a dummy tool which just does "echo"?

[difftool "test"]
	cmd =3D echo \"$LOCAL\" \"$REMOTE\"

Then run:

$ git difftool -t test

> For the record, I have successfully made calls to LVCompare.exe manua=
lly
> from a Windows command prompt directly (without Git).
>=20
> The relevant portion of the .gitconfig file is:
> [diff]
> =C2=A0=C2=A0=C2=A0=C2=A0 tool =3D "LVCompare"
> [difftool "LVCompare"]
> =C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D 'C:/Program Files (x86)/National Ins=
truments/Shared/LabVIEW
> Compare/LVCompare.exe' \"$LOCAL\"=C2=A0 \"$REMOTE\"
>=20
>=20
> For the record, the operating system is Windows 8.1.

Do any msysgit folks know whether GIT_EXTERNAL_DIFF is a known issue?
--=20
David
