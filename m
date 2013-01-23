From: Armin <netzverweigerer@gmail.com>
Subject: segmentation fault (nullpointer) with git log --submodule -p
Date: Wed, 23 Jan 2013 15:38:16 +0100
Message-ID: <20130123143816.GA579@krypton.darkbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: netzverweigerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 15:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty1TR-00062E-0D
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 15:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3AWOiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 09:38:23 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:50701 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab3AWOiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 09:38:22 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so4167760eei.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=WLUAGA2/ls23PAQDKImtHxTjXfp5+zRHqlVHSs/I0+I=;
        b=tIiM9/JdOFttpsQAsS/EQLr0NljnBoMfRZMriD8P8VB1L2AVnQM6Yc24MfRIuFgylY
         psMYSVT8ZMp++egoCaVLLnTkf8yQknunvY7136DiQCVA/DXg4/naPIGNSt5nC/TYIpdg
         lZehjEZ2Japakw745WVVnTA9wp4Lc+MSkmyrK70BwyhZVL8ypM1+AlnHGA0N0hU5mn8b
         ljuOu4WUXVKoAHJbWFu2bH11hMZ8PcKRcOcAgRF+pHCaThEjp/q6JU0R2lTGw1mVf3FN
         PyTDPDu3X4zhPZUR8+LMZ4Uo8N+g/yT0Jh7NgQO4Y9+7p/EtBm1luOKkd8qHqbc0vSly
         ihhQ==
X-Received: by 10.14.225.133 with SMTP id z5mr4692030eep.15.1358951900652;
        Wed, 23 Jan 2013 06:38:20 -0800 (PST)
Received: from krypton.darkbyte.org (krypton.darkbyte.org. [80.69.43.50])
        by mx.google.com with ESMTPS id l3sm31044176een.14.2013.01.23.06.38.18
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 06:38:19 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214322>

Hello dear git people.

I experience a reproducible segmentation fault on one of my repositorie=
s when doing a "git log --submodule -p", tested with newest version on =
Arch Linux (git version 1.8.1.1) and built fresh (git version 1.8.1.1.3=
47.g9591fcc), tried on 2 seperate systems:


Program terminated with signal 11, Segmentation fault.
#0  0x00000000004b51e5 in parse_commit_header (context=3D0x7ffff69b6980=
) at pretty.c:752
752     for (i =3D 0; msg[i]; i++) {
    (gdb) bt
#0  0x00000000004b51e5 in parse_commit_header (context=3D0x7ffff69b6980=
) at pretty.c:752
#1  format_commit_one (context=3D<optimized out>, placeholder=3D0x526b1=
e "s", sb=3D0x7ffff69b6ad0) at pretty.c:1157
#2  format_commit_item (sb=3D0x7ffff69b6ad0, placeholder=3D0x526b1e "s"=
, context=3D<optimized out>) at pretty.c:1224
#3  0x00000000004dacd9 in strbuf_expand (sb=3Dsb@entry=3D0x7ffff69b6ad0=
, format=3D0x526b1e "s", format@entry=3D0x526b18 "  %m %s", fn=3Dfn@ent=
ry=3D0x4b4730 <format_commit_item>, context=3Dcontext@entry=3D0x7ffff69=
b6980)
    at strbuf.c:247
#4  0x00000000004b5816 in format_commit_message (commit=3Dcommit@entry=3D=
0x1ffafd8, format=3Dformat@entry=3D0x526b18 "  %m %s", sb=3Dsb@entry=3D=
0x7ffff69b6ad0, pretty_ctx=3Dpretty_ctx@entry=3D0x7ffff69b6af0) at pret=
ty.c:1284
#5  0x00000000004dde52 in print_submodule_summary (reset=3D0x754640 "\0=
33[m", add=3D0x754708 "\033[32m", del=3D0x7546e0 "\033[31m", f=3D0x7f06=
85bac7a0, rev=3D0x7ffff69b6b40) at submodule.c:236
#6  show_submodule_summary (f=3D0x7f0685bac7a0, path=3D<optimized out>,=
 one=3Done@entry=3D0x1ff2af0 "\020\\vC\371\070\vJ\352\344\205\340\226u\=
273\021\372\330\234\004",=20
    two=3Dtwo@entry=3D0x2030a60 "\301a(\350\371\372\340mb[=D5=ADo_\272\=
301\223V=CB=99", dirty_submodule=3D<optimized out>, meta=3Dmeta@entry=3D=
0x754690 "\033[1m", del=3Ddel@entry=3D0x7546e0 "\033[31m", add=3D0x7547=
08 "\033[32m",=20
        reset=3Dreset@entry=3D0x754640 "\033[m") at submodule.c:307
#7  0x000000000048dd1d in builtin_diff (name_a=3Dname_a@entry=3D0x1ff2b=
50 "Packages/Application/Amadeus.Somea.Dialog", name_b=3Dname_b@entry=3D=
0x1ff2b50 "Packages/Application/Amadeus.Somea.Dialog",=20
    one=3Done@entry=3D0x1ff2af0, two=3Dtwo@entry=3D0x2030a60, xfrm_msg=3D=
0x2039a20 "\033[1mindex 105c764..c16128e 160000\033[m\n", must_show_hea=
der=3Dmust_show_header@entry=3D0, o=3Do@entry=3D0x7ffff69b7b88,=20
        complete_rewrite=3Dcomplete_rewrite@entry=3D0) at diff.c:2267
