From: Jon Seymour <jon.seymour@gmail.com>
Subject: A system administration use case for git
Date: Wed, 22 Apr 2009 19:22:09 +1000
Message-ID: <2cfc40320904220222ub9b95f8o35afcddb0390fe1b@mail.gmail.com>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
	 <46a038f90904220148i23f1a75n7036d9726870d5f5@mail.gmail.com>
	 <2cfc40320904220208g5acc2200w6144668ba2da5a09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 11:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwYgF-0005h4-Lx
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 11:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbZDVJWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 05:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbZDVJWL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 05:22:11 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:33370 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbZDVJWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 05:22:10 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1921266ywb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=9Vx7dV6iLDjPI64KetZjkIE8O4cb5b1+bcJ/olXZhz8=;
        b=v7Kjc9e7WFm4wWfD6OG/Ra4zhKlFRonYI7OM0plnaD4jJ6tgF4XmTkd2A0+v3aoSiJ
         RMvmdtbTRjod96OxSwRAzLy+YI0j+TjKt3bhOcSxVrPSL9pDLE91h3alenPCajwumVqp
         64PM0zenApFy5A9w0KjDmtCn3evNSFdLeTe+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=DrENQ4FsU1/m4S2z6FU/dIeuKlQ8nP3C9PrQwQzEzcCCaDHpzIqd9by17Ppmek5/ah
         brbca0hkMg3YdkNI5H7mmUaqyoCfdv/6SFD1Q8JxR0XLVdQdZTSu2jiJ9/uGu8cytp3m
         7UMTda0TGnGeUXCqxXC0hsNDPVCHBd7s1/8o8=
Received: by 10.151.48.15 with SMTP id a15mr10259904ybk.230.1240392129069; 
	Wed, 22 Apr 2009 02:22:09 -0700 (PDT)
In-Reply-To: <2cfc40320904220208g5acc2200w6144668ba2da5a09@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117184>

Martin,

One disadvantage of that approach is if the file system is very large
and only has a few deltas, then I effectively have to have two copies
of the reference file system - one in the GIT repo and one that I can
damage on a regular basis with rsync for the purposes calculating the
git deltas. =A0 I know I can then use git to repair the damage, but the=
n
the reference has to be protected from concurrent access.

I'd prefer not to have to maintain a copy of the tree that has to be
"damaged" on a regular basis and also if I didn't have to maintain a
copy of the git objects for identical files.

In an ideal world, storage requirements at the other place would be
those of the reference file system + those of the various deltas, but
no more.

jon seymour

On Wed, Apr 22, 2009 at 6:48 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Wed, Apr 22, 2009 at 10:33 AM, Jon Seymour <jon.seymour@gmail.com>=
 wrote:
>> Hello all, it's been quite a while.
>> It'd be nice to do this on arbitrary (non-git-controlled) file syste=
m tree:
>>
>> * calculate the git hashes of the tree (without making copies of the
>> files in the tree)
>> * archive the tree hashes
>> * rsync the tree hashes to another place
>> * work out which files aren't available in the other place's git rep=
o
>> * rsync those files the the other place
>
> Steps:
>
> 1 - rsync to the "other place"
> 2 - use the git repo in that "other place"
> 3 - if the tree hashes are needed "here", copy them from the "other
> place" git to here.
>
> rsync + git =3D awesomenesssssss
>
>
>
>
> --
> =A0martin.langhoff@gmail.com
> =A0martin@laptop.org -- School Server Architect
> =A0- ask interesting questions
> =A0- don't get distracted with shiny stuff =A0- working code first
> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
>
