From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Tue, 03 Nov 2009 00:09:27 -0800
Message-ID: <7veiogt4g8.fsf@alter.siamese.dyndns.org>
References: <4AE74408.7080103@ramsay1.demon.co.uk>
 <4AEFD9E2.6060004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 03 09:09:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ESa-0003EG-Km
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 09:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbZKCIJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 03:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZKCIJh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 03:09:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZKCIJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 03:09:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB1FD90249;
	Tue,  3 Nov 2009 03:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0SHBNbRSz9esMY7X+7gsw2H3YQ=; b=yRK0ZN
	9518hB/cmJJbWRjyqLz0vZWaLxiYoQCDUCNaeRd8lgkWZahB0W0iccKp4F4gN0NY
	3db/XSCFQWufmZY4CQ77apEj1RQKiyEIYRvN2A9ifyTZ6epKVn1WPAI+nNPJd7Z8
	5XS3+jVB6MafxbW/vSiC7HORj6ReB39XN6SP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hjqs/EwB/vLrI6jfWV868iTyLaZqrz7W
	goy2BG3nxRK4G4aOJBQaHdsODKQnfmO+HLogJ4pZB8VCxBnT8bVtcKIWyPPpMi8d
	Hd3vz2K8QmK24op3Xrq2LJZg0dt4gPRIbZy10eOCe5UeejSdfMIj8v5XLSl3CYQ/
	6T5IJ6Sro10=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8595090248;
	Tue,  3 Nov 2009 03:09:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D88C590247; Tue,  3 Nov 2009
 03:09:29 -0500 (EST)
In-Reply-To: <4AEFD9E2.6060004@viscovery.net> (Johannes Sixt's message of
 "Tue\, 03 Nov 2009 08\:21\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 397BE0EE-C850-11DE-A034-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131954>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ramsay Jones schrieb:
>> When the NO_MMAP build variable is set, which is the case by
>> default on cygwin, the msvc linker complains:
>> 
>>     error LNK2001: unresolved external symbol _getpagesize
>
> Make up your mind: use the cygwin configuration or use the MSVC
> configuration. MSVC doesn't define NO_MMAP for a reason. Where is the problem?
>
> I understand that you run into this error if you define NO_MMAP in your
> config.mak. I don't know whether we support NO_MMAP as a knob for to tweak
> the builds on all platforms. If this is the case (Junio?), then your
> justification must be updated.

I don't _mind_ per-se if platform people add good support for building
with both using and not using mmap(), even though I do not see a strong
need for supporting NO_MMAP configuration, on a platform with a working
good-quality mmap(), either emulation or native.

How does Cygwin-ness of the build environment affect the end result when
you build with MSVC?  I am not a Windows person, so I am only guessing,
but I suspect that the result does not pull any library nor crt0 from what
people usually consider "Cygwin environment".  It feels that the "default
configuration of Cygwin" that insists on NO_MMAP is the guilty party here.

The logic to set NO_MMAP on Cygwin obviously predates MSVC support, so it
probably was perfectly sane to say "We are compiling on Cygwin, and by
definition we use gcc to compile, link with the Cygwin libraries, and
mmap() support there is weak and we are better off with NO_MMAP from
performance (or correctness) standpoint".

If we are supporting use of MSVC as compiler toolchain on Cygwin, that
statement may no longer be true [*1*].

Shouldn't this be solved by teaching the Makefile about this new "Cygwin
but using MSVC as compiler toolchain" combination?  "Even on Cygwin, if we
are using MSVC, here are the compat layers we want to use and here are
what the underlying C library and POSIX emulation layer gives us."

So it really boils down to this question.  Is there _anything_ in the end
result that should be affected by Cygwin-ness of the build environment
when you build with MSVC?

Here are what I see in the Cygwin section:

        NO_D_TYPE_IN_DIRENT = YesPlease
        NO_D_INO_IN_DIRENT = YesPlease
        NO_STRCASESTR = YesPlease
        NO_MEMMEM = YesPlease
        NO_MKSTEMPS = YesPlease
        NO_SYMLINK_HEAD = YesPlease
        NEEDS_LIBICONV = YesPlease
        NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
        NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
        OLD_ICONV = UnfortunatelyYes
        NO_MMAP = YesPlease
        NO_IPV6 = YesPlease

These all look very much like they depend on the way how C runtime library
and the POSIX emulation layer are set up.  Perhaps these should be used
only when compiling with gcc and linking with glibc on Cygwin (which is
the norm)?


[Footnote]

*1* Notice "if" at the beginning of this sentence---I am not qualified to
make a judgement without help from area experts here.  Is it a sane thing
to run Cygwin and still use MSVC as the compiler toolchain?  Is it
commonly done?  I have no idea.
