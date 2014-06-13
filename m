From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 10:12:56 -0700
Message-ID: <xmqq38f84tt3.fsf@gitster.dls.corp.google.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<1402615835.5629.34.camel@stross> <539A7821.906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:13:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvV2O-0006Bn-HL
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbaFMRNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 13:13:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62185 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbaFMRNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 13:13:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D6A31F0EB;
	Fri, 13 Jun 2014 13:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uSFSSlaXDMkG
	4Q9diNepynp5iv0=; b=I2LfL2gLx5q7GRyBLMY9Rj3bNiugp4Kge9rYTCj43Ygu
	X1fItfWbazqPEzCoRdRychspYza9yAKNbqLaty9ZgJKYtQs9Y/xLQVXTSLzlxEnO
	+69bME5cFYl0qJsxoxcnM4Esy8vKpkYXVbAVAGIp68kFjrejtkTEh4y77yMpJyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OS4RzQ
	leEj41fDU8lZOUTxH/iBoKtCD7KDLB70D/N4snI5zF0HXQb/ajLzfV+SrBwFi9D4
	rHKuE9YKldErRx95Q1FY1gUYwxUBTRluszbsxnNSFrHSXU635MqS+w/GY45EmrFt
	FfIxNobHfHzH6lyFU5EiKfwu2x9FH8BN4O1dg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2337F1F0EA;
	Fri, 13 Jun 2014 13:13:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E80B11F0E0;
	Fri, 13 Jun 2014 13:12:57 -0400 (EDT)
In-Reply-To: <539A7821.906@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Fri,
	13 Jun 2014 06:03:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F752E2B4-F31D-11E3-BB97-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251616>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Or try to have a functionality to always use packed refs, and have a =
configuration
> for it:
>
> The advantage can be that branch names like "Branch" and "BRANCH" can=
 live together
> in a project, regardless if you have a case sensitive or insensitve f=
ile system.

That is unfortunately *FALSE*.  You forgot about how reflogs are
stored for these branches.

> Another advantage with the "always packed refs" is that you can have =
branches
> bugfix and bugfix/next-bug side by side.

Again, you forgot about reflogs.

=46or this case I do not think it even is unfortunate.  Having two
"bugfix" and "bugfix/a" branches, if you are planning to use the
hierarchical names to group things together, does not make much
sense, and if you are not using these hierarchical names to group
things together you can always use "bugfix" vs "bugfix-a" instead.
