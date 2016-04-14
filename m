From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: git status core dump with bad sector!
Date: Thu, 14 Apr 2016 10:59:57 -0400
Organization: http://www.giref.ulaval.ca
Message-ID: <570FB06D.5060308@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 17:09:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqitc-00008Z-Kw
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 17:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbcDNPJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2016 11:09:24 -0400
Received: from interne.giref.ulaval.ca ([132.203.7.102]:33788 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbcDNPJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 11:09:23 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Apr 2016 11:09:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 00180280639
	for <git@vger.kernel.org>; Thu, 14 Apr 2016 11:00:12 -0400 (EDT)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NItewjw2Ft5S for <git@vger.kernel.org>;
	Thu, 14 Apr 2016 10:59:57 -0400 (EDT)
Received: from [132.203.7.36] (lorien.giref.ulaval.ca [132.203.7.36])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id AF5442809DE
	for <git@vger.kernel.org>; Thu, 14 Apr 2016 10:59:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291525>

Hi,

just cloned a repo and it checked-out wihtout any error (with git 2.2.0=
)=20
but got come corrupted files (because I got some sdd failures).

Then, I get a git core dump when trying to "git status" into the repo=20
which have a "bad sector" on sdd drive (crypted partition).

I tried with git 2.2.0 AND git version 2.8.1.185.gdc0db2c.dirty (just=20
modified the Makefile to remove STRIP part)

In both cases, I have a  Bus error (core dumped)

Tried to make it more verbose:

GIT_TRACE=3D2 GIT_CURL_VERBOSE=3D2 GIT_TRACE_PERFORMANCE=3D2=20
GIT_TRACE_PACK_ACCESS=3D2 GIT_TRACE_PACKET=3D2 GIT_TRACE_PACKFILE=3D2=20
GIT_TRACE_SETUP=3D2 GIT_TRACE_SHALLOW=3D2 /opt/gitgit/bin/git status
10:54:30.644999 trace.c:318             setup: git_dir: .git
10:54:30.645094 trace.c:319             setup: git_common_dir: .git
10:54:30.645102 trace.c:320             setup: worktree:=20
/pmi/cmpbib/compilation_BIB_gcc-4.5.1_64bit/TestValidation_avec_erreur_=
disque_git_core_dump_dans_dev_Test.ExportationVTK_Avion
10:54:30.645112 trace.c:321             setup: cwd:=20
/pmi/cmpbib/compilation_BIB_gcc-4.5.1_64bit/TestValidation_avec_erreur_=
disque_git_core_dump_dans_dev_Test.ExportationVTK_Avion
10:54:30.645151 trace.c:322             setup: prefix:=20
Ressources/dev/Test.ExportationVTK/
10:54:30.645181 git.c:350               trace: built-in: git 'status'
Bus error (core dumped)

started in gdb:

Program received signal SIGBUS, Bus error.
0x00007ffff7866d58 in ?? () from /lib64/libcrypto.so.1.0.0
(gdb) bt
#0  0x00007ffff7866d58 in ?? () from /lib64/libcrypto.so.1.0.0
#1  0x3334d90d8c20f3f0 in ?? ()
#2  0xe59b5a6cd844a601 in ?? ()
#3  0xc587a53f67985ae7 in ?? ()
#4  0x3ce81893e5541777 in ?? ()
#5  0xdeb18349a4b042ea in ?? ()
#6  0x8254de489067ec4b in ?? ()
#7  0x6fbef2439704c81b in ?? ()
#8  0xe0eee2bb385a96da in ?? ()
#9  0x00007ffff6e19ab3 in ?? ()
#10 0x00007fffffffc4d0 in ?? ()
#11 0x000000000000001d in ?? ()
#12 0x00007ffff7863f80 in SHA1_Update () from /lib64/libcrypto.so.1.0.0
#13 0x00000000005102c0 in write_sha1_file_prepare=20
(buf=3Dbuf@entry=3D0x7ffff6c81000, len=3D1673936, type=3D<optimized out=
>,=20
sha1=3Dsha1@entry=3D0x7fffffffc750 "\340_~", hdr=3Dhdr@entry=3D0x7fffff=
ffc570=20
"blob 1673936",
     hdrlen=3Dhdrlen@entry=3D0x7fffffffc56c) at sha1_file.c:2951
#14 0x000000000051567b in hash_sha1_file (buf=3Dbuf@entry=3D0x7ffff6c81=
000,=20
len=3D<optimized out>, type=3D<optimized out>,=20
sha1=3Dsha1@entry=3D0x7fffffffc750 "\340_~") at sha1_file.c:3010
#15 0x00000000005159f8 in index_mem (sha1=3Dsha1@entry=3D0x7fffffffc750=
=20
"\340_~", buf=3Dbuf@entry=3D0x7ffff6c81000, size=3D1673936,=20
type=3Dtype@entry=3DOBJ_BLOB,
     path=3Dpath@entry=3D0x80a818=20
