From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: Re: git-fast-import crashes
Date: Tue, 16 Oct 2007 15:13:31 +0800
Message-ID: <e66701d40710160013h270f685sef57f80382089f3c@mail.gmail.com>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
	 <20071013032916.GL27899@spearce.org>
	 <20071013033407.GM27899@spearce.org>
	 <20071013073640.GC7110@artemis.corp>
	 <20071013075027.GD7110@artemis.corp>
	 <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com>
	 <20071015073307.GA1508@artemis.corp>
	 <e66701d40710150119y7c9e0ff6n83c5fbd25d351fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:13:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihgcd-0001qJ-95
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbXJPHNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508AbXJPHNg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:13:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:33946 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbXJPHNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:13:34 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1492709nfb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CNMCXE8T/pQL7sLK3afxbom5ZZ/xzVWQQF2HPH8ETZk=;
        b=Eo+mOyp37C5gpDXtTEcUWkFK5U31K14e9IWHu2qNxZ23r1uuwHm8sEJE0lxXOJUuicqiY5I2aEjmlwGz65sMYHclXOVEttxxZNZswnSnQFvx5PIxGJcFDPzCbCSbslKYpkF93WVo3Sa19yJO5olFLA8Vi6RdlESHI/67YIHWh2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nvkTUJ2kojd3Eawt6O29Ydb1J0E8/28iifsNArkinpNEJ3hZz5GV3z253mawzihswKJF9BSzgAChJT6rD1MIEGcy4RQpghHo7WC2O5IPpmnN3Sqe/Yy8M9S79iAGHEPwn84mb69MejK7yOS5QE8TyyuTI7kMSdVMcqW/JQ4AGKI=
Received: by 10.78.171.20 with SMTP id t20mr4624966hue.1192518811650;
        Tue, 16 Oct 2007 00:13:31 -0700 (PDT)
Received: by 10.78.132.20 with HTTP; Tue, 16 Oct 2007 00:13:31 -0700 (PDT)
In-Reply-To: <e66701d40710150119y7c9e0ff6n83c5fbd25d351fc6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61100>

Hi Pierre,

I have tested with your patch applied, and it still crashed badly.

I compiled the b449f4c version and I got a different backtrace from
GDB. I am still not sure about how the error occurs. I attached the
memory usage from various command line tools.

Regards,
Kevin Leung



GDB output
===========

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x756c7463
0x90018d0c in szone_realloc ()
(gdb) bt
#0  0x90018d0c in szone_realloc ()
#1  0x90018898 in realloc ()
#2  0x0001f8c8 in strbuf_grow (sb=0x75ef8, extra=0) at git-compat-util.h:223
#3  0x0001fc14 in read_line (sb=0x75ef8, fp=0xa0001b9c, term=10) at strbuf.c:107
#4  0x00002da8 in read_next_command () at fast-import.c:1599
#5  0x0000742c in cmd_new_commit () at fast-import.c:2118
#6  0x00007e80 in main (argc=1, argv=0xbffff828) at fast-import.c:2390
(gdb) frame 3
#3  0x0001fc14 in read_line (sb=0x75ef8, fp=0xa0001b9c, term=10) at strbuf.c:107
107                     strbuf_grow(sb, 1);
(gdb) print *sb
$1 = {
  alloc = 60,
  len = 23,
  eof = 0,
  buf = 0x5020b0 "D windows/packages/cdc/ces/adm"
}
(gdb) frame 2
#2  0x0001f8c8 in strbuf_grow (sb=0x75ef8, extra=0) at git-compat-util.h:223
223             void *ret = realloc(ptr, size);
(gdb) print (char *) ptr
$2 = 0x5020b0 "D windows/packages/cdc/ces/adm"
(gdb) print (char *)ret
$3 = 0xd <Address 0xd out of bounds>
(gdb)


