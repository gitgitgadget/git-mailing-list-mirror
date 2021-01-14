Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9379EC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F58623A50
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbhANSV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:21:26 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33185 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbhANSVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 13:21:24 -0500
X-Originating-IP: 103.82.80.201
Received: from localhost (unknown [103.82.80.201])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E4A24C0007;
        Thu, 14 Jan 2021 18:20:32 +0000 (UTC)
Date:   Thu, 14 Jan 2021 23:50:30 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Kirill Gavrilov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kirill Gavrilov <kirill@sview.ru>
Subject: Re: [PATCH] git-gui: fix blurry icon on macos taskbar
Message-ID: <20210114182030.rnbvypttrknshclh@yadavpratyush.com>
References: <pull.941.git.git.1609937443534.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.941.git.git.1609937443534.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kirill,

Thanks for the patch.

On 06/01/21 12:50PM, Kirill Gavrilov via GitGitGadget wrote:
> From: Kirill Gavrilov <kirill@sview.ru>
> 
> Update git-gui.ico and git-gui.icns with bitmaps of higher resolution.
> Call "wm iconphoto" with images created from PNG bitmaps on macOS.
> 
> Signed-off-by: Kirill Gavrilov <kirill@sview.ru>
> ---
>     git-gui: Fix blurry icon on macOS taskbar
>     
>     git-gui: fix blurry icon on macos taskbar
>     
>     Update git-gui.ico and git-gui.icns with bitmaps of higher resolution.
>     Call "wm iconphoto" with images created from PNG bitmaps on macOS.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-941%2Fgkv311%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-941/gkv311/master-v1
> Pull-Request: https://github.com/git/git/pull/941
> 
>  git-gui/Makefile            |   5 +++
>  git-gui/git-gui.sh          |   6 +++
>  git-gui/lib/git-gui-128.png | Bin 0 -> 1671 bytes
>  git-gui/lib/git-gui-16.png  | Bin 0 -> 360 bytes
>  git-gui/lib/git-gui-256.png | Bin 0 -> 3438 bytes
>  git-gui/lib/git-gui-32.png  | Bin 0 -> 564 bytes
>  git-gui/lib/git-gui.ico     | Bin 3638 -> 146106 bytes
>  git-gui/lib/git-gui.svg     |  79 ++++++++++++++++++++++++++++++++++++
>  git-gui/macosx/git-gui.icns | Bin 28866 -> 53863 bytes
>  9 files changed, 90 insertions(+)
>  create mode 100644 git-gui/lib/git-gui-128.png
>  create mode 100644 git-gui/lib/git-gui-16.png
>  create mode 100644 git-gui/lib/git-gui-256.png
>  create mode 100644 git-gui/lib/git-gui-32.png
>  create mode 100644 git-gui/lib/git-gui.svg
> 
> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index 56c85a85c1e..3dcda42e0ee 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -24,6 +24,11 @@ ALL_LIBFILES = $(wildcard lib/*.tcl)
>  PRELOAD_FILES = lib/class.tcl
>  NONTCL_LIBFILES = \
>  	lib/git-gui.ico \
> +	lib/git-gui.svg \

I see that you are adding the svg but don't see it being used anywhere 
in the code. What is it used for?

> +	lib/git-gui-16.png \
> +	lib/git-gui-32.png \
> +	lib/git-gui-128.png \
> +	lib/git-gui-256.png \
>  	$(wildcard lib/win32_*.js) \
>  #end NONTCL_LIBFILES
>  
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 201524c34ed..1d933dbf5d3 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -740,6 +740,12 @@ if {[is_Windows]} {
>  	if {![info exists env(DISPLAY)]} {
>  		set env(DISPLAY) :9999
>  	}
> +} elseif {[is_MacOSX]} {
> +	image create photo gitlogo16  -format png -file "$oguilib/git-gui-16.png"
> +	image create photo gitlogo32  -format png -file "$oguilib/git-gui-32.png"
> +	image create photo gitlogo128 -format png -file "$oguilib/git-gui-128.png"
> +	image create photo gitlogo256 -format png -file "$oguilib/git-gui-256.png"
> +	wm iconphoto . -default gitlogo256 gitlogo128 gitlogo32 gitlogo16

Quoting the "wm" manpage:

  wm iconphoto window ?-default? image1 ?image2 ...?
    [...]
  
    On Macintosh, the first image called is loaded into an OSX-native icon 
    format, and becomes the application icon in dialogs, the Dock, and other 
    contexts. At the script level the command  will accept only the first 
    image passed in the parameters as support for multiple sizes/resolutions 
    on macOS is outside Tk's scope. Developers should use the largest icon 
    they can support (preferably 512 pixels) to ensure smooth rendering on 
    the Mac.

So gitlogo{128,32,16} are not needed for MacOS.

But since you've already went through the effort of preparing these 
images, how about making all these available on Windows and Linux as 
well? Will these platforms also benefit from these logos?


>  } else {
>  	catch {
>  		image create photo gitlogo -width 16 -height 16
> diff --git a/git-gui/lib/git-gui-128.png b/git-gui/lib/git-gui-128.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..a17ecfa1f3ed2214d11af1b964b86a935c70fb79
> GIT binary patch
> literal 1671
> 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
> GxPJgly4)E6
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/git-gui/lib/git-gui-16.png b/git-gui/lib/git-gui-16.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..1bdbfb8ee70d07f7afbc1499fccc4b6d1fbc4884
> GIT binary patch
> literal 360
> zcmV-u0hj)XP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003mNkl<ZILl*T
> zzyloi`&<Cx6%6D8pypTh2YmJtt-*PZpEyv{BN(>d=kpgx|A6xk_*^7lqpt{1(NP!%
> z@_zyG2L#_|8*ROS4uG1sI_~qGM6`z6<|=$QEcLo^;p-N94R{T>X{j%L!$S8z9{d)s
> z0sk2om~NZv$$;<%FBjbn&bC^ULjpWucw$I^GeK|U=H{}erKN35Pfy<r#6dvze<b{d
> zpaDQd6+rwmH8nLKW&n^~2c+Kt=~QA2I1j|LL2M)!$N_ON$OWOHq0EE~xDCXeP&R93
> zW~N|6Ljx1gusD!m+1c5`gbY{##1BEX!o(626Gegivq1b3$YsQ90MMIiAg2QH51_5b
> zf%H)z{sOWc$j=}uK_w+6NdXP&1!_10)OZbu*8tgAqYwZMBf)p&{?^$50000<MNUMn
> GLSTZ`wUsyk
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/git-gui/lib/git-gui-256.png b/git-gui/lib/git-gui-256.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..059d832af118ab57910590321789926819822995
> GIT binary patch
> literal 3438
> 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
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/git-gui/lib/git-gui-32.png b/git-gui/lib/git-gui-32.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..93ec72f02a97c210ddcb3bcd8e77166e8046f2f5
> GIT binary patch
> literal 564
> zcmV-40?Yl0P)<h;3K|Lk000e1NJLTq001BW001Be1^@s6b9#F80005|Nkl<ZSi@sr
> zAQL$3_gQX#z~>|gJM8z4XP`H*Kj3{8=!pLy?6}XnYSaNVvBd76w<a)-k7C0>i@(7f
> z0OUW!p=LQn4shD*V+ON?Onhr-JHYOszpUdvpDt_|X!si>iw<E^1B`~!(OfWm9RQ5u
> zGN8qM5bWbj6HE3xII!HY(i0;WU$xX0qR0U^E%nWASm^#IAM4y2bpS;UxTvScea&3Y
> zf?RylOk1DY>5?%uHPs4;)j*uIv^2-`^z<}5IGk!WgDeGFcnXOB0}alAI$#lqj|bnP
> zisdOODT+YDUcwBfy90n09zr%4hXW1*@hc>L1GRi_i)83?pyj@Wg@v409AJ}>kRSl0
> zcS8ApGcq#FD0TqQpe~ptz;qCZCWqnxsDs6U>`%~;+Ch!r-wd_jAI#_Y8~_#H1Qq+8
> zo14o=X$TyI8ukrc4j9B@nVFeNAPfwC4kSJEU=9PS(V^4<tB?#6BT~;{m>!VhD9!(M
> zNU6Vuh(v1vN`O#3zkpG|PLTsZK0q??H#7?};;`HasOAMyy4XaOtOzuyAFY773&hia
> zxD*&d`9Qi8R!Sn_KfoxnriueV!3eZy1A$Tx8UF*~0;<+Rp`oG7Ktqdx_yeKh7gSi$
> ztSuND8_Nw0jcA}nGl6(FkbMN2@7qCX0OU|o%mV<CG{LDU?_eeX0000<MNUMnLSTYQ
> C<nvGf
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/git-gui/lib/git-gui.ico b/git-gui/lib/git-gui.ico
> index 334cfa5a1a59c320e86789ccf4ed3320584a0215..3d89dd570b072924d0dd89d62b453b0e106c21e4 100644
> GIT binary patch
> literal 146106
> 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
> 
> literal 3638
> zcmeH~ziSjh6vyA`iH8I(0ZDa`m_kiGRjLaq(go67oo?_yNF(H`v<gCCx)dr}*yJy`
> zO2G`4Nn=2`A`k>G*c^D|`FXRq?%pQGAH+tom$y6b`)1zz?CjmnM5HD+WPV=K@v0$m
> zpVstr=0Cb6@&WB3?mV`P)dYc~TThn@PF;e?-EMZ_OjCNjp7cKUWbpo_)a!L=G#WBB
> zH6=4MGcr3nE3H;b78Vv{adA;PosO)nt;x#DiYzTHN%yhJ`nt+9IS~CE<?X>2IXFI+
> zr?1~o$YCA}Sj=39=Fl9PGflHD9^IpRbdT=QZCF4L=m9672XrnH(Ia|9j|dT6@fBZV
> zs_ZyB>N^rS202kl<vBSR91IQy2SY-F!NK5Qa4<L+5+)1|1_y(K!NHKwVQ?@w7#s`^
> z2B&CnI5?bfsHPb};cB0NMGW0;85U1*Pa#iI4@;T`f}Vzl#lw=O1r85~hr`3+;Yd>j
> zhljz#;9;<-^Kf_=JPeUq$~jFTb+QkBnqHe7sHh$2m8P270j5CFK!E^Lpmrb_ND`<W
> zsGS~1s*O(lK>a{{dqjcyfw>7V1Q-JIV2_PiNq3LJm9srY<{(lp!WQ9()Ju=nIGBS7
> zM>Gy@EIn=pMOY#%5r{~^^c8?5GBDC9B1BmD!^p!kiLgYQkHli%273x<FenTPgTkON
> zC=BWA1Ve;DVNe(%45Y#64}-#>FenV9#?WC<7!(EtK&c-|rVLa%d2)Ds4~M4Q*2l{|
> zc_AAc8?w2%DcjrIva_=z`}_N{x3?#Uhlg@>bR_+LUrtU=<n;7ZhQpx@zNtLl-Q{=O
> zWp?d1U>EWw&+?k9a;G@%7Dpi#ts+XRkn`3=_<V;-xY{9wCsXB~T_?il+)SwU|5HCh
> zqSCltb^LF~$G2J@U);brn3XAYG2Pss#Vv4Yyp-#2nyZzgnxhh4z3O<Dk5!~o&0O~X
> zUEDI4k8)LOmt)qx>Ufs#qRiz=S0C3;H&uHz)oywvY@Ia+?a|z@J<31LR(q68+GkB^
> ztJxDQKhj%e{5rArh)~&n5x0GcZC&QEe4nyh!@2P2vPU7nJ1t!})4blNuqLrYVb}YV
> z>wOA)iT`z<k}ZxuUWoZxITnf)G83`|)0WiSr-4)P$HVAjfs}KcuzJbYz+A8T=+%W`
> t!ne1#9r^goEBwpG59dS%O_BaP5&n&m{sZi`$XCqvauzc?+sdr!e+Q6k)cF7a
> 
> diff --git a/git-gui/lib/git-gui.svg b/git-gui/lib/git-gui.svg
> new file mode 100644
> index 00000000000..81f26f7eeb4
> --- /dev/null
> +++ b/git-gui/lib/git-gui.svg
> @@ -0,0 +1,79 @@
> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
> +<svg
> +   xmlns:dc="http://purl.org/dc/elements/1.1/"
> +   xmlns:cc="http://creativecommons.org/ns#"
> +   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> +   xmlns:svg="http://www.w3.org/2000/svg"
> +   xmlns="http://www.w3.org/2000/svg"
> +   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
> +   width="128"
> +   height="128"
> +   viewBox="0 0 33.866666 33.866668"
> +   version="1.1"
> +   id="svg8"
> +   inkscape:version="1.0 (4035a4fb49, 2020-05-01)"
> +   sodipodi:docname="git-gui.svg"
> +   inkscape:export-filename="git.png"
> +   inkscape:export-xdpi="48.000004"
> +   inkscape:export-ydpi="48.000004">
> +  <defs
> +     id="defs2" />
> +  <sodipodi:namedview
> +     id="base"
> +     pagecolor="#ffffff"
> +     bordercolor="#666666"
> +     borderopacity="1.0"
> +     inkscape:pageopacity="0.0"
> +     inkscape:pageshadow="2"
> +     inkscape:zoom="1.979899"
> +     inkscape:cx="140.38309"
> +     inkscape:cy="25.399948"
> +     inkscape:document-units="mm"
> +     inkscape:current-layer="layer1"
> +     inkscape:document-rotation="0"
> +     showgrid="false"
> +     inkscape:window-width="1920"
> +     inkscape:window-height="976"
> +     inkscape:window-x="-8"
> +     inkscape:window-y="181"
> +     inkscape:window-maximized="1"
> +     units="px" />
> +  <metadata
> +     id="metadata5">
> +    <rdf:RDF>
> +      <cc:Work
> +         rdf:about="">
> +        <dc:format>image/svg+xml</dc:format>
> +        <dc:type
> +           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
> +        <dc:title />
> +      </cc:Work>
> +    </rdf:RDF>
> +  </metadata>
> +  <g
> +     inkscape:label="Layer 1"
> +     inkscape:groupmode="layer"
> +     id="layer1">
> +    <g
> +       id="g880"
> +       transform="rotate(-90,17.030427,16.773863)">
> +      <path
> +         sodipodi:nodetypes="ccczcccccccczzcc"
> +         id="path864"
> +         d="m 11.525998,13.931424 h 3.641546 c 0,-2.111835 -2.49681,-5.568568 -7.3916727,-5.487377 -5.52876,0.09171 -7.61050601,4.897619 -7.61050601,8.455019 0,3.5574 1.56280201,8.466483 7.37664601,8.466483 1.984375,0 3.4645457,-0.812503 5.1115287,-2.230032 v 1.854184 h 2.514006 V 16.002763 H 8.2482393 v 3.040189 h 3.7454817 c 0,1.414101 -1.1487,3.275809 -3.8676517,3.356734 -2.718952,0.08093 -4.573283,-2.049155 -4.573283,-5.514807 0,-3.465652 1.546961,-5.559333 4.398482,-5.559333 2.9851557,0 3.5747297,1.70831 3.5747297,2.605878 z"
> +         style="fill:#666666;fill-opacity:1;stroke:none;stroke-width:0.264583px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
> +      <rect
> +         y="7.9879885"
> +         x="16.637527"
> +         height="17"
> +         width="3.5"
> +         id="rect866"
> +         style="fill:#d8382d;fill-opacity:1;stroke:none;stroke-width:0.972763" />
> +      <path
> +         d="m 25.826632,7.9879911 v 6.7499759 h -4.24987 v 3.500046 h 4.24987 v 6.749976 h 3.500046 v -6.749976 h 4.24987 v -3.500046 h -4.24987 V 7.9879911 Z"
> +         style="fill:#40bf4c;fill-opacity:1;stroke:none;stroke-width:0.969494"
> +         id="rect868" />
> +    </g>
> +  </g>
> +</svg>
> diff --git a/git-gui/macosx/git-gui.icns b/git-gui/macosx/git-gui.icns
> index 77d88a77a7669667335cf6fd5767c8b40f3ce6e7..74a67301305c7ecf564ac6b508cba226bd2fbc8d 100644
> GIT binary patch
> literal 53863
> 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%0Aaa
> zy*Lw^aYBhja?5k3h5r#&p1FtnQlr-DNKarU(P#OW;3>Ji`h#ZhJ6k)qe8ia$b61bP
> zzj-6VB?8X_S*%;Hjv^yWP38aI1u4^GTHvd(ddS``0A8N0l@^}$T1$JPl=0vS&i!*m
> zK-U~6l9Kv3uPd6`BfRXzX%DzpUT2)ldfYN9Aw2BuO}@vrl@cAG!k#foFec~j6r34!
> zgd%c+bh-M59+(C@#jhepN3v_c*Sb!I6At~~pB=Ni8L|!kU+tX<JeAMC_~&p$vX-bw
> zs6<&3S(8JSY(+vPj>0)4QB=rs4i06_mMB{iA*qOnb0SMh*0N<UOV(sdICqZfyY%h%
> zyZ8V7{a*L~y7xZwa^{)kGc(W3JhMDA^Sn`yVRJUc?XsyJP*PHQVvxfYujswBpiNIt
> zACx;tZoK-@T|RDMAFte*JrOC!DW7gHUSuZZepQJXIiEf4*~a806H_rF`_Lj;a(Hxf
> zQ6<y#ey6n@t5W!|0W~PECoygFE@!UkElT0dG7Suh3*MgkF;%6n;CsXMp$u1g^8%+6
> zHxk%f6NUDOb&A+?A1%=AZiH_eFQ>-*oIWTddN6FDtp(hXoi|Ny4U%!%;Ox>B0M}PT
> z*Lk@%4;o1c)AmEGi}rRsKhM=I<S<tf<(S!TR%9-`V}5?V<dq?@dj1g4&9VE%i!VR4
> zCSME9$jX!HHwkx1&0d(DSy3yacwh4<d>dm@B$W?}+V`B#xUVDFyxN&1?BLS1lB-nD
> z;kWnXK1<B>PL)3KG_UbazT*`nyU=qtSadHXO+L#!&0Re$CDfp2Xy!_M(VbUV9e6}S
> z#5j0JYi(U}YhP~oDpTGx7qjkk{*+)QY?b|osq^u|bD9wKwn-~i;)P1)<vmBPkTuJA
> zW&BKK@=tZsx|KV+*Cet0WB$J{gx%tU-Nu}j=NFIkn{I33w;fk{V1i2)nIlTH%scC_
> z6?$2-kKRp4UZ^$c?9ui#GO8x)Jn6hMJ;;(*GkVvUZl*zufe@1ryoG)AS%{%XkIfFr
> zpe<W;PxwiWVD0Cw$X-@4R&@$E(^J^oD1Q8y3Y)3LwxPPE7xQj+&M6zx^GvQ3Osh>g
> zez5)tHSt3ee~mnRHFtXVWLif*A0MACIX6-G#(-twuAactVsS2p*$j~aE$kS%!I_7D
> zaA?R)p#O7GTiy8G^WE#p-JkaE)jXS+#CONO`+~CI;ZM#fGfQQp2oH`bID4<!a?<A<
> zIu|vU(_d70(=9elgy@vp&B;n`o=Eqv%nSEa<L$tEHBU2y+4mJ$@NC>0elfWY4ueH)
> zDwwjp$2#{Oo8e;ZdABGS*u&v4fz9fgZKk9>raPFIoBLF~IeOvl;~*P56F42pnmPXd
> zEV~MCw=79PeA2*(N%AS3>~W7dm;ENZLm@qBvQ1`FDW)oyrt>GhK1y`r9GIJ658+Ka
> zTQt<%vD>eBc0x((f*(h_)}oAQz*0;(H_xZ%aIc!fvFm!6UM)^V?b4N=Y`|Z8szgp(
> z;2d#$sE+Cu7`}=sG@gFFv`_!2)U^MjBPQ9$zYt~w@JhNtE*zKj1^9Ya4lK6LRlb!D
> zuPl3$AAa%b^u!eRLo6FvYUgoK!H7bi<E~4l?#P{`F5bM6`UFkeCB<xORw`e)M);|&
> z)H|bb`6GMj*ceLgeO}7s>(|iP4JQxjsB<5KmKW}nD;I0dx$Zi@YEnx;i>P&;r-CJ~
> zGMUO}Xml!&P9U{2+bX-q9e5rs))w>|=!F~X#A@{XG<E16jT?~l5O-b42DY=POXP|t
> z!!JK-6^b}ngz&uVg{ST(Iwz<vtWLf^tb~%F%ZlHv8$pm@erm?U;D4$5AUzs|*5NVW
> zT-;qeh&LQ^-o;3#1n0Syc=jb@dX#e4lIO8k&GtDW+(d#L5gW2mX=c~fayM^BWwQVe
> z5%7_aFfTNH?gpx3{e;Qr3lA0A?I)p$+gzkZyWn88<=t#8BQcP{b+u)=pNv5^B{jxE
> zQT38^{@~vJ#+MGhUpV%wTi%eESJE0-9N)hM+mJ<sJ5{F$uY@$YkH7^o+G}*P{Yb~=
> zgU{fuHHMCULuW-r;(0+wnAN8mcK5fSitnC@#JS${XVi%czrwj6u0mC3H$^U$#O*J<
> zeRLlb+i>zxdN{+>hsPFHubZ64tBfX0(G6U6Ll4+L22!(S9&H;w1@}h}n_Zs?TFs<E
> z=)`(w3-`NV3{UDs5hyA{Qshks1P&g`iUd5Uw<{CML&bK&O{Xgmm)O<RVx*PeLl)}B
> zVgeTL*C$ZPbG1<{!=e;Ug8RouBj)JR-Kh4*4y(p@lh4P5FQAArXvNmKwEFt#*Ad%L
> zZ;Kd@EJ@JKzH>g<1>t!`X2*_&HdOUph$W~9bQ=lmc{iY}xN(LvaVXsQG~DC8d{65#
> zUW-^k`|veI#gE8Nm%!j2{Z1+O6V*E*a!Y;zeB3xpy*X-Dp}m$qCwhCsk(!#CnOt_y
> zC+oiCL{FjwI^pfSXSnPV_G~z-He`e_!D*L{lEKE6uF>d{^b_aWR$Gtj3A|gJEKJpn
> z>HHuj*&qeamRTl6GJU#Fx1Emdts}P1iCLIQp5sUw{wtQo8Ks_s8xrfdx+Q>b{Iye6
> zit6(QW@hb2tEp{=S*zMZC>x47hFN5n&dfJj3-O_LwmP7d;rptt%l)ZC+Ikpz)IPfQ
> zyv~w?`Ck^X`=r)n7{QrJ+Qu7dw53r+)q#U5na9Hp3S!U6NKP;o*N=No9@_MIaZnhQ
> zopGTtdT8rI_#t5B)KdblF*>;3xG7DW;3Hf7hN4r^0Y@jtIy*57cbnA8)t4hBU!fHh
> zNL;j0Dh|%Lb~Kk6RmJetFzrd*w=~`)NZpMS60WnRwO2jUuLllm(J#q+&QBc_eMv9#
> z^wq`3)_C>qfWm63$Hqx&a=7bCX(?1F*z&eV^mb+n3O{6vDZoq&a!qcn97N07-6uO&
> zM~UjfcWK6ypilzGk25ey`OKkj%ow`vzb~!p-=!T9cmP8hsA(HcykEQ&kg^I&x)R~>
> zlU10xG)Yv4glpDJMPZb&s~6aW&e%GUB)c^Jw8x*fG&AdqfF(RILQ$9Fv`(elj_yoS
> zvwYCjBlJv1D%M+zC_Z0Fo}QWUI(+}(SnF9dc{4{5d;=I!R`+<aa?r5U>M&ZYF5y_(
> zhWP7dWinB>F!K4-qs0&Bi{V$v-a4Fwo1?HTw2bfDC1QvnQ99$cK0WCg>i>2%9zXe<
> zq14TbbyM9ck1_q5K2sr3aNRhjR1&*9+nb)9#inwr3GRHnaP7J@C(&%W?rvsY57kcS
> zOT-;#Sg!*c_1s(O${g1(T+&xCrN78x9hoZ2z`NAsz9-y66s#VyZFt39SH!^fhQG6D
> z_Xj1JiHPLWyK0T5M4y~t-PGK7soCv7)Vl^ac<;|2f8oJJgddiV)i*YNW{V&23=@vs
> zRc*b{nnp3wvCs3*>G7_@2U?RTSU8p(S;MhT14F{J&y2Q9z8SoD%5_L2@)Ld&U5`%*
> zuZuDDl=&NKZdg<m9kCR?$dWwQ1yQ8w6qR?Hr!kh6`#3gJhESV^H3}T5!W|n5^(2R%
> zywTFJCSpE8;c_#nt#qvL1N_9>TE!L;fw3Dx1D@X`Jf7W`KQ#3^4lXg)io-sTZ*ssF
> z69MJ5FDPjb2qwj_ZA@d;E@~^(D@%6E)#f!`Q*coHVy5fYSJlxwHl?>6vRwyT1{d&G
> z3^M5Bs^jg7gNGKV+eeR<=yR4BmRX$Dj5~g~=i{Q&WwKeooOkT;nJvM;eQ714kyKn<
> z?ACBwJMC1;XZMX8T_5!;--`MY`&fvGdeW85T?iMuKHHeTnym~xW`#rFg!L#tZrPBT
> ziAg!I=H_j+?(>1Y9<1B!ZL{swm$>=aM!UB6nSF&bHS(!988u6Xwru|G@R^1s4{^OT
> zPOm9p=t<#?ZaO%{$y~|SZX>j0u-|h3=J95yBH1~Wx)oFthlx$%GW2~M7)uw}CD%Kw
> z^Til5^uski4H9Mji8>#PyMphGDV#n7Z>YDhWo`@YHZEV`0*6B(!LjUf$`@7?dOJJ?
> zm98G<##v=3um?hr_~WueI$U-u>0f%%gD>z;60IzM-quvcJYw;|BgQK`@|n5&>aOwW
> zOD)3#zJSh{Hq_E>*B81PgArkNNxzhF2CHP^z<;livC^*3HP=h!h;JU1+_SLYyTR)|
> zpVz&_S$I~kE3Hvz)>)-QW=_Ds3T2NK*xi5PEYow*B)N5=&7G4$d4kG^%LIEaYHaYQ
> zml?_I!LSzDrI&9TNe$TdIgFJ(Y|mGtv&tDgsvBEfCn|UyJ=DBu_Yw{#*6IzMend<s
> z-SR0ChxW&daJOu>Az?;+Ept(T>dRJht<|NqE8<PrHA=6;Db6N`oP4{%`T~^x?5oJh
> zsjo)!W(758ite;$%p^2~Utxu#(LoFE#cAHe_?X0RCxMrb1OHMpFeOq~%=qYMdGQS0
> zgWp#E0UjwO1ps}<Uq8qM0#Hm~86N5E?mh)Azxp7Pdn*9kTT$AFwoJfiv}hk>9$8s#
> zqHDXxkSjiBz1<xXo<I#|W``UD294yUq{JqhMF(^B^jy2`T*qAmxj4-W&W3BK&cC=7
> zC=d~Hi<A*`huhGXH>fo?$$-l{b+^v$8hpaQW9dF?IK@^I<l&#Cj=9ZtxUGz=zCCj{
> za#lWagGl^YuN|B>3(Q}e=qPAMm96ipm2cPG)z`4E_ruluH*bf$x+@Qa74?T*@N3%m
> zoC8(c*-Nt{*dOJ9nQ-eJf;d4=50BTU9=$AGZ!mc}s6R5aJ#s{mdDK7TTKt6;)(geG
> zrUD}vi*S{fq*8sQQw{Yqt1R2kcd-;s=)~yzk9o?i<x!QVmr$_pf2@xG*oCiROj8s-
> zbGf&}V=dVyke=f;!K}S%tZ`j}MTxVre=&D?phxNY>!%z|FWAI9z9P%<#l%gJJZ^JJ
> zn``q3rsLye@}2>k!~@q__5{iWg2NswwzFYe8DiHawB3Gab&EUDV^{Oi<%Rca=;U`Q
> z75S_iUR4P}xJ-4uEiEm_<@wllRm{|BN<>|YxSKCgvilJSVK*m<*KkDQbWOKsxAPJ6
> zo1d@lel6U{(V5>G*c1U=E?#U-8D!aIAM{WTBWlNFbF?C*@92WU$t;z<&6-+Tq(p(9
> zSu~+BKdDBXi)G&Dz)c8K6UJQF@Cx_n@WkD*g4I{l+1h<a3b%p8+Kbiu>8=KC-n=>N
> zR(*P(OITPKwN7SqPp|ihFC5+-Rp<K>fK#uqa%^)`lU|{Nb&J)57SpPg4XAE)Z*Qte
> zL`T&cAS)$X1<9UcES7uea_g4lt_cMdX1zbBkVZa*vlYdn;xF$nkAKU?&hBkyx>Y+y
> zzaz)@h9kY=T>DAtL9tZ&@nA8R&8Mr*@a?<AwYM+q^Z~=DgJ&LC!yK><eySH)2eRQY
> zH%$S>rQj4-#_SKMg^H3$cxX5?YFIOrx7GL4d(9I?)(^-53+Q2bj7@#NVwGwZPRy4X
> zH2T}SpICR(Ra9C4;(*OxTko0{anbC$jd~hp-Qr@z*;lvXX`qq+@u>b=TOwbm32<D_
> z%$Q#zsFkxIk!+p7m@e_u=OS9_&P&dcq4OMS$#pn#mp8Y@v7R%Owdq%f98H<S>K?f$
> zDsK#{T*Y=b^bYx$(I-Q5=jYw9(fzTd?gD_J_ZKY{1H~}QEj7dLY$vq*r!AGi`}?QU
> zW@fg0#_JMdJH*YT;tp?8_j|iX<nX?7-8|;qq9XTXSHLkeCR=yRlS3m&Qms>6ePxK$
> z`-g}1!z<>5R)}ioaj`PL<;vw6PR(VPBDEa3cc$e$eqpIMs^^tTk+kz`G5rfG*rW%P
> zsEZ2&DtKXD^UTRNdm7{F#YZjjkJ;PcDyLNC_{AfFO`e(+X4@S+Qut<!zg~hq(;cu>
> zT#fVT1x-yZ(yuGlQ_!h*lHzK?h)&OaE&N4CX}!@Qfz@K>mzbw67P?K{I&+l%%sXBw
> z*3qefn#O=)(d}XT<LL)6^Z^zbSrzQ0XlB9THT$nIV`?Oc^1v&?S-kQ2`kZU{<}k-Y
> zMU;6DyQeu4o=sswH||7<yqD2;eDpQ+>j!nwychNN=L#Yu)^1;IEO1qk@$l6ew)|JQ
> zUY2$X!xN`px@>&OCAhAcz~o!BUA=OB&h|T^YMc95F7GVJRLgBr5C{$^zuj7#ounc;
> z$!(-z^t{(=t&qTZ4#m9DY}Uerf;{F6?&%^+d2VA<3Sp|)oTk<L<0>o`!u!OraYBMR
> z4UFO2Y}6}@2zpa*=^SsO>`!ppc%*+}x!T4c^K#)(a|n+$4&&eaFc)hxXVocBHz&_y
> z!_n5>zJ`^RRq4FB<0G-*F34lvYlekDs(n|~)jo1C#9~$Zogcs2dGW~x15GPDen3M0
> z0Gn*7!L2<*TjW^!R&>uQJV>hTCUZn--8SVXzzuAx6DN8&xHfV`n+JKOqLQKlK5KOk
> zCfL^>eJz|i0ME0VnnZr);;>m?*Vx#2I!>5D;N$R4W~@o{YMb>2+oLUf4I3s6<SXlD
> zk|@QDZW<N!ctcC2^?SIsIPA28>y++%nvT;smTa#_GzbNov<i=0)xc|MY6@3YRLof2
> zI8FDAU5L|VqZ-Q?$ETg1TTukxkzi0OE-C34Ag$&6<Xx>QD<41q66YRqTQbvAyVEI-
> zOh?kQT|oMzmF9(=ZM9%LJ}z!MBzXvC&2F{Uh^ZoUk7@QBI^C8S0!_`$jqHhXJ55+9
> zu4h=KZ+}Ss^yyPA=2OUil7O|km@QTjT>l`>uM>8uJK0kHYj_n?heNEMuz0WPd;^N`
> zuzej#<5kH=(>F%J3A~Xn-Yc_=@g6$MRuEeMm}R7T6_CEbpp$xN8#AfYs#ktH+4RAJ
> z{_WJgfhRVf!8%)c?OcoM<}=4?f2pgh8&CR@yE<MubgMx?RDRLxqNcFzw_`wX;b3k*
> zb)fLH><*jjB5PtF7(P#DUvy)e4bo-=fv=sbEpw*0KSTwww0sy*O0auED!EM$%K8;X
> zug5O(@vnd@ehz5tj>@17PX1+!CmT?hytKwP1<f95xOti_R9P2I8cZTtO>tZ<7#(Y9
> zXoxVa7u(UyAH@dHhMYHZ85GB>LbcI7Ufa0euisY8W%0ndyLIT<MZKBZcZI-)&<x+5
> zSHIR+(EIFMrNtH@&3_<gXUY18fn9B#dtz2!YgH0+23I>w=_asSNxt`QeV#O?EIOg;
> zzS>sSm83|QMEdPb6_=1Wqq%bvs)XI4$oaU3|L1KJZ|8thHKi`58q^VO*=mMu#Wq0F
> zrApnPXODaCjk<*d-9RQv851SHJG?N8fslo1>kQ3UVBmk!_aG|y08T8E-nHDT{R+v`
> z<PiPo53cq~L4h4Udq-Iek4KG3W}Hi4(Mx}P&dY1*q>)i0C!gOL|I_Y<hS4@b*S~l=
> zEtyBlX6_2jTe(RmUubjZbNAFz?wLY#Mf2w`3zX;2pLd-gxqi~v0L(<`&dOz6;`W?p
> zf21#K(Z9rA5o%STqL<dVi5(uKcozIVLkHZvHak7t;gjXc@!A1>02^UDdqg!Qc5m2>
> za>?eUEte=nK5VmhOqMVH#a%)&?5zLT!%P1wAn!lT#SoA;0`f*c-v1T4I0EwiZ{&+3
> zAaB+GHYPX%@<u@32*?`&c_Sci1mul?yb+K$0`f*c-U!GW0eK@JZv^CxfV>fqHv;lT
> zK;C~J<SixhuYkP&v{!+Eyb+K$ge4)Qas<Ur!<+qm);t38M%dv9A^qRNfk!~z2wwbu
> zJxlxlYX%XJHv;lTK;8(e{CDC!0`f*c-U!GW0eK@JZv^CxfV>fqHv;lTK;8(*8v%JE
> zAa4ZZjexunkT(MIMnK*O$QuE9BOq@C<c)y55s)_m@<u@32*?`&c_Sci1mul?yb+K$
> z0`f*c-U!GW0eK@JZv^CxfV>fqHv;nhKLql&m8Ri=FGT<!6@W<tJ{X|(kMwvDfB`B*
> z_#<I}Y7_t}(U@QA7=Kk?3`rHJB>dC((g08;s(?K;0KAQA1}!kI)~FWH{Ex5KTB^Yc
> z0v=}vfXx+LECAL79Gx`)S8xD-9RNJ>H(Lzw{mpz0fD_+rmvPsDAC3+Nhmtn7Ha@s(
> zzz2uI<A~6K-ex%la5DPa^^^~E1U3Yi77-T><$QnGt$(r`Lpj^1WnW(aYzfxDiWVWT
> z{^k}00D%_M51Y@j4=q-3DsVY=a0=$xl88guI9!GfwA-R(28FjF0hGCoFSL_zXd4?_
> zD_eh<R1B243L}ICU=s?negjGeLwh_x8QWZj!5oqS3Wq1)=<ztb^;G~XmjcMJTFIdJ
> zAL+1i$$&zHKN1;~z}uljlYgm`{Y!kwq!K`ZmHSWPgOyuCq<}J5x$@C+FeZg)`CsZv
> zQ3^m7sn)+$tw5Kk4-TXOU%j7y@c`&V=>h#H5d9BypyRLaqvx*=bQ69N9#)^ek1nh{
> zi6}834l7P9`q#QtlsJ$;s_$=9pWSI%*Gqpl2+(6xR4}oCUIl|u{qrRPfW5vd1dK22
> zoPz;S3;A8&>#It{_`ps!@>c<40Z|nOCI`O*Z(zXIkd~kH`rx;qH5|~}*Z>>}9|q7i
> zI2<1M<3g7^Rn&JQ>_ecD^xc&Xf0ov*SrTAwLjcra=Sak%fi(;o0$^u@J4<sw!Tt^h
> z9D<<^|4)srot@>fgDuSg*!t6SyI`0y3`JT_jV251pfetJpRjWcg`G5jy&kX)1t<sD
> z(_aO^H~@M_0w!}94E|XgUk0$?$P@}0mKcRhF8T8X=KYy3g+TU&9UqLmIOKQznQsY^
> z>;pS6Sa5$02n((R2F3&{0tFaQAw>QsT_RWx$o@|+ID#I~g$1Uor}xtZW?eT#FBpV=
> z|AB)cda#`SDhNaC>FVk&7nKCq0SieoSR9D`^%??w|7RDMoinYWqO$w|3WEuPno0lw
> z`v`CzMEm){hlQYm#?adEWtu0HP*H^v?S61B1ASXbEq(w^ZEw%XAw+_35}<d$;o;~`
> z0*vrc#>1x>j`H+4_;|y%W$Xu-pb=*WXF2wMu&JQo<OK(1mzxW%iNODdd=iGj;e7zS
> zAu<^zN2b8!o)X}=4Sy7vB$+@#lWA=O-Vm7rB`76OLe5VC$U|QRl01x0PEKbZ@$kR*
> zZuInET6%ggtpg-In36t052X(^cpKlm^r6=lk_7aUB#FbcB_!09i3b11n>a1+U=IMA
> z3G&hZpweEv!2ZGd7vmc$)%`Dye{lHQ{-Wi}YKBVfSvI8oAyS%AmilMa_W$U=F>qOp
> zP^qQMhVws#|8D);_y1oEe<3t<-!D@}bN^Yb{z>Xz&HsNEewF;6mE=$9)2t{(VW5ip
> zrcD3pFI-Kv1-HIe)6ew-fZ!1IpZb@=kjvqpeWX$ee~Dh1N*&N&NsE6E#}n$J?9T#$
> zRH`9#qxl1#Nov8*{*S0jD}VTdht#iZKM6de&d^-Ag@j;}NT5>1e)7+tQn`O~Dx*?`
> zezSZtcu}byKb+(jsq>6KEZ?s}i`1{SaKML3ZIDWR_}%&UOBl?5$F=j0SE`|5LFspo
> z?<U5a??nqQOHP0Bh7%;`iSH6^`oHjoPOHpfi=ICWP^15YxASs8fcnu7)TRHy4;nuf
> z|8D2$?d@Hh>+P-o?!*OK>ik4``QzV3{v=Ox&V%FL55*SrO%c93@P5DD(eHLTK0fj7
> z+S=N`wGhS!j}AeZkslGbesMfR^%{e(pWjsN4RDCc?>zD&KkZil11FsYb<KDG^d5cy
> e*47MtD|P^cN9HQar{GieLv09o^)~BUa{mG6i1<hV
> 
> literal 28866
> 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
> 
> 
> base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
> -- 
> gitgitgadget

-- 
Regards,
Pratyush Yadav
