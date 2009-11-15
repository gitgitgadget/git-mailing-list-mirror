From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: PEBKAC or bug: unable to create path-like branch names
Date: Sat, 14 Nov 2009 23:55:11 -0800
Message-ID: <8c9a060911142355i1e722f50uf21446524fe9cb9c@mail.gmail.com>
References: <20091115020605.GE15966@cl.cam.ac.uk> <20091115050227.GD5934@penguin.codegnome.org> 
	<8c9a060911142136s68a08892ifa27989f3a5bfdfb@mail.gmail.com> 
	<20091115073628.GE5934@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 08:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9ZxX-0007on-Ld
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 08:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbZKOHz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 02:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbZKOHz0
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 02:55:26 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48974 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZKOHzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 02:55:25 -0500
Received: by pwi3 with SMTP id 3so2734389pwi.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 23:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=2ee4M6l8weQLTmqxHp2szd3wNOn0N337JwHjCIzxkhc=;
        b=B4xQvfgF92l2jns2HMqnCanAcFtb16EPQYx7gH7tO4xxwNGUdb1E63R+H0+0fi4bBi
         DQEnyw+KLOOx9vE6sd133m6vcmSvIJvgjNHBooqSfJT4H/xhJPbSa8fOkkPbFdtATmfm
         +HXUjOHtCgAcSvm2csJu90UIyCAgxc/mSyU4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=MhxLdad0lvXtFMmjTZHzFeI16OJE11pe7AWX7Lck/sEeFCXeB/bgrNAMHFqGhM2G0+
         J38tviugYxZTuecUiJWLfJFeb36u9bme+kXERwwVSa2Q5h4qq2QjJKozN7yvwpHtQ0I4
         50SjjzHb6pKgQ9viGriWqcOiw065qTT+jIHBk=
Received: by 10.140.191.12 with SMTP id o12mr355615rvf.163.1258271731322; Sat, 
	14 Nov 2009 23:55:31 -0800 (PST)
In-Reply-To: <20091115073628.GE5934@penguin.codegnome.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132914>

On Sat, Nov 14, 2009 at 23:36, Todd A. Jacobs <nospam@codegnome.org> wr=
ote:
> On Sat, Nov 14, 2009 at 09:36:47PM -0800, Jacob Helwig wrote:
>
>> What version of git are you using? =C2=A0git checkout -b foo/bar/baz=
 works
>
> I'm using 1.6.5.2 as well. Okay, try this in a temp directory, and
> you'll see what I mean:
>
> =C2=A0 =C2=A0git init
> =C2=A0 =C2=A0echo foo > foo
> =C2=A0 =C2=A0git add foo
> =C2=A0 =C2=A0git commit -m testing foo
> =C2=A0 =C2=A0git checkout -b dev
> =C2=A0 =C2=A0git checkout -b dev/feature/foobar
>
> The first branch works fine, but after attempting the nested branch t=
he
> message reappears:
>
> =C2=A0 =C2=A0error: unable to resolve reference refs/heads/dev/featur=
e/foobar: Not a directory
> =C2=A0 =C2=A0fatal: Failed to lock ref for update: Not a directory
>
> I can recreate this behavior at any time; it isn't just a problem wit=
h
> an existing repository.
>
> --
> "Oh, look: rocks!"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-- Doctor Who, "Destiny of the Daleks"
>

The problem is that you have a branch dev.  You can't have both a
file, and a directory with the same name.

You're trying to get git to do basically this:

% cd .git/refs/heads
% ls -l
total 0
-rw-rw-r-- 1 jhe jhe 41 2009-11-14 23:51 dev
-rw-rw-r-- 1 jhe jhe 41 2009-11-14 23:51 master
% mkdir dev
mkdir: cannot create directory `dev': File exists

You're getting the equivalent of the "cannot create directory" error.
When you have a branch with slashes in it, it gets stored as a
directory hierarchy under .git/refs/heads.

-Jacob
