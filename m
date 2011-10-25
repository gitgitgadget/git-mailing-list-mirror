From: Bernt Hansen <bernt@norang.ca>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Mon, 24 Oct 2011 20:00:15 -0400
Message-ID: <878voaym7k.fsf@norang.ca>
References: <20111024201153.GA1647@x4.trippels.de>
	<20111024214949.GA5237@amd.home.annexia.org>
	<20111024225836.GA1678@x4.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Richard W.M. Jones" <rjones@redhat.com>, meyering@redhat.com,
	git@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 02:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIUSV-0005ON-JR
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 02:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab1JYAA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 20:00:28 -0400
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65432 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755774Ab1JYAA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 20:00:27 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <bernt@norang.ca>)
	id 1RIURO-000GUH-5i; Tue, 25 Oct 2011 00:00:26 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+axPIjxEMTsh+SrNhA9SVd
Received-SPF: pass (mail.norang.ca: domain of bernt@norang.ca designates 192.168.1.5 as permitted sender) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=localhost.localdomain; envelope-from=bernt@norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from localhost.localdomain (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p9P00Hwx017234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 24 Oct 2011 20:00:18 -0400
Received: from localhost.localdomain (gollum [127.0.0.1])
	by localhost.localdomain (8.14.3/8.14.3/Debian-9.4) with ESMTP id p9P00HcT025623;
	Mon, 24 Oct 2011 20:00:17 -0400
Received: (from bernt@localhost)
	by localhost.localdomain (8.14.3/8.14.3/Submit) id p9P00FFq025622;
	Mon, 24 Oct 2011 20:00:15 -0400
X-Authentication-Warning: localhost.localdomain: bernt set sender to bernt@norang.ca using -f
In-Reply-To: <20111024225836.GA1678@x4.trippels.de> (Markus Trippelsdorf's
	message of "Tue, 25 Oct 2011 00:58:36 +0200")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184194>

Markus Trippelsdorf <markus@trippelsdorf.de> writes:

> On 2011.10.24 at 22:49 +0100, Richard W.M. Jones wrote:
>> On Mon, Oct 24, 2011 at 10:11:53PM +0200, Markus Trippelsdorf wrote:
>> > Suddenly I'm getting strange protection faults when I run "git grep" on
>> > the gcc tree:
>> 
>> Jim Meyering and I are trying to chase what looks like a similar or
>> identical bug in git-grep.  We've not got much further than gdb and
>> valgrind so far, but see:
>> 
>> https://bugzilla.redhat.com/show_bug.cgi?id=747377
>> 
>> It's slightly suspicious that this bug only started to happen with the
>> latest glibc, but that could be coincidence, or could be just that
>> glibc exposes a latent bug in git-grep.
>
> Thanks for the pointer.
>
> Compiling git with -O1 "solves" the problem for me. 
> This issue is independent of the exact git version being used (I tried
> three different ones and always hit the problem).
> It happens always on the _second_ run of "git grep" on my machine. The
> first run always succeeds. So this might be a cache related issue.

Hi,

I updated from an old commit 2883969 (Sync with maint, 2011-10-15)
to origin/master 10b2a48 (Merge branch 'maint', 2011-10-23) today and
promptly got segfaults on git status in my org-mode repository.

Going back to the old commit makes it work again.

Git bisect identifies the following commit as the problem:

[2548183badb98d62079beea62f9d2e1f47e99902] fix phantom untracked files when core.ignorecase is set

I'm doing make && make install to my local home directory.

On the above commit I get this:

--8<---------------cut here---------------start------------->8---
bernt@gollum:~/git/org$ git status
*** glibc detected *** git: free(): invalid next size (normal): 0x08ce1a88 ***
======= Backtrace: =========
/lib/i686/cmov/libc.so.6(+0x6b281)[0xb749d281]
/lib/i686/cmov/libc.so.6(+0x6cad8)[0xb749ead8]
/lib/i686/cmov/libc.so.6(cfree+0x6d)[0xb74a1bbd]
/lib/i686/cmov/libc.so.6(+0x5c0a0)[0xb748e0a0]
/lib/i686/cmov/libc.so.6(fopen64+0x2c)[0xb749067c]
git[0x80ba49c]
git[0x810d0ab]
git[0x80627af]
git[0x804b867]
git[0x804ba73]
/lib/i686/cmov/libc.so.6(__libc_start_main+0xe6)[0xb7448c76]
git[0x804b141]
======= Memory map: ========
08048000-0814f000 r-xp 00000000 08:01 6555228    /home/bernt/git/bin/git
0814f000-08154000 rw-p 00106000 08:01 6555228    /home/bernt/git/bin/git
08154000-0819c000 rw-p 00000000 00:00 0 
08cd7000-08cf8000 rw-p 00000000 00:00 0          [heap]
b7300000-b7321000 rw-p 00000000 00:00 0 
b7321000-b7400000 ---p 00000000 00:00 0 
b740f000-b742c000 r-xp 00000000 08:01 4603917    /lib/libgcc_s.so.1
b742c000-b742d000 rw-p 0001c000 08:01 4603917    /lib/libgcc_s.so.1
b742d000-b742e000 rw-p 00000000 00:00 0 
b742e000-b7430000 r-xp 00000000 08:01 4620339    /lib/i686/cmov/libdl-2.11.2.so
b7430000-b7431000 r--p 00001000 08:01 4620339    /lib/i686/cmov/libdl-2.11.2.so
b7431000-b7432000 rw-p 00002000 08:01 4620339    /lib/i686/cmov/libdl-2.11.2.so
b7432000-b7572000 r-xp 00000000 08:01 4622760    /lib/i686/cmov/libc-2.11.2.so
b7572000-b7574000 r--p 0013f000 08:01 4622760    /lib/i686/cmov/libc-2.11.2.so
b7574000-b7575000 rw-p 00141000 08:01 4622760    /lib/i686/cmov/libc-2.11.2.so
b7575000-b7578000 rw-p 00000000 00:00 0 
b7578000-b758d000 r-xp 00000000 08:01 4620333    /lib/i686/cmov/libpthread-2.11.2.so
b758d000-b758e000 r--p 00014000 08:01 4620333    /lib/i686/cmov/libpthread-2.11.2.so
b758e000-b758f000 rw-p 00015000 08:01 4620333    /lib/i686/cmov/libpthread-2.11.2.so
b758f000-b7592000 rw-p 00000000 00:00 0 
b7592000-b76cf000 r-xp 00000000 08:01 794957     /usr/lib/i686/cmov/libcrypto.so.0.9.8
b76cf000-b76e7000 rw-p 0013c000 08:01 794957     /usr/lib/i686/cmov/libcrypto.so.0.9.8
b76e7000-b76ea000 rw-p 00000000 00:00 0 
b76ea000-b76fd000 r-xp 00000000 08:01 286811     /usr/lib/libz.so.1.2.3.4
b76fd000-b76fe000 rw-p 00013000 08:01 286811     /usr/lib/libz.so.1.2.3.4
b771b000-b771d000 rw-p 00000000 00:00 0 
b771d000-b771e000 r-xp 00000000 00:00 0          [vdso]
b771e000-b7739000 r-xp 00000000 08:01 4604271    /lib/ld-2.11.2.so
b7739000-b773a000 r--p 0001a000 08:01 4604271    /lib/ld-2.11.2.so
b773a000-b773b000 rw-p 0001b000 08:01 4604271    /lib/ld-2.11.2.so
bfa3d000-bfa52000 rw-p 00000000 00:00 0          [stack]
Aborted (core dumped)
--8<---------------cut here---------------end--------------->8---

Let me know if I can provide any more information.

Regards
Bernt
