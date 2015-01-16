From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proper plumbing for porcelain gpg formats on git show?
Date: Fri, 16 Jan 2015 11:52:50 -0800
Message-ID: <xmqqk30m1p0t.fsf@gitster.dls.corp.google.com>
References: <EB979B4B153D49909C78239A333869FB@black>
	<20150116192947.GD29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCwz-0008Ns-GK
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbbAPTwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:52:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752989AbbAPTww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:52:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E68F630D97;
	Fri, 16 Jan 2015 14:52:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NlTRNfsDfEdy2OzTATIO3ESCbss=; b=MevGfv
	r8T8Qxof1cBkWET9vfOGRem5FB7FN7hOSckkYxjKAnN2xr8bNWcAlwM7xkQEAlPX
	qGF0SzLcX1ebST5U1WgSZvAXDplgi4hKQ4J7eNnxUhmn1JNfSxjTAGeXGc4fCaS/
	dA98klvZBZBKxr3WF+hThAXvRsUa/Qs1ZQsEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t9BancD0PLZ/jQV45oEzmQ8V6sQRR+rx
	6GSDzOV0BrVpllLvUE6CZuuQXyFob0EYAMbSsZ2goep2VUovkOh0WK5zLi4xUIpv
	tGIpueAPb2xVhEgty2uoFcFghxGleK/n3jbuuUL/EjYZJ6H28TcGr+wpidJ2SSOM
	mQlBA4a84dM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB08230D96;
	Fri, 16 Jan 2015 14:52:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F9BA30D95;
	Fri, 16 Jan 2015 14:52:51 -0500 (EST)
In-Reply-To: <20150116192947.GD29365@google.com> (Jonathan Nieder's message of
	"Fri, 16 Jan 2015 11:29:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 410FF3BA-9DB9-11E4-88B3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262568>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> would there be interest in accepting a patch for 
>>
>> %Gs - the raw GPG text from the commit
>> %Gf - the key fingerprint
>
> There may be bikeshedding on the exact format specifier, but aside
> from that I don't see why not. ;-)

I was about to say "As long as the execution is good, why not?
Spawning an extra process 'gpg --list-packets' is not quite
acceptable without properly being lazy is not acceptable".

But verify_signed_buffer() reads "gpg --status-fd=1 --verify"
output, it is already done lazily in format_commit_one() only when
the "%G?" placeholder is used, and the output we parse that are
prefixed by [GNUPG:] should have enough information to grab the
fingerprint from on the VALIDSIG line.

So I do not see a lot of room to screw-up the execution ;-).
