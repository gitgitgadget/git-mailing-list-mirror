From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 03 Jun 2016 10:04:47 -0700
Message-ID: <xmqqh9dap5jk.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160603110843.15434-1-pclouds@gmail.com>
	<20160603110843.15434-4-pclouds@gmail.com>
	<575199E7.7000503@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sWl-0007t8-KD
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbcFCREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 13:04:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcFCREu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:04:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 849FA1E6D6;
	Fri,  3 Jun 2016 13:04:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rLmUdK9VPiKK0NJl0kbY0KLoLW0=; b=N+ri4E
	RHZSC9p557CWJWKVUUDxuqVe//9XN2ZBpz0IM8NRZqvG2reCvt8T6pYl+Ijh3yXF
	WFCLr8UNIXW/LByBkzDUvvDJH4+dhgP2w1CjmSUkmhqdiAHPJ/iktIZUvfdEDUDy
	9EXMs63QJko4dqOtcxHYm6RNJuqtWbrZEsNZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gm7fMLc12JruirGeo15egEw9F5zXgIhW
	2d7W5bnwD3FgQceyu8g/CMKa/dRNJ81yYj/2AwJCg7aYD9KRT86zYK+nvbzg8BOX
	UvpcxTzVD2CLhYNWyUFrK8RYLOgosyateCJGSY9x5GKf+5cKiYFic66KD1fxcSuw
	qrcrzHbfgFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A4DA1E6D5;
	Fri,  3 Jun 2016 13:04:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F235A1E6D4;
	Fri,  3 Jun 2016 13:04:48 -0400 (EDT)
In-Reply-To: <575199E7.7000503@xiplink.com> (Marc Branchaud's message of "Fri,
	3 Jun 2016 10:53:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47ADE458-29AD-11E6-A773-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296348>

Marc Branchaud <marcnarc@xiplink.com> writes:

> What if we detect when the full line exceeds the terminal width, and
> insert a newline after the remote ref and indent the ->  to the same
> offset as its surrounding lines, like this:
>
>  * [new branch]      2nd-index -> pclouds/2nd-index
>  * [new branch]      some-kind-of-long-ref-name
>                                -> pclouds/some-kind-of-long-ref-name
>  * [new branch]      3nd-index -> pclouds/3nd-index

I am OK with this format (not in the sense that I like it better
than what the patch produces, but in the sense that I do not have
strong preference either way).  It may be hard to come up with a
good heuristics to decide where on the display width "->" should
come, though.

>> +When `from` and `to` share a common suffix, the line could be
>> +displayed in the form:
>> +
>> +-------------------------------
>> + <flag> <summary> {<from> -> <to>}<suffix> (<reason>)
>
> If we go with this format, we'll need to document <suffix>.

The sentence above calls it "a common suffix", so instead of saying
<suffix> we can say <common-suffix> perhaps?  Or did you mean
something more than that?
