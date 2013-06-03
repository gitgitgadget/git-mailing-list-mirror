From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Mon, 03 Jun 2013 12:21:10 -0700
Message-ID: <7vtxlfc861.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjaJm-0008Lc-7U
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab3FCTVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 15:21:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab3FCTVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:21:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B77D2254DE;
	Mon,  3 Jun 2013 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aySnJgD7GBIdCcO+v7SI1g8ijAs=; b=jQzWTX
	UeQmvWHjDB95RlE3wITaOoBd+TQvUM/JaZHu/WGGIaOjTVL0ZwLOf3f+2a3Ir81j
	/8Ng34mULtwXavhPSYS9glCS6gjumaf4wS0g4so9nfJWcg+2DZZCo78fBBi4aGw7
	/qTlCFXAxIIGaoTguMABJUjfOkHmt6AS+LI+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hXSAKtvzFeMg7kFuS1s5TQWhZ87SOjpo
	Tqmazds3JsKC8FirwkZDlN2lf0BT9vtQ5TqaEj4ijwJYDJb4iEZ8DsEY1sLrDewU
	YkRb0pSRVn7G+SIQPuX7njfQYhyLR5Cjv5V4JaN+w2WDSMfwu5HUokLDUNDV/nUy
	xfTADGL0f+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4AF6254DC;
	Mon,  3 Jun 2013 19:21:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8DFF254D6;
	Mon,  3 Jun 2013 19:21:11 +0000 (UTC)
In-Reply-To: <7vr4gjdomk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 03 Jun 2013 11:40:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C05333EE-CC82-11E2-93A0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226271>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Pretty much what it says on the tin.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  Documentation/git-cherry-pick.txt   |  3 +++
>>  builtin/revert.c                    |  2 ++
>>  sequencer.c                         |  6 ++++++
>>  sequencer.h                         |  1 +
>>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>>  5 files changed, 25 insertions(+)
>>
>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
>> index c205d23..fccd936 100644
>> --- a/Documentation/git-cherry-pick.txt
>> +++ b/Documentation/git-cherry-pick.txt
>> @@ -129,6 +129,9 @@ effect to your index in a row.
>>  	redundant commits are ignored.  This option overrides that behavior and
>>  	creates an empty commit object.  Implies `--allow-empty`.
>>  
>> +--skip-empty::
>> +	Instead of failing, skip commits that are or become empty.
>
> Not quite sure.  Is this "instead of recording an empty commit,"
> (which may or may not fail depending on the allow-empty settings)?
>
> If that is what this patch is meant to do, I think the change makes
> sense.

Also what I noticed while looking at 4-5/8.

Wouldn't "revert --skip-empty A..B" make sense as well?
