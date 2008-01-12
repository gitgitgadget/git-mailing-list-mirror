From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 18:43:04 -0600
Message-ID: <47880D18.8030405@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil>	<4787F1F5.2010905@nrlssc.navy.mil> <7vve5z2abv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUTQ-00077L-PN
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762683AbYALAnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 19:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762686AbYALAnL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:43:11 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44845 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762677AbYALAnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:43:09 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0C0h4mo023791;
	Fri, 11 Jan 2008 18:43:04 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jan 2008 18:43:04 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vve5z2abv.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Jan 2008 00:43:04.0543 (UTC) FILETIME=[1783F6F0:01C854B4]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--21.328100-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3MzEtNzAxNDU1LTcwNjI0OS03?=
	=?us-ascii?B?MDU0NTAtMTEzMjg5LTcwNzkwOS03MDA0NzYtNzAwNjkzLTEzOTUw?=
	=?us-ascii?B?NC03MDAyNjQtNzAwOTcxLTcwMjM1OC03MDA3NTgtMTIxNjI0LTcw?=
	=?us-ascii?B?MDgzOS03MDg1NTgtMzAwMTUzLTcwMjc2Mi03MDI1OTgtNzA0NDI1?=
	=?us-ascii?B?LTcxMTEwOS0xMDYzNzAtNzAxMzA1LTcwMTIzMi03MDIxMTgtNzA0?=
	=?us-ascii?B?MjU3LTcwNzQ1MS03MDQ4NTItNzA2NDU0LTcwMTYwNC0xNDgwMzkt?=
	=?us-ascii?B?MTAwMDMtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70239>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>=20
>> It's reproduceable for me by amending the commit.
>=20
> Reliably reproducible?  Can you build with "-O0 -g" and run
> "commit --amend" under gdb?
>=20

make NO_CURL=3D1 CFLAGS=3D'-O0 -g'
Done.

I also moved xmmap into commit.c, and turned the inlined definition
in git-compat-util.h into a declaration.


I set a breakpoint on xmmap(). This is the backtrace on the last entry
into xmmap() before it die()'ed.

The fstat message at the end is from a call to fstat that I added to
print out the file size (to compare with mmap length). As you can
see the fstat also fails with the 'Bad file descriptor' message.


#0  xmmap (start=3D0x0, length=3D996168, prot=3D1, flags=3D2, fd=3D6, o=
ffset=3D0)
    at commit.c:680
#1  0x080acf30 in use_pack (p=3D0x8150650, w_cursor=3D0xffffc0ac, offse=
t=3D94828,=20
    left=3D0xffffc06c) at sha1_file.c:748
#2  0x080ae169 in unpack_object_header (p=3D0x8150650, w_curs=3D0xffffc=
0ac,=20
    curpos=3D0xffffc0a0, sizep=3D0xffffc1d0) at sha1_file.c:1333
#3  0x080ae8bb in unpack_entry (p=3D0x8150650, obj_offset=3D94828,=20
    type=3D0xffffc1dc, sizep=3D0xffffc1d0) at sha1_file.c:1595
#4  0x080ae55d in cache_or_unpack_entry (p=3D0x8150650, base_offset=3D9=
4828,=20
    base_size=3D0xffffc1d0, type=3D0xffffc1dc, keep_cache=3D1) at sha1_=
file.c:1490
#5  0x080af057 in read_packed_sha1 (
    sha1=3D0xffffc1b0 "=EF=BF=BD=EF=BF=BD\034\f~\023\203=EF=BF=BD=EF=BF=
=BDE=3D=EF=BF=BD$n~=EF=BF=BD=EF=BF=BDX=EF=BF=BD=EF=BF=BD@=EF=BF=BD220",=
=20
    type=3D0xffffc1dc, size=3D0xffffc1d0) at sha1_file.c:1815
#6  0x080af2cf in read_sha1_file (
    sha1=3D0xffffc1b0 "=EF=BF=BD=EF=BF=BD\034\f~\023\203=EF=BF=BD=EF=BF=
=BDE=3D=EF=BF=BD$n~=EF=BF=BD=EF=BF=BDX=EF=BF=BD=EF=BF=BD@=EF=BF=BD220",=
=20
    type=3D0xffffc1dc, size=3D0xffffc1d0) at sha1_file.c:1881
#7  0x080af3a0 in read_object_with_reference (
    sha1=3D0x853cf18 "=EF=BF=BD=EF=BF=BD\034\f~\023\203=EF=BF=BD=EF=BF=BD=
E=3D=EF=BF=BD$n~=EF=BF=BD=EF=BF=BD40000 libapsrs",=20
    required_type_name=3D0x80f8488 "tree", size=3D0xffffc20c,=20
    actual_sha1_return=3D0x0) at sha1_file.c:1910
#8  0x080cd2d0 in diff_tree_sha1 (
    old=3D0x853cf18 "=EF=BF=BD=EF=BF=BD\034\f~\023\203=EF=BF=BD=EF=BF=BD=
