From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: remote.origin.*pack settings are not honored when repository is specified
Date: Mon, 21 Mar 2011 20:25:47 +0100
Message-ID: <AANLkTina56vfqidyyB0DgkAP2upvkCuW8OshnxzuNVjy@mail.gmail.com>
References: <982706A6-A00E-43B3-9002-41C8DC084EC9@vocaro.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Trevor Harmon <trevor@vocaro.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:26:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1kk7-0005Vc-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab1CUT0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:26:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50405 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1CUT0N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 15:26:13 -0400
Received: by bwz15 with SMTP id 15so5294875bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PIso8rwYcWOlXCKEr7aVEH6C6YJIN04uf0tlLJPS4N4=;
        b=eWASBTKd2vI3haWRpQ4xg0QkjhI5Lfv6rdO/YkZOfrRkEgLDKvGt4RrzyiMQLSGNmR
         6B4iut2TgtRRkUmvUYUm6zZbSKXLtOFiEGqKk/2Dsdnv8Y8yilM1x1m/AhKtr94WkCOo
         HEOqxKCDr8/BZFea4sDGgKBZYMzj13wZWmyLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=J8ngrn5ZVGs/iF2WrbpApUPzlQy8dnYqb2mteNe/d36Mqe0NfOHI18EShqrEjnQFD2
         zw4C8fF9cGDDZb+xYgZIt5lVsveOfA3NCXJEql5tS/5c3d9y2c88QK74+hu7s8EInazS
         PcVa23KFbytfduDImQJe6wcvvkHrMbQNG3wOM=
Received: by 10.205.24.9 with SMTP id rc9mr4165018bkb.92.1300735571780; Mon,
 21 Mar 2011 12:26:11 -0700 (PDT)
Received: by 10.204.97.201 with HTTP; Mon, 21 Mar 2011 12:25:47 -0700 (PDT)
In-Reply-To: <982706A6-A00E-43B3-9002-41C8DC084EC9@vocaro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169644>

On Mon, Mar 21, 2011 at 7:31 PM, Trevor Harmon <trevor@vocaro.com> wrot=
e:
> Hi,
>
> I'm trying to set up a remote repository on a shared hosting provider=
=2E The provider doesn't have Git on their system, so I installed it to=
 a custom location: ~/opt. That should be sufficient to allow external =
clients to use the repository, but there's a snag: The provider prevent=
s users from modifying the PATH variable for non-interactive shells, wh=
ich means I can't add ~/opt/bin to the server's PATH for SSH sessions. =
As a result, users who attempt to clone the repository get an error:
>
> =A0bash: git-upload-pack: command not found
>
> Luckily, users can work around this issue by providing Git with the c=
ommand's location:
>
> =A0git clone -u /home/[user]/opt/bin/git-upload-pack [repository]
>
> but a subsequent "git pull" on the working copy also fails for the sa=
me reason, though that's also easily remedied:
>
> =A0git config remote.origin.uploadpack '/home/[user]/opt/bin/git-uplo=
ad-pack'
>
> However, there's one last problem I can't find a workaround for... Sp=
ecifying the repository explicitly when doing a "git pull", such as:
>
> =A0git pull someguy@somewhere.com:git/some-repository.git
>
> still gives a "git-upload-pack: command not found" error. It seems th=
at Git isn't honoring the remote.origin.uploadpack value here.

remote.origin.* applies to the configured remote called "origin". If
you specify a remote-url then you're not using the configured remote.

You could use the --upload-pack option when pulling (unless you're
using Windows and MSYS/CYGWIN, because bash will end up translating
the path to a win32-path...)

> This is a problem because I'm using a third-party automated tool for =
handling pushes, and it's hard-coded to always specify the repository i=
n the command (as opposed to the default from the remotes list).
>
> Is this a bug in Git? Thanks,

No, this is expected behavior. You should probably look into getting
it fixed in the external tool, if possible.
