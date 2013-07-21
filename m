From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Sun, 21 Jul 2013 14:56:40 -0700
Message-ID: <7v7ggjshk7.fsf@alter.siamese.dyndns.org>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
	<1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
	<51EAEA76.9060502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 21 23:56:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V11cW-0000lw-8V
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab3GUV4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 17:56:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab3GUV4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 17:56:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB08E32D06;
	Sun, 21 Jul 2013 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lPIoB7fbd6XrBhjW8vZvEJglYEo=; b=mVSs6d
	71vBZGXC3ohGiLWlIH1TH6hHk67mzrY5OwDSk5Nm4lo2XCSbraZj14r1lDuOO9iU
	dSCVSYtRC13imCJsCIAaF16vmD5aGPOOdht8XFLvjnBdLXCcJNuvveIf6vLOFRs5
	iOpya7UWkri+8Ioz0hu4of3d4AiC2CxsWiNK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwU9VdNGnPT0dSwWMtKG8ZZu9SM1NCOq
	8IuUPg811PbWnPLdrLzHFiTZWxtGJWNgNHd5gaRBYhcq4QK3APjrTnwefr3uUdWM
	XTj/MHM/fdKAu0Rrp0GX93K+Pm2TACKpmbAK3EArJOXkGMxECmvsocgK+puIRDIE
	CEqYL+zB4+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0FDE32D05;
	Sun, 21 Jul 2013 21:56:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3743732D04;
	Sun, 21 Jul 2013 21:56:42 +0000 (UTC)
In-Reply-To: <51EAEA76.9060502@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 20 Jul 2013 20:52:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D76E582-F250-11E2-BBB4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230945>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Mark Levedahl wrote:
>> The supported Cygwin distribution on supported Windows versions provides
>> complete support for POSIX filemodes, so enable this by default.
>> ...
>> Historical notes: Cygwin version 1.7 supports Windows-XP and newer, thus 
>> dropped support for all OS variants that lack NTFS and/or ...
>> ...  Thus, POSIX filemode support 
>> could not be expected by default on a Cygwin 1.5 installation, but is 
>> expected by default on a 1.7 installation.
>> 
> Again, I have to ask; should you not "revert" commit c869753e ("Force core.filemode
> to false on Cygwin.", 30-12-2006)?  After this commit, there is no longer any user
> of the NO_TRUSTABLE_FILEMODE build variable, and no real prospect of anyone else
> wanting to use it.

Thanks for raising this point.

Reading c869753e once again:

    The issue is that Cygwin and NTFS correctly supports the
    executable mode bit, and Git properly detected that, but most
    native Windows applications tend to create files such that
    Cygwin sees the executable bit set when it probably shouldn't
    be.

In other words, the reason why "NO_TRUSTABLE_FILEMODE" was added was
not because the Cygwin did not give us reliable filemodes.  It was
because tools outside the control of Git and/or Cygwin that users
use tend to misbehave, even when the working tree is on a filesystem
on which Cygwin can give us trustable filemodes.

So "1.7 always supports core.filemodes correctly because it no
longer works on filesystems without trustable filemodes" is not a
valid reason to justify Mark's change.

There are only three possible ways going forward, I think:

 (A) Drop Mark's patch, and do nothing else, because breakages of
     other people's programs are not fixed by Cygwin 1.7's improved
     filesystem support, and users still use those mode breaking
     programs written by others;

 (B) Drop Mark's patch, and revert c869753e, because it is not the
     business of our project to sweep breakages of other people's
     tools under the rug by crippling our software; or

 (C) Drop NO_TRUSTABLE_FILEMODE for _all_ versions of Cygwin,
     declaring that the spirit of c869753e to work around bugs in
     other people's software by crippling Git is justified, but that
     it is no longer necessary on Cygwin because people do not use
     such misbehaving third-party tools anymore.

These three each rely on its own precondition; I suspect it is
likely that (A)'s is the most accurate description of the real world.
