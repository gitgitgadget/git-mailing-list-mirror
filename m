From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the 
	replaced one
Date: Wed, 4 Aug 2010 22:42:50 +1000
Message-ID: <AANLkTimPQcZN-ASP+N+h9GaOSkgbnyNxiSktL+z-nBRu@mail.gmail.com>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
	<201008030700.40533.chriscool@tuxfamily.org>
	<AANLkTikaPhV+SkzCJ+G3V39mS4FORELP34ePrPWbHFeV@mail.gmail.com>
	<201008041358.13081.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 04 14:43:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgdJi-0000wE-D7
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 14:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753Ab0HDMm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 08:42:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61579 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703Ab0HDMmy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 08:42:54 -0400
Received: by wwj40 with SMTP id 40so6388351wwj.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fb91FK4WENXUy/oXZapPNezUGEMLInbZ82qqx5s8w34=;
        b=R+C3WVS7c+oz5ejS+1jChMfBZxGfDrvbOjxqhSDvETT9eTKyIVSbIMMPfG5+qUA7aL
         G2OAsfwuZ8v4VGgrOmRnT/HdApiZoHRTQheM07Dl7zhV6MWeaTQ87A+X/LqtsEVuoJOA
         DAb3VW/R12zoObn/BecTSGIz5fgdyDW7+Cuak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BqQwTJxzHcdN/YDs9f094bWlVAg/o4RZLhhx3UYGyehwlN6oD3wh8x3CvJ0dPFqHGH
         jheUX+Bxouz9tZVOQy+iGIHSq8FHR0p/DLeSTDf5BR6UJO3aBS+dSzJtLCYk/BJgiBgR
         9+WBffBOU4a89Ny4Cz35g8wgGo07vJ7rhYylI=
Received: by 10.216.180.145 with SMTP id j17mr7660140wem.109.1280925772102; 
	Wed, 04 Aug 2010 05:42:52 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Wed, 4 Aug 2010 05:42:50 -0700 (PDT)
In-Reply-To: <201008041358.13081.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152577>

On Wed, Aug 4, 2010 at 9:58 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
>> > I will
>> > try to have a deeper look at that, but it would help if you could =
give
>> > an example of a command that triggers this behavior.
>>
>> The following patch add "sha1" command. These commands give differen=
t sha1:
>>
>> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` A
>> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B
>
> Yes, but that does not mean that the content of the object returned b=
y
> lookup_commit(A) is not the content of A.
>
> Or do you have an example where the content of the object returned by
> lookup_commit(A) is not the content of A?

Both return the content of B. I modified my patch a bit to also show
the content, ((struct commit*)obj)->buffer.

$ ./git cat-file -p HEAD
tree 13109340ff2bd55bd16271bbad7a9232f9052923
parent 9a3028b987d73e4c85e8db9980720feba6a1b5c6
parent 2aedccd3d51ec922020f7c7e39df5d2c4d3af515
author Junio C Hamano <gitster@pobox.com> 1280274846 -0700
committer Junio C Hamano <gitster@pobox.com> 1280274905 -0700

Sync with 1.7.2.1

Signed-off-by: Junio C Hamano <gitster@pobox.com>

$ ./git cat-file -p HEAD^
tree 4ffcd88bed7a675e2d130a41203a7ebe026b6462
parent 9a9fb5d3c4c8601beb2d7b8e3b9283c6c3815a2d
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 127992=
5924 +0000
committer Junio C Hamano <gitster@pobox.com> 1280124888 -0700

tests: Ignore the Test::Harness .prove file

We document how to run prove with the --state option in t/README. This
produces a .prove YAML file in the current directory. Change the t/
gitignore to ignore it, and clean it up on `make clean'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

$ ./git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` A
old  =3D ba9523ea809dc496a14f3644bdc1dd6f486983c0
new  =3D 9a3028b987d73e4c85e8db9980720feba6a1b5c6
sha1 =3D 9a3028b987d73e4c85e8db9980720feba6a1b5c6
tree 4ffcd88bed7a675e2d130a41203a7ebe026b6462
parent 9a9fb5d3c4c8601beb2d7b8e3b9283c6c3815a2d
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 127992=
5924 +0000
committer Junio C Hamano <gitster@pobox.com> 1280124888 -0700

tests: Ignore the Test::Harness .prove file

We document how to run prove with the --state option in t/README. This
produces a .prove YAML file in the current directory. Change the t/
gitignore to ignore it, and clean it up on `make clean'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

$ ./git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B
old  =3D ba9523ea809dc496a14f3644bdc1dd6f486983c0
new  =3D 9a3028b987d73e4c85e8db9980720feba6a1b5c6
sha1 =3D ba9523ea809dc496a14f3644bdc1dd6f486983c0
tree 4ffcd88bed7a675e2d130a41203a7ebe026b6462
parent 9a9fb5d3c4c8601beb2d7b8e3b9283c6c3815a2d
author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 127992=
5924 +0000
committer Junio C Hamano <gitster@pobox.com> 1280124888 -0700

tests: Ignore the Test::Harness .prove file

We document how to run prove with the --state option in t/README. This
produces a .prove YAML file in the current directory. Change the t/
gitignore to ignore it, and clean it up on `make clean'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
--=20
Duy
