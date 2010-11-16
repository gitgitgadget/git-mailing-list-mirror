From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -s: allow "(cherry picked " lines in sign-off
 section
Date: Tue, 16 Nov 2010 14:52:36 -0800
Message-ID: <7vlj4shoej.fsf@alter.siamese.dyndns.org>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net> <20101116193018.GA31036@sigill.intra.peff.net> <20101116202556.GA27390@burratino> <20101116204027.GB27390@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 23:53:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIUOk-000861-VM
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 23:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873Ab0KPWwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 17:52:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932559Ab0KPWwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 17:52:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6D80273B;
	Tue, 16 Nov 2010 17:52:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zqc5aRuE5AZjzRmjKc47EUZI614=; b=cYvBD3
	erkT+zfzLy/Kl37adbW/335r8Kf8CIGH46AXoWefLCGMvsSzLNXJ4bdfdoR6a3Ei
	lXbaAZnmv6K4FKowgilrPXxS6wcSquxUaJiZ7BVitpWiacXw8QiGnLoqTCDhLdqs
	pMM/oS6KYtbY/hIaPkfG9EH9UQWvNThmDAc7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcr3ZXNXw3/1YiJky6BVK7kV8fFRwqFg
	buGjtJEt/tn1DcfcQSqKrFDC6uikh+XzP7TR7lUB1UFmJjW4Rf6RYfNLX4VYaKe8
	fFAHlrdtAvn2d5swfvdqCDMKBS3Fk/4JfbR6hG5xPGPDOHC6wvsyxvMCNgBA3Ui3
	Y2I16wg4v7Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85A312734;
	Tue, 16 Nov 2010 17:52:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE6D12732; Tue, 16 Nov 2010
 17:52:47 -0500 (EST)
In-Reply-To: <20101116204027.GB27390@burratino> (Jonathan Nieder's message of
 "Tue\, 16 Nov 2010 14\:40\:27 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F7EC91C-F1D4-11DF-AFE7-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161590>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> 	(cherry picked from commit 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0)
>> 
>> 	Signed-off-by: Back Porter <backporter@example.com>
>> 
>> The cherry-pick is a step in the line of a patch like any other,
>> so one might prefer to lose the extra newline.
>
> Sigh.  s/line/life/
>
> [...]
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Let's kick off the reviews.
>
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -528,6 +528,8 @@ static int ends_rfc2822_footer(struct strbuf *sb)
>>  		i++;
>>  
>>  	for (; i < len; i = k) {
>> +		static const char cherry_pick[] = "(cherry picked from commit ";
>> +
>
> Better to share this string with builtin/revert.c, no?
>
> What would happen when "(cherry picked ..." gets translated?
> Should only the current language's version be tolerated in
> the commit footer, or is there something more generic to
> match for that could take care of wording changes automatically?

With this patch you are declaring that "(cherry picked from..." is a magic
marker just like "Signed-off-by: " never to be translated, no?

I am not sure I agree with the reasoning of this patch, by the way.  A
cherry-pick is an event that breaks the life of the patch, so it may even
be a sensible thing to do to express "the above sign-off chain shows who
were involved in the original commit; I am cherry-picking it out of
context, and these people do not have much to do with the result" with a
blank line on both sides of the "cherry picked" line, like this:

        A concise summary of the change

	A detailed description of the change, why it is needed, what
        was broken and why applying this is the best course of action.

	Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

	(cherry picked from commit 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0)

	Signed-off-by: Back Porter <backporter@example.com>
