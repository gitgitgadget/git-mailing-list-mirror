From: Tim Olsen <tim@brooklynpenguin.com>
Subject: git-merge segfault in 1.6.6 and master
Date: Wed, 20 Jan 2010 11:17:56 -0500
Message-ID: <hj7abm$5vc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 17:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXdGj-0004m4-29
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 17:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab0ATQSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 11:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147Ab0ATQSe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 11:18:34 -0500
Received: from lo.gmane.org ([80.91.229.12]:57259 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab0ATQS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 11:18:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXdGB-0004Wt-Qz
	for git@vger.kernel.org; Wed, 20 Jan 2010 17:18:23 +0100
Received: from nyc01.limewire.com ([38.108.107.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:18:23 +0100
Received: from tim by nyc01.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:18:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nyc01.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137557>

The following happens on 1.6.6 and master as of
5b15950ac414a8a2d4f5eb480712abcc9fe176d2.  The problem goes away if I
use the resolve merge strategy instead.

tolsen@neurofunk:~/git/site-build-dav-sync-05 [git:build-dav-sync-05]$
gdb --args git merge origin/deployed
GNU gdb (GDB) 7.0-debian
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copyi=
ng"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
=46or bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /usr/local/bin/git...done.
(gdb) r
Starting program: /usr/local/bin/git merge origin/deployed
[Thread debugging using libthread_db enabled]

Program received signal SIGSEGV, Segmentation fault.
*__GI_memcmp (s1=3D0x4, s2=3D0x77b034, len=3D20) at memcmp.c:339
339	memcmp.c: No such file or directory.
	in memcmp.c
(gdb) bt full
#0  *__GI_memcmp (s1=3D0x4, s2=3D0x77b034, len=3D20) at memcmp.c:339
        srcp1 =3D <value optimized out>
        srcp2 =3D <value optimized out>
        res =3D <value optimized out>
#1  0x0000000000495c12 in hashcmp (sha1=3D0x4 <Address 0x4 out of bound=
s>,
sha2=3D0x77b034 "\304\037Eg\262\367\256\367\376\061=ED=99=9A\331\037\bQ=
\231\332",
<incomplete sequence \370>) at cache.h:620
No locals.
#2  0x0000000000495ca3 in sha_eq (a=3D0x4 <Address 0x4 out of bounds>,
b=3D0x77b034 "\304\037Eg\262\367\256\367\376\061=ED=99=9A\331\037\bQ\23=
1\332",
<incomplete sequence \370>) at merge-recursive.c:60
No locals.
#3  0x0000000000499523 in merge_trees (o=3D0x7fffffffd5b0, head=3D0x77b=
058,
merge=3D0x77b030, common=3D0x0, result=3D0x7fffffffd548) at merge-recur=
sive.c:1209
        code =3D 8076320
        clean =3D 13064
#4  0x0000000000499a46 in merge_recursive (o=3D0x7fffffffd5b0,
h1=3D0x7932d0, h2=3D0x793240, ca=3D0x7b3c00, result=3D0x7fffffffd628) a=
t
merge-recursive.c:1343
        iter =3D 0x0
        merged_common_ancestors =3D 0x121e360
        mrtree =3D 0x7b3c20
        clean =3D 0
#5  0x000000000043eee6 in try_merge_strategy (strategy=3D0x4f2078
"recursive", common=3D0x787170, head_arg=3D0x4f2570 "HEAD") at
builtin-merge.c:577
        clean =3D 0
        reversed =3D 0x7b3c20
        o =3D {branch1 =3D 0x4f2570 "HEAD", branch2 =3D 0x7fffffffdf33
"origin/deployed", subtree_merge =3D 0, buffer_output =3D 1, verbosity =
=3D 2,
diff_rename_limit =3D -1, merge_rename_limit =3D -1, call_depth =3D 0, =
obuf =3D
{alloc =3D 0, len =3D 0,
            buf =3D 0x775ee8 ""}, current_file_set =3D {items =3D 0x122=
0510,
nr =3D 11526, alloc =3D 11552, strdup_strings =3D 1}, current_directory=
_set =3D
{items =3D 0x1203b80, nr =3D 2957, alloc =3D 2976, strdup_strings =3D 1=
}}
        result =3D 0x303035302d203031
        lock =3D 0x7b3d40
        index_fd =3D 15
        args =3D 0x7fffffffd6a0
        i =3D 0
        ret =3D 2
        j =3D 0x0
        buf =3D {alloc =3D 0, len =3D 0, buf =3D 0x775ee8 ""}
        index_fd =3D 15
        lock =3D 0x7b2900
