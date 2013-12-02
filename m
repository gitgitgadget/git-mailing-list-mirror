From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: git-blame segfault
Date: Mon, 2 Dec 2013 13:57:48 +0100
Message-ID: <20131202125748.GA275@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 02 14:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnTB3-0000gt-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 14:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093Ab3LBNEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 08:04:36 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:52967 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab3LBNEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 08:04:33 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2013 08:04:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:subject:message-id:mime-version:content-type; s=
	beta; bh=oLv8o9K6LDwFyUJBpMp/Ur/hC3v8CxnDi8kEuzxJ6qY=; b=uBRkPOU
	TV6RQiCPfkJVb4upxRefHhvUvS3V/zdTnocu4nxgSmwvyv0uiQ4CQuEEozB6dX59
	9wfVqTQDfThnVEVufLiZPY9e3AvEpVsqdTlSZfbij5dnV5Tj5D33eOIr4bseQWGs
	eBxdq24MK7imxCZCXHej3QemHsAeYFliToPw=
Received: (qmail 3534 invoked from network); 2 Dec 2013 13:57:49 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 2 Dec 2013 13:57:49 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238629>

When git is compiled with current gcc and "-march=native" 
git-blame segfaults:

For example:

 % gdb --args /var/tmp/git/git-blame gcc/tree-object-size.c
...
Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x000000000051240d in xdl_emit_hunk_hdr (s1=s1@entry=30, c1=<optimized out>, s2=s2@entry=30, c2=c2@entry=6, func=func@entry=0x7fffffffd2d8 "", funclen=0, 
    ecb=ecb@entry=0x7fffffffd580) at xdiff/xutils.c:460
#2  0x0000000000512af7 in xdl_emit_diff (xe=0x7fffffffd390, xscr=<optimized out>, ecb=0x7fffffffd580, xecfg=0x7fffffffd590) at xdiff/xemit.c:237
#3  0x0000000000510a5d in xdl_diff (mf1=mf1@entry=0x7fffffffd510, mf2=mf2@entry=0x7fffffffd520, xpp=xpp@entry=0x7fffffffd570, xecfg=xecfg@entry=0x7fffffffd590, 
    ecb=ecb@entry=0x7fffffffd580) at xdiff/xdiffi.c:601
#4  0x000000000050b005 in xdi_diff (mf1=<optimized out>, mf2=<optimized out>, xpp=xpp@entry=0x7fffffffd570, xecfg=xecfg@entry=0x7fffffffd590, xecb=xecb@entry=0x7fffffffd580)
    at xdiff-interface.c:136
#5  0x00000000004104df in diff_hunks (file_a=<optimized out>, file_b=<optimized out>, ctxlen=ctxlen@entry=0, hunk_func=hunk_func@entry=0x411320 <blame_chunk_cb>, 
    cb_data=cb_data@entry=0x7fffffffd830) at builtin/blame.c:105
#6  0x0000000000412b54 in pass_blame_to_parent (parent=0x11da810, target=0x11dab50, sb=0x7fffffffd6e0) at builtin/blame.c:815
#7  pass_blame (opt=0, origin=0x11dab50, sb=0x7fffffffd6e0) at builtin/blame.c:1281
#8  assign_blame (opt=<optimized out>, sb=0x7fffffffd6e0) at builtin/blame.c:1559
#9  cmd_blame (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/blame.c:2523
#10 0x00000000004060b5 in run_builtin (argv=0x7fffffffe528, argc=2, p=0x578bd8 <commands.22612+120>) at git.c:314
#11 handle_internal_command (argc=2, argv=0x7fffffffe528) at git.c:478
#12 0x0000000000405772 in main (argc=2, av=<optimized out>) at git.c:575
(gdb) up
#1  0x000000000051240d in xdl_emit_hunk_hdr (s1=s1@entry=30, c1=<optimized out>, s2=s2@entry=30, c2=c2@entry=6, func=func@entry=0x7fffffffd2d8 "", funclen=0, 
    ecb=ecb@entry=0x7fffffffd580) at xdiff/xutils.c:460
460             if (ecb->outf(ecb->priv, &mb, 1) < 0)
(gdb) l
455             }
456             buf[nb++] = '\n';
457
458             mb.ptr = buf;
459             mb.size = nb;
460             if (ecb->outf(ecb->priv, &mb, 1) < 0)
461                     return -1;
462
463             return 0;
464     }
(gdb) p *ecb
$1 = {
  priv = 0x7fffffffd830, 
  outf = 0x0
}

If I leave xecfg uninitialized in the following function the issue goes
away.

>From builtin/blame.c:
  94 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
  95                       xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
  96 {
  97         xpparam_t xpp = {0};
  98         xdemitconf_t xecfg = {0};
  99         xdemitcb_t ecb = {NULL};
 100
 101         xpp.flags = xdl_opts;
 102         xecfg.ctxlen = ctxlen;
 103         xecfg.hunk_func = hunk_func;
 104         ecb.priv = cb_data;
 105         return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
 106 }
 107

I'm not sure if this a git bug or a gcc bug. In any case I've opened a
gcc bug-report here: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59363


-- 
Markus
