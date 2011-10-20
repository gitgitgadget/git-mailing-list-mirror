From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/5] t7004: extract generic "GPG testing" bits
Date: Wed, 19 Oct 2011 17:37:02 -0700
Message-ID: <1319071023-31919-5-git-send-email-gitster@pobox.com>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
 <1319071023-31919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGgdU-0007Z2-OE
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 02:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab1JTAhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 20:37:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755678Ab1JTAhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 20:37:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50E969D3
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QxH4
	JFy8NIWGpG9bbXMPLg6MLOE=; b=umJs0d9oO5m6XE1Nj+aEGkJPxuFbE2dsObSj
	88Ey3B+cCUiwa575iGsmyrzI+HQ04qtzcKViQG8iFPDgXJ0mOgwK/5Sr4uHUA/8k
	u3KJAEvudOHhbZc7ZTTBUgnx/Q5/R0FIpqwvP0gy5aTp5/f/Vxp0ACfMkQrpxJ2r
	XUuIjBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aF0KmU
	XQHuYOZKPJsS1iDpy64MiU5JPo/4NZMz+iao1xeuWKKSFJUbi5vrqihb5P/VR9dl
	GMFvlYslMSr8FH74BL2mMDjCu//QmovHI0dMW3pc2WQxIzSYD7kdOHxSl/i37qJr
	/XwZYkPHpSx+2GaZgY4JBRRzaqH9pngmD4BEo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAEC769D2
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D723F69D1 for
 <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.498.g3f2e50