#6  0x00000000004407d4 in cmd_merge (argc=3D1, argv=3D0x7fffffffda90,
prefix=3D0x0) at builtin-merge.c:1134
        ret =3D 0
        result_tree =3D
"\200\332\377\377\377\177\000\000\000\000\000\000\000\000\000\000\024\0=
00\000"
        buf =3D {alloc =3D 60, len =3D 0, buf =3D 0x7762d0 ""}
        head_arg =3D 0x4f2570 "HEAD"
        flag =3D 1
        head_invalid =3D 0
        i =3D 0
        best_cnt =3D -1
        merge_was_ok =3D 0
        automerge_was_ok =3D 0
        common =3D 0x787170
        best_strategy =3D 0x0
        wt_strategy =3D 0x4f2078 "recursive"
        remotes =3D 0x776838
#7  0x000000000040488f in run_builtin (p=3D0x729b48, argc=3D2,
argv=3D0x7fffffffda90) at git.c:257
        status =3D 1647275105
        help =3D 0
        st =3D {st_dev =3D 0, st_ino =3D 0, st_nlink =3D 7509264, st_mo=
de =3D
4158578380, st_uid =3D 32767, st_gid =3D 1, __pad0 =3D 0, st_rdev =3D 0=
, st_size
=3D 7508768, st_blksize =3D 140737340287064, st_blocks =3D
3403153865682452481, st_atim =3D {tv_sec =3D 0,
            tv_nsec =3D 140737488345392}, st_mtim =3D {tv_sec =3D
140737351990853, tv_nsec =3D 140737488345752}, st_ctim =3D {tv_sec =3D =
134688,
tv_nsec =3D 0}, __unused =3D {5129592, 140737488346931, 0}}
        prefix =3D 0x0