E=3D=EF=BF=BD$n~=EF=BF=BD=EF=BF=BD40000 libapsrs",=20
    new=3D0x853d108 "=EF=BF=BD=EF=BF=BD\036\034_=EF=BF=BD006=EF=BF=BD\f=
\025\236{=EF=BF=BD220StM0=EF=BF=BD40000 libapsrs",=20
    base=3D0x8534098 "aps/src/libapsnav/", opt=3D0xffffc694) at tree-di=
ff.c:376
#9  0x080cc9cb in compare_tree_entry (t1=3D0xffffc330, t2=3D0xffffc310,=
=20
    base=3D0x815a260 "aps/src/", baselen=3D8, opt=3D0xffffc694) at tree=
-diff.c:61
#10 0x080ccf93 in diff_tree (t1=3D0xffffc330, t2=3D0xffffc310,=20
    base=3D0x815a260 "aps/src/", opt=3D0xffffc694) at tree-diff.c:278
#11 0x080cd371 in diff_tree_sha1 (
    old=3D0x853cbe0 "N|\021xH/K<R=EF=BF=BD\025=EF=BF=BD=EF=BF=BD\2250=EF=
=BF=BD00644 stamp-h.in",=20
    new=3D0x853cdb0 "\0027w=EF=BF=BD=EF=BF=BD=EF=BF=BD}=EF=BF=BD=EF=BF=BD=
=C6=B3\213\036=C2=B1|100644 stamp-h.in",=20
    base=3D0x815a260 "aps/src/", opt=3D0xffffc694) at tree-diff.c:384
---Type <return> to continue, or q <return> to quit---
#12 0x080cc9cb in compare_tree_entry (t1=3D0xffffc430, t2=3D0xffffc410,=
=20
    base=3D0x817d3b8 "aps/", baselen=3D4, opt=3D0xffffc694) at tree-dif=
f.c:61
#13 0x080ccf93 in diff_tree (t1=3D0xffffc430, t2=3D0xffffc410,=20
    base=3D0x817d3b8 "aps/", opt=3D0xffffc694) at tree-diff.c:278
#14 0x080cd371 in diff_tree_sha1 (
    old=3D0x853c580 "\037\215=EF=BF=BD=EF=BF=BD\217\200=EF=BF=BDE=EF=BF=
=BDb=EF=BF=BD=EF=BF=BD232=EF=BF=BD03640000 avhrr",=20
    new=3D0x853c848 "g\230\032a \207V=EF=BF=BDs~=EF=BF=BD=EF=BF=BDr\177=
=EF=BF=BD23540000 avhrr",=20
    base=3D0x817d3b8 "aps/", opt=3D0xffffc694) at tree-diff.c:384
#15 0x080cc9cb in compare_tree_entry (t1=3D0xffffc530, t2=3D0xffffc510,=
=20
    base=3D0x80faba8 "", baselen=3D0, opt=3D0xffffc694) at tree-diff.c:=
61
#16 0x080ccf93 in diff_tree (t1=3D0xffffc530, t2=3D0xffffc510, base=3D0=
x80faba8 "",=20
    opt=3D0xffffc694) at tree-diff.c:278
#17 0x080cd371 in diff_tree_sha1 (
    old=3D0x813c3dc "\231=EF=BF=BD2274M=EF=BF=BD\236=EF=BF=BD\t?=EF=BF=BD=
\225\t=EF=BF=BD=EF=BF=BD",=20
    new=3D0x813c43c "*!=EF=BF=BD\200\006=EF=BF=BD\235=EF=BF=BD?t=EF=BF=BD=
=EF=BF=BD:DR", base=3D0x80faba8 "",=20
    opt=3D0xffffc694) at tree-diff.c:384
#18 0x080d11d0 in log_tree_diff (opt=3D0xffffc610, commit=3D0x813c438,=20
    log=3D0xffffc5c0) at log-tree.c:378
#19 0x080d125a in log_tree_commit (opt=3D0xffffc610, commit=3D0x813c438=
)
    at log-tree.c:402
#20 0x0805d26b in print_summary (prefix=3D0x0,=20
    sha1=3D0xffffd7e0 "*!=EF=BF=BD\200\006=EF=BF=BD\235=EF=BF=BD?t=EF=BF=
=BD=EF=BF=BD:DR") at builtin-commit.c:709
#21 0x0805dae7 in cmd_commit (argc=3D0, argv=3D0xffffd9e8, prefix=3D0x0=
)
    at builtin-commit.c:898
#22 0x0804b44b in run_command (p=3D0x80fd468, argc=3D3, argv=3D0xffffd9=
e8)
    at git.c:257
#23 0x0804b5f9 in handle_internal_command (argc=3D3, argv=3D0xffffd9e8)
    at git.c:383
#24 0x0804b75c in main (argc=3D3, argv=3D0xffffd9e8) at git.c:447
(gdb) c
Continuing.
fstat failed: Bad file descriptor
fatal: Out of memory? mmap failed: Bad file descriptor
Created commit=20
Program exited with code 0200.
(gdb)
