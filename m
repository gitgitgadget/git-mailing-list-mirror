From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] upload-pack-2: Implement the version 2 of upload-pack
Date: Wed, 04 May 2016 13:11:07 -0700
Message-ID: <xmqqvb2tfusk.fsf@gitster.mtv.corp.google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1461972887-22100-4-git-send-email-sbeller@google.com>
	<1462210997.4123.49.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:11:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay38d-0000Hf-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcEDULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:11:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751311AbcEDULL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:11:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DC4217860;
	Wed,  4 May 2016 16:11:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TLEgVD1vUdkz0xxPacXXed1PCT4=; b=eMif9B
	7lcE1MN5fACu2FM7YO10jCOBwLMgKLYYsmKLhPl24u05fiMYceY0ir5kQDs85zED
	+mvDzCYWiyNFPBrsu0Yj5GmJiUUdcQjbqB1n+1MLt3TIBdoyAQMk+p+bY9TqAu/y
	wPN6727BXLU9CwoEhAdTzj7pioHm/KiV55bt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKXWHL6ga+7q4/mzfurW/prcGfFXibBt
	Dv7vufQPo6CAp2uGm2pybO6QFcqyvf18+mKG/XA+yvTHrZ7gL9dHBONt32UnQzo9
	l48vkxYxrI093JcX6dblB6k59z3/mwTUkdEht9nRCmZ/u6reEWKXTwxwjt0yAWFG
	fNqFZWaod34=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84EDC1785F;
	Wed,  4 May 2016 16:11:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE1081785E;
	Wed,  4 May 2016 16:11:08 -0400 (EDT)
In-Reply-To: <1462210997.4123.49.camel@twopensource.com> (David Turner's
	message of "Mon, 02 May 2016 13:43:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57135C6A-1234-11E6-B323-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293581>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>> In upload-pack-2 we send each capability in its own packet buffer.
>> The construction of upload-pack-2 is a bit unfortunate as I would
>> like
>> it to not be depending on a symlink linking to upload-pack.c, but I
>> did
>> not find another easy way to do it. I would like it to generate
>> upload-pack-2.o from upload-pack.c but with '-DTRANSPORT_VERSION=2'
>> set.
>
> Couldn't we check argv[0] and use that to determine protocol?  Then we
> could symlink executables rather than source code.

Yeah, I do not have a good suggestion on the mechanism to actually
switch between behaviours other than what was already been discussed
in the thread, but the code resulting from the patch proposed is too
ugly with full of #ifdef for it to be the final form.

Just to make sure nobody gets me wrong; it is OK as a POC to move
the discussion forward.

A production quality implemention however would need to either be a
single executable that switches behaviour at runtime, or two
executables, each with its own *.c file with its own main(), that
share code in another common *.c file, I would think.
