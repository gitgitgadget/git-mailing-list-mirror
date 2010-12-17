From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/21] tree_entry_interesting(): fix depth limit with
 overlapping pathspecs
Date: Fri, 17 Dec 2010 12:02:40 -0800
Message-ID: <7vsjxwi2vz.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-11-git-send-email-pclouds@gmail.com>
 <7vmxo5l2g4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=4vnitj-U5M+V_ALVpAk0ncMG=09aAEqA=KD41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 21:02:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTgVz-0002eW-TX
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 21:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab0LQUCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 15:02:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0LQUCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 15:02:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 569073189;
	Fri, 17 Dec 2010 15:03:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FzuRyISw5XAzO5Zzh6QMqJouFfo=; b=Fc0toC
	mmOT9i2WELQJwuq5gBORFECvlN6LnTx4Z5LFcwkKwAgYpk9zv/cB9w5QJg/i9ZqZ
	lerKUp9cur5Ni5U8znAIM2rqTGr//Nr/E5a/Rw9P6yt7kDcph4cGmTTXqxipwrGB
	jKDi59i1+oUjjL746GRyeM2yIt3iCqYi0vJ94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qZiEA42s2RmKhIutVSEnSFvytyW4Rjg3
	3rXNm2ccAeJikVsSHV3knYzOLD4VNOiylAVkuYWoa+RSby452SZycr+VFk9e+3lG
	lBpcDqFze4mj/LeV8I7918rl0azdCzBGSFJrOPezt8qIwWIbydr7e6/H8uS2KF29
	9eh8FCJ+9nk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 341B63184;
	Fri, 17 Dec 2010 15:03:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 24E0B3180; Fri, 17 Dec 2010
 15:03:09 -0500 (EST)
In-Reply-To: <AANLkTi=4vnitj-U5M+V_ALVpAk0ncMG=09aAEqA=KD41@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 17 Dec 2010 17\:05\:32 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE59EDC4-0A18-11E0-B23A-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163886>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2010/12/17 Junio C Hamano <gitster@pobox.com>:
>> One thing I am not clear is what it means to limit the recursion level
>> when you have wildcards.
>
> Recursion level does not affect wildcards at all. That was original
> design, a91f453 (grep: Add --max-depth option. - 2009-07-22). I think
> current git-grep still follows that.

I know what the current code does, as I remember a91f453 essentially
punted on coming up with a sane semantics.  As this series under
discussion is about coming up with a unified and sane pathspec handling
across board, it would be a good opportunity to think about it again, this
time without punting so fast.
