From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filtering out mode-change-only changes
Date: Wed, 29 Feb 2012 11:52:13 -0800
Message-ID: <7vsjhts9hu.fsf@alter.siamese.dyndns.org>
References: <jik2le$2lb$1@dough.gmane.org>
 <7vmx82wbmr.fsf@alter.siamese.dyndns.org>
 <7vipiqwb2g.fsf@alter.siamese.dyndns.org> <4F4E7847.9030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2pZW-0003UY-CW
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab2B2TwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 14:52:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab2B2TwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 14:52:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57F3A7708;
	Wed, 29 Feb 2012 14:52:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VkACNWyvR071HKnSFc+D/9SeDSU=; b=i78BBV
	pYjf+3uh+0WPwrts7Ubn4c/2IpojqQKnAVKif9hySg7ZNDoSM7ILktA86zCA8Jfc
	D3C65hfN6wWkKrq6mRJgsT1KW6Gbdzrso6tjj3QPQolweXBMbSfXXBskiebXEZoy
	6U7eOCOY6XcxgbgEapkfaRruZxcvbPvZNMDTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VbSh6p5EAXO3slK28wDOME8m9thpr6BN
	VNxlZZURPT/NsJIfEgXs1Ynhxf1mwMBFRKqJc4sVYkaQ56To9WGLJGMBg6uOhOtE
	i8bQxMQOqcef3JLtLhZ03DcdBv6fj6euwqm0J8lwUbnzprP7VJrDVbzn9m1NOLeE
	FVWGiLcsT64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ECCD7707;
	Wed, 29 Feb 2012 14:52:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C980D7704; Wed, 29 Feb 2012
 14:52:14 -0500 (EST)
In-Reply-To: <4F4E7847.9030402@gmail.com> (Neal Kreitzinger's message of
 "Wed, 29 Feb 2012 13:11:03 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0B34C70-630E-11E1-ADC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191849>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> A3-2: (Some Desired Options)
> --name-status learns a new status for file-mode-only changes (ie, "P"
> for "P"ermissions).

After reading everything above I omitted from your response in my quote, I
still do not get the feeling that these willy-nilly mode changes that you
are suffering from is a problem that is general enough to warrant such a
change, even if such a change is done as an optional feature.

Calling our executable bits "Permission" is a misnomer, by the way. It is
more about "is this an executable file?" attribute, and is not "are you
allowed to execute this?" permission.

> --raw learns "P+x" and "P-x" in the status column to tell you if the
> executable bit was added or removed.

As --raw output by definition is designed to be read by scripts that can
and do parse its output, I do not see how this can be a useful addition at
all. The same information is available in the separate mode column already.

> I wonder if filemode tracking was somewhat of an afterthought of the
> content-is-king design of git and that is why it is semi-opaque.

Our blobs represent contents.  Whether your shell script has or does not
have executable bits, the file has the same contents.

The executable-ness of a particular file starts to matter only when you
extract it to your working tree.  The executable-ness matters equally as
its contents, and as the path at which it is extracted.  All three are
recorded in an entry in a tree object and in an entry in the index, as a
<mode, object name, path> tuple.

At the end-user level, you seldom use the blob contents (identified by the
object name in the three tuple explained above) alone without the
surrounding context (the other two members of the three tuple) the blob
appears in.  Especially in "diff", you not only want to view the content
change, but also need to know the change of the context in which the blobs
appear in.  And that is why we show "This content, or a related old
version of it, appeared at this old path, but now it appears at this new
path with the following change, and it lost the executable bit during the
change."

I do see nothing afterthought about the design at the storage or at the
presentation level.
