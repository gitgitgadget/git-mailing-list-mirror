From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Fix TreeWalk.idEqual when both trees are missing the path
Date: Wed, 21 Jan 2009 00:50:30 +0100
Message-ID: <200901210050.31131.robin.rosenberg.lists@dewire.com>
References: <1232387556-10289-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tomi.pakarinen@iki.fi, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQO9-0000Se-6S
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 00:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870AbZATXum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbZATXum
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 18:50:42 -0500
Received: from mail.dewire.com ([83.140.172.130]:21897 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792AbZATXui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 18:50:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A8928147E631;
	Wed, 21 Jan 2009 00:50:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4PiDycu8K3X6; Wed, 21 Jan 2009 00:50:33 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3089C147E60C;
	Wed, 21 Jan 2009 00:50:32 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1232387556-10289-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106540>

m=E5ndag 19 januari 2009 18:52:36 skrev Shawn O. Pearce:
> The Javadoc of idEqual() says its simply a faster form of
> getObjectId(nthA).equals(getObjectId(nthB)), but its code
> didn't match that definition when both trees didn't exist
> at the current path.

Great. I think we're almost ready for merge. First a few test
cases below. If you think they are ok, I'll add them after the
(simple) merge implementation, or maybe squash.

However there is a conflict with the CanonicalTreeParsers here and
in master. Shawn: Could you resolve that and resubmit patch 5 rebased o=
n main?

-- robin

=46rom 7e8fd54d304bac1fcf08e29c9b8a208c9d0be743 Mon Sep 17 00:00:00 200=
1
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Mon, 19 Jan 2009 23:09:09 +0100
Subject: [JGIT PATCH] Add a few simple merge test cases

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/test/resources/create-second-pack |   13 +++-
 ...ck-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx |  Bin 0 -> 1296 by=
tes
 ...k-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack |  Bin 0 -> 562 byt=
es
 ...ck-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx |  Bin 1088 -> 1100=
 bytes
 ...ck-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx |  Bin 2696 -> 2976=
 bytes
 ...k-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack |  Bin 5956 -> 5901=
 bytes
 .../org/spearce/jgit/test/resources/packed-refs    |    6 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    3 +-
 .../org/spearce/jgit/merge/SimpleMergeTest.java    |   86 ++++++++++++=
++++++++
 9 files changed, 103 insertions(+), 5 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/tes=
t/resources/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/tes=
t/resources/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/merge/Si=
mpleMergeTest.java

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jg=
it/test/resources/create-second-pack
index 052877d..5501a67 100755
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/cr=
eate-second-pack
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/cr=
eate-second-pack
@@ -138,7 +138,18 @@ done
=20
 git repack -d
=20
+git checkout -b f a
+mkdir f
+echo "an eff" >f/f
+git add f/f
+git commit -m "An eff"
+git checkout -b g a
+mkdir f
+echo "an F" >f/f
+git add f/f
+git commit -m "An F"
+git repack -d
 git pack-refs --all
=20
=20
-qgit --all master
+gitk --all master
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.idx b/org.spearce.jg=
it.test/tst-rsrc/org/spearce/jgit/test/resources/pack-3280af9c07ee18a87=
705ef50b0cc4cd20266cf12.idx
new file mode 100644
index 0000000000000000000000000000000000000000..300c0cea48c6c4eda2b870b=
3631355c2137cebb0
GIT binary patch
literal 1296
zcmexg;-AdGz`z8=3DxBw$if)Wfen|Y98R-n6x!E8Wvw8HE_v#E_afM$;3(J&x74Y2LV
z)Q$1iT(-xv{o%d?ezP~d30WlO{o~}bSuv7YXEk0%y}!Bi+NY5F;<3>Ud#7h~`1YT>
zpf~%nNr$-eG+Xt8#O{s4dXa}k?k(2XVRih3k&*4s=3DJ(gu+%LX=3Dd`sY>$NY6y^vccL
zFK5=3D6yT6d|<2_P&W-sI8NG8+rIE_yi-_5-HB{Hf?{<GXKDS;Zn=3Df$-%{*{*K-dyoz
z&(nux&wt#UJNGfeC6_5O>cO{}3Ii^?mL8a&y=3DG5Sv+Zu7cmBCoC&;S-%NRy4AT9!?
z`vpMy1+YjH0J3?2>?R=3DnM4az|fajV^sv(TevSnRfJoL#bbLi`ut*5^~(=3D3sT{r8l`
LdIkBjci#j6ga?3q

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack b/org.spearce.j=
git.test/tst-rsrc/org/spearce/jgit/test/resources/pack-3280af9c07ee18a8=
7705ef50b0cc4cd20266cf12.pack
new file mode 100644
index 0000000000000000000000000000000000000000..fca3460ed2d263db153ef11=
a3e559aa47be9efa1
GIT binary patch
literal 562
zcmWG=3DboORoU|<4bj+wj_bLMu(avd@dV7p)3wYNd_w#iMsjvLl57%x5H=3DK9t?sp<Ik
zy-ohcJU(|Bgw!K{Gkv_Y)iV2yx4Bxy1{RN(o3pO*q+i>SxK8BLij_wrj#O`T2rS%|
zUidH}#Dz~P_m$6`*V#8S7O30$?L3y2f3D=3DXx!-Gc->7BMhQ+Jj+_2mgvGJNrY1Q>E
z`!M4(EkS4a)5PtqUNAR^RLt3ZvSM!F_9Ysop$AQ_o=3D`fgan!){>Lnvp)w4&gTr#<6
zbJ0Ne><t4`-HQenFC4JBdBNan&7yZ)YUX+jzt0Q2UdLK7$Jmg8snw;eQ&#wAvg(}L
zl3h94ac_R_Q2Cq@G><bvueUMReOX@5{%4zP=3De_0sF8g8j-j}{7l$@EFjfI6<?;LqF
z>59_cNnJv1%X-D5F2%7O*}gP)y~fA+sX;sDEEi;$xJmWcT1KEPCI$w^hJhZ*0-ygC
ze!96v!gK9rDgDLw?#EQU4L(uJFlPtvbn}Wi-e-b6e7zqtF>ux~X%pkRgJF9WHdZg*
z5cec;Vs*D^S%j>8VoFLzLPA>7q6xDjVkSi`2@eW9bYaU!C+}OQ8-8rt@>W#!-)0}K
z>7PxQ7@WVWFrc_@!{3{K{@t4O`{?)ne9o9JGxophirXp4u;mKxJX5gi3V?27nZf8F
Z&i6pTbIm2y5XNWOvMw(k`ec<k001O50^|Sy

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx b/org.spearce.jg=
it.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89c=
c2e6b89d2bd8e5de02b5745.idx
index cf58d5baa11824217bb0c5eab7444fb406219885..58b712f6c58e3b99abd536c=
17c306ef2c37c5238 100644
GIT binary patch
delta 89
zcmV-f0H*)I2+Rlw|8!4d00002kpW(@UZMj;7j}SvqA`rvo4QPkhl4}`;t5v+%)Fm1
v0000CGYgnnQ2?6FEimT$X76fU(jBSR$3y!oeS1unZtru#oQ%-R@OV6B4p%0y

literal 1088
zcmZQzpebMknm&q0!(cQG4Bj-rBVN|fu*k6I#_U}_-R;dTjE^|OnT@$;L<KU;I;(5&
j?04Gxtk_GkE3duSzFw<E`CW}`!gtH2lI+N+ZF^b)CtDqp

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx b/org.spearce.jg=
it.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6b=
db59ee3fcc6eb0983e20371.idx
index 2579301b8447e4d55480f65ae6c27fe1eb99bf4d..3ff542377406158d8155129=
ae66fc0b51cba76b8 100644
GIT binary patch
delta 1975
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

delta 1424
zcmXAodpOg39LK-zhS}CORBqiywTvYvt=3DowdD#N2mgzBt@5IKe;vS>-U{M=3D6D3@eXI
zwN+-U$n|h4?YM<bxg?b9L8d%7UpxPPp6C1ezTfZ9=3DgrgQ67$uSEdjtNDOOS2&*wP<
z#X22l#6LK^By6P^01bB(lW#e;PSHzLL5MFsS6EYh-&h0yQGl2$6OI9ZKBloRJmlyt
ze{7J*6yMO*Ws-V3^%|UaVwI)u%1Ddz=3DJW!~7IC7T8e?rc0NP}1uY1NtV?1EdM|xcy
zgI!z%v|#|0)+4e111pF>z6?7n@9SSOnEb{qIZ)#f`EwHh*c_ej;~>xNV#BVv(5gKK
zGHOTeXgvgSjNWxdEc$&~PT%n|m&~@bksg~d1VHB`B9#NNuB0%%<Zc$b^ZD@*9P8Ew
zy+^cpcK}e;WJ_dMg)B>rEZf>JD?t&)MIT!LSi>jR&k;TD^m-mx-|W?&ouuH_{8}FZ
z-y+5;tCm&xhlWNPKdTMk$0Te8p}))9gs9&J003I{)a}CPJ+D*kz9(f#+0Il`$?Qw0
zkY?Yw;CwJJR#~hg*2M(rebOEcuY~h7Bv=3DmAtZ=3DWkJ0)S@(kBj|l{)UaN7@kN5(t25
z?Wtft+>61=3Dn|DpPyQhqcuO{EfXaj%{?!BetTj&TcofUDT*hIXupNqG<0{?GCUdn;E
zgtJ1=3Dd%exBQxfnkb<^B+!D-d*r%<`(`LiS4iZ+?T<G(r&j^hR;(~&9-(3(a7r&!9%
z9sYY`n#GCso`HF7>tz81x*}NBRm<vkE>+fz$=3Dp&VzlW;pT7_!l<+FJ3q2lR4LYQ$N
z1BYpytK4L46JVGfQn(Q+-x?EVYF)6L<ujY`O7iMJTI2Gyk20v-0r8OoiLyBJIgWY1
zidUXyV?j~4-uwq-vlwQQA19PvXMUl3Con76SDfxzUM|vt=3Dd@-aZqbY#8kTdV0c*_D
zsQQ}wQ(`0$09+{|kOP$+IUI+`rIK}Pd``w+n17g}sC0AwJOFC5oVID3^>140mdLtd
zQvz*x(y2NYDyfeTtW$p!@UU#lgLh7Ah1;J*ZeHFD&#Wj-ZPl^1K|*U&d35X&UkNOt
znGwI-udioN;NhRU?MK-*{iHI8iteI_dQyYh?4x@Cz-K4ZtB4(l>$Sa2gNoUJjMfzt
zPr_owA#^zq-IVF-i#MYXZ~pd2*PkZU<zeQG`b6jeotfwuP;$%dL2P!vz4wc}up;T1
zA8_tlz-@cIf25mo)GYW>RM5mTp7jS5OkzL6lLLtue*b6m5UVVZ(q}fRr#|D_S&<AI
zrfE=3Di^{Q<x_srsvZJiEmYBaN^VSEY#yUU~-F{-km_w=3Du)3l2^9O>B)ac?{=3Dn$g~`=
Y
zU#`3n!<nnA(%RR(Nb&bp=3D9T;#pAM_}v`XZEbiryOL+f|^iFu|?kRTGpgVz44&N;l3
z##Eqv)DI<0HDXG8p5|VHJs3j{s;_3Kvr-$C_eDxK8h`ksUZlm37dm-WXTuB`wQ(_O
z1B5!2Bmek?WV&;M`Q;)q%rL2?>2VDE`4M|`&Hgy@%xv9p#}r?<iwYz~4pb<W;vB?f
zRR2=3D*PY)P8>o9g>{$nm&vPZj-hfjy<sD<>TxNOVrP9j!o#|#A8c2o+Dnt|V}z;ouA
zFE)I_FDFS2R-c6Q%Yo?9Ud)}Ib;%TrY80)HMDp_FCoMoFI)y_knjx=3DH>F;I5y(En>
zJN<jy?d351@!^^kPXmnh8#>YD*&aiDH%NSL0i&2i%u$4cun_t(TE+z<DpRM+f7>Fh
z?~SAtr)g`O&$8&1U0h1vT~cU;GC=3DRe9<sOUyT0Rzlyn)1V7VEdU<8k4y$JXZTkul8

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack b/org.spearce.j=
git.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6=
bdb59ee3fcc6eb0983e20371.pack
index bb47c90d93b0b2276fc36b96bc8734085bde6007..ef56d7e941828561e9f6e2c=
bc46e2d6c9c8d76bf 100644
GIT binary patch
delta 55
zcmV-70LcHuE{!g*s{sV$1%N=3D4!2w$X;R0W?G6I+l180Cov)>O<2NYiZCg!fo8+@2=3D
Nzv)s5^+^m_Both>71IC!

delta 110
zcmV-!0FnQVF2pXds{t1D1;B8vj0l7bffm|^TP<Z-I%~PjDwD4PTNd#G&=3DE?wtTJn>
zFyp3IpgDDT#i6f=3Dvkd~64Hb6+x-!#bo>2e-!WL1JYjAg}b^oces1H#G6hxtEG1~WN
Q{ggPWqc#a04LlG+NkNq^UjP6A

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resou=
rces/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test=
/resources/packed-refs
index 746bd6b..fd735fe 100644
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pa=
cked-refs
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pa=
cked-refs
@@ -4,8 +4,10 @@
 6e1475206e57110fcef4b92320436c1e9872a322 refs/heads/c
 f73b95671f326616d66b2afb3bdfcdbbce110b44 refs/heads/d
 d0114ab8ac326bab30e3a657a0397578c5a1af88 refs/heads/e
-d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
+47d3697c3747e8184e0dc479ccbd01e359023577 refs/heads/f
+175d5b80bd9768884d8fced02e9bd33488174396 refs/heads/g
 49322bb17d3acc9146f98c97d078513228bbf3c0 refs/heads/master
+d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
 6db9c2ebf75590eef973081736730a9ea169a0c4 refs/tags/A
 17768080a2318cd89bba4c8b87834401e2095703 refs/tags/B
 ^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
@@ -27,5 +29,3 @@ bf5123bb77c7b5a379f7de9c1293558e3e24dfb8 refs/tags/B8=
th
 ^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
 dd144af286452bfd6a1ea02b0d3745bcdb555e9d refs/tags/B9th
 ^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
-8bbde7aacf771a9afb6992434f1ae413e010c6d8 refs/tags/spearce-gpg-pub
-^fd608fbe625a2b456d9f15c2b1dc41f252057dd7
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryT=
estCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/Repositor=
yTestCase.java
index 9e48fde..20348f1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase=
=2Ejava
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase=
=2Ejava
@@ -236,7 +236,8 @@ public void run() {
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371",
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
 				"pack-546ff360fe3488adb20860ce3436a2d6373d2796",
-				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
+				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa",
+				"pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12"
 		};
 		final File packDir =3D new File(db.getObjectsDirectory(), "pack");
 		for (int k =3D 0; k < packs.length; k++) {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMer=
geTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMe=
rgeTest.java
new file mode 100644
index 0000000..96064f5
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.=
java
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.merge;
+
+import java.io.IOException;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class SimpleMergeTest extends RepositoryTestCase {
+
+	public void testOurs() throws IOException {
+		Merger ourMerger =3D MergeStrategy.OURS.newMerger(db);
+		boolean merge =3D ourMerger.merge(new ObjectId[] { db.resolve("a"), =
db.resolve("c") });
+		assertTrue(merge);
+		assertEquals(db.mapTree("a").getId(), ourMerger.getResultTreeId());
+	}
+
+	public void testTheirs() throws IOException {
+		Merger ourMerger =3D MergeStrategy.THEIRS.newMerger(db);
+		boolean merge =3D ourMerger.merge(new ObjectId[] { db.resolve("a"), =
db.resolve("c") });
+		assertTrue(merge);
+		assertEquals(db.mapTree("c").getId(), ourMerger.getResultTreeId());
+	}
+
+	public void testTrivialTwoWay() throws IOException {
+		Merger ourMerger =3D MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(=
db);
+		boolean merge =3D ourMerger.merge(new ObjectId[] { db.resolve("a"), =
db.resolve("c") });
+		assertTrue(merge);
+		assertEquals("02ba32d3649e510002c21651936b7077aa75ffa9",ourMerger.ge=
tResultTreeId().name());
+	}
+
+	public void testTrivialTwoWay_disjointhistories() throws IOException =
{
+		Merger ourMerger =3D MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(=
db);
+		boolean merge =3D ourMerger.merge(new ObjectId[] { db.resolve("a"), =
db.resolve("c~4") });
+		assertTrue(merge);
+		assertEquals("86265c33b19b2be71bdd7b8cb95823f2743d03a8",ourMerger.ge=
tResultTreeId().name());
+	}
+
+	public void testTrivialTwoWay_ok() throws IOException {
+		Merger ourMerger =3D MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(=
db);
+		boolean merge =3D ourMerger.merge(new ObjectId[] { db.resolve("a^0^0=
^0"), db.resolve("a^0^0^1") });
+		assertTrue(merge);
+		assertEquals(db.mapTree("a^0^0").getId(), ourMerger.getResultTreeId(=
));
+	}
+
+	public void testTrivialTwoWay_conflict() throws IOException {
+		Merger ourMerger =3D MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(=
db);
+		boolean merge =3D ourMerger.merge(new ObjectId[] { db.resolve("f"), =
db.resolve("g") });
+		assertFalse(merge);
+	}
+}
--=20
1.6.1.rc3.56.gd0306
