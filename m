From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: submodule/index/working tree woes
Date: Sat, 25 Jun 2011 14:02:29 +0300
Message-ID: <BANLkTi=4D1qqM+9EFZACHwVwSsVOkWQ4GQ@mail.gmail.com>
References: <20110624182546.GB30640@vmware.com>
	<BANLkTik6xij0ZNy9nB2sbiF97Z4EF76sHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 13:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaQe4-0006RN-2r
	for gcvg-git-2@lo.gmane.org; Sat, 25 Jun 2011 13:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab1FYLCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jun 2011 07:02:33 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47469 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1FYLCc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2011 07:02:32 -0400
Received: by yia27 with SMTP id 27so1363468yia.19
        for <git@vger.kernel.org>; Sat, 25 Jun 2011 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=Ut/Ln2QptQlJZgJ6zXuNaEi3U2vSdt9G2Defs0U9oBQ=;
        b=KhNMDUo+FHuGCg8hms4VAdi1kmc1vPifeow3j9eTZvVg1DfDOqFMr88OVJ9uwlyG2d
         AlUZkB6gZ85EHIbcqzccj6aD//ABzUzupAJPeFp0MbfA8RGMh7vvRGJIm+Y9kNMuXKJR
         yb3/LX4Jefbt5RupGTNpen1X2FvENd1KcOi9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=aWgE6IVVl1X/lzVdf5q1SkzGT9zhdK9TCT7samYd2/EDYH34tR64usyf1NlaU+keK/
         z0j7Bp4XJf8EDpuim6rqq0wpoxAQFaHr9DH+OSgl2zCM30Ii2XFaP3m3Jaoi//TzNYE2
         NG6HrIsx0g72wQ5J5BKN0hnPpTIzwl21Cyes4=
Received: by 10.236.110.176 with SMTP id u36mr6564047yhg.162.1308999749611;
 Sat, 25 Jun 2011 04:02:29 -0700 (PDT)
Received: by 10.147.172.19 with HTTP; Sat, 25 Jun 2011 04:02:29 -0700 (PDT)
In-Reply-To: <BANLkTik6xij0ZNy9nB2sbiF97Z4EF76sHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176317>

---------- Forwarded message ----------
=46rom: Alexei Sholik <alcosholik@gmail.com>
Date: 25 June 2011 14:00
Subject: Re: submodule/index/working tree woes
To: masterblaster@vmware.com


On 24 June 2011 21:25, John Powell <jpowell@vmware.com> wrote:
> I have no changes to be committed (tracked or untracked according to
> 'git status') and yet when I try and switch branches git complains
> that I have untracked working tree files that would be overridden
> and aborts before the switch.
>
> The change I have just committed locally removes some files from the
> repository and adds a submodule in it's place to better organize the
> source for the project.
>
> Shaka, when the walls fell. =C2=A0Anyone want to assist me with this =
issue?
> Feeling clueless.
>

Git is unable to remove a directory with submodule when switching
branches. If you have a submodule on one branch and a directory with
the same name on another branch, you'll have troubles.

I'm speaking of version 1.7.3.4. Here's a small demo:
$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in /Users/alco/Documents/git/test/.git=
/
$ echo "Hello" >file.txt
$ git add file.txt
$ git commit -m 'test'
[master (root-commit) 8e9c724] test
=C2=A01 files changed, 1 insertions(+), 0 deletions(-)
=C2=A0create mode 100644 file.txt
$ git checkout -b another
Switched to a new branch 'another'
$ echo "Bye" >file2.txt
$ git add file2.txt
$ git commit -m 'second'
[another 62e6da2] second
=C2=A01 files changed, 1 insertions(+), 0 deletions(-)
=C2=A0create mode 100644 file2.txt
$ git checkout master
Switched to branch 'master'
$ git submodule add git://github.com/tweepy/tweepy.git
Cloning into tweepy...
=2E..
$ git commit -m 'submodule'
[master 3c9b6f7] submodule
=C2=A02 files changed, 4 insertions(+), 0 deletions(-)
=C2=A0create mode 100644 .gitmodules
=C2=A0create mode 160000 tweepy
$ git checkout another
warning: unable to rmdir tweepy: Directory not empty
Switched to branch 'another'
$ ls tweepy/
CONTRIBUTORS =C2=A0 =C2=A0INSTALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 LICENSE =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 README =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0docs
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0examples =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
etup.py =C2=A0 =C2=A0 =C2=A0 =C2=A0tests.py =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tools
=C2=A0 tweepy
$ git version
git version 1.7.3.4

--
Best regards,
Alexei Sholik



--=20
Best regards,
Alexei Sholik