In-Reply-To: <1319071023-31919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A6FE8846-FAB3-11E0-9903-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183993>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-gpg.sh          |   29 +++++++++++++++++++++++++++++
 t/lib-gpg/pubring.gpg |  Bin 0 -> 1164 bytes
 t/lib-gpg/random_seed |  Bin 0 -> 600 bytes
 t/lib-gpg/secring.gpg |  Bin 0 -> 1237 bytes
 t/lib-gpg/trustdb.gpg |  Bin 0 -> 1280 bytes
 t/t7004-tag.sh        |   29 +----------------------------
 t/t7004/pubring.gpg   |  Bin 1164 -> 0 bytes
 t/t7004/random_seed   |  Bin 600 -> 0 bytes
 t/t7004/secring.gpg   |  Bin 1237 -> 0 bytes
 t/t7004/trustdb.gpg   |  Bin 1280 -> 0 bytes
 10 files changed, 30 insertions(+), 28 deletions(-)
 create mode 100644 t/lib-gpg.sh
 create mode 100644 t/lib-gpg/pubring.gpg
 create mode 100644 t/lib-gpg/random_seed
 create mode 100644 t/lib-gpg/secring.gpg
 create mode 100644 t/lib-gpg/trustdb.gpg
 delete mode 100644 t/t7004/pubring.gpg
 delete mode 100644 t/t7004/random_seed
 delete mode 100644 t/t7004/secring.gpg
 delete mode 100644 t/t7004/trustdb.gpg

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
new file mode 100644
index 0000000..eb09027
--- /dev/null
+++ b/t/lib-gpg.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+# Check if gpg is available
+gpg --version >/dev/null 2>/dev/null
+if [ $? -eq 127 ]; then
+	say "# gpg not found - skipping tag signing and verification tests"
+else
+	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
+	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+	# that version, creation of signed tags using the generated key fails.
+	case "$(gpg --version)" in
+	'gpg (GnuPG) 1.0.6'*)
+		say "Skipping signed tag tests, because a bug in 1.0.6 version"
+		;;
+	*)
+		test_set_prereq GPG
+		;;
+	esac
+fi
+
+# key generation info: gpg --homedir t/t7004 --gen-key
+# Type DSA and Elgamal, size 2048 bits, no expiration date.
+# Name and email: C O Mitter <committer@example.com>
+# No password given, to enable non-interactive operation.
+
+cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
+chmod 0700 gpghome
+GNUPGHOME="$(pwd)/gpghome"
+export GNUPGHOME
diff --git a/t/lib-gpg/pubring.gpg b/t/lib-gpg/pubring.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..83855fa4e1c6c37afe550c17afa1e7971042ded5
GIT binary patch
literal 1164
zcmV;71ateD0ipy(XUi!O1OT%L_{gO;4KKDfwF;#WWYZ2?*>Ph_j9y>uobJf#jXEbw
zQUOEXs+@;X*)1kyN*7VwW}f-GD3>Vlu2F6j{T^Kt%(kMo(W3C}W^X)NL|0VdGIzc`
z5@TY!;Du~AFGW=#0vYgS@U2j8Q{Qe9F~lQEBVt+(yjM1jQ{YLe0lxsC<HX~BiFSU3
zs3oq~QtxsAzbwuV1N{{&PcudMk6}p><?O}^6vikhMm+>LD}W25r?wdKr$(|R8_;Mn
z&Yh%2Hbu9IX>#(R8S&@jVI!K^K7AI$=A+*-qJ>-J^fdR_m5GZao*%P{nee=O$Eb$s
zes#O%4Z_4OAZW}8Ey8%%w->rA>z!nf)&NPikkr&pkRlB>=W+x68fwevWl9Ys2R3m2
zNPf<ig>x1y^AXyemu>Q}DAp%==Q`5sCrBzLaH^rOm1NLtt-ig*IfY?HMdv66@%u%#
zy0K62;Z+4O3Ol6i*<7GlXeW6FC?0yV!c_#yGozNjrOE#8+Rw@Z8cGAG=eE%uMUW=V
zX(76db;AG@lD)hAv?4<wPasWcbaZ8MAUtDlZEb0EbY*ftWq4t2aBO8RV{dIfh+YH}
z5dr`n1p-EA%P9gI0|pBT2nPcK0~G=T0~P`S0v-VZ7k~f?2@n&u^&ZXMLk)Bt0G~<e
ziCMX)QRqT4mEiivJ-X>{Mxg+pzucC_!d-8(MV+3G?_=VDC^nQ}umS)BxdIIYMrX@T
z5C{Oyxp_ZR>*yfS@@M%BVY6{X4EXUYpbiBs(uw7knRB|b)>)=o+wQ%-v34o&a|fQ;
z&R=xVK8Z-jS8R4m_gj2C$xPq$xv1H553!y9ip8A~vxoyq&fFbw!L$zU@hDh#f$r>>
zAYPcTf%K%xv5<+JivV@Da!&`-v8eIo5ApKIdiK7E`krA1X!I73&)t#yo}GERUSnBN
zlK-+<I<**0!u}jvbPz5b{hhe8_PVcR!i8ObFp-W0bqNWKA+W14zV9Mj$a~(KZ-0uf
z|BVvaf!K}k92MNalP4hQ^Yxqk-*SzY6q{6Cw*+Fr_+LZp=BFzuo3pVX*T?Ic-|hbZ
z1PurPv|=$EKX~Bz_Bz;JW71^>8;AnsY?5ub{hajO)@PHTt`On@Z;}jyeue<@oS$3l
zEu9m5O={<O&85HqUN|R$bZiPXX4YsWsPOn@@M)Lf;hyI_(eM$*#Sf3}T=1jzGvsiy
ziKuCmV^)`UC@8ma=jBiHqr!1L4>w`5P=-vvIiJTGj0-lRpc+EU9(`B#rn1m1WqmXr
z5Z+N|DR*y*k<4fY0I_eP7qVo9Fx58WMwaK^N~I=>1VN29R|Umg^2q$WGlE#9AFC2_
zOYG5M$}OL?FQ)ej0!KGwY-hAFz#wAPr>3&{`s7!HUZ22Y7KY{9ly1wQ8^hqBojPv8
zh)Dz(5dr`S1p-EA%T59t3;+rV5EHib9?jlE4Z-XHpqd%~B34SUmtRi+{;vv2ei?p%
eLjau^#pu5ba=n|GS94<zkje^zT1YFf0ssTLm?$>@

literal 0
HcmV?d00001

diff --git a/t/lib-gpg/random_seed b/t/lib-gpg/random_seed
new file mode 100644
index 0000000000000000000000000000000000000000..8fed1339ed0a744e5663f4a5e6b6ac9bae3d8524
GIT binary patch
literal 600
zcmV-e0;m1=h9nBV>1C6QsKJEiEJaD@Q3F8s5u<$E+<2(By)JAZSxviTsXg(wKC+O%
zzvV{Z>W3*k?r7~pgmmkbw8-x{Am!eeN)z?cwIHcT2jqgiA(SXo<iO=E?cY80`p#w8
z)O-&?SnwsJ=1VJ-?26&*g88Nr8E=g2onRW^(c+2nJlX)?dmK)tPO0EY-!B!vMCv1)
z-AOW(3WuF+7IdSxMnzrDgnMqVU=|+YFxlY|VeR+Fg<%C@0Xupi0<S7QYJyFTR$}FQ
zzoSAbU>CoCKWKX;!3@L_U=aFUm!M<>ILG}$`bfnadAkLQbI-upV7Qwf^OE&N45Pz<
zk~^KlzNC6)d@QGv=K5-At&A8FS&MQSR`LB}@R1?A3K1p(vM>7CK}EfFhmBJd&cH^-
z(3Ih^`VuoVBB|w~p!Q^#DY%V2A2FhXu<Bp*L)lSCUdqRyI5wxMG&E1sL$)E$Zo&pJ
zgy#;fENqHImgN>LL2!7DhfZ}&;BSAyz=T0#S?2+NET5St@16L?YI?5Io%<uD|2}hl
zx0xsuefz1+bM^-ZIgtKs=)&VAI8(MfytvM>t>%~nsXUb~*EkptHiN?W{=DRu_s;2u
ziHh{2&>;CQO7;>{$DN33_Ef}g+;b<2hIF^p(Y>^riLBb*Y2Xw>F8)jp49&oLKJOic
z+V{Lt!_`eKGhyk5Edie{-^#n!TFlsfux*QBRZEh^4SVePPmb{BvF|>sKd2cYg@vKp
mVI8jcB1(k(tlt^Kr<{EMs>|b*d70nyVMQcc%xEnE(#Uq3d^-35

literal 0
HcmV?d00001

diff --git a/t/lib-gpg/secring.gpg b/t/lib-gpg/secring.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..d831cd9eb3eee613d3c0e1a71093ae01ea7347e3
GIT binary patch
literal 1237
zcmV;`1S<QL0lNf7XUi!O1OT%L_{gO;4KKDfwF;#WWYZ2?*>Ph_j9y>uobJf#jXEbw
zQUOEXs+@;X*)1kyN*7VwW}f-GD3>Vlu2F6j{T^Kt%(kMo(W3C}W^X)NL|0VdGIzc`
z5@TY!;Du~AFGW=#0vYgS@U2j8Q{Qe9F~lQEBVt+(yjM1jQ{YLe0lxsC<HX~BiFSU3
zs3oq~QtxsAzbwuV1N{{&PcudMk6}p><?O}^6vikhMm+>LD}W25r?wdKr$(|R8_;Mn
z&Yh%2Hbu9IX>#(R8S&@jVI!K^K7AI$=A+*-qJ>-J^fdR_m5GZao*%P{nee=O$Eb$s
zes#O%4Z_4OAZW}8Ey8%%w->rA>z!nf)&NPikkr&pkRlB>=W+x68fwevWl9Ys2R3m2
zNPf<ig>x1y^AXyemu>Q}DAp%==Q`5sCrBzLaH^rOm1NLtt-ig*IfY?HMdv66@%u%#
zy0K62;Z+4O3Ol6i*<7GlXeW6FC?0yV!c_#yGozNjrOE#8+Rw@Z8cGAG=eE%uMUW=V
zX(76db;AG@lD)hA005tK#LT31ryNoF9o-(`X`Xl5w88@mle8j3AWtAoX>@dDav(fo
zZ*6U9baZ8MKxKGgZE$R5E@N+PK8Rif6A=Oc9t8qMXUi!98v_Ol2?z%R0s|ES0|OQU
z0RkQY0vCV)3JDMsw)Gy(-a`#^9RQ%c+5fOQwB&AM#DD9)s1L@!pm9S0pF>@|C2*qL
z%1j5#NZ6^U*PB>^d9VTi0G$Fo1V(4eP7nwH&bfI%Q|ss;(eh{c3}LfzMGW}yE1(Vq
zEz*hQmYH+9vesFqTifovzOi;G@N);A+0I{d(LRYt$5(82OZQuRJjqPo^tq_na}Tkd
z|BA((5wnN`O3vIJaly0>?(ryCcY*Hgm>^!5uz~cX%CV4%oQnW;wsKDg)3K=W<qz@l
z$a?m^i29yk259sakI&ta{GOe8x?W>hQIh|%Svs{CO~U>hTXYaE9sQlSv-Y~LWWt4A
ze=w1b1$7Atj3KbAF~092T*!Ogn{R)Lum6n_*@4)N@EjG~z>_B+>GSoQ{oitpmlT^+
zUAF{c!T4W8?B=H{DVwvgAlJw1n&0jJ00a#P0JLH;8$Wp9`Sv>4USrZ_1sjM0<!q8|
zxc!{;-PUK5pso<&0dJBFgMNkp@|>Sr>@A%Wd`)WSc+I820A4sJf^=*OHfGjnC8+TD
zW$<a2;o+X=JkjtG#>Eeh?p*Mr_A}&gvx%r_lw($xcPJ>gap&bv^P|FXJr6fwvQUOh
zz&W4C8jK4zqM#Z=%N~7K_NKDXEM<K(9uVG9XDN4YijmA{1^}^dq8GAcg)r4N<3^U}
z-b$q=iUdK8Hdh73UGm8MyfcDWr5~#ja!c&dVahF^v@fRj3IazrWNc@&F~A^V)u*Pi
z`ugNogkGP(V-|+x+mvq0pc}*Bpq)By!2khN4M6SOU21NKpXW5P=UU_LoDzvrTdR;4
zU)W&&o9V6>MQOk{A%?1(Ozs{Qqlifa7!d*h2?YX1XUk3k8w>yn2@n&u^&ZXMLk+>~
z0HDxvfGrJTMY@$ys#k#t?D63Zq=W#R3eUeT(L61`VGHe?zP;`rnta#-umS)8nA%Rq

literal 0
HcmV?d00001

diff --git a/t/lib-gpg/trustdb.gpg b/t/lib-gpg/trustdb.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..abace962b8bf84be688a6f27e4ebd0ee7052f210
GIT binary patch
literal 1280
zcmZQfFGy!*W@Ke#U|?`dKkWykumMIcY@%4iM%7^n6rj+M4;MLzzlOX&pwTnxkD-}P
zc^HbXN0fL!SIq1?>env3?W^3`d(OOU5YNaX{KU(k^<0;M@87ONv)_6ZxD={-=<kYO
M2Ud3=2BC}r0AuhNr2qf`

literal 0
HcmV?d00001

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 097ce2b..ded5c86 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -8,6 +8,7 @@ test_description='git tag
 Tests for operations with tags.'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 # creating and listing lightweight tags:
 
@@ -585,24 +586,6 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-# subsequent tests require gpg; check if it is available
-gpg --version >/dev/null 2>/dev/null
-if [ $? -eq 127 ]; then
-	say "# gpg not found - skipping tag signing and verification tests"
-else
-	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
-	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
-	# that version, creation of signed tags using the generated key fails.
-	case "$(gpg --version)" in
-	'gpg (GnuPG) 1.0.6'*)
-		say "Skipping signed tag tests, because a bug in 1.0.6 version"
-		;;
-	*)
-		test_set_prereq GPG
-		;;
-	esac
-fi
-
 # trying to verify annotated non-signed tags:
 
 test_expect_success GPG \
@@ -625,16 +608,6 @@ test_expect_success GPG \
 
 # creating and verifying signed tags:
 
-# key generation info: gpg --homedir t/t7004 --gen-key
-# Type DSA and Elgamal, size 2048 bits, no expiration date.
-# Name and email: C O Mitter <committer@example.com>
-# No password given, to enable non-interactive operation.
-
-cp -R "$TEST_DIRECTORY"/t7004 ./gpghome
-chmod 0700 gpghome
-GNUPGHOME="$(pwd)/gpghome"
-export GNUPGHOME
-
 get_tag_header signed-tag $commit commit $time >expect
 echo 'A signed tag message' >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
diff --git a/t/t7004/pubring.gpg b/t/t7004/pubring.gpg
deleted file mode 100644
index 83855fa4e1c6c37afe550c17afa1e7971042ded5..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1164
zcmV;71ateD0ipy(XUi!O1OT%L_{gO;4KKDfwF;#WWYZ2?*>Ph_j9y>uobJf#jXEbw
zQUOEXs+@;X*)1kyN*7VwW}f-GD3>Vlu2F6j{T^Kt%(kMo(W3C}W^X)NL|0VdGIzc`
z5@TY!;Du~AFGW=#0vYgS@U2j8Q{Qe9F~lQEBVt+(yjM1jQ{YLe0lxsC<HX~BiFSU3
zs3oq~QtxsAzbwuV1N{{&PcudMk6}p><?O}^6vikhMm+>LD}W25r?wdKr$(|R8_;Mn
z&Yh%2Hbu9IX>#(R8S&@jVI!K^K7AI$=A+*-qJ>-J^fdR_m5GZao*%P{nee=O$Eb$s
zes#O%4Z_4OAZW}8Ey8%%w->rA>z!nf)&NPikkr&pkRlB>=W+x68fwevWl9Ys2R3m2
zNPf<ig>x1y^AXyemu>Q}DAp%==Q`5sCrBzLaH^rOm1NLtt-ig*IfY?HMdv66@%u%#
zy0K62;Z+4O3Ol6i*<7GlXeW6FC?0yV!c_#yGozNjrOE#8+Rw@Z8cGAG=eE%uMUW=V
zX(76db;AG@lD)hAv?4<wPasWcbaZ8MAUtDlZEb0EbY*ftWq4t2aBO8RV{dIfh+YH}
z5dr`n1p-EA%P9gI0|pBT2nPcK0~G=T0~P`S0v-VZ7k~f?2@n&u^&ZXMLk)Bt0G~<e
ziCMX)QRqT4mEiivJ-X>{Mxg+pzucC_!d-8(MV+3G?_=VDC^nQ}umS)BxdIIYMrX@T
z5C{Oyxp_ZR>*yfS@@M%BVY6{X4EXUYpbiBs(uw7knRB|b)>)=o+wQ%-v34o&a|fQ;
z&R=xVK8Z-jS8R4m_gj2C$xPq$xv1H553!y9ip8A~vxoyq&fFbw!L$zU@hDh#f$r>>
zAYPcTf%K%xv5<+JivV@Da!&`-v8eIo5ApKIdiK7E`krA1X!I73&)t#yo}GERUSnBN
zlK-+<I<**0!u}jvbPz5b{hhe8_PVcR!i8ObFp-W0bqNWKA+W14zV9Mj$a~(KZ-0uf
z|BVvaf!K}k92MNalP4hQ^Yxqk-*SzY6q{6Cw*+Fr_+LZp=BFzuo3pVX*T?Ic-|hbZ
z1PurPv|=$EKX~Bz_Bz;JW71^>8;AnsY?5ub{hajO)@PHTt`On@Z;}jyeue<@oS$3l
zEu9m5O={<O&85HqUN|R$bZiPXX4YsWsPOn@@M)Lf;hyI_(eM$*#Sf3}T=1jzGvsiy
ziKuCmV^)`UC@8ma=jBiHqr!1L4>w`5P=-vvIiJTGj0-lRpc+EU9(`B#rn1m1WqmXr
z5Z+N|DR*y*k<4fY0I_eP7qVo9Fx58WMwaK^N~I=>1VN29R|Umg^2q$WGlE#9AFC2_
zOYG5M$}OL?FQ)ej0!KGwY-hAFz#wAPr>3&{`s7!HUZ22Y7KY{9ly1wQ8^hqBojPv8
zh)Dz(5dr`S1p-EA%T59t3;+rV5EHib9?jlE4Z-XHpqd%~B34SUmtRi+{;vv2ei?p%
eLjau^#pu5ba=n|GS94<zkje^zT1YFf0ssTLm?$>@

diff --git a/t/t7004/random_seed b/t/t7004/random_seed
deleted file mode 100644
index 8fed1339ed0a744e5663f4a5e6b6ac9bae3d8524..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 600
zcmV-e0;m1=h9nBV>1C6QsKJEiEJaD@Q3F8s5u<$E+<2(By)JAZSxviTsXg(wKC+O%
zzvV{Z>W3*k?r7~pgmmkbw8-x{Am!eeN)z?cwIHcT2jqgiA(SXo<iO=E?cY80`p#w8
z)O-&?SnwsJ=1VJ-?26&*g88Nr8E=g2onRW^(c+2nJlX)?dmK)tPO0EY-!B!vMCv1)
z-AOW(3WuF+7IdSxMnzrDgnMqVU=|+YFxlY|VeR+Fg<%C@0Xupi0<S7QYJyFTR$}FQ
zzoSAbU>CoCKWKX;!3@L_U=aFUm!M<>ILG}$`bfnadAkLQbI-upV7Qwf^OE&N45Pz<
zk~^KlzNC6)d@QGv=K5-At&A8FS&MQSR`LB}@R1?A3K1p(vM>7CK}EfFhmBJd&cH^-
z(3Ih^`VuoVBB|w~p!Q^#DY%V2A2FhXu<Bp*L)lSCUdqRyI5wxMG&E1sL$)E$Zo&pJ
zgy#;fENqHImgN>LL2!7DhfZ}&;BSAyz=T0#S?2+NET5St@16L?YI?5Io%<uD|2}hl
zx0xsuefz1+bM^-ZIgtKs=)&VAI8(MfytvM>t>%~nsXUb~*EkptHiN?W{=DRu_s;2u
ziHh{2&>;CQO7;>{$DN33_Ef}g+;b<2hIF^p(Y>^riLBb*Y2Xw>F8)jp49&oLKJOic
z+V{Lt!_`eKGhyk5Edie{-^#n!TFlsfux*QBRZEh^4SVePPmb{BvF|>sKd2cYg@vKp
mVI8jcB1(k(tlt^Kr<{EMs>|b*d70nyVMQcc%xEnE(#Uq3d^-35

diff --git a/t/t7004/secring.gpg b/t/t7004/secring.gpg
deleted file mode 100644
index d831cd9eb3eee613d3c0e1a71093ae01ea7347e3..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1237
zcmV;`1S<QL0lNf7XUi!O1OT%L_{gO;4KKDfwF;#WWYZ2?*>Ph_j9y>uobJf#jXEbw
zQUOEXs+@;X*)1kyN*7VwW}f-GD3>Vlu2F6j{T^Kt%(kMo(W3C}W^X)NL|0VdGIzc`
z5@TY!;Du~AFGW=#0vYgS@U2j8Q{Qe9F~lQEBVt+(yjM1jQ{YLe0lxsC<HX~BiFSU3
zs3oq~QtxsAzbwuV1N{{&PcudMk6}p><?O}^6vikhMm+>LD}W25r?wdKr$(|R8_;Mn
z&Yh%2Hbu9IX>#(R8S&@jVI!K^K7AI$=A+*-qJ>-J^fdR_m5GZao*%P{nee=O$Eb$s
zes#O%4Z_4OAZW}8Ey8%%w->rA>z!nf)&NPikkr&pkRlB>=W+x68fwevWl9Ys2R3m2
zNPf<ig>x1y^AXyemu>Q}DAp%==Q`5sCrBzLaH^rOm1NLtt-ig*IfY?HMdv66@%u%#
zy0K62;Z+4O3Ol6i*<7GlXeW6FC?0yV!c_#yGozNjrOE#8+Rw@Z8cGAG=eE%uMUW=V
zX(76db;AG@lD)hA005tK#LT31ryNoF9o-(`X`Xl5w88@mle8j3AWtAoX>@dDav(fo
zZ*6U9baZ8MKxKGgZE$R5E@N+PK8Rif6A=Oc9t8qMXUi!98v_Ol2?z%R0s|ES0|OQU
z0RkQY0vCV)3JDMsw)Gy(-a`#^9RQ%c+5fOQwB&AM#DD9)s1L@!pm9S0pF>@|C2*qL
z%1j5#NZ6^U*PB>^d9VTi0G$Fo1V(4eP7nwH&bfI%Q|ss;(eh{c3}LfzMGW}yE1(Vq
zEz*hQmYH+9vesFqTifovzOi;G@N);A+0I{d(LRYt$5(82OZQuRJjqPo^tq_na}Tkd
z|BA((5wnN`O3vIJaly0>?(ryCcY*Hgm>^!5uz~cX%CV4%oQnW;wsKDg)3K=W<qz@l
z$a?m^i29yk259sakI&ta{GOe8x?W>hQIh|%Svs{CO~U>hTXYaE9sQlSv-Y~LWWt4A
ze=w1b1$7Atj3KbAF~092T*!Ogn{R)Lum6n_*@4)N@EjG~z>_B+>GSoQ{oitpmlT^+
zUAF{c!T4W8?B=H{DVwvgAlJw1n&0jJ00a#P0JLH;8$Wp9`Sv>4USrZ_1sjM0<!q8|
zxc!{;-PUK5pso<&0dJBFgMNkp@|>Sr>@A%Wd`)WSc+I820A4sJf^=*OHfGjnC8+TD
zW$<a2;o+X=JkjtG#>Eeh?p*Mr_A}&gvx%r_lw($xcPJ>gap&bv^P|FXJr6fwvQUOh
zz&W4C8jK4zqM#Z=%N~7K_NKDXEM<K(9uVG9XDN4YijmA{1^}^dq8GAcg)r4N<3^U}
z-b$q=iUdK8Hdh73UGm8MyfcDWr5~#ja!c&dVahF^v@fRj3IazrWNc@&F~A^V)u*Pi
z`ugNogkGP(V-|+x+mvq0pc}*Bpq)By!2khN4M6SOU21NKpXW5P=UU_LoDzvrTdR;4
zU)W&&o9V6>MQOk{A%?1(Ozs{Qqlifa7!d*h2?YX1XUk3k8w>yn2@n&u^&ZXMLk+>~
z0HDxvfGrJTMY@$ys#k#t?D63Zq=W#R3eUeT(L61`VGHe?zP;`rnta#-umS)8nA%Rq

diff --git a/t/t7004/trustdb.gpg b/t/t7004/trustdb.gpg
deleted file mode 100644
index abace962b8bf84be688a6f27e4ebd0ee7052f210..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1280
zcmZQfFGy!*W@Ke#U|?`dKkWykumMIcY@%4iM%7^n6rj+M4;MLzzlOX&pwTnxkD-}P
zc^HbXN0fL!SIq1?>env3?W^3`d(OOU5YNaX{KU(k^<0;M@87ONv)_6ZxD={-=<kYO
M2Ud3=2BC}r0AuhNr2qf`

-- 
1.7.7.498.g3f2e50