#8  0x0000000000404a1a in handle_internal_command (argc=3D2,
argv=3D0x7fffffffda90) at git.c:401
        p =3D 0x729b48
        cmd =3D 0x7fffffffdf2d "merge"
        i =3D 47
        commands =3D {{cmd =3D 0x4e4871 "add", fn =3D 0x405778 <cmd_add=
>,
option =3D 5}, {cmd =3D 0x4e4875 "stage", fn =3D 0x405778 <cmd_add>, op=
tion =3D
5}, {cmd =3D 0x4e487b "annotate", fn =3D 0x405b84 <cmd_annotate>, optio=
n =3D
1}, {cmd =3D 0x4e4884 "apply",
            fn =3D 0x40da8e <cmd_apply>, option =3D 0}, {cmd =3D 0x4e48=
8a
"archive", fn =3D 0x40e7c6 <cmd_archive>, option =3D 0}, {cmd =3D 0x4e4=
892
"bisect--helper", fn =3D 0x40ea7c <cmd_bisect__helper>, option =3D 5}, =
{cmd
=3D 0x4e48a1 "blame",
            fn =3D 0x413481 <cmd_blame>, option =3D 1}, {cmd =3D 0x4e48=
a7
"branch", fn =3D 0x415393 <cmd_branch>, option =3D 1}, {cmd =3D 0x4e48a=
e
"bundle", fn =3D 0x415bb4 <cmd_bundle>, option =3D 0}, {cmd =3D 0x4e48b=
5
"cat-file", fn =3D 0x416484 <cmd_cat_file>,
            option =3D 1}, {cmd =3D 0x4e48be "checkout", fn =3D 0x4197c=
5
<cmd_checkout>, option =3D 5}, {cmd =3D 0x4e48c7 "checkout-index", fn =3D
0x417514 <cmd_checkout_index>, option =3D 5}, {cmd =3D 0x4e48d6
"check-ref-format",
            fn =3D 0x416cf2 <cmd_check_ref_format>, option =3D 0}, {cmd=
 =3D
0x4e48e7 "check-attr", fn =3D 0x416a73 <cmd_check_attr>, option =3D 1},=
 {cmd
=3D 0x4e48f2 "cherry", fn =3D 0x437b3e <cmd_cherry>, option =3D 1}, {cm=
d =3D
0x4e48f9 "cherry-pick",
            fn =3D 0x456fd1 <cmd_cherry_pick>, option =3D 5}, {cmd =3D
0x4e4905 "clone", fn =3D 0x41b4b5 <cmd_clone>, option =3D 0}, {cmd =3D
0x4e490b "clean", fn =3D 0x41a198 <cmd_clean>, option =3D 5}, {cmd =3D
0x4e4911 "commit", fn =3D 0x41f144 <cmd_commit>,
            option =3D 5}, {cmd =3D 0x4e4918 "commit-tree", fn =3D 0x41=
c4a0
<cmd_commit_tree>, option =3D 1}, {cmd =3D 0x4e4924 "config", fn =3D 0x=
420398
<cmd_config>, option =3D 0}, {cmd =3D 0x4e492b "count-objects", fn =3D
0x420e9a <cmd_count_objects>,
            option =3D 1}, {cmd =3D 0x4e4939 "describe", fn =3D 0x421e8=
a
<cmd_describe>, option =3D 1}, {cmd =3D 0x4e4942 "diff", fn =3D 0x4238d=
c
<cmd_diff>, option =3D 0}, {cmd =3D 0x4e4947 "diff-files", fn =3D 0x422=
454
<cmd_diff_files>, option =3D 5}, {
            cmd =3D 0x4e4952 "diff-index", fn =3D 0x4226b0 <cmd_diff_in=
dex>,
option =3D 1}, {cmd =3D 0x4e495d "diff-tree", fn =3D 0x422bb1 <cmd_diff=
_tree>,
option =3D 1}, {cmd =3D 0x4e4967 "fast-export", fn =3D 0x42553f
<cmd_fast_export>, option =3D 1}, {
            cmd =3D 0x4e4973 "fetch", fn =3D 0x429fb8 <cmd_fetch>, opti=
on =3D
1}, {cmd =3D 0x4e4979 "fetch-pack", fn =3D 0x4275da <cmd_fetch_pack>, o=
ption
=3D 1}, {cmd =3D 0x4e4984 "fmt-merge-msg", fn =3D 0x42b17a
<cmd_fmt_merge_msg>, option =3D 1}, {
            cmd =3D 0x4e4992 "for-each-ref", fn =3D 0x42d287
<cmd_for_each_ref>, option =3D 1}, {cmd =3D 0x4e499f "format-patch", fn=
 =3D
0x436a1f <cmd_format_patch>, option =3D 1}, {cmd =3D 0x4e49ac "fsck", f=
n =3D
0x42eae7 <cmd_fsck>, option =3D 1}, {
            cmd =3D 0x4e49b1 "fsck-objects", fn =3D 0x42eae7 <cmd_fsck>=
,
option =3D 1}, {cmd =3D 0x4e49be "gc", fn =3D 0x42f26b <cmd_gc>, option=
 =3D 1},
{cmd =3D 0x4e49c1 "get-tar-commit-id", fn =3D 0x45ea9f
<cmd_get_tar_commit_id>, option =3D 0}, {
            cmd =3D 0x4e49d3 "grep", fn =3D 0x431505 <cmd_grep>, option=
 =3D
3}, {cmd =3D 0x4e49d8 "help", fn =3D 0x4332b8 <cmd_help>, option =3D 0}=
, {cmd
=3D 0x4e49dd "init", fn =3D 0x43420d <cmd_init_db>, option =3D 0}, {cmd=
 =3D
0x4e49e2 "init-db",
            fn =3D 0x43420d <cmd_init_db>, option =3D 0}, {cmd =3D 0x4e=
49ea
"log", fn =3D 0x43560b <cmd_log>, option =3D 3}, {cmd =3D 0x4e49ee "ls-=
files",
fn =3D 0x438f72 <cmd_ls_files>, option =3D 1}, {cmd =3D 0x4e49f7 "ls-tr=
ee", fn
=3D 0x439f6b <cmd_ls_tree>,
            option =3D 1}, {cmd =3D 0x4e49ff "ls-remote", fn =3D 0x4399=
3f
<cmd_ls_remote>, option =3D 0}, {cmd =3D 0x4e4a09 "mailinfo", fn =3D 0x=
43c72d
<cmd_mailinfo>, option =3D 0}, {cmd =3D 0x4e4a12 "mailsplit", fn =3D 0x=
43d20c
<cmd_mailsplit>, option =3D 0}, {
            cmd =3D 0x4e4a1c "merge", fn =3D 0x43fc4b <cmd_merge>, opti=
on =3D
5}, {cmd =3D 0x4e4a22 "merge-base", fn =3D 0x440d14 <cmd_merge_base>, o=
ption
=3D 1}, {cmd =3D 0x4e4a2d "merge-file", fn =3D 0x440f0a <cmd_merge_file=
>,
option =3D 0}, {
            cmd =3D 0x4e4a38 "merge-ours", fn =3D 0x441408 <cmd_merge_o=
urs>,
option =3D 1}, {cmd =3D 0x4e4a43 "merge-recursive", fn =3D 0x4414e2
<cmd_merge_recursive>, option =3D 5}, {cmd =3D 0x4e4a53 "merge-subtree"=
, fn
=3D 0x4414e2 <cmd_merge_recursive>,
            option =3D 5}, {cmd =3D 0x4e4a61 "mktree", fn =3D 0x441d15
<cmd_mktree>, option =3D 1}, {cmd =3D 0x4e4a68 "mv", fn =3D 0x44210b <c=
md_mv>,
option =3D 5}, {cmd =3D 0x4e4a6b "name-rev", fn =3D 0x443251 <cmd_name_=
rev>,
option =3D 1}, {
            cmd =3D 0x4e4a74 "pack-objects", fn =3D 0x44821f
<cmd_pack_objects>, option =3D 1}, {cmd =3D 0x4e4a81 "peek-remote", fn =
=3D
0x43993f <cmd_ls_remote>, option =3D 0}, {cmd =3D 0x4e4a8d "pickaxe", f=
n =3D
0x413481 <cmd_blame>, option =3D 1}, {
            cmd =3D 0x4e4a95 "prune", fn =3D 0x449431 <cmd_prune>, opti=
on =3D
1}, {cmd =3D 0x4e4a9b "prune-packed", fn =3D 0x448e33 <cmd_prune_packed=
>,
option =3D 1}, {cmd =3D 0x4e4aa8 "push", fn =3D 0x449cdd <cmd_push>, op=
tion =3D
1}, {cmd =3D 0x4e4aad "read-tree",
            fn =3D 0x44a28d <cmd_read_tree>, option =3D 1}, {cmd =3D 0x=
4e4ab7
"receive-pack", fn =3D 0x44be59 <cmd_receive_pack>, option =3D 0}, {cmd=
 =3D
0x4e4ac4 "reflog", fn =3D 0x44daf6 <cmd_reflog>, option =3D 1}, {cmd =3D
0x4e4acb "remote",
            fn =3D 0x4519b9 <cmd_remote>, option =3D 1}, {cmd =3D 0x4e4=
ad2
"replace", fn =3D 0x451fa9 <cmd_replace>, option =3D 1}, {cmd =3D 0x4e4=
ada
"repo-config", fn =3D 0x420398 <cmd_config>, option =3D 0}, {cmd =3D 0x=
4e4ae6
"rerere",
            fn =3D 0x452698 <cmd_rerere>, option =3D 1}, {cmd =3D 0x4e4=
aed
"reset", fn =3D 0x4530cf <cmd_reset>, option =3D 1}, {cmd =3D 0x4e4af3
"rev-list", fn =3D 0x4540be <cmd_rev_list>, option =3D 1}, {cmd =3D 0x4=
e4afc
"rev-parse",
            fn =3D 0x45537f <cmd_rev_parse>, option =3D 0}, {cmd =3D 0x=
4e4b06
"revert", fn =3D 0x456f84 <cmd_revert>, option =3D 5}, {cmd =3D 0x4e4b0=
d "rm",
fn =3D 0x457368 <cmd_rm>, option =3D 1}, {cmd =3D 0x4e4b10 "send-pack",=
 fn =3D
0x458c65 <cmd_send_pack>,
---Type <return> to continue, or q <return> to quit---
            option =3D 1}, {cmd =3D 0x4e4b1a "shortlog", fn =3D 0x459c2=
7
<cmd_shortlog>, option =3D 2}, {cmd =3D 0x4e4b23 "show-branch", fn =3D
0x45b3b7 <cmd_show_branch>, option =3D 1}, {cmd =3D 0x4e4b2f "show", fn=
 =3D
0x43511f <cmd_show>, option =3D 3}, {
            cmd =3D 0x4e4b34 "status", fn =3D 0x41ec30 <cmd_status>, op=
tion
=3D 5}, {cmd =3D 0x4e4b3b "stripspace", fn =3D 0x45cf9d <cmd_stripspace=
>,
option =3D 0}, {cmd =3D 0x4e4b46 "symbolic-ref", fn =3D 0x45d0f3
<cmd_symbolic_ref>, option =3D 1}, {
            cmd =3D 0x4e4b53 "tag", fn =3D 0x45df1e <cmd_tag>, option =3D=
 1},
{cmd =3D 0x4e4b57 "tar-tree", fn =3D 0x45e8b4 <cmd_tar_tree>, option =3D=
 0},
{cmd =3D 0x4e4b60 "unpack-objects", fn =3D 0x45fe1f <cmd_unpack_objects=
>,
option =3D 1}, {
            cmd =3D 0x4e4b6f "update-index", fn =3D 0x461634
<cmd_update_index>, option =3D 1}, {cmd =3D 0x4e4b7c "update-ref", fn =3D
0x461fac <cmd_update_ref>, option =3D 1}, {cmd =3D 0x4e4b87
"update-server-info", fn =3D 0x4622f8 <cmd_update_server_info>,
            option =3D 1}, {cmd =3D 0x4e4b9a "upload-archive", fn =3D 0=
x4627e4
<cmd_upload_archive>, option =3D 0}, {cmd =3D 0x4e4ba9 "verify-tag", fn=
 =3D
0x4634ba <cmd_verify_tag>, option =3D 1}, {cmd =3D 0x4e4bb4 "version", =
fn =3D
0x491586 <cmd_version>,
            option =3D 0}, {cmd =3D 0x4e4bbc "whatchanged", fn =3D 0x43=
4df8
<cmd_whatchanged>, option =3D 3}, {cmd =3D 0x4e4bc8 "write-tree", fn =3D
0x463614 <cmd_write_tree>, option =3D 1}, {cmd =3D 0x4e4bd3 "verify-pac=
k",
fn =3D 0x462fb3 <cmd_verify_pack>,
            option =3D 0}, {cmd =3D 0x4e4bdf "show-ref", fn =3D 0x45cb5=
3
<cmd_show_ref>, option =3D 1}, {cmd =3D 0x4e4be8 "pack-refs", fn =3D 0x=
448ad0
<cmd_pack_refs>, option =3D 1}}
        ext =3D ""
#9  0x0000000000404b00 in run_argv (argcp=3D0x7fffffffd984,
argv=3D0x7fffffffd978) at git.c:443
        done_alias =3D 0
#10 0x0000000000404c51 in main (argc=3D2, argv=3D0x7fffffffda90) at git=
=2Ec:514
        cmd =3D 0x7fffffffdf2d "merge"
        done_help =3D 0
        was_alias =3D 0
(gdb)