The output of `leaks'
=================

Process 27075: 88 nodes malloced for 2335 KB
Process 27075: 6 leaks for 624 total leaked bytes.
Leak: 0x005012b0  size=208      string 'EOT'
Leak: 0x00501e60  size=128      string 'EOT'
Leak: 0x00501c80  size=128      string 'EOT'
Leak: 0x00500f10  size=64       string 'EOT'
Leak: 0x00501fa0  size=64       string 'EOT'
Leak: 0x00501f60  size=32
        0x00000000 0x02008000 0x00000000 0x01000000     ................
        0x02000000 0x0000001a 0x00000000 0x00000000     ................



Below is the output of `malloc_history'
==============================

Deallocation of 5020b0 - no corresponding allocation
67 calls for 2874 bytes: thread_a000ed88 |0x0 | start | _start | main
| cmd_new_commit | read_next_command | read_line | strbuf_grow

12 calls for 2016 bytes: thread_a000ed88 |0x0 | start | _start | main
| prepare_packed_git | prepare_packed_git_one | add_packed_git

8 calls for 831 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | cmd_data | read_line | strbuf_grow

4 calls for 160 bytes: thread_a000ed88 |0x0 | start | _start |
__keymgr_dwarf2_register_sections | _dyld_register_func_for_add_image
| dyld::registerAddCallback(void (*)(mach_header const*, long)) |
ImageLoader::runNotification(ImageLoader::LinkContext const&,
unsigned) | ImageLoader::recursiveImageNotification(ImageLoader::LinkContext
const&, unsigned) | dyld::imageNotification(ImageLoader*, unsigned) |
dwarf2_unwind_dyld_add_image_hook

3 calls for 1976 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set | load_tree |
read_sha1_file | read_packed_sha1 | unpack_entry | unpack_entry |
patch_delta

3 calls for 84 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set | load_tree |
read_sha1_file | read_packed_sha1 | unpack_entry |
unpack_object_header | use_pack

2 calls for 1200 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | patch_delta

2 calls for 1200 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
patch_delta

2 calls for 1200 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | patch_delta

2 calls for 80 bytes: thread_a000ed88 |0x0 | start | _start |
__keymgr_dwarf2_register_sections | _dyld_register_func_for_add_image
| dyld::registerAddCallback(void (*)(mach_header const*, long)) |
ImageLoader::runNotification(ImageLoader::LinkContext const&,
unsigned) | ImageLoader::recursiveImageNotification(ImageLoader::LinkContext
const&, unsigned) | dyld::imageNotification(ImageLoader*, unsigned) |
dwarf2_unwind_dyld_add_image_hook

2 calls for 56 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_object_header | use_pack

1 calls for 2097152 bytes: thread_a000ed88 |0x0 | start | _start |
main | pool_calloc | pool_alloc

1 calls for 160012 bytes: thread_a000ed88 |0x0 | start | _start | main
| alloc_objects

1 calls for 52000 bytes: thread_a000ed88 |0x0 | start | _start | main
| cmd_new_commit | load_tree | new_tree_entry

1 calls for 17804 bytes: thread_a000ed88 |0x0 | start | _start | main

1 calls for 8192 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | cmd_data

1 calls for 4156 bytes: thread_a000ed88 |0x0 | start | _start | main

1 calls for 4096 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | store_tree | store_tree | store_tree | mktree |
size_dbuf

1 calls for 4096 bytes: thread_a000ed88 |0x0 | start | _start | main |
read_next_command | read_line | fgetc | __srget | __srefill |
__smakebuf

1 calls for 3072 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | store_tree | store_tree | store_tree | mktree |
size_dbuf

1 calls for 2048 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | size_dbuf

1 calls for 1149 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set | load_tree |
read_sha1_file | read_packed_sha1 | unpack_entry | unpack_entry |
unpack_entry | patch_delta

1 calls for 1149 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set | load_tree |
read_sha1_file | read_packed_sha1 | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_compressed_entry

1 calls for 1032 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | unpack_compressed_entry

