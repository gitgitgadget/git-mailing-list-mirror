From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Tue, 25 Nov 2014 09:23:10 -0800
Message-ID: <xmqqfvd7tcsh.fsf@gitster.dls.corp.google.com>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net>
	<CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
	<CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
	<20141125012359.GR6527@google.com>
	<CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
	<20141125034730.GB19161@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtJpd-000477-N5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 18:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbaKYRXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 12:23:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750784AbaKYRXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 12:23:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 327B71EB64;
	Tue, 25 Nov 2014 12:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ube3XOZrK6bRgNFqHaU9CJl21fU=; b=oiuxQH
	8Z++EMrjCWxcvJ/mHbiCQmgJ7C4/fft2cqQqm/PL9W462ILPmFflSMsLhrth11b9
	LfteWzI9CEZyX5YxdZopO0vWZXUEh9aTt3k0dPOvtt13ut/f6xMB6//3/5Eu6qn6
	sZS1zkl7y9dq47CGqe1vRiJ4HrdnWNBYzdAbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZ9bIS8UPs4RQLhOJYskwjuj986ZkUFz
	RMOKffTo5Bk9XLKH4WVT7ZS9zp9PYWRBf70segGUvLETcOwuNNFxjNp6i7+sy7yn
	StsznjnVPK/Qfbx/UwylgTkvs4aygrd9gba2ekLbnSgKetp6gcCjAIXo+gba+rHQ
	6m3V8oyGiwk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E0D1EB63;
	Tue, 25 Nov 2014 12:23:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 943CC1EB60;
	Tue, 25 Nov 2014 12:23:11 -0500 (EST)
In-Reply-To: <20141125034730.GB19161@peff.net> (Jeff King's message of "Mon,
	24 Nov 2014 22:47:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB406E82-74C7-11E4-BAC1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260226>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 25, 2014 at 08:52:58AM +0700, Duy Nguyen wrote:
>
>> On Tue, Nov 25, 2014 at 8:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > I think the biggest obstacle is the upgrade path. ;-)
>> 
>> In the worst case we can always treat new repos as a different VCS. So
>> people will need a migration from SHA-1 to the new format, just like
>> they migrate from SVN/CVS to Git. Painful but simple.
>
> Maybe we can fix the tree-sorting order while we are at it. :)
>
> More seriously, there may come a day when we are ready to break
> compatibility completely with a new "Git v3.0" (2.0 is already taken, of
> course). I do not have immediate plans for it, but it's possible that
> multiple factors may make such a move desirable sometime in the next 10
> years, and that would be a good time to jump hash algorithms, as well.

As the fundamental data model of Git is built around "given the
object name, the same data is retrieved, and equally importantly,
given the same data, the same object name is used, so that we can
say two objects with different names record different contents
without looking at the data", it does not mesh with the use of
tagged hash where object name consists of a pair of <what hash is
used> and <what the hash value is> at all.  It is a proper mindset
to treat it as a different VCS to give us a clean break when (I did
not say "if") we need to switch hashes, I think.

Thanks.
