From: Barry Wardell <barry.wardell@gmail.com>
Subject: Re: [PATCH] git-svn: Simplify calculation of GIT_DIR
Date: Sat, 3 Mar 2012 19:45:47 +0000
Message-ID: <CAHrK+Z9fRQqLSY=3kc+8WkifTy1mJoA5ZFyGjXbdS8SXg9v=9w@mail.gmail.com>
References: <1330798107-33561-1-git-send-email-barry.wardell@gmail.com> <1330799233.691.40.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 20:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3uuF-0004DW-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 20:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab2CCTqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 14:46:11 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34015 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752137Ab2CCTqJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Mar 2012 14:46:09 -0500
Received: by lahj13 with SMTP id j13so3250113lah.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 11:46:08 -0800 (PST)
Received-SPF: pass (google.com: domain of barry.wardell@gmail.com designates 10.112.85.233 as permitted sender) client-ip=10.112.85.233;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of barry.wardell@gmail.com designates 10.112.85.233 as permitted sender) smtp.mail=barry.wardell@gmail.com; dkim=pass header.i=barry.wardell@gmail.com
Received: from mr.google.com ([10.112.85.233])
        by 10.112.85.233 with SMTP id k9mr6473764lbz.56.1330803968372 (num_hops = 1);
        Sat, 03 Mar 2012 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=nLSspblKD3kV1xMQKorpQNQtWGOxxDqpj3BJ8lPvQyU=;
        b=SnEuqgH5/aMptXTkPD9i0BGbo1KvPfwwHvSzgU74PMQBxaWbr8t5iQOxM5TAViamNF
         WSHWs0GPVQVyx/YWuhvbVTO8OjpwxcrNuPP5ignV44+NDG/gPuaxAXXdIbK0pDaPQ0Fy
         RtDAGfxCMN8JJnP8XFkMgJ9Y+sNwycM8CFzjGCRRp3Uu44sv+M7lVjg5SnmhL90lUwwq
         RN7O6r0fMfHPlNKBEZvpn21dmMwhg6Y4Y+AoM0N4v4eUg0EUAvKA+dA/LgzBIMQ8wy7Y
         GC+cQKzjsXYzjk7F5lKal64cXEZxKtvx1g6/J9pWaASkkLduXwAPNjB0nqotLHFm5vTu
         vvQQ==
Received: by 10.112.85.233 with SMTP id k9mr5324295lbz.56.1330803968322; Sat,
 03 Mar 2012 11:46:08 -0800 (PST)
Received: by 10.112.11.67 with HTTP; Sat, 3 Mar 2012 11:45:47 -0800 (PST)
In-Reply-To: <1330799233.691.40.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192132>

On Sat, Mar 3, 2012 at 6:27 PM, Carlos Mart=EDn Nieto <cmn@elego.de> wr=
ote:
>
> > -# make sure we're always running at the top-level working director=
y
> > +# Access an existing repository
>
> Is there a reason making sure we're at the top-level dir isn't necess=
ary
> anymore?

No, in fact it is still necessary.

> > =A0unless ($cmd && $cmd =3D~ /(?:clone|init|multi-init)$/) {
> > - =A0 =A0 unless (-d $ENV{GIT_DIR}) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 if ($git_dir_user_set) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "GIT_DIR=3D$ENV{GIT_D=
IR} explicitly set, ",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "but it is not a =
directory\n";
> > - =A0 =A0 =A0 =A0 =A0 =A0 }
> > - =A0 =A0 =A0 =A0 =A0 =A0 my $git_dir =3D delete $ENV{GIT_DIR};
> > - =A0 =A0 =A0 =A0 =A0 =A0 my $cdup =3D undef;
> > - =A0 =A0 =A0 =A0 =A0 =A0 git_cmd_try {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cdup =3D command_oneline=
(qw/rev-parse --show-cdup/);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $git_dir =3D '.' unless (=
$cdup);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chomp $cdup if ($cdup);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cdup =3D "." unless ($cd=
up && length $cdup);
> > - =A0 =A0 =A0 =A0 =A0 =A0 } "Already at toplevel, but $git_dir not =
found\n";
> > - =A0 =A0 =A0 =A0 =A0 =A0 chdir $cdup or die "Unable to chdir up to=
 '$cdup'\n";
>
> Here you delete a chdir to the top-level directory, just as you delet=
ed
> the comment above, yet in the commit message you don't explain why th=
is
> isn't necessary anymore. Doesn't the rest of the code still assume th=
at
> it's running at the top-level dir?


Yes, you're right. I will restore the chdir and submit a new patch.

Barry