#8  0x000000000048e60e in run_diff_cmd (pgm=3Dpgm@entry=3D0x0, name=3D0=
x1ff2b50 "Packages/Application/Amadeus.Somea.Dialog", other=3D<optimize=
d out>,=20
    attr_path=3Dattr_path@entry=3D0x1ff2b50 "Packages/Application/Amade=
us.Somea.Dialog", one=3Done@entry=3D0x1ff2af0, two=3Dtwo@entry=3D0x2030=
a60, msg=3Dmsg@entry=3D0x7ffff69b74b0, o=3Do@entry=3D0x7ffff69b7b88, p=3D=
p@entry=3D0x20371b0)
    at diff.c:3057

(gdb) bt
#0  0x00000000004b51e5 in parse_commit_header (context=3D0x7ffff69b6980=
) at pretty.c:752
#1  format_commit_one (context=3D<optimized out>, placeholder=3D0x526b1=
e "s", sb=3D0x7ffff69b6ad0) at pretty.c:1157
#2  format_commit_item (sb=3D0x7ffff69b6ad0, placeholder=3D0x526b1e "s"=
, context=3D<optimized out>) at pretty.c:1224
#3  0x00000000004dacd9 in strbuf_expand (sb=3Dsb@entry=3D0x7ffff69b6ad0=
, format=3D0x526b1e "s", format@entry=3D0x526b18 "  %m %s", fn=3Dfn@ent=
ry=3D0x4b4730 <format_commit_item>, context=3Dcontext@entry=3D0x7ffff69=
b6980)
    at strbuf.c:247
#4  0x00000000004b5816 in format_commit_message (commit=3Dcommit@entry=3D=
0x1ffafd8, format=3Dformat@entry=3D0x526b18 "  %m %s", sb=3Dsb@entry=3D=
0x7ffff69b6ad0, pretty_ctx=3Dpretty_ctx@entry=3D0x7ffff69b6af0) at pret=
ty.c:1284
#5  0x00000000004dde52 in print_submodule_summary (reset=3D0x754640 "\0=
33[m", add=3D0x754708 "\033[32m", del=3D0x7546e0 "\033[31m", f=3D0x7f06=
85bac7a0, rev=3D0x7ffff69b6b40) at submodule.c:236
#6  show_submodule_summary (f=3D0x7f0685bac7a0, path=3D<optimized out>,=
 one=3Done@entry=3D0x1ff2af0 "\020\\vC\371\070\vJ\352\344\205\340\226u\=
273\021\372\330\234\004",=20
    two=3Dtwo@entry=3D0x2030a60 "\301a(\350\371\372\340mb[=D5=ADo_\272\=
301\223V=CB=99", dirty_submodule=3D<optimized out>, meta=3Dmeta@entry=3D=
0x754690 "\033[1m", del=3Ddel@entry=3D0x7546e0 "\033[31m", add=3D0x7547=
08 "\033[32m",=20
    reset=3Dreset@entry=3D0x754640 "\033[m") at submodule.c:307
#7  0x000000000048dd1d in builtin_diff (name_a=3Dname_a@entry=3D0x1ff2b=
50 "Packages/Application/Amadeus.Somea.Dialog", name_b=3Dname_b@entry=3D=
0x1ff2b50 "Packages/Application/Amadeus.Somea.Dialog",=20
    one=3Done@entry=3D0x1ff2af0, two=3Dtwo@entry=3D0x2030a60, xfrm_msg=3D=
0x2039a20 "\033[1mindex 105c764..c16128e 160000\033[m\n", must_show_hea=
der=3Dmust_show_header@entry=3D0, o=3Do@entry=3D0x7ffff69b7b88,=20
    complete_rewrite=3Dcomplete_rewrite@entry=3D0) at diff.c:2267
