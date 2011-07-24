From: rupert THURNER <rupert.thurner@gmail.com>
Subject: Re: submodule add does not consider git svn
Date: Sun, 24 Jul 2011 10:00:29 +0200
Message-ID: <CAJs9aZ8fAPzr6Lo1EUO+Lnr1pHm=dNr6P5oYgpXE1RqkmMX7hA@mail.gmail.com>
References: <CAJs9aZ9cMZd5PfOW7Zfza3un5JqKRM5eQdDpKPCWvLn-vkzktA@mail.gmail.com>
 <4E2B10B7.3010903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 24 10:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qktci-0005pp-OW
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 10:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab1GXIAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 04:00:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64356 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab1GXIAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 04:00:49 -0400
Received: by iyb12 with SMTP id 12so3377817iyb.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MFpGmrTx+d0Hby/Mfj5gFZU9TY7TRjT1VT6fb/VJZkg=;
        b=wAuYGl0BIt2OUrP/Sf+YRmji6cvfdFzJv5GSFnn11G6HTOQbd/aRfSW2IDMa+4X2Oq
         l6HT2g2dV58LbgbSlPVrNBuiw3ZLfa0HofamKLXty/TUoQYlRqGUNMvCv7b8l2gpxW0X
         6AFYly/y6aoJUovTcWjkYIQmjgojrzvawatjQ=
Received: by 10.231.5.144 with SMTP id 16mr3143879ibv.189.1311494449077; Sun,
 24 Jul 2011 01:00:49 -0700 (PDT)
Received: by 10.42.96.193 with HTTP; Sun, 24 Jul 2011 01:00:29 -0700 (PDT)
In-Reply-To: <4E2B10B7.3010903@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177731>

On Sat, Jul 23, 2011 at 20:19, Jens Lehmann <Jens.Lehmann@web.de> wrote=
:
>
> Am 23.07.2011 05:33, schrieb rupert THURNER:
> > it seems that "git submodule add" looses information from "git svn
> > clone". what am i missing here which would allow to "git svn rebase=
"
> > the repository, even if it is newly added as submodule?
> >
> > the following example takes a little, as the repository has 15'000
> > revisions, even 99% do not concern the checked out part.
> >
> > rupert @ login : ~/tmp/subm-bug
> > =C2=A0mkdir -p =C2=A0~/tmp/subm-bug
> > =C2=A0cd ~/tmp/subm-bug
> > =C2=A0git svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw=
/mgar/pkg/GeoIP/trunk
> > GeoIP
> > =C2=A0git init test
> > =C2=A0cd test
> > =C2=A0git submodule add ~/tmp/subm-bug/GeoIP
> > =C2=A0cd GeoIP
> > =C2=A0git svn rebase
> >
> > Migrating from a git-svn v1 layout...
> > Data from a previous version of git-svn exists, but
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 .git/svn
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 (required for this version (1.7.5.4) of=
 git-svn) does not exist.
> > Done migrating from a git-svn v1 layout
> > Unable to determine upstream SVN information from working tree hist=
ory
>
> That is because in your example "git submodule add" clones that repo
> *again* from where you put it using "git svn clone". I am not really
> familiar with git svn, but I assume it is intended that when you clon=
e
> such a repo it "forgets" that it was connected with a svn repo. Try t=
he
> following instead:
>
> git init test
> cd test
> git svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pk=
g/GeoIP/trunk GeoIP
> git submodule add ./GeoIP =C2=A0 =C2=A0 =C2=A0# Add existing git svn =
repo GeoIP in place
> cd GeoIP
> git svn rebase
>
> Of course when you push that submodule somewhere else using git I exp=
ect
> that "git svn rebase" won't work when you clone that somewhere else, =
just
> like it happened in your example.

how would the standard git case work, to continue with the example abov=
e:
  git clone test test1
  git clone test1 test2

if then sombody changes test, and i want to get these changes into
test2, without involving test1, and rebase what is there?

rupert
