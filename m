From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 13:10:50 +0100
Message-ID: <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com>
References: <20100125225139.GA3048@fredrik-laptop>
	 <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 13:12:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZkGz-0003ns-LL
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 13:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab0AZMKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 07:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088Ab0AZMKw
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 07:10:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:47559 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0AZMKw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 07:10:52 -0500
Received: by fg-out-1718.google.com with SMTP id e21so561953fga.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EILEmX9RrKkASvnMpszs2IirGbrVpGBKstjxvqqr1oI=;
        b=dXAjtud5bq5+U9kEF76ZZ/EwfTWdSCgGhlVmobqIKQCG+DlCscbMpKvkAlLKu2ht2/
         i5SDhDK749Q2TLUPJxXlKiqFg9q1Bzl9Kug9JMdfPzDqGCbQj0d1DsodrjUlj4MneaJd
         Z1YVIy+V5MjxvSjcUbN+6m04rRY5kEh4sFRdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J/MFy9UuH2EbOe1T70v7B/jQvlJXojfvT4wEAc2TzchKJtHxhmW17yoZGbpw+mME2Y
         gzIn2vxcitN++WvgI9cvxpWkqyDkdw5hn1Wpb8B0OTnzAq/tEHGUfcL75ra6I/YnSD1+
         lIJr2ZcoRFf8MZNkkKbQEDfUI7qfX3iuAb7Ig=
Received: by 10.239.191.204 with SMTP id c12mr914688hbi.174.1264507850131; 
	Tue, 26 Jan 2010 04:10:50 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138033>

On Tue, Jan 26, 2010 at 00:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> The profile for the threaded case says:
>
> =A0 =A051.73% =A0 =A0 =A0git =A0libc-2.11.1.so =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [.] re_search_internal
> =A0 =A011.47% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] copy_user_generic_string
> =A0 =A0 2.90% =A0 =A0 =A0git =A0libc-2.11.1.so =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [.] __strlen_sse2
> =A0 =A0 2.66% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] link_path_walk
> =A0 =A0 2.55% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] intel_pmu_enable_all
> =A0 =A0 2.40% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] __d_lookup
> =A0 =A0 1.71% =A0 =A0 =A0git =A0libc-2.11.1.so =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [.] __GI___libc_malloc
> =A0 =A0 1.55% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] _raw_spin_lock
> =A0 =A0 1.43% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] sys_futex
> =A0 =A0 1.30% =A0 =A0 =A0git =A0libc-2.11.1.so =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [.] __cfree
> =A0 =A0 1.28% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] intel_pmu_disable_all
> =A0 =A0 1.25% =A0 =A0 =A0git =A0libc-2.11.1.so =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [.] __GI_memchr
> =A0 =A0 1.14% =A0 =A0 =A0git =A0libc-2.11.1.so =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [.] _int_malloc
> =A0 =A0 1.02% =A0 =A0 =A0git =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 [k] effective_load
>
> and the only thing that makes me go "eh?" there is the strlen(). Why =
is
> that so hot? =A0But locking doesn't seem to be the biggest issue, and=
 in
> general I think this is all pretty good. The 'effective_load' thing i=
s the
> scheduler, so there's certainly some context switching going on, prob=
ably
> still due to excessive synchronization, but it's equally clear that t=
hat
> is certainly not a dominant factor.

I see the strlen in my profiles as well, but I haven't figured out
where it comes from. I get the following:

    51.16%  git-grep  /lib/tls/i686/cmov/libc-2.10.1.so
[.] 0x000000000b14c6
    10.12%  git-grep  /lib/tls/i686/cmov/libc-2.10.1.so
[.] __GI_strlen
     9.27%  git-grep  [kernel]
[k] __copy_to_user_ll
     4.68%  git-grep  /lib/tls/i686/cmov/libc-2.10.1.so
[.] __memchr
     1.72%  git-grep  [kernel]
[k] __d_lookup
     1.18%  git-grep  /lib/i686/cmov/libcrypto.so.0.9.8
[.] sha1_block_asm_data_order
     1.11%  git-grep  [kernel]
[k] __ticket_spin_lock
     0.84%  git-grep  [vdso]
[.] 0x00000000b6c422

If I use perf record -g I get

    10.39%  git-grep  /lib/tls/i686/cmov/libc-2.10.1.so
[.] __GI_strlen
                |
                |--99.05%-- look_ahead
                |          grep_buffer_1
                |          grep_buffer
                |          run
                |          start_thread
                |          __clone
                |
                |--0.64%-- grep_file
                |          grep_cache
                |          cmd_grep
                |          run_builtin
                |          handle_internal_command
                |          main
                |          __libc_start_main
                |          0x804ae81
                 --0.32%-- [...]

This doesn't make much sense to me as look_ahead doesn't call strlen
(I compiled git with -O0 to avoid any issues with inlined functions).
But I haven't used perf so much, so maybe I'm reading the output the
wrong way.

> One potentially interesting data point is that if I make NR_THREADS b=
e 16,
> performance goes down, and I get more locking overhead. So NR_THREADS=
 of 8
> works well on this machine.

Interesting. I get the best results with 8 threads as well, but I only
have two cores.

> One worry is, of course, whether all regex() implementations are
> thread-safe. Maybe there are broken libraries that have hidden global
> state in them?

That would certainly be a problem. A quick google search didn't show
any known bugs. Of course, this doesn't tell us anything about the
unknown ones.

- Fredrik
