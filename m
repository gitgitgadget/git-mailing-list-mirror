From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 05 Feb 2010 14:31:44 -0800
Message-ID: <7vsk9fwbzj.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vaavo90ic.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com>
 <201002051136.43738.johan@herland.net>
 <7veikzfysv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:32:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdWic-0006Bp-4R
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 23:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933935Ab0BEWb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 17:31:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933852Ab0BEWb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 17:31:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F12997EEF;
	Fri,  5 Feb 2010 17:31:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nHujHwBW8uQW/vLAinvZEqnTuPg=; b=kDz0HI
	Wim8vitLquya42IH8lK0YYL/CaoZJAR+O1OtchFM9K5lPUTCjn0bg3jcD5XQOYX8
	kxOC48jTnNJPRTaFhjRUsnPoBPZC6DKaMJZudSU4XtpApJUGg+izksirNHJiee+a
	/rgHjZsFcf+1Tg/gjvnWPbj7+SbzxBoWx9orY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I2nvO+FfblA1el72nuuBhsgLV8r0Hg/A
	zUorXSO6mEp7zfGZLxOvzP2U8ut/UIVb1Ap9/hWUttJtHDfxrSTYck0H9W+GMjdc
	fWtHMonZ7R0Lx8YXOMN7aLE4EakdQYrp/4Rsd2R9Pmv3w29B14Pwz3j8ZKIU7gq/
	VSIipSSsVtA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 212B997EE9;
	Fri,  5 Feb 2010 17:31:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 078D997EE3; Fri,  5 Feb
 2010 17:31:45 -0500 (EST)
In-Reply-To: <7veikzfysv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 05 Feb 2010 08\:10\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41BAB532-12A6-11DF-B192-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139102>

Junio C Hamano <gitster@pobox.com> writes:

> * "log --format=%N" and "log --show-notes"
> 
> Currently %N expands to the hardcoded "log --show-notes" default format.
> We can probably keep it that way.  When the user asked for a non default
> notes hierarchy (i.e. other than refs/notes/commits), we may want to
> adjust "Notes:" string to use "Notes-%s:" to show which hierarchy it came
> from, and concatenate them together.
>
> For "log --show-notes" output, we also might want to move the notes to the
> header part like I illustrated above in format-patch output, instead of
> "start with unindented Notes: and indented body at the end".  I.e. instead
> of showing this:

Giuseppe was wondering about multi-line thing, so the illustration should
be adjusted to match the "format-patch" example to show a multi-line note,
I think.  Here is what I meant.

Instead of showing:

    $ git log --notes-ref=amlog -1 4d0cc22
    commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Thu Feb 4 11:10:44 2010 -0800

        fast-import: count --max-pack-size in bytes

        Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
        ...

    Notes:
        pulled on Fri Feb 5 07:36:12 2010 -0800
        from git://git.bogomips.org/git-svn.git/
    Notes-amlog:
        <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>

which is what 1.6.6 added, showing it like this:

    $ git log --notes-ref=amlog -1 4d0cc22
    commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Thu Feb 4 11:10:44 2010 -0800
    Notes: pulled on Fri Feb 5 07:36:12 2010 -0800
     from git://git.bogomips.org/git-svn.git/
    Notes-amlog: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>

        fast-import: count --max-pack-size in bytes

        Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
        ...

might be easier to see.  After all, notes are metainformation on commits,
and people who are interested will look at the header, and those who are
not will skim over the block of text at the beginning, knowing that is
where all the metainformation is.

But this is just "might", not "should---I strongly believe".