#8  0x000000000048e60e in run_diff_cmd (pgm=3Dpgm@entry=3D0x0, name=3D0=
x1ff2b50 "Packages/Application/Amadeus.Somea.Dialog", other=3D<optimize=
d out>,=20
    attr_path=3Dattr_path@entry=3D0x1ff2b50 "Packages/Application/Amade=
us.Somea.Dialog", one=3Done@entry=3D0x1ff2af0, two=3Dtwo@entry=3D0x2030=
a60, msg=3Dmsg@entry=3D0x7ffff69b74b0, o=3Do@entry=3D0x7ffff69b7b88, p=3D=
p@entry=3D0x20371b0)
    at diff.c:3057
#9  0x000000000048eb3d in run_diff (o=3D0x7ffff69b7b88, p=3D0x20371b0) =
at diff.c:3145
#10 diff_flush_patch (o=3D0x7ffff69b7b88, p=3D0x20371b0) at diff.c:3979
#11 diff_flush_patch (p=3D0x20371b0, o=3D0x7ffff69b7b88) at diff.c:3970
#12 0x000000000048f15f in diff_flush (options=3Doptions@entry=3D0x7ffff=
69b7b88) at diff.c:4500
#13 0x00000000004a211a in log_tree_diff_flush (opt=3Dopt@entry=3D0x7fff=
f69b7850) at log-tree.c:776
#14 0x00000000004a22b2 in log_tree_diff (log=3D0x7ffff69b7720, commit=3D=
0x1ffdf60, opt=3D0x7ffff69b7850) at log-tree.c:836
#15 log_tree_commit (opt=3Dopt@entry=3D0x7ffff69b7850, commit=3Dcommit@=
entry=3D0x1ffdf60) at log-tree.c:859
#16 0x00000000004393d3 in cmd_log_walk (rev=3Drev@entry=3D0x7ffff69b785=
0) at builtin/log.c:310
#17 0x0000000000439f38 in cmd_log (argc=3D3, argv=3D0x7ffff69b80c0, pre=
fix=3D0x0) at builtin/log.c:582
#18 0x0000000000405978 in run_builtin (argv=3D0x7ffff69b80c0, argc=3D3,=
 p=3D0x74fd20) at git.c:281
#19 handle_internal_command (argc=3D3, argv=3D0x7ffff69b80c0) at git.c:=
442
#20 0x0000000000404de2 in run_argv (argv=3D0x7ffff69b7f50, argcp=3D0x7f=
fff69b7f5c) at git.c:488
#21 main (argc=3D3, argv=3D0x7ffff69b80c0) at git.c:563
(gdb) f 0
#0  0x00000000004b51e5 in parse_commit_header (context=3D0x7ffff69b6980=
) at pretty.c:752
752     for (i =3D 0; msg[i]; i++) {
(gdb) l
747 static void parse_commit_header(struct format_commit_context *conte=
xt)
748 {
749     const char *msg =3D context->message;
750     int i;
751=20
752     for (i =3D 0; msg[i]; i++) {
753         int eol;
754         for (eol =3D i; msg[eol] && msg[eol] !=3D '\n'; eol++)
755             ; /* do nothing */
756=20
(gdb) p msg
$7 =3D <optimized out>
(gdb) p context->message
$8 =3D 0x0
(gdb) x/8i $pc
=3D> 0x4b51e5 <format_commit_item+2741>:  movzbl (%rcx),%eax
   0x4b51e8 <format_commit_item+2744>:  mov    %rcx,0x18(%rsp)
   0x4b51ed <format_commit_item+2749>:  mov    %rcx,%r10
   0x4b51f0 <format_commit_item+2752>:  test   %al,%al
   0x4b51f2 <format_commit_item+2754>:  je     0x4b52a3 <format_commit_=
item+2931>
   0x4b51f8 <format_commit_item+2760>:  nopl   0x0(%rax,%rax,1)
   0x4b5200 <format_commit_item+2768>:  test   %al,%al
   0x4b5202 <format_commit_item+2770>:  je     0x4b529e <format_commit_=
item+2926>
(gdb) i r rcx
rcx            0x0  0


Does this help in any way? Can i provide any further information that h=
elps?

Many thanks for reading this and all the best,


Armin
