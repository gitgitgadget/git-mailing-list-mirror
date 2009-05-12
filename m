From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 16:59:34 +0200
Message-ID: <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <200905121103.00432.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120354p6e1bf517y154601132f0901a3@mail.gmail.com>
	 <200905121557.18542.Hugo.Mildenberger@namir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
X-From: git-owner@vger.kernel.org Tue May 12 17:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3tSw-00019F-Jx
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbZELO7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 10:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZELO7f
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 10:59:35 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:45824 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbZELO7e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 10:59:34 -0400
Received: by bwz22 with SMTP id 22so24158bwz.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ISC9YU8ZgFaIb9WpExx1lUq4QPURTPcXY1JmERfBjK8=;
        b=qCRjj/Tj3rInNd5un+P9958OfV/8jTG1+QjuBKhsKvVkG3qhA6V8U+8aGM7HcTCGae
         1fS7mEh7nEF6BmYFNthAV3fTV7qxJnk02jAgF7RDeR/wmmP77qn3hPtuRQJVEFFhSc0Z
         MEX49XRZYtwJMBVT3XFoUWr1e1NKNCy9FYk08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jj8NdLaBd5wV0CLzeH8IAfsHQOV5C/ph7gjOIVS9vmivxyndB97pQzmshbQKVCHczY
         nf2jy2+q/L36YqJXOT6qTVkMn8/IG0TVfkxjTYnXuQdVxuiObpJsaCOB4sW1i7E/pXV9
         44Y/zSOiWiJOGXEJK8A0z6vbHgjbRcE3pZ3Nw=
Received: by 10.204.121.140 with SMTP id h12mr8142916bkr.70.1242140374173; 
	Tue, 12 May 2009 07:59:34 -0700 (PDT)
In-Reply-To: <200905121557.18542.Hugo.Mildenberger@namir.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118900>

2009/5/12 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
>> OTOH, a warning about commonly used delimiters not fitting a name
>> context, maybe a good idea. Like "\r\n\t", backslash (came up recent=
ly
>> on this list). Such a check and associated warning may be useful for
>> repository names and branches.
>>
>> Still, it's more of a policy issue and I would make it optional, eve=
n
>> if enabled by default. Maybe even by defining a regexp which the
>> repo name or branch name must (for hard error) or should (for a warn=
ing)
>> match.
>>
>> For your specific case, you can take a look at builtin-clone.c,
>> just after the line containing "guess_dir_name(repo_name"...
>> --
>
> But at least the git versions I tried (up to 1.6.3) really do have a =
problem
> when facing a trailing newline in repository names; so one should enf=
orce a
> convention.

That's what I mean by saying: "... even if enabled by default".
I just want to disable newbie-helping annoyances on my systems.

> I looked into guess_dir_name().

That's not the right place. The place I meant is right below the call
to this function (you have to parse the names given in the command-line
too).

The automatically generated (that's the case with guess_dir_name)
directory name certainly shouldn't contain any unexpected characters.

> A regex call would be easy to fit, but
> currently the git binary does not depend on libpcre. Is it generally
> considered to be acceptable to add such a dependency?

No. And pcre is not the only regex lib in the world. And we prefer
shell patterns, if any at all.

> While I like the idea to make use of a configurable regular expressio=
n, such
> an expression had to be a command line parameter with a reasonable de=
fault
> value, because .git/config still would not exist when the value would=
 be
> needed.

That's where _default_ policy plays its role. "Default" like in "it is =
compiled
into the git executable and needs no configuration present".

> Last not least, I managed to reproduce the problem almost exactly:
>
> 1.) hm@localhost git
> clone "git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetoo=
th-testing.git
> "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(Note the trailing linefeed)

That's all the command printed? No "Initialized empty Git repository" l=
ine?

> 2.) hm@localhost ~/tmp/bluetooth-testing.git $ make

Hmm... At this point the clone may have worked (at least partially).
It named "bluetooth-testing.git", which it shouldn't (but explainable:
the repo url suffix is not .git anymore, but ".git\r\n"). But it looks =
like
the post-clone checkout failed (silently? which would be bad):

> =C2=A0 =C2=A0 =C2=A0 =C2=A0Makefile:313: /home/hm/tmp/bluetooth-testi=
ng.git
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/scripts/Kbuild.include: No such file or d=
irectory
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make[1]: /home/hm/tmp/bluetooth-testing.gi=
t: No such file or directory
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make[1]: *** No rule to make target `/home=
/hm/tmp/bluetooth-testing.git'.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Stop.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0make: *** No rule to make target `include/=
config/auto.conf', needed by
> =C2=A0 =C2=A0 =C2=A0 =C2=A0`include/config/kernel.release'. =C2=A0Sto=
p.

Assuming the files must be present, of course.

> 3.) hm@localhost ~/tmp/bluetooth-testing.git $ git pull
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: Error in line 2:
>
> 4.) ".git/config" now contains
>
> url =3D
> git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-test=
ing.git\n
>
> I particulary liked the git message "fatal: Error in line 2:" ...
>

Separate issue. Will look at it later.
