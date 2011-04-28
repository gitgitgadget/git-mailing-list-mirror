From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 10:06:36 +1000
Message-ID: <BANLkTin0=1LdvHgLebuSyUGmFRVzNGoVtg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:06:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFEkm-0001ft-Eu
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 02:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab1D1AGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 20:06:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64903 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab1D1AGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 20:06:38 -0400
Received: by ewy4 with SMTP id 4so671523ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JXBGbPXgtW6sHpwjihUH5o0WUmS5qkUaimsgleW1b0U=;
        b=Q6vLu2k0dxXOiHf7UDGtlhg7goI8t+W4sCDBJdhYrNPWZ3gBz79D3UxEVnpX2Sv3BN
         oS8RYLhPhDEtdYFnaGCO3HWn3GNsxSWwmIQD6jSmZWXd6fol2ErsC+qV6ahC9FZoAbkE
         kqdhAHaDNd/uP60WfzA0nHbCBLr5a/UDgXOv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aiNT+iZJpvpq1kAD42Sh+Jb7PgJgTfguc7ebbw+B/z1PwBAPtn02ITiYYqjNmrQQFy
         H0wW7tdBbZNdQbUWZbHMLBbShHhoVBCpqeRx/1I8BXLONHJLFxWGT3zN59USq6s6sB0T
         91gRV2iRqmxowcw5hyHy09rPkQHI1JZOb1Kf4=
Received: by 10.14.6.10 with SMTP id 10mr1199839eem.117.1303949196404; Wed, 27
 Apr 2011 17:06:36 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 17:06:36 -0700 (PDT)
In-Reply-To: <7vsjt35l84.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172293>

On Thu, Apr 28, 2011 at 9:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>
> I was thinking it, and the location git-work binary gets installed, should
> depend on where "git" and its subcommand binaries are installed.  The word
> plug-in mentioned in the thread implied that whatever plugs in is not by
> itself full fledged thing that is useful standalone, so it seemed a very
> natural thing to do.
>

You are correct about this - the ~/.git-pm/activation was, um, a horrible idea.

>> In the $prefix
>> case, the same snippet in .profile that adds $prefix/bin to the $PATH
>> would also say
>>
>>       MANPATH=$prefix/man:$(manpath)
>
> You are correct only if "git" the user is building is _not_ changed to
> look for other places for its own manpages.  If "git" was built to look at
> somewhere else, the relationship between the output of "git --exec-path"
> and that location shouldn't be assumed to be ../../share/man or anything.
>
> The layout should be discoverable, by exposing system_path(GIT_MAN_PATH)
> and friends (see builtin/help.c), just like we expose GIT_EXEC_PATH.
>
>> Or is the idea to blindly install (a symlink to) git-work to $(git
>> --exec-path)/ rather than a place on the $PATH?
>
> You can call it _blindly_ if you like, but that is what I meant.  "git"
> tells where the binary and help material for a "plugin" to be installed,
> so that it can find them where it expects to.
>

> After all, I am not interested at all in adding "git pm" or other crap.  I
> am just trying to help people write their own "make install" of a plugin
> project, like "git work".  And writing "make uninstall" for that project
> should be doable with the same information I am trying to give in this
> thread, no?

Ok, how about this?

plugins/
  gitwork/
     git-work.sh
     git-work.1

libexec/
  plugins/
    git-work -> ../../plugins/gitwork/git-work.sh

share/
  man/
     man1/
         git-work.1 -> ../../../plugins/git-work.1

The function of a:

    git plugin activate git-work

would simply be to establish the symlinks.

gitwork would get into plugins/ by your existing platform manager or
make install do some minimal validation of conflicts, etc.

jon.
