From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "remote-hg: update bookmarks when pulling"
Date: Thu, 16 May 2013 11:16:31 -0700
Message-ID: <7vbo8a6b9c.fsf@alter.siamese.dyndns.org>
References: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
	<7v4ne27ubp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 20:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud2jI-0004P6-10
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 20:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab3EPSQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 14:16:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab3EPSQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 14:16:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC52F1FBFB;
	Thu, 16 May 2013 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8vUVSKlLqU8//tiKMq/eXy8Bfd4=; b=YBbxlv
	s0ypwGpEKo9lWwzQMug8I4t4OwHJ6qr9KnsxPzBPhFFtDKmOYCb3dFKhkLpZK0sd
	fv6I4ZOqsotB2kAzpUw9RLRaQczQKxL+TSxTRsunV9GM05rWDBqwol6z3X3Ey1Td
	SWwhjJFb/FPga7pKBn886Ep37m6jn2ALZp9Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhZypQJcgxCbkRUVX2Br3ZH2vZ0k+Ndl
	T5pKThCPpJZMiOMqO5K+AUaXRlidTg9EOnBY8r7Hy2a4DvOM8X8PPkCjQ0dKWGKb
	AeuL0aNzIeERW9FhNo2dAkiOOnGsLcHymcvU3X61ASmDDGjgmAQ6zwfggfre5mer
	v5JpXf1MMrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06CE1FBFA;
	Thu, 16 May 2013 18:16:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18B151FBF8;
	Thu, 16 May 2013 18:16:33 +0000 (UTC)
In-Reply-To: <7v4ne27ubp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 May 2013 09:39:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCF30FD0-BE54-11E2-81BA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224607>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This reverts commit 24317ef32ac3111ed00792f9b2921dc19dd28fe2.
>>
>> Different versions of Mercurial have different arguments for
>> bookmarks.updatefromremote(), while it should be possible to call the
>> right function with the right arguments depending on the version, it's
>> safer to restore the old behavior for now.
>>
>> Reported by Rodney Lorrimar.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> Intended for master (v1.8.3).
>
> Hmm, is this the one we merged yesterday?

Just double-checking.

This is a lot more urgent request for confirmation than anything
else I've been sending today (and receiving responses from you
about).

>
>>
>>  contrib/remote-helpers/git-remote-hg | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
>> index dc276af..beb864b 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -363,9 +363,6 @@ def get_repo(url, alias):
>>                  die('Repository error')
>>              repo.pull(peer, heads=None, force=True)
>>  
>> -        rb = peer.listkeys('bookmarks')
>> -        bookmarks.updatefromremote(myui, repo, rb, url)
>> -
>>      return repo
>>  
>>  def rev_to_mark(rev):
