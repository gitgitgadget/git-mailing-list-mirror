From: David Kastrup <dak@gnu.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 22:01:11 +0100
Message-ID: <87twzdl0iw.fsf@fencepost.gnu.org>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josh Boyer <jwboyer@fedoraproject.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 26 22:01:54 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YFqn6-0003eq-PA
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Jan 2015 22:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbbAZVBo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Jan 2015 16:01:44 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:40660 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbAZVBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2015 16:01:41 -0500
Received: from localhost ([127.0.0.1]:39696 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YFqmx-0003dv-EC; Mon, 26 Jan 2015 16:01:39 -0500
Received: by lola (Postfix, from userid 1000)
	id 8AA2BDF71A; Mon, 26 Jan 2015 22:01:11 +0100 (CET)
In-Reply-To: <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 26 Jan 2015 12:44:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263044>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jan 26, 2015 at 8:32 AM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
>>
>> I went to do the Fedora 3.19-rc6 build this morning and it failed in
>> our buildsystem with:
>>
>> + '[' '!' -f /builddir/build/SOURCES/patch-3.19-rc6.xz ']'
>> + case "$patch" in
>> + unxz
>> + patch -p1 -F1 -s
>> symbolic link target '../../../../../include/dt-bindings' is invalid
>> error: Bad exit status from /var/tmp/rpm-tmp.mWE3ZL (%prep)
>
> Ugh. I don't see anything we can do about this on the git side, and I
> do kind of understand why 'patch' would be worried about '..' files.
> In a perfect world, patch would parse the filename and see that it
> stays within the directory structure of the project, but that is a
> rather harder thing to do than just say "no dot-dot files".
>
> The short-term fix is likely to just use "git apply" instead of "patch".
>
> The long-term fix? I dunno. I don't see us not using symlinks, and a
> quick check says that every *single* symlink we have in the kernel
> source tree is one that points to a different directory using ".."
> format. And while I could imagine that "patch" ends up counting the
> dot-dot entries and checking that it's all inside the same tree it is
> patching, I could also easily see patch *not* doing that.

I consider it rather hard and error-prone and/or an attack vector to
choose a course of action for ../ in connection with the -p option.

-- 
David Kastrup
