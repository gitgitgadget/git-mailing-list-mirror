From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Sun, 19 Aug 2012 18:20:23 -0700
Message-ID: <7v393inyug.fsf@alter.siamese.dyndns.org>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
 <20120802104421.GA13271@dcvr.yhbt.net> <5021F9D4.1010700@debian.org>
 <20120808230754.GB24956@dcvr.yhbt.net>
 <7v1ujgot8h.fsf@alter.siamese.dyndns.org>
 <20120810195133.GA16423@dcvr.yhbt.net> <50316C07.30907@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 03:21:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Gg0-0007yp-PW
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 03:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab2HTBU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 21:20:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2HTBU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 21:20:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C05E99E3;
	Sun, 19 Aug 2012 21:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=caSfcoyqjL/Eh/Ikfiikg6ByJbA=; b=mqx6FN
	8JcvO0sjeaTGD6HCs8yt4cZQJ6CjNmVmS8F1DecSfKVdiGahSdHWytDH4iIOqOWG
	aFgAkf6lw1K1l3Pez7sgx4OFU3i2vmyuMQzC2KnEkgUu7JYu9dK5YSQO7epE/5eZ
	rjFaPwueNM8WplE7AGEtvIBmBi8AooNWR2p0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5xA/VC0oBa8U9eDiKYNu0WW8JkyDP7Y
	hXfe6QxohCR4RO9aaTRFBpc9X6VuRMaE+EB2z5R6cyQEkRrvjqzeEzKeT/tTT1Ui
	YwcYI3Zl5SRSpcRy+VLV9DIXGU1Ya1NdgLAwaFTGAyGEMzcnQcXcWSe/Z65CbE6W
	SzytDFHkifk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE3FD99E2;
	Sun, 19 Aug 2012 21:20:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A64099E1; Sun, 19 Aug 2012
 21:20:25 -0400 (EDT)
In-Reply-To: <50316C07.30907@debian.org> (Robert Luberda's message of "Mon,
 20 Aug 2012 00:43:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3826717A-EA65-11E1-AAFE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203749>

Robert Luberda <robert@debian.org> writes:

> Eric Wong wrote:
>
> Hi,
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> I should have asked this yesterday, but do you mean you want to have
>>> your "maint" in the upcoming 1.7.12?  This does look like a useful
>>> thing to do, but does not seem like a regression fix to me.
>> 
>> Yeah, I wasn't sure what to name it since my master is still carrying
>> Michael's larger SVN 1.7 changes.   Perhaps I should've named my "maint"
>> "for-git-master" in this case...
>
>
> While working on my next patch, I've accidentally discovered that bash gives
> the following errors in the test file introduced in my commit :
>
> ./t9164-git-svn-dcommit-concrrent.sh: line 65: $hook: ambiguous redirect
> ./t9164-git-svn-dcommit-concrrent.sh: line 66: $hook: ambiguous redirect

Thanks.  It is this one (especially the latter half "Note that")
in the Documentation/CodingGuidelines.

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.  Note that
   even though it is not required by POSIX to double-quote the
   redirection target in a variable (as shown above), our code does so
   because some versions of bash issue a warning without the quotes.
