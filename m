From: "Aubrey Li" <aubreylee@gmail.com>
Subject: Re: git clone problem through HTTP
Date: Sun, 22 Apr 2007 13:10:25 +0800
Message-ID: <6d6a94c50704212210o4f19679fxc2938ad07176682e@mail.gmail.com>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
	 <7vodliyd1j.fsf@assigned-by-dhcp.cox.net>
	 <7vd51yybpf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Brian Gernhardt" <benji@silverinsanity.com>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 07:10:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfULX-0004Sc-CA
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 07:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXDVFK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 01:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbXDVFK2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 01:10:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:54814 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbXDVFK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 01:10:26 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1045453nze
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 22:10:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PW9jV2i3p6UKPK/zLqmPFAAtrRrqcklen9bbTFDjpofApZENKBLONiFXKVvGtiF3zvIMatX86snRc4Qh3eubDDlKHW9AYM65NVO9E7Jsz9ReHk+9+rt9/eT3y0TfJmb6t6fFaGx9T8Rl5dgIuTc/MpfbhF6PhFeKqqIlI1UFSeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AByDQ3JhA9dJghu08pbYMBitNuYvtwgcb1vnEb7hFBxsZP/IsuTlSdp74R0mwVOOkDaS5557a0Dy0fkM8Vk21TwjWJ1Y70JiMQLXgsWlUgHA5yp7Nulvrh742SuW/QghSUIdua4LUVxkC31ZAFX3pMg3M7R2M+0XhNSr4cmqeQs=
Received: by 10.114.154.1 with SMTP id b1mr393172wae.1177218625693;
        Sat, 21 Apr 2007 22:10:25 -0700 (PDT)
Received: by 10.114.146.20 with HTTP; Sat, 21 Apr 2007 22:10:25 -0700 (PDT)
In-Reply-To: <7vd51yybpf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45212>

On 4/21/07, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> > [[manual workaround to make it work with existing tools]]
> > ... should work, because I knew about this problem and fixed it in
> > git-fetch in v1.5.0.
> >
> > Alas, I forgot to update the matching code in git-clone.
> >
> > This is why I keep saying that we should get rid of as much code
> > from git-clone, and make it essentially a thin wrapper around
> > the six commands I quoted above.
> >
> > ---
> >
> > diff --git a/git-clone.sh b/git-clone.sh
> > index 513b574..cad5c0c 100755
> > --- a/git-clone.sh
> > +++ b/git-clone.sh
> > @@ -60,7 +60,7 @@ Perhaps git-update-server-info needs to be run there?"
> >               else
> >                       tname=$name
> >               fi
> > -             git-http-fetch $v -a -w "$tname" "$name" "$1" || exit 1
> > +             git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
> >       done <"$clone_tmp/refs"
> >       rm -fr "$clone_tmp"
> >       http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
>
> I've applied the above patch on top of 'maint' and it clones
> Linus's reopsitory over http just fine.  I will include this fix
> in upcoming maintenance release v1.5.1.2.
>
> Thanks for reporting the breakage.
>

Thanks for fixing this issue, but so far I have no chance to verify it.
I cloned the linus' git tree 5 hours ago and it hangs at
"got 345019345f09254292831cb75c6824d826592b09",
Now 5 hours elapsed, it still hangs, no error, no warning as below:
===========================================
aubrey@ubuntu-feisty:~/upstream-kernel$ git-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6
Initialized empty Git repository in /home/aubrey/upstream-kernel/linux-2.6/.git/
Getting alternates list for
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting pack list for
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting index for pack 25bdaf46d6823b132b076f6e4467d0607876ca66
Getting index for pack d7c8d1a960522394a6aa0b952bae5bb2c3b49deb
Getting index for pack 26e13df8f754e1521ff927b46e47934f2fbbffb6
Getting pack 26e13df8f754e1521ff927b46e47934f2fbbffb6
 which contains 0f851021c0f91e5073fa89f26b5ac68e23df8e11
