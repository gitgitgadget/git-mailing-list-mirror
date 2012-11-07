From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Long clone time after "done."
Date: Wed, 7 Nov 2012 11:32:37 -0600
Message-ID: <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 18:33:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TW9V9-0007SK-SE
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 18:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab2KGRdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 12:33:00 -0500
Received: from mx71.nozonenet.com ([204.14.89.24]:55808 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752342Ab2KGRc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 12:32:59 -0500
Received: (qmail 7027 invoked by uid 399); 7 Nov 2012 12:32:58 -0500
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 7 Nov 2012 12:32:58 -0500
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so2740467iea.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 09:32:57 -0800 (PST)
Received: by 10.50.37.133 with SMTP id y5mr5365160igj.8.1352309577889; Wed, 07
 Nov 2012 09:32:57 -0800 (PST)
Received: by 10.64.23.243 with HTTP; Wed, 7 Nov 2012 09:32:37 -0800 (PST)
In-Reply-To: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209137>

To elaborate from before, my repository is about 2GB and has about 7k
branches and tags with 15 years of history imported from CVS. I
created a toy repository attempting to replicate the problem but
haven't had any luck so instead I launched Git in a debugger to see
what operation is taking so long in "git clone". I stopped randomly in
the middle and stepped to the line which seems to be contributing the
most:

  #0  read_packed_sha1 (sha1=0xb0ee98
"\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D",
type=0x7fbfffe7a4, size=0x7fbfffe798) at sha1_file.c:2237
  #1  0x00000000004d366e in read_object (sha1=0xb0ee98
"\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D",
type=0x7fbfffe7a4, size=0x7fbfffe798) at sha1_file.c:2277
  #2  0x00000000004d3839 in read_sha1_file_extended (sha1=0xb0ee98
"\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D",
type=0x7fbfffe7a4, size=0x7fbfffe798, flag=<optimized out>) at
sha1_file.c:2307
  #3  0x00000000004ae000 in read_sha1_file (sha1=0x7fbfffc5e0 "",
type=0x6be000, size=0x2b039b9010) at cache.h:730
  #4  parse_object (sha1=0xb0ee98
"\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D") at
object.c:212
  #5  0x00000000004ae9ec in handle_one_ref (path=0xb0eec0
"refs/tags/<removed>", sha1=0xb0ee98
"\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D", flags=2,
cb_data=<optimized out>) at pack-refs.
  #6  0x00000000004bc402 in do_one_ref (base=<optimized out>,
fn=0x4ae8f0 <handle_one_ref>, trim=<optimized out>, flags=0,
cb_data=0x7fbfffe9c0, entry=0xb0ee90) at refs.c:527
  #7  0x00000000004bd38b in do_for_each_ref_in_dir (dir=0xb09be8,
offset=<optimized out>, base=0x4fd9b0 "", fn=0x4ae8f0
<handle_one_ref>, trim=0, flags=0, cb_data=0x7fbfffe9c0) at refs.c:553
  #8  0x00000000004bd6cb in do_for_each_ref_in_dirs (dir1=0x6a8588,
dir2=0xb0ab18, base=0x4fd9b0 "", fn=0x4ae8f0 <handle_one_ref>, trim=0,
flags=0, cb_data=0x7fbfffe9c0) at refs.c:599
  #9  0x00000000004bd6cb in do_for_each_ref_in_dirs (dir1=0x6a3118,
dir2=0xb038b8, base=0x4fd9b0 "", fn=0x4ae8f0 <handle_one_ref>, trim=0,
flags=0, cb_data=0x7fbfffe9c0) at refs.c:599
  #10 0x00000000004bdb3f in do_for_each_ref (submodule=<optimized
out>, base=0x4fd9b0 "", fn=0x4ae8f0 <handle_one_ref>, trim=0, flags=0,
cb_data=0x7fbfffe9c0) at refs.c:1288
  #11 0x00000000004aeaba in pack_refs (flags=<optimized out>) at pack-refs.c:133
  #12 0x000000000041da30 in write_remote_refs (local_refs=<optimized
out>) at builtin/clone.c:470
  #13 update_remote_refs (refs=<optimized out>, mapped_refs=<optimized
out>, remote_head_points_at=<optimized out>, branch_top=0x6a4210
"refs/remotes/origin/", msg=0x6a1160 "clone: from
/z/umoszkow/git/clone/../merged/merged.git") at bu
  #14 cmd_clone (argc=<optimized out>, argv=0x7fbffff1b0,
prefix=<optimized out>) at builtin/clone.c:898
  #15 0x0000000000404eef in handle_internal_command (argc=3,
argv=0x7fbffff1b0) at git.c:306
  #16 0x0000000000405347 in run_argv (argcp=<optimized out>,
argv=<optimized out>) at git.c:513
  #17 main (argc=3, argv=0x7fbffff1b0) at git.c:588

It looks like handle_one_ref() is called for each ref and most result
in a call to read_sha1_file(). It only takes a second or so for each
call but when you have thousands of them (one for each ref) it adds
up. Adding --single-branch --branch <branch> doesn't appear to help as
it is implemented afterwards. I would like to debug this problem
further but am not familiar enough with the implementation to know
what the next step is. Can anyone offer some suggestions? I don't see
why a clone should be dependent on an O(#refs) operations.

On Tue, Oct 23, 2012 at 1:30 PM, Uri Moszkowicz <uri@4refs.com> wrote:
> I have a large repository which I ran "git gc --aggressive" on that
> I'm trying to clone on a local file system. I would expect it to
> complete very quickly with hard links but it's taking about 6min to
> complete with no checkout (git clone -n). I see the message "Clining
> into 'repos'... done." appear after a few seconds but then Git just
> hangs there for another 6min. Any idea what it's doing at this point
> and how I can speed it up?
