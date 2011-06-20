From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 14:59:36 -0700
Message-ID: <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 23:59:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmVV-0004Gv-8A
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 23:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab1FTV7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 17:59:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1FTV7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 17:59:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED8336615;
	Mon, 20 Jun 2011 18:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQQWURU0VMIlGjILjd+0tR4qVwM=; b=Gws299
	QtFi1Qh+YSNUrLBx46GFBe0u+dx7KdaADgtsxilbexxyYU4OFTGPoFe/Oa+lNP+t
	+oIATK5QhGs4E2B7CMAFXucMtje+IipNiItbqOf7/Mu4SAiN3bi7OXwFncXRv7kr
	361FMawIMGaHIfv/lXvVil+m/Vd6+DWg6eUlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ic5oEklvM1m4t0ybVCe6iDTIQ6XSpfDC
	bvvRqzVGF2ZLZinSuvwNgu+YHuDfVMzOlvyZEwQyHHjYw18qSkH3rq3BOHzv9F3y
	oDg7qEzRwnJOLtc19diP1XGIo9Ynb2X1QXDmNA/t53Wm53YhVfMiL+7MA85GwBHD
	XBUNtsE/x1s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E69E76614;
	Mon, 20 Jun 2011 18:01:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 391A16613; Mon, 20 Jun 2011
 18:01:50 -0400 (EDT)
In-Reply-To: <20110620213001.GB32765@one.firstfloor.org> (Andi Kleen's
 message of "Mon, 20 Jun 2011 23:30:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6477F42-9B88-11E0-A788-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176098>

Andi Kleen <andi@firstfloor.org> writes:

> On Mon, Jun 20, 2011 at 02:17:32PM -0700, Junio C Hamano wrote:
>> Andi Kleen <andi@firstfloor.org> writes:
>> 
>> > From: Andi Kleen <ak@linux.intel.com>
>> >
>> > Add a lot of dummy returns to silence "control flow reaches
>> > end of non void function" warnings with disabled noreturn.
>> >
>> > If NO_NORETURN is not disabled they will be all optimized away.
>> 
>> I think this is probably a bad move, given that the previous patch is a
>
> This is basically the patch you suggested. Do you have some other suggestion 
> now?

Sorry, I do not recall suggesting to add these dummy returns. The NO_NORETURN
workaround (your [1/3]) is what I remember.

>> these will introduce noise for build without NO_NORETURN (either when
>> profile feedback is not used, or when profile feedback build is in use and
>> it no longer requires the NO_NORETURN workaround).
>
> I fixed the noise in a followon patch. 

I suspect that we are talking about different warnings.

The extra unreachable returns this patch adds will introduce more
"unreachable code" warnings, which was what my message you are responding
to is about.

While I agree with you that this patch will now squelch "control flow
reaches end of non void function" warnings (which is your justification
for this patch), I am just pointing out that it is like robbing Peter to
pay Paul.
