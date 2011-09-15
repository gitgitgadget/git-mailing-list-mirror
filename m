From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 09:17:33 -0400
Message-ID: <CACPiFC+gXYn8cu5dwdcbzT1RYmmbdPhFhdejbxJs9zY8C-F4cQ@mail.gmail.com>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
 <4E71A5FF.5040807@viscovery.net> <201109150948.09040.trast@student.ethz.ch> <CAOZxsTrxPZ1V+_W=trRpOTJ9emh8msreGOyAYm_1hs0zXaOd1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 15:18:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4BpH-0002r9-VE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 15:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933681Ab1IONRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 09:17:55 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35850 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125Ab1IONRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 09:17:54 -0400
Received: by yie30 with SMTP id 30so2134371yie.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7BRPxVMDsalQMyJTRHp3qxz8aWzaNQA1LAYONW9G2uE=;
        b=R4THmsYljBK3mn94Il1bxG4+DgfyLUEQseoazYTuZ9AEFJUoDxIxoUcOva3U7THQTT
         1QJkNta9y4KEvdvX28R9hYtBnq7oBN8fKMtewTKTVsorab8SO7y5t+7RVdRhpsLYEu6G
         SZEl22G3ygtMkiKgNak7N9Ixt4RBuY/vlFjyg=
Received: by 10.43.48.133 with SMTP id uw5mr1193365icb.114.1316092674105; Thu,
 15 Sep 2011 06:17:54 -0700 (PDT)
Received: by 10.42.172.130 with HTTP; Thu, 15 Sep 2011 06:17:33 -0700 (PDT)
In-Reply-To: <CAOZxsTrxPZ1V+_W=trRpOTJ9emh8msreGOyAYm_1hs0zXaOd1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181467>

On Thu, Sep 15, 2011 at 5:42 AM, Joshua Stoutenburg
<jehoshua02@gmail.com> wrote:
> I got confused in Chapter 5 of the Pro Git pdf book, trying to discer=
n
> what needs to be done on the server, and what needs to be done on the
> work station

OK - some hints:

1 - For private code, or public code where you value the service, you
can use the commercial services out there, that's easy

2 - For public/foss code, with low/simple service expectations, you
can get free hosting

3 - For a private setup... the normal thing is to use git over ssh, so
the server should be reachable by your users, and your users need an
ssh account. You will want to setup a group ("gituser") and create a
directory ("/git") owned by that group, writable by the group, with
sticky group mode.

 To create a new project repo, ssh into the server and say git
--git-dir /git/fooproject init --shared . It will be empty -- on a
user workstation create your first commit, and push it into the (so
far empty) repo with git push git+ssh://hostname/git/fooproject master
=2E

On the server you can add a gitweb or cgit install for browsability.

If you want to allow anonymous users to access your git repos in
readonly mode, you can setup the git "service", with xinetd. That
allows you to tell people "git clone git://hostname/fooproject" .

Careful when configuring network services if the host is public, you
don't want to serve git://host/etc/shadow :-)

This is what most "git servers" do -- it works in your company
network, it also works for a public FOSS project with anon readers and
a handful of ssh-authenticated committers.

(For a project using a more distributed model of
one-developer-one-repo, you follow the same setup but perhaps make
per-developer directories.)

4 - You _can_ do git over http, instead of ssh, but I suspect the
setup is more involved. In any case, others will have to fill in.

> Also, I'm not clear on the best way to manage large numbers of git
> users (like 12-24), who also may have permissions to other services a=
s
> well (ftp, databases, email, etc). =A0I have some hesitancy creating
> each one manually on the CLI.

CLI is generally fine :-) if you contract a hosting server that gives
you email/db/ftp and has a webbased admin UI, all you need
"additional" is to ensure you can manage ssh accounts with ease.

cheers,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
