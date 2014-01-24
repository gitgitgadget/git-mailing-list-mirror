From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] cherry-pick, revert: add the --gpg-sign option
Date: Fri, 24 Jan 2014 14:45:41 -0800
Message-ID: <xmqqa9elq9re.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-2-git-send-email-sandals@crustytoothpaste.net>
	<xmqqiot9qend.fsf@gitster.dls.corp.google.com>
	<20140124210836.GA58260@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 23:46:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6pVx-0007tT-G8
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 23:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbaAXWpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 17:45:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbaAXWpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 17:45:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D97B65CC7;
	Fri, 24 Jan 2014 17:45:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WJvQoslmXMayMDxdqM7kH+KM+6s=; b=eZPGOA
	lt1lm6lAF8GzVMU0CWVItdovUZqafCMLQAy+axEHvODxwO+axFdxKZWTNpEsqLK0
	F1Xsyi8IJ2GBu0vIn1K2vNmTu8+km6PiMJGYQmypIfrxSB89yhxkXQxAI0fEzZ8x
	mLkxGYXolpkwNuRtP9sBLut9C+2G1D9T3bWlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uiziz8xxy6Hi1VkGObLIgvTCkUvPBRD5
	4kse38w7al/IGTjXb5T5qo++o5yAOVbXVuEZhB2G9H33txxGTNHQWGyy2IphVJrb
	MKAUudFK/yShTGjcCp4nYvUkZYyikW/0mjrnCKj8wcM2h6sRMboJ8gzjTiS06v7E
	p9u94kVldWo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E269165CC6;
	Fri, 24 Jan 2014 17:45:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 269C765CC4;
	Fri, 24 Jan 2014 17:45:45 -0500 (EST)
In-Reply-To: <20140124210836.GA58260@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 24 Jan 2014 21:08:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42D6063C-8549-11E3-A33A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241049>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Jan 24, 2014 at 01:00:06PM -0800, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > +-S[<keyid>]::
>> > +--gpg-sign[=<keyid>]::
>> > +	GPG-sign commits.
>> > +
>> 
>> Does this accept --no-gpg-sign?  If not, shouldn't it?
>
> It does not.  I took Nicolas's patches from the list and applied them to
> master, so nothing from next is there, including the commit.gpgsign
> stuff.
>
> Would you prefer I rebased them on next instead?

Not really.

It is debatable if it should mean that the user wants to sign
commits that are created by running other commands like "am" and
"stash" when he sets commit.gpgsign to true, but even if the answer
to that question were true, the configuration must be overridable
with e.g. "git stash --no-gpg-sign", explicitly from the command
line.  Until that happens, the series with 2af2ef3c (Add the
commit.gpgsign option to sign all commits, 2013-11-05) cannot be
merged to 'master'.

A series that lets you specify positives from the command line
without any sticky configuration variable, i.e. these patches, do
not have to wait for that to happen.  So this series should come
first and then the "commit.gpgsign" ones can be rebased on top of
this series, I would think.