"Ressources/dev/Test.ExportationVTK/Ressources.Avion/Avion.Quadratique.=
cont.vtu.etalon",=20
flags=3Dflags@entry=3D0) at sha1_file.c:3305
#16 0x00000000005160ee in index_core (flags=3D0, path=3D0x80a818=20
"Ressources/dev/Test.ExportationVTK/Ressources.Avion/Avion.Quadratique.=
cont.vtu.etalon",=20
type=3DOBJ_BLOB, size=3D<optimized out>, fd=3D7,
     sha1=3D0x7fffffffc750 "\340_~") at sha1_file.c:3367
#17 index_fd (sha1=3Dsha1@entry=3D0x7fffffffc750 "\340_~", fd=3D7,=20
st=3Dst@entry=3D0x7fffffffc7c0, type=3Dtype@entry=3DOBJ_BLOB,
     path=3Dpath@entry=3D0x80a818=20
"Ressources/dev/Test.ExportationVTK/Ressources.Avion/Avion.Quadratique.=
cont.vtu.etalon",=20
flags=3Dflags@entry=3D0) at sha1_file.c:3410
#18 0x00000000004eac66 in ce_compare_data (st=3D0x7fffffffc7c0,=20
ce=3D0x80a7c0) at read-cache.c:166
#19 ce_modified_check_fs (ce=3D0x80a7c0, st=3D0x7fffffffc7c0) at=20
read-cache.c:215
#20 0x00000000004ebb6d in ie_modified (istate=3Distate@entry=3D0x7e5fe0=
=20
<the_index>, ce=3Dce@entry=3D0x80a7c0, st=3Dst@entry=3D0x7fffffffc7c0,=20
options=3Doptions@entry=3D16) at read-cache.c:395
#21 0x00000000004ebcfe in refresh_cache_ent=20
(istate=3Distate@entry=3D0x7e5fe0 <the_index>, ce=3Dce@entry=3D0x80a7c0=
,=20
options=3Doptions@entry=3D16, err=3Derr@entry=3D0x7fffffffc908,
     changed_ret=3Dchanged_ret@entry=3D0x7fffffffc90c) at read-cache.c:=
1130
#22 0x00000000004ed59c in refresh_index (istate=3D0x7e5fe0 <the_index>,=
=20
flags=3Dflags@entry=3D6, pathspec=3Dpathspec@entry=3D0x7bb738 <s.25876+=
24>,=20
seen=3Dseen@entry=3D0x0, header_msg=3Dheader_msg@entry=3D0x0)
     at read-cache.c:1221
#23 0x0000000000429e3b in cmd_status (argc=3D<optimized out>,=20
argv=3D0x7fffffffcca0, prefix=3D0x7e950f=20
"Ressources/dev/Test.ExportationVTK/") at builtin/commit.c:1376
#24 0x00000000004063b3 in run_builtin (argv=3D0x7fffffffcca0, argc=3D1,=
=20
p=3D0x7b4030 <commands+2352>) at git.c:352
#25 handle_builtin (argc=3D1, argv=3D0x7fffffffcca0) at git.c:539
#26 0x00000000004054a1 in run_argv (argv=3D0x7fffffffca80,=20
argcp=3D0x7fffffffca6c) at git.c:593
#27 main (argc=3D1, av=3D<optimized out>) at git.c:698

Ii would have expected git to first gave me an error when checking out=20
the files!!! Here is the log:

Checking out files:  99% (28645/28934)
Checking out files: 100% (28934/28934)
Checking out files: 100% (28934/28934), done.
Already on 'master'
Your branch is up-to-date with 'origin/master'.
     On valide le d=C3=A9p=C3=B4t TestValidation avec la r=C3=A9f=C3=A9=
rence:=20
9b4a485202b2b52922377842c15bfd605d240667
HEAD is now at 9b4a485 BUG: On sp=C3=A9cifie bash comme shell...

But at least 1 file is corrupted!

I keep preciously this faulty repo to further investigation with someon=
e=20
who can help dig into the coredump and correct it...

I am available to recompile a new git to help...

Thanks,

Eric
