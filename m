From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/10] remote-hg: fix new branch creation
Date: Wed, 15 May 2013 12:40:08 -0700
Message-ID: <7v8v3gav6v.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-6-git-send-email-felipe.contreras@gmail.com>
	<51929c576d949_13a8f89e18183b@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 21:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UchYh-0001yP-KF
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 21:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab3EOTkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 15:40:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101Ab3EOTkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 15:40:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2AAE1E5E5;
	Wed, 15 May 2013 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IwONy/tqs+C3XC92rZK+6kUcm4g=; b=WoULrS
	+qZdNNdYyA/EaVFV7jJhNgfKDDaxPTXJ1zCU/8SKvO7NhqzzeOf08VJLomgBlbe1
	NQbgT0cP/lmH0//VVCtNAi3Lo/+Z6Aq1AoKKulx9wM56kkdGXbkkLwzmnTNPg4p9
	mRFtVnM6iomLKCnDSnIvHiTEtHfNCBdDARBic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VL+e8TvIKW3Fx/AxRR52HcaIJXdqQJi8
	T5O7M/NB+24G6CaZW8iez2PVT3mCb3x4vhITOBMwdfPh2toYD5jmLuFvM997c7Ts
	0I50n6vTaGAkKyxSesgPuxUchr1rQPrta+22eIxSM8m19KgRiWEBTyx0TOgiS9JG
	JcSLvbGYeDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D992D1E5E4;
	Wed, 15 May 2013 19:40:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B5191E5E2;
	Wed, 15 May 2013 19:40:10 +0000 (UTC)
In-Reply-To: <51929c576d949_13a8f89e18183b@nysa.mail> (Felipe Contreras's
	message of "Tue, 14 May 2013 15:19:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40FC0AD4-BD97-11E2-AC53-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224442>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Felipe Contreras wrote:
>> When force_push is disabled, we need to turn the argument to True.

With your follow-up clarification, here is what ended up in the log
message:

    remote-hg: fix new branch creation

    When a user creates a new branch with git:

      $ git checkout -b branches/devel

    and then pushes this branch

      $ git push origin branches/devel

    which is the way to push new mercurial branches, we do want to
    create a branch, but the command would fail without newbranch=True.

    This only matters when force_push=False, but setting newbranch=True
    unconditionally does not hurt.

The only part that I came up with on my own is "but ... does not
hurt" at the end.  If that is incorrect, please supply an update.

Thanks.

>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-hg | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
>> index 4a5c72f..3cf9b4c 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -856,7 +856,7 @@ def do_export(parser):
>>              continue
>>  
>>      if peer:
>> -        parser.repo.push(peer, force=force_push)
>> +        parser.repo.push(peer, force=force_push, newbranch=True)
>>  
>>      # handle bookmarks
>>      for bmark, node in p_bmarks:
>> -- 
>> 1.8.3.rc1.579.g184e698
