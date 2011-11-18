From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .git ignored regardless of --git-dir value
Date: Fri, 18 Nov 2011 14:47:11 -0800
Message-ID: <7v7h2xjbf4.fsf@alter.siamese.dyndns.org>
References: <CAC2kKA_PZNDg_dPjWXKeFU4ZVpMas3PubZfSgTnfCfVPuNPdsA@mail.gmail.com>
 <7vsjlljf57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Ferris <shawn.ferris@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRXDL-00045i-SC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 23:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab1KRWrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 17:47:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab1KRWrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 17:47:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA3D6B40;
	Fri, 18 Nov 2011 17:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=whQ7Y8wQpQqyrqWq+qyd8gd5umc=; b=PrgFnU
	19KnowI7dU2pozFt9hPtVobeRlrtFoZWfxf+YAXM0yJGE/BoIlyy6TCFhbQLjanV
	QlysaM4MRVo7HrGJMHqkOP9KXE68gt/3gKvhIXYGW4M63riAHg+Bn3rtviHeoPLu
	TQ3nTxjRZfstOvl3lJt6X8+yY71zchtP4yM4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQV5r0uF197YupLoL5nUjLJt2EnhGbI5
	oODF7n+HqXPGuwE1D5gpNOtXa5SMkEGxmtZAj1bbVuERWolv5GIZRJyWnRztmN+o
	qa0R8ZsKa1qqPlvPp0ShC5Ei3VBaDHDNtfakyb7IbRSv4ECJuACar9l34CkIo8Qi
	Y3l3DBRMqHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F4D6B3E;
	Fri, 18 Nov 2011 17:47:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6F106B3C; Fri, 18 Nov 2011
 17:47:12 -0500 (EST)
In-Reply-To: <7vsjlljf57.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 18 Nov 2011 13:26:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41710ECC-1237-11E1-B103-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185683>

Junio C Hamano <gitster@pobox.com> writes:

> Shawn Ferris <shawn.ferris@gmail.com> writes:
>
>> Is it expected behavior to have the .git directory ignored, even after
>> specifying an alternate location with --git-dir? For example:
>>
>> $ git --git-dir=.foo init
>> Initialized empty Git repository in /home/sferris/work/t/.foo/
>
> GIT_DIR and --git-dir are meant to refer to a different .git dir (or a
> bare-looking repository) located elsewhere, and not for a random pathname
> like ".foo". No matter what, ".git/" anywhere is ignored from very early
> days of Git, as Linus himself writes in the source, e.g. 8695c8b (Add
> "show-files" command to show the list of managed (or non-managed) files.,
> 2005-04-11):
>
>  ...
>  * Also, we currently ignore all names starting with a dot.
>  * That likely will not change. 
>  ...

Sorry, but the above quote is wrong.  The correct one is from 453ec4b
(libify git-ls-files directory traversal, 2006-05-16), and survives to
this day in dir.c:

 ...
 * Read a directory tree. We currently ignore anything but
 * directories, regular files and symlinks. That's because git
 * doesn't handle them at all yet. Maybe that will change some
 * day.
 *
 * Also, we ignore the name ".git" (even if it is not a directory).
 * That likely will not change.
 ...

In other words, originally we ignored all names starting with a dot and
declared that likely will not change, but then loosened the rule to let
people manage their .bashrc and friends. But ".git" is still special, and
that likely will not change.
