From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Fix ignoring of pathspecs with rev-list --objects
Date: Thu, 26 Aug 2010 16:41:20 -0700
Message-ID: <7v7hjdkkm7.fsf@alter.siamese.dyndns.org>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
 <1282704795-29661-3-git-send-email-newren@gmail.com>
 <AANLkTimguNHXSFyO1EvS+dHbHiXU-dXTNwkWfEsVUbVC@mail.gmail.com>
 <AANLkTimCv-fn-h21pM8L9NiGg3w7OXBJ-kfiC+HJLsTP@mail.gmail.com>
 <AANLkTi=Y5tbdxc4f2j_1D1gib2gwEzNw6_Az3Ag9T1nn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 01:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oom4f-0005lG-C1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 01:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0HZXld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 19:41:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0HZXlb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 19:41:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0B5D0295;
	Thu, 26 Aug 2010 19:41:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xjlceKoF/4LxNR9YMa5Qwtar7+E=; b=cDCgOx
	OwDeWeiouKDqmggEVy2PUu81H6UePxZ4ehgVMX+9lsvBX05VGKuej7F5IN/JlEoV
	ocPVcESQu4cHBGR762SHDOdPIKPCe3C8Hm4dMifDHJjjbfaw//NOX3k/X0QJEgGM
	MLLn/a5qkuukYuHV0JgtcXHEEfcYbPeOBu5V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NlfizoDqmguYa9vB8+wbJrAvLVNjeevc
	S1YIX/0V2UyHYHYS90MEqPDB4sAQFZG4BRtXm2N1mf+I1k1VWqfpLHUC1ejTjVLB
	FpgcqMIvNMKIIwhCVL8HTkjrCdzHrFyY0dYY+mKWVMywkRQoDGbbGm0+/LMXfg/a
	nsRm84w23iI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E7EFD0294;
	Thu, 26 Aug 2010 19:41:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACD37D0291; Thu, 26 Aug
 2010 19:41:22 -0400 (EDT)
In-Reply-To: <AANLkTi=Y5tbdxc4f2j_1D1gib2gwEzNw6_Az3Ag9T1nn@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 27 Aug 2010 09\:15\:29 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 714D3C0C-B16B-11DF-8A3F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154570>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Aug 26, 2010 at 9:50 AM, Elijah Newren <newren@gmail.com> wrote:
>>> While at it, can you please also fix its comments? The comments say
>>> pathspec while what it uses is actually path prefix...
>>> ...
>>> - * Is a tree entry interesting given the pathspec we have?
>>> + * Is a tree entry interesting given the path prefix we have?
>>
>> I believe the comment is parsed thus: "tree entry" == combination of
>> desc, base, and baselen... So I believe the original was
>> correct, though I can see how it's confusing at first.
>
> Pathspec as in match_pathspec() in dir.c allows wildcards...
>
> There is also a GSoC suggestion about this [1] and I posted a related
> patch a while back [2] but forgot it until now.
>
> [1] https://git.wiki.kernel.org/index.php/SoC2010Ideas#Unify_Pathspec_Semantics
>
> [2] http://mid.gmane.org/1243240924-5981-1-git-send-email-pclouds@gmail.com

As [1] you quoted says, both are called pathspecs and because our longer
term goal is to unify them, I think the original comment is fine.

I wonder why I was Cc'ed on this shed-coloring committee, though...