1 calls for 822 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set |
tree_content_set | load_tree | read_sha1_file | read_packed_sha1 |
unpack_entry | unpack_entry | unpack_compressed_entry

1 calls for 522 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry |
unpack_compressed_entry

1 calls for 436 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set |
tree_content_set | tree_content_set | tree_content_set |
tree_content_set | load_tree | read_sha1_file | read_packed_sha1 |
unpack_entry | unpack_entry | unpack_compressed_entry

1 calls for 400 bytes: thread_a000ed88 |0x0 | start | _start | main

1 calls for 285 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set |
tree_content_set | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry |
unpack_compressed_entry

1 calls for 258 bytes: thread_a000ed88 |0x0 | start | _start | main |
start_packfile | mkstemp | arc4random

1 calls for 212 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set |
tree_content_set | tree_content_set | tree_content_set | load_tree |
read_sha1_file | read_packed_sha1 | unpack_entry | unpack_entry |
unpack_compressed_entry

1 calls for 168 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | patch_delta

1 calls for 168 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | patch_delta

1 calls for 168 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | patch_delta

1 calls for 168 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | unpack_compressed_entry

1 calls for 168 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | load_tree | read_sha1_file |
read_packed_sha1 | unpack_entry | unpack_entry | unpack_entry |
unpack_entry | unpack_entry | unpack_entry | unpack_entry |
patch_delta

1 calls for 129 bytes: thread_a000ed88 |0x0 | start | _start | main |
start_packfile

1 calls for 122 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set | load_tree |
read_sha1_file | read_packed_sha1 | unpack_entry | unpack_entry |
unpack_compressed_entry

1 calls for 64 bytes: thread_a000ed88 |0x0 | start | _start | main |
git_config | git_path | get_git_dir | setup_git_env | sprintf$LDBL128
| __vfprintf$LDBL128 | localeconv_l

1 calls for 61 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | parse_ident

1 calls for 60 bytes: thread_a000ed88 |0x0 | start | _start |
__keymgr_dwarf2_register_sections | _dyld_register_func_for_add_image
| dyld::registerAddCallback(void (*)(mach_header const*, long)) |
ImageLoader::runNotification(ImageLoader::LinkContext const&,
unsigned) | dyld::imageNotification(ImageLoader*, unsigned) |
dwarf2_unwind_dyld_add_image_hook |
_keymgr_get_and_lock_processwide_ptr_2 | get_or_create_key_element

1 calls for 52 bytes: thread_a000ed88 |0x0 | start | _start | main |
git_config | git_path | get_git_dir | setup_git_env | strdup

1 calls for 48 bytes: thread_a000ed88 |0x0 | start | _start | main |
git_config | git_path | get_git_dir | setup_git_env

1 calls for 46 bytes: thread_a000ed88 |0x0 | start | _start | main |
git_config | git_path | get_git_dir | setup_git_env

1 calls for 45 bytes: thread_a000ed88 |0x0 | start | _start | main |
git_config | git_path | get_git_dir | setup_git_env

1 calls for 40 bytes: thread_a000ed88 |0x0 | start | _start |
__keymgr_dwarf2_register_sections | _dyld_register_func_for_add_image
| dyld::registerAddCallback(void (*)(mach_header const*, long)) |
ImageLoader::runNotification(ImageLoader::LinkContext const&,
unsigned) | dyld::imageNotification(ImageLoader*, unsigned) |
dwarf2_unwind_dyld_add_image_hook

1 calls for 40 bytes: thread_a000ed88 |0x0 | start | _start |
__keymgr_dwarf2_register_sections | _dyld_register_func_for_add_image
| dyld::registerAddCallback(void (*)(mach_header const*, long)) |
ImageLoader::runNotification(ImageLoader::LinkContext const&,
unsigned) | ImageLoader::recursiveImageNotification(ImageLoader::LinkContext
const&, unsigned) | dyld::imageNotification(ImageLoader*, unsigned) |
dwarf2_unwind_dyld_add_image_hook

