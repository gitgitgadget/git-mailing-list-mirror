From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] git-svn: Allow certain refs to be ignored
Date: Fri, 14 Oct 2011 11:24:57 +0200
Message-ID: <CAA01Csq9jR_C9t4PzsnpJo7wt=M_wnJVXZG2fAmrvvOgPb1SBA@mail.gmail.com>
References: <CAN4ruPiSgY+LPdDgS021WQyoHMuNrJDzrqMuCt9G5qfZ=XtjoQ@mail.gmail.com>
	<7vvcs0s7xa.fsf@alter.siamese.dyndns.org>
	<20111010225838.GB3828@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Olson <mwolson@gnu.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 11:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REe7i-0006GY-LY
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 11:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab1JNJcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 05:32:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54651 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab1JNJcH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 05:32:07 -0400
Received: by qadb15 with SMTP id b15so680280qad.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=b9Ols8S9g5iVEq1mRpwmTQFiNpox5M0r0NcEH1f4kco=;
        b=GcoNBTWvkuPuCuYmFXhA7m5NUOD0rsnVh5dVYaOYZUVVnBqAN/5wdEdHAuasnTOqTC
         iQ9w1vCxjTNhlJwdmjqO+y3vX1XegS7T/8rXtoDl2xz74hbgnSIvyhbSB8xefi/ELJzH
         /aOblCeqYBFcaumQToOvY+HGbtNVbsF6yK5Vw=
Received: by 10.182.114.42 with SMTP id jd10mr4651964obb.42.1318584297989;
 Fri, 14 Oct 2011 02:24:57 -0700 (PDT)
Received: by 10.182.11.3 with HTTP; Fri, 14 Oct 2011 02:24:57 -0700 (PDT)
In-Reply-To: <20111010225838.GB3828@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183560>

On Tue, Oct 11, 2011 at 12:58 AM, Eric Wong <normalperson@yhbt.net> wro=
te:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Asking Eric to comment when he has time to do so.
>>
>> I find these pattern matches that are not anchored on either side
>> somewhat disturbing (e.g. --ignore-refs=3Dmaster would ignore master=
2)
>> but ignore-paths codepath seems to follow the same pattern, so perha=
ps it
>> is in line with what git-svn users want. I dunno.
>
> As stated last year, I remember wanting globs instead of regexps, but
> we already made the regexp mistake with ignore-paths, too :(
>
> I don't think it's horrible with regexps, and if git-svn users find i=
t
> useful, it's fine by me.

In my case globs would be too limited. I'm using negative look-ahead
assertions to match only branches/tags for projects that are
interesting to me. With globs it's not possible AFAIK (I would have to
specify all ignored patterns by hand which would work only for known
patterns):
  ignore-paths =3D ^path/branches/(?!proj1|proj2)


>> Michael Olson <mwolson@gnu.org> writes:
>> > Re-sent by request of Piotr Krukowiecki. =A0This is against v1.7.4=
=2E1,
>> > and I've been using it stably for a while.
>
> Michael: can you please rebase against latest and resend? =A0Thanks.

I've got following error while using the patch. I don't know it also
happens without the patch...

	M	...
r216099 =3D 4d16d4890915f4c02ba541956957a4e4b4bed400
(refs/remotes/proj2/proj2-branch9)
Auto packing the repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 10284, done.
Compressing objects: 100% (7695/7695), done.
Writing objects: 100% (10284/10284), done.
Total 10284 (delta 5077), reused 0 (delta 0)
fatal: refs/remotes/proj1/trunk: not a valid SHA1
update-ref refs/heads/master refs/remotes/proj1/trunk: command
returned error: 128

$ git log -1
fatal: bad default revision 'HEAD'
$ git log -1 trunk
fatal: ambiguous argument 'trunk': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
$ ls .git/refs/remotes/
proj2

The commands I've used:

git svn init --prefix=3Dproj2/ -Rproj2 -s
--ignore-paths=3D'^proj2/branches/(?!proj1|proj2)|^proj2/tags/(?!proj1|=
proj2)|^proj2/(?!trunk|branches|tags)'
--ignore-refs=3D'^refs/remotes/proj2/(?!proj1|proj2|trunk|tag)|^refs/re=
motes/proj2/tags/(?!proj1|proj2)'
http://url/svn/repos/proj2
git svn init --prefix=3Dproj1/ -Rproj1 -s
--ignore-paths=3D'^proj1/branches/(?!proj1|proj2)|^proj1/tags/(?!proj1|=
proj2)|^proj2/(?!trunk|branches|tags)'
--ignore-refs=3D'^refs/remotes/proj1/(?!proj1|proj2|trunk|tag)|^refs/re=
motes/proj1/tags/(?!proj1|proj2)'
http://url/svn/repos/proj1
git svn fetch proj2 && git svn fetch proj1

The error happened while fetching proj2. I wonder why it tried to set
master to proj1?
Is my command ok? I want to have both proj1 and proj2 under one git rep=
ository.


--=20
Piotr Krukowiecki
