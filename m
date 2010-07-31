From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Sat, 31 Jul 2010 00:44:37 -0500
Message-ID: <20100731054437.GD14425@burratino>
References: <i308gl$v6p$1@dough.gmane.org>
 <20100731044957.GA8920@burratino>
 <i30bg7$50k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 07:46:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of4te-0002Bt-Mq
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 07:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab0GaFpv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 01:45:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab0GaFpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 01:45:49 -0400
Received: by iwn7 with SMTP id 7so2040423iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H2h9ffmKabwOmOCm31qlDhxyl7uZ/rYOON97TPYVxd4=;
        b=cO3QMSenvQJ0nBbWQQ8+rbb718VhjJqcgo0fxljl36Zu6BMWqZni2WnAJ/S/1+HaaQ
         NZjsM/9gR/CRR1s2oh7Q3AwmwhXJ3/b3qVtuDSXH5j7ghtLIhELtRxTjFWiO806lJXBO
         btjTpjB/d+XtX4bBvLS2Vh3TcMcwVRBLFjf4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JT2CQC2EuD71o6brMo4BfUpFZvgGwgPDpobdFQK1XujHOt51QiloQcaSkWqm+4i1Rx
         G9Toc9f25r4CNFORrdmR8ZR8UCEa02/6osQ7X/4xXOqtqRKmK93NWE/tev4odqt8l8gB
         D/nHH/PP4qPCgy1Yw09j2fiMY0+VaHPla0KzY=
Received: by 10.231.178.103 with SMTP id bl39mr2802840ibb.138.1280555148368;
        Fri, 30 Jul 2010 22:45:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm2705600ibk.13.2010.07.30.22.45.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 22:45:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i30bg7$50k$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152305>

Hi again,

Some clarifications.

Walter Bright wrote:

> git is installed under Ubuntu, but I'll be checking in files that I
> edit on both Windows and Ubuntu, so the line endings will vary
> depending on which platform I last editted the file on. Hence, I
> want to force them all to be LF upon checkin.

"[core] autocrlf =3D input" would work.  With this setting, the work
tree is considered sacred (i.e., not touched in any magical way at
all) but content checked in that looks like text is converted to
use LF.

Using .gitattributes you can override the autodetection (see
convert.c::is_binary) of text files.

>>	[core]
>>		eol =3D lf
>
> So this changes the file in the repository to lf only, but not in
> the worktree? That's what I want.

The opposite.  This makes the file in the worktree use lf on
checkout, if it is known to be a text file.

On Linux it is a no-op.  For files known to be text files, the version
checked in _always_ uses LF anyway.  The setting "[core] eol =3D lf" is
just a way to turn off "[core] eol =3D crlf".

> In the tracked tree? The documentation:
>=20
> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#_c=
hecking_out_and_checking_in
>=20
> says it goes in:
>=20
>  $GIT_DIR/info/attributes, .gitattributes
>=20
> so I'm confused again. Does .gitattributes go in $GIT_DIR, or in
> $GIT_DIR/info ? And what if both of those files are there, which one
> 'wins' ?

Though I said "in the tracked tree", it is generally the file in the
worktree that counts.  There can be .gitattributes files in any
subdirectory of the toplevel of the work tree.

=2Egit/info/attributes is a place to put local attribute settings that
should not be tracked.  It has higher precedence than the
=2Egitattributes files.  As the gitattributes(5) page says:

	git consults $GIT_DIR/info/attributes file (which has the
	highest precedence), .gitattributes file in the same
	directory as the path in question, and its parent
	directories up to the toplevel of the work tree (the
	further the directory that contains .gitattributes is
	from the path in question, the lower its precedence).

>> If everyone for which you want these setting to take effect uses a
>> recent version of git, you can write =E2=80=9Ctext=E2=80=9D instead =
of =E2=80=9Ccrlf=E2=80=9D if
>> you prefer.
>
> git --version says I'm using 1.5.6.3

Not recent enough. :)

Actually versions before 1.7.2 do not have the "[core] eol"
configuration, either, so there is one less thing to worry about.

> A final question: where does the repository actually go (so I can
> back it up)?

The subdirectory .git of the top level of the worktree.

You can back up with "git clone" or "git bundle", but copying the
=2Egit directory also works fine.

Regards,
Jonathan
