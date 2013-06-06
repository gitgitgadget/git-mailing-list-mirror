From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] cherry-pick: add --skip-empty option
Date: Thu, 06 Jun 2013 12:21:12 -0700
Message-ID: <7v38svyriv.fsf@alter.siamese.dyndns.org>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-4-git-send-email-felipe.contreras@gmail.com>
	<7vbo7jytv5.fsf@alter.siamese.dyndns.org>
	<CAMP44s3b2K0nbfuhNqB6FNevdPjVByQCpAie5nzAjx8bw5Y+RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:21:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfkQ-00065P-72
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab3FFTVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 15:21:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab3FFTVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:21:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF13268F1;
	Thu,  6 Jun 2013 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9d3U7QWHwcqwit4sjoZAM9SYl9w=; b=hTFCBp
	FK6rC2nJWMBElCoGhhamKRBufJyqjAEKebA/mk2fVXU9jUhN2CJAv3FZEv1JJnXQ
	yYmT2poM5sKteAee8xpYY4jcgWS8Sh2egCbH/xIHswKaOq0jjtOmAtDSD8IawYA+
	7M7+mRQ+IuTTbjqu8uJBe65id5ywsgFTRS0t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tOnfW3TvbwCaVZBZ/j0Rfo+haXCSCHnk
	BCILfnO9M254lwTfDe+gAVkNTbHUzpRNtt5z9tPtIoZddXxol0TCwC5SeT1WkDx7
	iJdvK/fm9KDgWvMM5+LRGMd5aSpbEqQCbFxzxo+ctGKzkdMGCKK6kq9pzCKSH4Wy
	O5rHKTARl9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4360268F0;
	Thu,  6 Jun 2013 19:21:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 194DE268EF;
	Thu,  6 Jun 2013 19:21:14 +0000 (UTC)
In-Reply-To: <CAMP44s3b2K0nbfuhNqB6FNevdPjVByQCpAie5nzAjx8bw5Y+RQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 6 Jun 2013 13:34:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40E1DA6C-CEDE-11E2-B985-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226529>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Jun 6, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Pretty much what it says on the tin.
>>
>> And a bit more, isn't it?
>>
>> The --keep-redundant-commits option implies the --allow-empty option
>> and it was perfectly acceptable to give both.  By making sure that
>> only at most one of -k-r-d, -a-e or -s-e is given, this forbids that
>> usage.
>>
>> "It is implied so there is no *need* to give it redundantly" is
>> different from "It is implied so you shouldn't give it redundantly".
>
> Remove that line then.
>
>> Like 7 and 8 that adds --quiet/--skip, don't we want this also for
>> revert?
>
> If we don't want --allow-empty in revert, we don't want --skip-empty
> either. That is a separate patch.

OK.
