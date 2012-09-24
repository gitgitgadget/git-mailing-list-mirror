From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: configure submodule.<name>.path on add and
 init
Date: Mon, 24 Sep 2012 13:43:12 -0700
Message-ID: <7vmx0fxicf.fsf@alter.siamese.dyndns.org>
References: <1348515040-19986-1-git-send-email-orgads@gmail.com>
 <5060BB3D.9010609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 22:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGFUz-0001ou-7S
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240Ab2IXUnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 16:43:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216Ab2IXUnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 16:43:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F13A382B2;
	Mon, 24 Sep 2012 16:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mLeechTl/FJGCUgcDRuqfdC5K+U=; b=a7/EzH
	toPYijDBCUe0Dz9S/PF/JS1jNRplL8fmRfVvfBxRgK/lRUIm5fLD0TF0PBUKKI80
	EEqWegNVUkHaC+qTZL9WghciTBMVom2p62iGSdClrzSx2T/KXPAx9qxHC51X0ZdD
	ikFOzg/vMw1n+bTD0IYtRPZPdPUOp6Zj6f18s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rl3RW0C5FRl9J3VAQ0ipkLFfRsVsbB+V
	1VaopkWUsyaYZ4eOAjfE0KL3casrzc75VYMjVXBVidqsVol3i5rAbsN8CWAfHV/G
	tbzKIDJTO3zHLtRvEd3FYhAu4kiOUy/AijsaTkxLd0dlfiW4X/9yGIFr2SmFEhSy
	y935BXkIIdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5E3D82B1;
	Mon, 24 Sep 2012 16:43:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CF0282AF; Mon, 24 Sep 2012
 16:43:14 -0400 (EDT)
In-Reply-To: <5060BB3D.9010609@web.de> (Jens Lehmann's message of "Mon, 24
 Sep 2012 21:57:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 762DEA9A-0688-11E2-9639-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206328>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 24.09.2012 21:30, schrieb Orgad Shaneh:
>> In order to read diff options for a submodule, its path must be configured
>> ---
>>  git-submodule.sh |    2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 3e2045e..f97bb62 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -359,6 +359,7 @@ Use -f if you really want to add it." >&2
>>  			esac
>>  		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>>  	fi
>> +	git config submodule."$sm_path".path "$sm_path"
>>  	git config submodule."$sm_path".url "$realrepo"
>>  
>>  	git add $force "$sm_path" ||
>> @@ -476,6 +477,7 @@ cmd_init()
>>  				url=$(resolve_relative_url "$url") || exit
>>  				;;
>>  			esac
>> +			git config submodule."$name".path "$name" ||
>>  			git config submodule."$name".url "$url" ||
>>  			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
>
> Nack. The path must only be configured in .gitmodules or we'll
> never be able to rename the submodule directory.

That sounds sensible on the surface, and the rejection of this is
probably the right thing to do, but then how would the name/path
mapping work without .gitmodules?  Historically, you did not have to
have a .gitmodules in-tree at all in order to use submodules
locally, but if discovery of submodule.$name.ignore depends on
having the in-tree .gitmodules file, that sounds like a minor
regression to me.
