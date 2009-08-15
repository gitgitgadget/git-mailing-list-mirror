From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: Linus' sha1 is much faster!
Date: Sat, 15 Aug 2009 16:02:12 -0400
Message-ID: <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com>
References: <4A85F270.20703@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bug-coreutils@gnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 22:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McPTw-0000EC-DQ
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 22:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZHOUDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2009 16:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZHOUDy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 16:03:54 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:33402 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbZHOUDy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 16:03:54 -0400
Received: by ey-out-2122.google.com with SMTP id 22so482741eye.37
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+JcwykmgoUa+HM18S+pGrb+5ZiBXlFxXzuMBtWec6fA=;
        b=JlRKhntxhMX63mYqJQXr3ddRYMM/5VjbyY+IAmJ4ZYWO4A7TsRNJjGq/TFaWLhUgIc
         hwoe8PS1GtCKj9kma1KFNElOeLRnVaV3hGSERatchIuynqPdmegU+LM8figaZztkLNTh
         JgkyXdhedKaUh6SwrhzY7TyyytwrUIukllYRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VMQ1zTc4rMLXn2+57fsCRtJtqfeiDx7Yc+5TKcYhcsqiXKP7e9Krscb73aOWfWhEkr
         ufvQhOsoPGLBXdUiEj6N+Rno5501EAmLskjx14GZvP+Dme3kJcYJoQpMsLP4IyE0VZ7o
         hgXKNLv1kx5N3ud8fx2H6f/8W1flfaL+xiWwE=
Received: by 10.216.87.9 with SMTP id x9mr718134wee.0.1250366634358; Sat, 15 
	Aug 2009 13:03:54 -0700 (PDT)
In-Reply-To: <4A85F270.20703@draigBrady.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126022>

2009/8/14 P=E1draig Brady <P@draigbrady.com>:
> I've noticed before that coreutils hashing utils
> were a little behind in performance, but was prompted
> to look at it again when I noticed the recently
> updated sha1 implementation in git:
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dhistory;f=3Dblock-sha1;h=3D=
d3121f7;hb=3Dpu
>
> Testing that with the attached program which I wrote
> in a couple of mins to try and match sha1sum's system calls
> shows that it's around 33% faster, as shown below:
>
> $ gcc $(rpm -q --qf=3D"%{OPTFLAGS}\n" coreutils) linus-sha1.c sha1.c =
-o linus-sha1
>
> $ time ./linus-sha1 300MB_file
> df1e19e245fee4f53087b50ef953ca2c8d1644d7 =A0300MB_file
> real =A0 =A00m2.742s
> user =A0 =A00m2.516s
> sys =A0 =A0 0m0.206s
>
> $ time ~/git/coreutils/src/sha1sum 300MB_file
> df1e19e245fee4f53087b50ef953ca2c8d1644d7 =A0300MB_file
>
> real =A0 =A00m4.166s
> user =A0 =A00m3.846s
> sys =A0 =A0 0m0.298s
>
> So, could we use that code in coreutils?
> Think of all the dead fish it would save.

coreutils is licensed under GPLv3, and git under GPLv2 (only), so
you'd need permission from all contributors to the implementation in
order to relicense under GPLv3. A quick grep of the history suggests
these contributors to be:

Brandon Casey <drafnel@gmail.com>
Junio C Hamano <gitster@pobox.com>
Linus Torvalds <torvalds@linux-foundation.org>
Nicolas Pitre <nico@cam.org>
(adding these people to the CC list)

Additionally, it was originally based on the code in
mozilla-sha1/sha1.c, but that contains a license grant allowing it to
be used under GPLv2 /or later/, so if GPLv3 relicensing is enough it
shouldn't be necessary to get in contact with the original author.
However if the FSF requires copyright assignment to accept the new
implementation, it will be necessary to track down contributors to the
original mozilla-sha1/sha1.c as well.

Note that I'm not a lawyer, so there might be other roadblocks etc to
this as well, etc :)
