From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Thu, 02 Sep 2010 07:50:44 -0700
Message-ID: <7vlj7k42t7.fsf@alter.siamese.dyndns.org>
References: <201009012054.20482.robin.rosenberg@dewire.com>
 <1283351989-19426-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=wESk38u1XSTL1rd2__eQzHfSuq-EbqooxmcVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, robin.rosenberg@dewire.com,
	srabbelier@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 16:51:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrB8E-0005wW-KL
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 16:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab0IBOvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 10:51:02 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656Ab0IBOu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 10:50:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8848DD2E21;
	Thu,  2 Sep 2010 10:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c5Ee9oNo3711N7SiRjUH8hve/F4=; b=iz2JhQ
	UhqXuNy8Ykfd62j4Ikt1ldeWahEJ/LbHKQMtBhNr7HaprKdtYReJPB2o8I2lAXGp
	vMWi/sTgmefx+YQAyw0q1gF9u4qSFq19O2QxXFbWVj7dU4U9Sxq06epP8IXyoU9z
	BKe6VWobxakqDdnKxRNjUXQMfPk/GC2hUKj8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSJbImAUpOTfn7be6P35wXfLybQaTDHd
	QFWqqWpyTfqpdEBnJb31ZMFzVynFp+tfAMCGYXf41NiF7/9/xvMZS3SQBFF0LQP3
	9Oe2H9XTNlvTQ6oWnplaVo0XGdj1UYxpFj0eu1Dqt2B/QkO9ZIfySmyUgXR+SPip
	ZV4/pX1+z3E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE74D2E11;
	Thu,  2 Sep 2010 10:50:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22680D2E0B; Thu,  2 Sep
 2010 10:50:46 -0400 (EDT)
In-Reply-To: <AANLkTi=wESk38u1XSTL1rd2__eQzHfSuq-EbqooxmcVw@mail.gmail.com>
 (Alex Riesen's message of "Thu\, 2 Sep 2010 10\:56\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B6B5706-B6A1-11DF-BBBC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155131>

Alex Riesen <raa.lkml@gmail.com> writes:

>> +  32-bit ctime seconds, the last time a file's metadata changed
>> +    this is stat(2) data
>> +
>> +  32-bit ctime nanoseconds (modulo 1G)
>> +    this is stat(2) data
>
> Maybe I'm missing something, but I failed to find where "modulo 1G" comes from.

I think the above wants to say "seconds and sub-seconds are stored in
separate fields, and latter is purely sub-seconds, never reaching nor
exceeding a whole second" (gig == 10^-9) times nano (== 10^+9) is 1).

I personally do not think it is a good idea to say " (modulo 1G)" there;
it is more confusing than without.

Either the reader knows, from seeing "this is stat(2) data", what
seconds/nanoseconds mean, in which case the comment gives redundant
information in cryptic terms, or the reader doesn't, in which case the
concept of storing the timestamp as a (second, subsecond) tuple needs to
be explained a lot better than the above to be understood.
