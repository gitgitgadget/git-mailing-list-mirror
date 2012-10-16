From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/4v2] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 12:34:08 -0700
Message-ID: <7v8vb6rz2n.fsf@alter.siamese.dyndns.org>
References: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
 <28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net> <507DB39C.3080005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Joachim Schmitz <jojo@schmitz-digital.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOCuL-0001FN-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 21:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048Ab2JPTeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 15:34:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367Ab2JPTeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 15:34:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7719B75;
	Tue, 16 Oct 2012 15:34:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hBCTFUB5L7M48ttIkYynmkNqscE=; b=B4KMjA
	tHKdW/jX8SVo1Cjte7MsAGxehC559QAJbzBZRntdpsri+as+snYtf44SKpQzXXBx
	IVXp5wpXYzMjefaZT9rJsqtAQMZHi0JFOoO6B7vXQ/0UrrO3jEbqM/ElVjN+VUI2
	k3oX0WjlBQXM5betLhWaK9xTNjc0MNsa2bxG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjEplYqMdXQFpnNRKyjScnBCvDk1ka73
	+k22Rc2eu3cU9Ag6M+SAcmj/4GSVls+nz2WMgiVZcR0/647NZf014zVz6qHcGNpS
	TY4M43wDjQloAUPedcTWl6qSiGJnvRMMZlrttGNNHLl8puNAnM6kvDGebY4qMCvO
	pJR0Eu8gDTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CB579B74;
	Tue, 16 Oct 2012 15:34:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 694F59B70; Tue, 16 Oct 2012
 15:34:10 -0400 (EDT)
In-Reply-To: <507DB39C.3080005@kdbg.org> (Johannes Sixt's message of "Tue, 16
 Oct 2012 21:21:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 755C1654-17C8-11E2-B7E6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207875>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.10.2012 17:07, schrieb Michael J Gruber:
>> Some test want to use the time command (not the shell builtin) and test
>> for its availability at /usr/bin/time.
>> 
>> Provide a lazy prereq TIME_COMMAND which tests for $TEST_COMMAND_PATH,
>> which can be set from config.mak. It defaults to /usr/bin/time.
>
> This avoids the builtin:
>
> 	command time $that_command
>
> It works for bash, ksh, zsh, and dash (where the latter doesn't have it
> as builtin).

"command time" works but I think that is because it is not a
built-in ;-)

Here is what I read in bash(1):

       command [-pVv] command [arg ...]  Run command with args
              suppressing the normal shell function lookup. Only
              builtin commands or commands found in the PATH are
              executed.

Taken together with this from "COMMAND EXECUTION":

       If the command name contains no slashes, the shell attempts
       to locate it.  If there exists a shell function by that name,
       that function is invoked as described above in FUNCTIONS.  If
       the name does not match a function, the shell searches for it
       in the list of shell builtins.  If a match is found, that
       builtin is invoked.

       If the name is neither a shell function nor a builtin, and
       contains no slashes, bash searches each element of the PATH
       for a directory containing an executable file by that name.

I suspect "command printf 'a b c\n'" would not use $HOME/bin/printf
even when I have $HOME/bin early in my $PATH (nor /usr/bin/printf
for that matter).
