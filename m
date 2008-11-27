From: Simon Hausmann <simon@lst.de>
Subject: git fsck segmentation fault
Date: Thu, 27 Nov 2008 18:14:06 +0100
Message-ID: <200811271814.06941.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 18:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5kSi-00046A-7B
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 18:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYK0ROJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 12:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYK0ROI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 12:14:08 -0500
Received: from verein.lst.de ([213.95.11.210]:45687 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbYK0ROF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2008 12:14:05 -0500
Received: from rhea.localnet ([62.70.27.104])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mARHDxIF006156
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 27 Nov 2008 18:14:00 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; x86_64; ; )
Content-Disposition: inline
X-Spam-Score: 0.001 () BAYES_50
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101817>

Hi,

when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a medium=
 sized
(930M) repository I get a segfault.

The backtrace indicates an infinite recursion. Here's the output from t=
he last
few lines:

Checking commit ffffb0556074699814751f3b34526b3d6850c6f7
Checking blob ffffb4e9edf03e7f5643abc5603ca57e745c313d
Checking tree ffffde1114cdd0937cb798069b45f4ceadccd22f
Checking tree ffffe7e34be267ca55a6ae823f8bf31d7a8ef3cd
Checking blob ffffe8bbfc4d7adcb4e5fa00f1b4c99e26591b76
Checking tree ffffea81b8790b194ac215807165e3ff7f824320
Checking blob ffffec79ba618a429dee33bb0acb0ab36cb1310d
Checking tree fffff62eaba873e3ea3cfd7535e6ac514fd18332
Checking blob fffff6519569fac30b11b7bc830d61e296b7c5e2
Segmentation fault (core dumped)

gdb on the core file produces the following backtrace:

#0  0x0000000000487684 in unpack_object_header (p=3D0x26ad4c0, w_curs=3D=
0x7fff72f8a060, curpos=3D0x7fff72f8a058, sizep=3D0x7fff72f8a0c8) at sha=
1_file.c:1400
1400            base =3D use_pack(p, w_curs, *curpos, &left);


#0  0x0000000000487684 in unpack_object_header (p=3D0x26ad4c0, w_curs=3D=
0x7fff72f8a060, curpos=3D0x7fff72f8a058, sizep=3D0x7fff72f8a0c8) at sha=
1_file.c:1400
#1  0x000000000048827e in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
508859, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a004) at sha1_file.c:1=
693
#2  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
581247, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a148) at sha1_file.c:1=
647
#3  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
679881, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a1c8) at sha1_file.c:1=
647
#4  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
685453, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a248) at sha1_file.c:1=
647
#5  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
689484, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a2c8) at sha1_file.c:1=
647
#6  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
738466, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a348) at sha1_file.c:1=
647
#7  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
744208, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a3c8) at sha1_file.c:1=
647
#8  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D490=
755670, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a448) at sha1_file.c:1=
647
#9  0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
146004, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a4c8) at sha1_file.c:1=
647
#10 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
148469, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a548) at sha1_file.c:1=
647
#11 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
150324, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a5c8) at sha1_file.c:1=
647
#12 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
150930, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a648) at sha1_file.c:1=
647
#13 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
549282, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a6c8) at sha1_file.c:1=
647
#14 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
552398, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a748) at sha1_file.c:1=
647
#15 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
552652, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a7c8) at sha1_file.c:1=
647
#16 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
553208, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a848) at sha1_file.c:1=
647
#17 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
556704, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a8c8) at sha1_file.c:1=
647
#18 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
560658, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a948) at sha1_file.c:1=
647
#19 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
582507, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8a9c8) at sha1_file.c:1=
647
#20 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
604310, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8aa48) at sha1_file.c:1=
647
#21 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
614312, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8aac8) at sha1_file.c:1=
647
#22 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
666142, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8ab48) at sha1_file.c:1=
647
#23 0x0000000000488352 in unpack_entry (p=3D0x26ad4c0, obj_offset=3D491=
901113, type=3D0x7fff72f8cd14, sizep=3D0x7fff72f8cd08) at sha1_file.c:1=
647
#24 0x00000000004887ca in read_packed_sha1 (sha1=3D0x336ba64 "=EF=BF=BD=
W\004=EF=BF=BD\037d\203g=EF=BF=BD=EF=BF=BD;v\032vF=EF=BF=BD>=EF=BF=BDR=EF=
=BF=BD", type=3D0x7fff72f8cd14, size=3D0x7fff72f8cd08) at sha1_file.c:1=
957
#25 0x00000000004889fe in read_object (sha1=3D0x336ba64 "=EF=BF=BDW\004=
=EF=BF=BD\037d\203g=EF=BF=BD=EF=BF=BD;v\032vF=EF=BF=BD>=EF=BF=BDR=EF=BF=
=BD", type=3D0x7fff72f8cd14, size=3D0x7fff72f8cd08) at sha1_file.c:2047
#26 0x0000000000488bcc in read_sha1_file (sha1=3D0x26ad4c0 "", type=3D0=
x7fff72f8a060, size=3D0x1d3c923b) at sha1_file.c:2063
#27 0x000000000048f3fd in parse_tree (item=3D0x336ba60) at tree.c:224
#28 0x0000000000423a32 in mark_object (obj=3D0x336ba60, type=3D2, data=3D=
<value optimized out>) at builtin-fsck.c:102
#29 0x00000000004673bc in fsck_walk (obj=3D<value optimized out>, walk=3D=
0x423880 <mark_object>, data=3D0x336ba38) at fsck.c:26
#30 0x0000000000423a4a in mark_object (obj=3D0x336ba38, type=3D2, data=3D=
<value optimized out>) at builtin-fsck.c:105
#31 0x00000000004673bc in fsck_walk (obj=3D<value optimized out>, walk=3D=
0x423880 <mark_object>, data=3D0x66fff78) at fsck.c:26
#32 0x0000000000423a4a in mark_object (obj=3D0x66fff78, type=3D2, data=3D=
<value optimized out>) at builtin-fsck.c:105
#33 0x00000000004673bc in fsck_walk (obj=3D<value optimized out>, walk=3D=
0x423880 <mark_object>, data=3D0x66c9a28) at fsck.c:26
#34 0x0000000000423a4a in mark_object (obj=3D0x66c9a28, type=3D2, data=3D=
<value optimized out>) at builtin-fsck.c:105
#35 0x0000000000467299 in fsck_walk (obj=3D0x6bea7b0, walk=3D0x423880 <=
mark_object>, data=3D0x6bea7b0) at fsck.c:50
#36 0x000000000042390d in mark_object (obj=3D0x6bea7b0, type=3D1, data=3D=
<value optimized out>) at builtin-fsck.c:105
#37 0x00000000004672d1 in fsck_walk (obj=3D<value optimized out>, walk=3D=
0x423880 <mark_object>, data=3D0x3283fd0) at fsck.c:57
#38 0x000000000042390d in mark_object (obj=3D0x3283fd0, type=3D1, data=3D=
<value optimized out>) at builtin-fsck.c:105
#39 0x00000000004672d1 in fsck_walk (obj=3D<value optimized out>, walk=3D=
0x423880 <mark_object>, data=3D0x3283f88) at fsck.c:57
#40 0x000000000042390d in mark_object (obj=3D0x3283f88, type=3D1, data=3D=
<value optimized out>) at builtin-fsck.c:105
[...]

The stack trace in total has about ~80000 frames.

Does anyone have any suggestions on how to debug this?

Thanks,
Simon
