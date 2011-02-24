From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 09:27:29 -0800
Message-ID: <7v7hcp2vi6.fsf@alter.siamese.dyndns.org>
References: <20110224112246.3f811ac2@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 18:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pseyc-0005KU-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 18:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab1BXR1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 12:27:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab1BXR1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 12:27:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A43BB3AAE;
	Thu, 24 Feb 2011 12:28:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sKd7EmOiBijv7CbAVLnr87DHTqE=; b=Nmz9LN
	qFecGW/cL8Z/6b+DiVSY/ocCJs2vXSn+DNY6OQCJ8RMfG5m9HSZCq/Bk1mcjsWJW
	XIOvjY8B/MuyJBDewIPApoxulM8Ngc/YEfmrIFFJ6Zt6U9qKY2HbtCdxRN4qbrur
	o/rFRNS9HpcSeh8Z22c+8Q4lSN/QvGF7BAdFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OnizBGYmkqlSUY/7ZiXloIoVleceALzY
	BEohQUOOYy08TLzlj7OfmMUJ9l/aKWx9wyecWZi7XxB/bWPvkyiMiKtiVj0HbSkn
	3fSZF+xFKxkeAhq++nPM1xdezPXWcLkRQKyCqzc/elF2KV5JnkUVqZilY+g3SgWu
	QJFNxTK4XNM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F0843AAD;
	Thu, 24 Feb 2011 12:28:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9320F3AAC; Thu, 24 Feb 2011
 12:28:45 -0500 (EST)
In-Reply-To: <20110224112246.3f811ac2@glyph> (Marco's message of "Thu\, 24
 Feb 2011 11\:22\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A11F890-403B-11E0-95F5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167840>

Marco <netuse@lavabit.com> writes:

> I'm new to git and a bit confused about how some commands work.
>
> git add .                    -- Adds everything *but* deleted files
> git add -A                   -- Adds everything
> git commit -a -m "whatever"  -- Commits everything *but* new files
>
> I don't understand why there's not switch (is there?) for commit to commit new
> and deleted files, like -A for git add?

Historical accident.  In the early days of git, there was no .gitignore
mechanism, so a mode that operates on everything under the working tree
was almost always an undesired thing to have (think *.o files).

Then .gitignore mechanism came, and "add ." has become usable.  But
"commit -a" has been widely used way before that.

If you look at "commit -a" within that context, you would understand why
it should only look at the paths git knows about.

Of course, "add -A" is a much later invention.  The option was named "-A"
with capital letter, even though there is no "add -a".

This was because I knew we would eventually want to have "commit -A" that
grabs everything and new files (honoring the gitignore mechanism), and
aimed for consistency between "add -A" that I was adding, and "commit -A"
that was yet to be written.  See 3ba1f11 (git-add --all: add all files,
2008-07-19).

I think it now is sensible to add "commit -A" if somebody is inclined to
do so.  Nobody felt the need for it strongly enough to do so, it seems.