1 calls for 28 bytes: thread_a000ed88 |0x0 | start | _start | main |
cmd_new_commit | tree_content_set | tree_content_set |
tree_content_set | tree_content_set | tree_content_set |
tree_content_set | load_tree | read_sha1_file | read_packed_sha1 |
unpack_entry | unpack_object_header | use_pack

1 calls for 18 bytes: thread_a000ed88 |0x0 | start | _start |
__keymgr_dwarf2_register_sections | _dyld_register_func_for_add_image
| dyld::registerAddCallback(void (*)(mach_header const*, long)) |
ImageLoader::runNotification(ImageLoader::LinkContext const&,
unsigned) | dyld::imageNotification(ImageLoader*, unsigned) |
dwarf2_unwind_dyld_add_image_hook | calloc

1 calls for 4 bytes: thread_a000ed88 |0x0 | start | _start | main |
start_packfile


Output of `vmmap'
===============

Virtual Memory Map of process 27270 (git-fast-import)
Output report format:  2.0

==== Non-writable regions for process 27270
__PAGEZERO             00000000-00001000 [    4K] ---/--- SM=NUL
/Users/developer/bin/git-fast-import
__TEXT                 00001000-00034000 [  204K] r-x/rwx SM=COW
/Users/developer/bin/git-fast-import
__LINKEDIT             00080000-000f3000 [  460K] r--/rwx SM=COW
/Users/developer/bin/git-fast-import
mapped file            000f7000-000f8000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-b7cda23e237f38b466d2f7b54f665a7d0c8a32ed.idx
mapped file            000f8000-000f9000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-5f301a4b08a7f7d44b288f2a96d33f3c3efbf7fb.idx
mapped file            000f9000-000fa000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-ee6298d97a1154422169e66d6655071a49cb8686.idx
__TEXT                 00205000-00216000 [   68K] r-x/rwx SM=COW
/opt/local/lib/libz.1.dylib
__LINKEDIT             00217000-00219000 [    8K] r--/rwx SM=COW
/opt/local/lib/libz.1.dylib
__TEXT                 00219000-00313000 [ 1000K] r-x/rwx SM=COW
/opt/local/lib/libiconv.2.dylib
__LINKEDIT             00314000-0031e000 [   40K] r--/rwx SM=COW
/opt/local/lib/libiconv.2.dylib
__TEXT                 0031e000-00421000 [ 1036K] r-x/rwx SM=COW
/opt/local/lib/libcrypto.0.9.8.dylib
__LINKEDIT             00438000-0048d000 [  340K] r--/rwx SM=COW
/opt/local/lib/libcrypto.0.9.8.dylib
__TEXT                 0048d000-004c8000 [  236K] r-x/rwx SM=COW
/opt/local/lib/libssl.0.9.8.dylib
__LINKEDIT             004cc000-004dd000 [   68K] r--/rwx SM=COW
/opt/local/lib/libssl.0.9.8.dylib
mapped file            004dd000-004df000 [    8K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-5f301a4b08a7f7d44b288f2a96d33f3c3efbf7fb.pack
mapped file            004ec000-004ed000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-ea2fe30b68a19c9cd6a4bf1dd345377b4dd77df0.idx
mapped file            004ed000-004ee000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-97e365a44e20cb37576362c81afdaa879a871a10.idx
mapped file            004ee000-004ef000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-f1bcc0635a35caff73d8ccac60ec6656f0527a10.idx
mapped file            004ef000-004f0000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-f1bcc0635a35caff73d8ccac60ec6656f0527a10.pack
mapped file            004f0000-004f1000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-60dd3fcceddf3eacbe2279ef191f87668b97fb57.idx
mapped file            004f1000-004f2000 [    4K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-8a733b7ccad3eb85b4286a011eccdff20441d9e4.idx
mapped file            004f2000-004f7000 [   20K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-8acbc2151777eb8a2093e5229897d5711dab175b.idx
mapped file            004f7000-004fa000 [   12K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-3d264397b577400c2277f1b89f2065e0cc9846e3.idx
mapped file            004fa000-004fc000 [    8K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-010e1c06a07ef38c31f8e01782eeda433b007709.idx
mapped file            004fc000-00500000 [   16K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-ea2fe30b68a19c9cd6a4bf1dd345377b4dd77df0.pack
mapped file            006ad000-006e4000 [  220K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-3294c669f264ef7a21e2280bfd934e7459140022.idx
mapped file            01208000-01363000 [ 1388K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-8acbc2151777eb8a2093e5229897d5711dab175b.pack
mapped file            01363000-0146c000 [ 1060K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-010e1c06a07ef38c31f8e01782eeda433b007709.pack
mapped file            02008000-052fe000 [52184K] r--/rwx SM=COW
/Volumes/data/kevin/test_gitp4/cdc/.git/objects/pack/pack-3294c669f264ef7a21e2280bfd934e7459140022.pack
__TEXT                 8fe00000-8fe01000 [    4K] r-x/rwx SM=COW  /usr/lib/dyld
__TEXT                 8fe01000-8fe02000 [    4K] r-x/rwx SM=COW  /usr/lib/dyld
__TEXT                 8fe02000-8fe53000 [  324K] r-x/rwx SM=COW  /usr/lib/dyld
__LINKEDIT             8fe5d000-8fe71000 [   80K] r--/rwx SM=COW  /usr/lib/dyld
__TEXT                 90000000-901bd000 [ 1780K] r-x/r-x SM=COW
/usr/lib/libSystem.B.dylib
__LINKEDIT             901bd000-90214000 [  348K] r--/r-- SM=COW
/usr/lib/libSystem.B.dylib
__TEXT                 90214000-9021a000 [   24K] r-x/r-x SM=COW
/usr/lib/system/libmathCommon.A.dylib
__LINKEDIT             9021a000-9021b000 [    4K] r--/r-- SM=COW
/usr/lib/system/libmathCommon.A.dylib
__TEXT                 91433000-9143f000 [   48K] r-x/r-x SM=COW
/usr/lib/libgcc_s.1.dylib
__LINKEDIT             9143f000-91443000 [   16K] r--/r-- SM=COW
/usr/lib/libgcc_s.1.dylib
__DATA                 a0214000-a0215000 [    4K] r--/r-- SM=COW
/usr/lib/system/libmathCommon.A.dylib
STACK GUARD            fffec000-ffff0000 [   16K] ---/rwx SM=NUL
system                 ffff8000-ffffa000 [    8K] r--/r-- SM=SHM
commpage [libSystem.B.dylib]

==== Writable regions for process 27270
__DATA                 00034000-00035000 [    4K] rw-/rwx SM=COW
/Users/developer/bin/git-fast-import
__DATA                 00035000-00080000 [  300K] rw-/rwx SM=PRV
/Users/developer/bin/git-fast-import
VM_ALLOCATE ?          000fa000-000fb000 [    4K] rw-/rwx SM=NUL
MALLOC_LARGE           000fb000-00100000 [   20K] rw-/rwx SM=PRV
DefaultMallocZone_0x500000
MALLOC_TINY (freed?)   00100000-00102000 [    8K] rw-/rwx SM=COW
MALLOC_TINY (freed?)   00102000-00205000 [ 1036K] rw-/rwx SM=ZER
__DATA                 00216000-00217000 [    4K] rw-/rwx SM=COW
/opt/local/lib/libz.1.dylib
__DATA                 00313000-00314000 [    4K] rw-/rwx SM=COW
/opt/local/lib/libiconv.2.dylib
__DATA                 00421000-00435000 [   80K] rw-/rwx SM=COW
/opt/local/lib/libcrypto.0.9.8.dylib
__DATA                 00435000-00438000 [   12K] rw-/rwx SM=NUL
/opt/local/lib/libcrypto.0.9.8.dylib
__DATA                 004c8000-004cc000 [   16K] rw-/rwx SM=COW
/opt/local/lib/libssl.0.9.8.dylib
MALLOC_LARGE           004df000-004ec000 [   52K] rw-/rwx SM=PRV
DefaultMallocZone_0x500000
MALLOC_TINY            00500000-00605000 [ 1044K] rw-/rwx SM=COW
DefaultMallocZone_0x500000
Performance tool data  00605000-00685000 [  512K] rw-/rwx SM=COW
MALLOC_LARGE           00685000-006ad000 [  160K] rw-/rwx SM=PRV
DefaultMallocZone_0x500000
Performance tool data  006e4000-006ed000 [   36K] rw-/rwx SM=COW
MALLOC (freed?)        00800000-01008000 [ 8224K] rw-/rwx SM=PRV
MALLOC_LARGE           01008000-01208000 [ 2048K] rw-/rwx SM=PRV
DefaultMallocZone_0x500000
MALLOC                 01800000-02008000 [ 8224K] rw-/rwx SM=COW
DefaultMallocZone_0x500000
__DATA                 8fe53000-8fe54000 [    4K] rw-/rwx SM=COW  /usr/lib/dyld
__DATA                 8fe54000-8fe5a000 [   24K] rw-/rwx SM=COW  /usr/lib/dyld
__DATA                 8fe5a000-8fe5d000 [   12K] rw-/rwx SM=PRV  /usr/lib/dyld
__DATA                 a0000000-a0002000 [    8K] rw-/rw- SM=COW
/usr/lib/libSystem.B.dylib
__DATA                 a0002000-a0003000 [    4K] rw-/rw- SM=COW
/usr/lib/libSystem.B.dylib
__DATA                 a0003000-a0004000 [    4K] rw-/rw- SM=COW
/usr/lib/libSystem.B.dylib
__DATA                 a0004000-a0005000 [    4K] rw-/rw- SM=COW
/usr/lib/libSystem.B.dylib
__DATA                 a0005000-a000b000 [   24K] rw-/rw- SM=COW
/usr/lib/libSystem.B.dylib
__DATA                 a000b000-a0010000 [   20K] rw-/rw- SM=ZER
/usr/lib/libSystem.B.dylib
__DATA                 a0010000-a0011000 [    4K] rw-/rw- SM=COW
/usr/lib/libSystem.B.dylib
__DATA                 a0011000-a0012000 [    4K] rw-/rw- SM=ZER
/usr/lib/libSystem.B.dylib
__DATA                 a1433000-a1434000 [    4K] rw-/rw- SM=COW
/usr/lib/libgcc_s.1.dylib
Stack                  bf800000-bffff000 [ 8188K] rw-/rwx SM=PRV
Stack                  bffff000-c0000000 [    4K] rw-/rwx SM=COW  thread 0

==== Legend
SM=sharing mode:
        COW=copy_on_write PRV=private NUL=empty ALI=aliased
        SHM=shared ZER=zero_filled S/A=shared_alias

==== Summary for process 27270
ReadOnly portion of Libraries: Total=6092KB resident=2944KB(48%)
swapped_out_or_unallocated=3148KB(52%)
Writable regions: Total=30036KB written=504KB(2%) resident=968KB(3%)
swapped_out=0KB(0%) unallocated=29068KB(97%)

REGION TYPE             [ VIRTUAL]
===========             [ =======]
MALLOC                  [  20816K]
Performance tool data   [    548K]
STACK GUARD             [     16K]
Stack                   [   8192K]
VM_ALLOCATE ?           [      4K]
__DATA                  [    540K]
__LINKEDIT              [   1364K]
__PAGEZERO              [      4K]
__TEXT                  [   4728K]
mapped file             [  54952K]
system                  [      8K]
