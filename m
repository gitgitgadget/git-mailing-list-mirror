From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 17 Nov 2008 08:41:44 -0800
Message-ID: <7vskpqwbhz.fsf@gitster.siamese.dyndns.org>
References: <200811121029.34841.thomas@koch.ro>
 <20081112173651.GA9127@linode.davidb.org>
 <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
 <loom.20081113T174625-994@post.gmane.org>
 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org> <7vtza95h01.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 17:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L27EX-0003xj-M4
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 17:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbYKQQoi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2008 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbYKQQoi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 11:44:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbYKQQoh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 11:44:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EEE1B7F1C6;
	Mon, 17 Nov 2008 11:44:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4AE07F185; Mon,
 17 Nov 2008 11:41:51 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sat, 15 Nov 2008 09:15:52 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0531D2D2-B4C7-11DD-AD75-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101231>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>
>> This introduces make variable NO_PTHREADS for platforms that lack th=
e
>> support for pthreads library or people who do not want to use it for
>> whatever reason.  When defined, it makes the multi-threaded index
>> preloading into a no-op, and also disables threaded delta searching =
by
>> pack-objects.
>
> Ack. Makes sense.

Hmm, I started getting random segfaults that sometimes reproduce.  For
example, this is what I just got from "git diff --stat $some_commit".

#0  0x00002b952568b090 in strlen () from /lib/libc.so.6
#1  0x000000000044ed42 in git_checkattr (path=3D0x2b95284b3970 "parse-o=
ptions.c",
    num=3D3, check=3D0x41000e90) at attr.c:512
#2  0x0000000000458921 in convert_to_git (
    path=3D0x2b95284b3970 "parse-options.c",
    src=3D0x2aaaaaabb000 <Address 0x2aaaaaabb000 out of bounds>, len=3D=
12594,
    dst=3D0x41000f30, checksafe=3DSAFE_CRLF_FALSE) at convert.c:578
#3  0x0000000000489ac3 in index_mem (
    sha1=3D0x41000ff0 "\210f=EF=BF=BD=E2=BD=A1x=EF=BF=BD\207=EF=BF=BD=EF=
=BF=BD 7R}\217\032=EF=BF=BD=EF=BF=BD", buf=3D0x2aaaaaabb000,
    size=3D12594, write_object=3D0, type=3D<value optimized out>,
    path=3D0x2f2f2f2f2f2f2f2f <Address 0x2f2f2f2f2f2f2f2f out of bounds=
>)
    at sha1_file.c:2451
#4  0x0000000000489c3d in index_fd (
    sha1=3D0x41000ff0 "\210f=EF=BF=BD=E2=BD=A1x=EF=BF=BD\207=EF=BF=BD=EF=
=BF=BD 7R}\217\032=EF=BF=BD=EF=BF=BD", fd=3D5,
    st=3D<value optimized out>, write_object=3D0, type=3DOBJ_BLOB,
    path=3D0x2b95284b3970 "parse-options.c") at sha1_file.c:2483
#5  0x000000000047857a in ce_modified_check_fs (ce=3D0x2b95284b3930,
    st=3D0x41001080) at read-cache.c:92
#6  0x00000000004786a2 in ie_match_stat (istate=3D0x71c860, ce=3D0x2b95=
284b3930,
    st=3D0x41001080, options=3D<value optimized out>) at read-cache.c:2=
82
#7  0x0000000000497e65 in preload_thread (_data=3D<value optimized out>=
)
    at preload-index.c:46
#8  0x00002b9525964017 in start_thread () from /lib/libpthread.so.0
#9  0x00002b95256da5bd in clone () from /lib/libc.so.6
#10 0x0000000000000000 in ?? ()

Unfortunately, I do not have time to debug this right now (I will be on=
 a
14-hour flight in a few hours).