walk 0f851021c0f91e5073fa89f26b5ac68e23df8e11
walk ea8df8c5e609a53f4d03d133baea9561412f4303
walk 8929fea39cb0ab3e455fe00e7eb6806c32155cd2
Getting pack 25bdaf46d6823b132b076f6e4467d0607876ca66
 which contains 060a71d41ad7ccc3214065a182e6f67568420071
got 234bae68cb98ec1eb6d6ef7d4d5b5a1e912cb7bf
walk 241c39b9ac4bf847013aa06cce6d4d61426a2006
walk 1d464c26b5625215c4b35fb336c8f3c57d248c2e
walk 38b66f8444050c7cdfad759b8b556338e1fcb4da
Getting pack d7c8d1a960522394a6aa0b952bae5bb2c3b49deb
 which contains 66384c580873a1cd270f462024f6f1e855e9fd72
got 0298f016ee23659121cefa271ae66966a64cd424
got 58bd33f6890ceefadb1a7b0075f3fe03b546699d
got a965e259b9fc8fb88c31579b9101dad9a970a7b1
got 56fd03cfe031eab738b7306dd143f16103166235
got b3ee2932815d17c8e4b7c90f245837bd236d761a
got 8549905d926ce8278d46f3152f03105de24e288f
got cd6c1010f011937d4e0d7e36e1d1ba7745546a7b
got 7cf006e71b7778ad859b30b80735ab558f63e7f2
got 3494ea781bf2d0455fa1a94a3c61e6629dacee83
got 244f4a6deb4cf1a6c9f221fe22ee1e41210f975f
got 114e99c6dd853f7f5eb77e2c5f0d6d49bf223d49
got ab1a09ea04b06ba38816528c1091a4bf33759ced
got 9be48827ac233e192db3201d9d634013a8d9ea3b
got ebe3480c6ee1cb422ec4d2cfd9057700406df56c
got 0ae65a338d14f1ab5f31f80b74f2605c855f4fb9
got d2b13fee42dad2216a7913a694e9be154b846c1f
got 019fa5d835565eeaeffcb646fb5eafea1241ca28
got 63f915d3551335374428fd8cb1997598e39e302c
got a1afcc413c0e44361ca1a6a868ed5fb8576813d7
got 891f99feea7ed68bbf74640bfd020cde5d4ecf9b
got cab26f301eab5caed62b1a3dcf8c4c7896b23d8b
got 8dc3bc4f5863dc33ea1832083ef3a6325d896b1f
got 42e9b05e17387374c8aabcdc7d494b3c3e13edbe
got ac36152c68bf1261206e86f5373ff5eac21b09a7
got 2b4c8974f2649242cf946421bc8af83cad47f5b2
got 50cc1700978d2ae577594c6ecd8d2db5f00b9014
got a3d46ea371269d4e0ae069365405389b6443ffb8
got 9f10689905a8d68c3eb7be4b00561c52f7f6ac23
got 656bdb1352d8d8ee44991ecb8e2ca75f0f5b05a6
got e3019d52c30f751533d7ad58abea58fc53ab39d8
got 5efb5afc45baa091eee09138cdf1593cb3d4341c
got b6e0eea1e39e015bcc11da33495a249c06e5f156
got 44aa9b726573b2685d0007c27876b13fe4a5ef2f
got 2877744cb6069439ec60e199d715eb55276fb6fc
got cd3469720cbf9e08e07ac085f98255e2d7ade549
got 0eb7d596d4703cd3f773c529b6888eaad5172b48
got aebb4e2d5ae30e055df38924e2e835a14e623080
got f7dcbdac0a8a5dbfa92c684d9e4e3f5c520b9ec9
got 4b01496dc33d3439eec32b4fafe74bbcc4538b58
got 2772fee93881f1fc85d5e8a56b7a31fa3e1c5cca
got b29e3e4b72c922e10be26207b6a8c102029d9de8
got c48b0f49f00362d1ec7ed5625a1ab8e6d73bf946
got 345019345f09254292831cb75c6824d826592b09
--------hang here-----------
==============================================
Any suggestions? thanks!

-Aubrey
