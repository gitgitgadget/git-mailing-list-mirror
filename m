From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Sun, 24 Feb 2013 00:46:11 -0800
Message-ID: <7vvc9i5cbw.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
 <CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:47:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9XEY-00054E-9U
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 09:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab3BXIqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 03:46:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754229Ab3BXIqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 03:46:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA149041;
	Sun, 24 Feb 2013 03:46:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vgzd8hXCn13EPlhv64gGRs+v220=; b=MbtCqL
	glF43R9PcLI1Li81TmzlWClgeP2ZdMe8oCPiVkVjICesiLXXjaJKasi51qaQkucs
	DNpmOM9Sj0TlKqA9z4We1kBi50vzo8HQ/9HzLxWuWgiQE5lMiN3+EFH03coUZnrB
	pNnD/sOzZJz8R98pvsYJoBXBeDvnEEdQ55IdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kJsFK3NxTxTA3tgFP00N/ZzJtS+VV03E
	yB3IiTuGMgjRkPP+F2BeVK7G2KxPzmIHPvNTsSihx9s/APwtl+kVMa4YK+Xx79+u
	v3o+z2pwDpdRx9oCTIWrld5VsuLO1ZCRqCyQMahSIkV+NBILaBSmj6wsNBL8p59L
	Fjno2tUzhw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A08C89040;
	Sun, 24 Feb 2013 03:46:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17D51903E; Sun, 24 Feb 2013
 03:46:13 -0500 (EST)
In-Reply-To: <CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com> (Mike
 Gorchak's message of "Sun, 24 Feb 2013 09:36:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4C6B8B6-7E5E-11E2-B447-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216980>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> Hello,
>
>> Here is a small patch with QNX build improvements:
>>
>> 1) Rename tar.h to tar_git.h. Latest QNX versions have system tar.h
>> header according to
>> http://pubs.opengroup.org/onlinepubs/009696699/basedefs/tar.h.html ,
>> to avoid inclusion of another tar.h, original header was renamed.
>> 2) Rename fnmatch.h to fnmatch_gnu.h and fnmatch.c to fnmatch_gnu.c to
>> avoid inclusion of system fnmatch.h header in case if -I/usr/include
>> path is specified before -Icompat/fnmatch. Which is common situation.
>> 3) pager.c - default "less" invocation flags were changed for QNX 6,x
>> platform, since QNX has incompatible with GNU coreutils version of
>> "less" utility.
>> 4) config.mak.uname - a) do not override mkdtemp/mkstemps/strcasestr
>> detection, since newer QNX version could contain such functions. Let
>> to configure decide what is present in the system. b) getpagesize()
>> function is existing under QNX, c) QNX has pthread functions in the
>> libc, so do not define NO_PTHREAD macro.
>
> Sorry, in the previous post the patch was not inlined.

First on the form.  The message lacks a proper commit log message
and a sign-off.  Please check Documentation/SubmittingPatches and
also compare the message I am responding to with recent patch
submission messages from other people on the list.

As to the substance, I am fairly negative about the approach this
patch takes, especially the rationale it uses for #2 above.  It goes
directly against the spirit of having compat/ directory in the first
place to have -I/usr/include _before_ -Icompat/anything and that,
not the names of header files in compat/ directory, is the root
cause of the problem you are seeing, I think.
