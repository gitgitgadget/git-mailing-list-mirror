From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Thu, 26 Sep 2013 13:08:18 +0200
Message-ID: <20130926110818.GE6615@paksenarrion.iveqy.com>
References: <522FAAC4.2080601@gmail.com>
 <52416058.90008@gmail.com>
 <20130926101648.GD6615@paksenarrion.iveqy.com>
 <CACsJy8BQDwHJiDyaOfcmOSg+=jpj-NyCTtw1vLwppSwYxF5hhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 13:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP9JJ-0008Qo-2M
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 13:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab3IZLAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Sep 2013 07:00:37 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:52906 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019Ab3IZLAg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 07:00:36 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so794945lab.12
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PUZjipwVyfgxWUOckEqy9Usxi1QnNGVNfjCczf1Ft6g=;
        b=aOipcekXDDSHV69uCEVu7evpWm7j7Txu2MxsYMszMaAE8x7UcLrOkoCpWVNqilV7Ja
         szX5F+CEw21y9IJSrTWFEOxSTVdIg3WTAG9Zbi8ZjRcn0PFAXBcxUb0unXj0hz1xIqaq
         hP/75SbkNNMcnvt/RT29/oOGDQYU65cCYpqIzJO94/7QrQtqj6PSoHNc0yP0oOAMFSEq
         3Su+VUjPCbo+Pus4wM1eoakEgOd/nzRQ2Y/spJ4vzcfzcI+0u4CXWAqvFHhJ+yUboAo2
         xla7uGUm4/j9rDK4RBXo/m+/I8It81luZp7beNe98A4ESJIN+NKCHkU4dqU+sk1pnylx
         zB3w==
X-Received: by 10.152.228.130 with SMTP id si2mr230165lac.32.1380193235083;
        Thu, 26 Sep 2013 04:00:35 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id yl7sm2030913lbb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 04:00:34 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VP9Qg-0000hD-FL; Thu, 26 Sep 2013 13:08:18 +0200
Content-Disposition: inline
In-Reply-To: <CACsJy8BQDwHJiDyaOfcmOSg+=jpj-NyCTtw1vLwppSwYxF5hhA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235415>

On Thu, Sep 26, 2013 at 05:26:27PM +0700, Duy Nguyen wrote:
> On Thu, Sep 26, 2013 at 5:16 PM, Fredrik Gustafsson <iveqy@iveqy.com>=
 wrote:
> > On Tue, Sep 24, 2013 at 11:50:16AM +0200, Karsten Blees wrote:
> >> Tests can be reproduced with 'time echo "perfhash[map] <method> 10=
00" | ./test-hashmap', see test-hashmap.c for definition of method flag=
s.
> >
> > So I'm still curious about the actual performance improvements for =
git.
> > I runned git describe on the linux kernel with both the old hashmap=
 and
> > this new one:
> >
> > ...
> >
> > I can't see any improvements at all here. What do I miss? Am I runn=
ing
> > git describe in the wrong way? Does linux.git have too few tags to =
be
> > important?
>=20
> I wonder if it makes any difference if there are a lot more refs. I
> hear gerrit creates a lot but don't know how many. linux-2.6 has ~350
> refs. How about increasing the number of refs to 3500 refs?

So I runned:
for i in $(git rev-list HEAD ); do git tag "tag$i" $i ; done

in my linux repo and aborted it after a while:
iveqy@minilla:/srv/slask/linux$ git tag | wc -l
9323

So it's a few at least. Not sure how those artificial tagnames would
hurt or improve the performance.

Old hashtable
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD=20
v3.12-rc2-83-g4b97280

real    0m0.384s
user    0m0.288s
sys     0m0.092s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD=20
v3.12-rc2-83-g4b97280

real    0m0.383s
user    0m0.284s
sys     0m0.100s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD=20
v3.12-rc2-83-g4b97280

real    0m0.386s
user    0m0.312s
sys     0m0.072s


New hashtable
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD=20
v3.12-rc2-83-g4b97280

real    0m0.382s
user    0m0.300s
sys     0m0.084s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD=20
v3.12-rc2-83-g4b97280

real    0m0.382s
user    0m0.288s
sys     0m0.092s
iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD=20
v3.12-rc2-83-g4b97280

real    0m0.384s
user    0m0.296s
sys     0m0.088s


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
