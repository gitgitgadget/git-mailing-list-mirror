From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Tue, 21 Aug 2012 10:53:57 -0700
Message-ID: <7v8vd8dtca.fsf@alter.siamese.dyndns.org>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <1345523464-14586-6-git-send-email-pclouds@gmail.com>
 <20120821051706.GA55686@mannheim-rule.local>
 <CACsJy8DHdj61sH8DjLsUfKdb4yzbnACWdCsgmFDtjJqq08c2TQ@mail.gmail.com>
 <20120821142441.GA56154@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:54:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3seW-0008UA-G1
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab2HURyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:54:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab2HURx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4642B788D;
	Tue, 21 Aug 2012 13:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vbTwvHQQ3oEIfkwJc65Y4Dih/UE=; b=tu9nU2
	P0wm7g0J9l07cLB5cIjbIXnxp6L62LYEmOS5QkEmQmLgAvgRrTxChPPbs3/DQ/t/
	aROxEhuCLTM/6N1zckdLq0S7+QEHVYTSQmBrSY7wjwUYa/V3wx0a9h/rOCJZAN5D
	Gkt69AAkRxyKgP1Ues1mRiqT3cad5MRj3TaCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2vGLnomJcRmqCIcoGR6zZDXSIHbcEOX
	/Jbt+O0jzJF2v+DUdotH42kW1J/UYc7Lfj10fsFkd50ehe6oDGUIfiL1rn028AMk
	OCvdATi7X7pR7pwpMAVnCMeabThzHqfqhfDggPsdjRI+vLLzhjOWPiInB6vVShGg
	hSoYPi6cYW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34341788C;
	Tue, 21 Aug 2012 13:53:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77E68788B; Tue, 21 Aug 2012
 13:53:58 -0400 (EDT)
In-Reply-To: <20120821142441.GA56154@mannheim-rule.local> (Jonathan Nieder's
 message of "Tue, 21 Aug 2012 07:24:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ED4BF00-EBB9-11E1-B394-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203977>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguyen Thai Ngoc Duy wrote:
>> On Tue, Aug 21, 2012 at 12:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>>> @@ -35,7 +35,7 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
>>>>       printf "0032want %s\n00000009done\n0000" \
>>>>               $(git rev-parse HEAD) >input &&
>>>>       test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
>>>> -     grep "unable to read" output.err &&
>>>> +     test_i18ngrep "unable to read" output.err &&
>>>>       grep "pack-objects died" output.err
>>>
>>> Wouldn't it make sense to change the second "grep" of output intended
>>> for humans to test_i18ngrep while at it?
>>
>> This comes from error("git upload-pack: git-pack-objects died with
>> error.") in unpack-trees.c, which is not i18n-ized yet. There's
>> another test in t5530 that does the same grep. I think we should leave
>> it as is until we mark the string for translation, then gettext poison
>> will spot it (verified) and we can fix it.
>
> I don't understand the distinction you're making.  Isn't the message
> intended for humans, and wouldn't changing that one line to
> test_i18ngrep now save trouble later?  Tests are meant to check git's
> intended behavior, not to exactly match its current behavior.

Correct; your suggestion is good.
