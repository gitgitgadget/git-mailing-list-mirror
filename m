From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] UTF8 BOM follow-up
Date: Mon, 20 Apr 2015 14:50:08 -0700
Message-ID: <xmqqegnejwq7.fsf@gitster.dls.corp.google.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
	<1429209548-32297-1-git-send-email-gitster@pobox.com>
	<55318CE2.1000706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkJab-0000dN-IH
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 23:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbbDTVuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 17:50:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751745AbbDTVuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 17:50:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA9B14A0CA;
	Mon, 20 Apr 2015 17:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEvJ7u65vyRcZSDLntxFECyjUGg=; b=cwFZbD
	0Qj1zq4x+tGdqTc6YSVTSSABbZoJCmh9kZmUlz34NLTZPJ90/GrMW5Hv4DdgJJBj
	O0YTFxwpCIFnd6io/4Kt67yU+RTz1/sYoGkK4/mhoRX2h0j9wrHWOPkknVvAIyJa
	+DKyB47fJFK7wArgXaQmFDtc4TIxARJm4IiX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G15kj++SnWME751tc8qhFHvL7BC4pXKA
	b/hQ2mtQoS0amgitabzH+5vvF/r824yYKcMs5HnMjxXJMBiki7YveQAp9PihCki6
	kn+11BqMfrK5v1mNMvXky2PX93RkECckA2Bagv3xG/ybk1rVbbA7v3641jTLNKX7
	GWsxwgsFj+A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D37714A0C8;
	Mon, 20 Apr 2015 17:50:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 535BE4A0C7;
	Mon, 20 Apr 2015 17:50:09 -0400 (EDT)
In-Reply-To: <55318CE2.1000706@gmail.com> (Karsten Blees's message of "Sat, 18
	Apr 2015 00:44:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36D697A4-E7A7-11E4-9D9F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267503>

Karsten Blees <karsten.blees@gmail.com> writes:

> Wouldn't it be better to just strip the BOM on commit, e.g. via a
> clean filter or pre-commit hook (as suggested in [1])?

The users can do whatever they want and if they think having a BOM
in these files is a bad idea, I'd encourage them to use whatever
means to ensure that.  The code and history hygiene is a good thing.

But you should realize that $HOME/.gitconfig, $GIT_DIR/info/exclude,
$GIT_DIR/config, etc.  are not even committed files in the first
place.  These are not even defined to be "UTF-8 only" by us.  Their
contents is entirely up to the end users.

Here with these changes, we are only being nice to the users by
stripping a well-known two-byte sequence that is known to be left
commonly by some tools users would use. In a sense, this is the same
degree of niceness that we strip the CR at the end of the line
before LF.  Just like you _could_ have said these files must be
encoded in UTF-8 and must not have BOM at the beginning, we _could_
have defined that these files must be recorded with LF end-of-line.
But obviously we don't, as there is no need to make lives of end
users unnecessarily more complex, and it is easy to help users use
both LF and CRLF with simply stripping on our reader's side.  We do
this BOM stripping for the same reason to make it easier for users.
