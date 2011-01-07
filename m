From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why don't git-init and git-clone probe for core.ignorecase on
 Windows > XP?
Date: Fri, 07 Jan 2011 12:18:28 -0800
Message-ID: <7voc7s5uy3.fsf@alter.siamese.dyndns.org>
References: <AANLkTimqgCsmC96fkWQJ0yB+FuyC6Xkgn3UAfZrqMqK_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIlq-00051U-NA
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1AGUSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:18:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab1AGUSg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:18:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 381C33A0D;
	Fri,  7 Jan 2011 15:19:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IttBYUmnyYqHlkAmcQVG9Q/Gtss=; b=K/FEVn
	p2Shm+3hM+kJjcVScpIdcZWGkgySbhZ4v7bTzAgzrfaQNU7+WiSrrrOK3zbq6fCI
	tb5OsS4CT9++HJVHhXDIRxK6UGtDuQMEWwnH+5RgBWVj2SoiJexzGOuK+J8j8yqz
	z811mI+wG2SoAnl3IDNKu3tXQQ2HJGRPQNhHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XR8XWJnmzc8nM06ngDS4SdXjJkPlN1yL
	c/FblL6FKmsdqW59Kyx4cfHdtaTkWeUye3DNDwm8DelhIj52Zz+rR6hSvJ3sQr4u
	gSbxgJDZ0Tap638DU0ZLEc9Na26XYvBwl0gXb20Q2bO2JvROU2lW3F6EwDFz3MEL
	jvTepbzfCWk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15D5F3A0B;
	Fri,  7 Jan 2011 15:19:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 268C03A0A; Fri,  7 Jan 2011
 15:19:08 -0500 (EST)
In-Reply-To: <AANLkTimqgCsmC96fkWQJ0yB+FuyC6Xkgn3UAfZrqMqK_@mail.gmail.com>
 (Dun Peal's message of "Fri\, 7 Jan 2011 12\:34\:35 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63F7009E-1A9B-11E0-A700-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164754>

Dun Peal <dunpealer@gmail.com> writes:

> The git-config manpage says about core.ignorecase:
>
> "The default is false, except git-clone(1) or git-init(1) will probe
> and set core.ignorecase true if appropriate when the repository is
> created."
>
> I assume this is happening when you clone or init on FAT, which is
> explicitly mentioned earlier in that section. But apparently it
> doesn't happen for either XP, Vista or 7. While those newer releases
> use NTFS, which technically supports case-sensitivity, the operating
> itself still apparently doesn't, so it would seem like git-clone and
> git-init should probe regarding the core.ignorecase on any version of
> Windows, no?

Sorry, but it is unclear if you are complaining that core.ignorecase is
set (but you believe it shouldn't be) or it is not set (but you believe it
should be) on NTFS from the description.

As far as I can tell from the code (I obviously only look at the plain
vanilla git, and msysgit might have some patch to this part, I dunno.  Oh
by the way you didn't say which version you are complaining about,
either), we do the probing on all systems (including POSIX folks with FAT
filesystem mounted) by first creating .git/config and then checking if a
file .git/CoNfIg which we know we never created can be accessed.  If we
can, that means the filesystem ignores case, iow, we cannot have two files
config and CoNfIg at the same time, and set core.ignorecase to true.
