From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Mon, 17 Nov 2014 07:33:26 -0800
Message-ID: <xmqqfvdhzvsp.fsf@gitster.dls.corp.google.com>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
	<1416036379-4994-3-git-send-email-mhagger@alum.mit.edu>
	<xmqqvbmfyo8w.fsf@gitster.dls.corp.google.com>
	<5469B134.1050306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 17 16:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqOJ4-0002ro-5M
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 16:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaKQPda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 10:33:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751411AbaKQPd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 10:33:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 482C11EB60;
	Mon, 17 Nov 2014 10:33:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0CZjsi1CyNsD3VCWhu0MvcfFBCA=; b=UEqjpV
	RcoLQ3CEPt8F6snig0z9JiA1ZId1Ov++f5sf/RgLjdbgwRWMhgjNEic0sf1Kxx16
	A1e3cPgRtv7HffHaiFBxAS13zx/+sAiInM37uf6nrGrX0lxcsVcDzaVN1mV4WNnR
	Tp4EBiLyqe0j+sZBf8Zh6Ixw8JSi1ezE7n4WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WbKplnkKAeaNE+D35u5pN4C8Lzp4W5Cn
	OWn91q6aTWKPrSEg+uxILnKfZLuwszeQTIjh6CmlzQtDpFZU0mOvzQ77M3Hi1F0l
	E6es7Ug8gFnTBj47XuPYkQVbA3UBm2HWzEO94nmLhMFluUPut8JigE2Q/AzjgIr8
	GTqFWYo7qT4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FFEE1EB5F;
	Mon, 17 Nov 2014 10:33:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CDA41EB5D;
	Mon, 17 Nov 2014 10:33:29 -0500 (EST)
In-Reply-To: <5469B134.1050306@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 17 Nov 2014 09:26:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14B62ACE-6E6F-11E4-ABEF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 11/16/2014 07:49 PM, Junio C Hamano wrote:
> ...
>> So I would suggest not to spend any cycle or any code complexity to
>> "repair" existing repositories.  Having that bit on does not hurt
>> anybody.  Those who found it curious can flip that bit off and then
>> Git with "preserve existing permissions" fix will keep that bit off
>> from then on.
>
> I disagree. The point of "preserve existing permissions" was to allow
> people to make their config files more readable/writable than the
> default,...

s/more/less/, I think, was the original motivation.  Having to limit
more tightly than usual was what made the "config" unusual among
files under $GIT_DIR.  If it were to loosen, Eric's change should
not have been done in the first place. The sharedRepository setting
to defeat the default umask is there for that kind of thing.

> That being said, I still believe that executable config files are not a
> significant risk ...

It is merely an annoyance, to the same degree of annoyance we find
when we see all files appear executable on a FAT floppy mounted on
Linux ;-)  I do not think it is a risk at all, and I do not see a
point in going into people's repository and actively "fixing" it.
People who notice can fix, and people who do not care do not care
and are not harmed.
