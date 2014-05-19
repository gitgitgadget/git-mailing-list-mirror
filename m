From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: format-patch crashes with a huge patchset
Date: Mon, 19 May 2014 22:35:56 +0300
Message-ID: <20140519193556.GA987@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 21:37:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmTN9-0001TF-8e
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 21:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbaESThD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 15:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbaESThC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 15:37:02 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4JJb2FI017753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 19 May 2014 15:37:02 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s4JJb0Fs023366
	for <git@vger.kernel.org>; Mon, 19 May 2014 15:37:01 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249617>

I tried to fump the whole history of qemu with format-patch.
It crashes both with v2.0.0-rc2-21-g6087111
and with git 1.8.3.1:

~/opt/libexec/git-core/git-format-patch --follow -o patches/all
e63c3dc74bfb90e4522d075d0d5a7600c5145745..

Backtrace:


Program received signal SIGSEGV, Segmentation fault.
0x0814d9d5 in try_to_follow_renames (opt=0xffffc8e4,
base=base@entry=0x816e4fe "", t2=0xffffbdf0, t1=0xffffbddc) at
tree-diff.c:227
227             diff_opts.single_follow = opt->pathspec.items[0].match;
Missing separate debuginfos, use: debuginfo-install
openssl-libs-1.0.1e-37.fc19.1.i686
(gdb) p opt
$1 = (struct diff_options *) 0xffffc8e4
(gdb) where
#0  0x0814d9d5 in try_to_follow_renames (opt=0xffffc8e4,
base=base@entry=0x816e4fe "", t2=0xffffbdf0, t1=0xffffbddc) at
tree-diff.c:227
#1  diff_tree_sha1 (old=0x97469b4
"\372\022\366\336k\345\236\362\062K\021\236\300\227\036\302\217\251\202f", 
    new=new@entry=0x9746994 "$\305H\250)\237\203\266ya\311W\n\274
\n\027^*\221", base=base@entry=0x816e4fe "", opt=opt@entry=0xffffc8e4)
    at tree-diff.c:305
#2  0x080fb83d in log_tree_diff (log=0xffffbf28, commit=0x9734730,
opt=0xffffc618) at log-tree.c:780
#3  log_tree_commit (opt=opt@entry=0xffffc618,
commit=commit@entry=0x9734730) at log-tree.c:810
#4  0x08088406 in cmd_format_patch (argc=<optimized out>,
argv=0xffffccc4, prefix=0x0) at builtin/log.c:1510
#5  0x0804c666 in run_builtin (argv=0xffffccc4, argc=5, p=0x81cb524
<commands+420>) at git.c:314
#6  handle_builtin (argc=5, argv=0xffffccc4) at git.c:487
#7  0x0804bc22 in main (argc=5, av=0xffffccc4) at git.c:584
(gdb) p opt->pathspec.items
$2 = (struct pathspec_item *) 0x0


Did not debug further: could be related to the fact
swap is disabled on my box, so attempts to allocate
huge amounts of RAM might fail.

Still should not segv I think ...

-- 
MST
