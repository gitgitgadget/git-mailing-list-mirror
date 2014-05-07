From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: Always normalize paths to Windows-style
Date: Wed, 07 May 2014 13:40:05 -0700
Message-ID: <xmqqmwet8gre.fsf@gitster.dls.corp.google.com>
References: <20140428083931.GA10257@camelia.ucw.cz>
	<CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
	<20140428113815.GA10559@camelia.ucw.cz>
	<20140428114224.GA11186@camelia.ucw.cz>
	<CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
	<20140428142931.GA12056@camelia.ucw.cz>
	<20140507184444.GB4013@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed May 07 22:40:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8dT-0004xy-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbaEGUkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:40:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51748 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbaEGUkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:40:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9432516095;
	Wed,  7 May 2014 16:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MzIC1U88clHbhApKWbxSNgnu1gI=; b=H/PnXu
	M00TU019vvGqsCASvx2/dJG069ZSdU2cW0EIXHz9XL4sxZJtY/ang8p/W4iW1Zx2
	Y0ZmWp6xmzZqa8Rr7grNAOCyH0A/cHD21hY3pAAgj14hX4vr6VsLl6gzU+vHUNn0
	ysUuY+NGoFYJig6iQHpBlURvzbTdA/Qk98PZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ThFil2Vo08WaoI/hplcxs3ZzkYpFlQvA
	yPwpFdqpNuP/S/iVfW+lUm+QitgGIqQSbBocLZw9D9ZcTyCUbsSRvp3lo7ekt/xf
	+Al81BbJ6+q7DlzwHF1HCepLjnmlgCHbiAOx2GOSUlVMkThHdmOa7IWtKx8TTyKc
	VFqimxa6Wz4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 88FCD16094;
	Wed,  7 May 2014 16:40:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED09616093;
	Wed,  7 May 2014 16:40:06 -0400 (EDT)
In-Reply-To: <20140507184444.GB4013@sandbox-ub> (Heiko Voigt's message of
	"Wed, 7 May 2014 20:44:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C646AECA-D627-11E3-8DCF-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248363>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Apr 28, 2014 at 04:29:31PM +0200, Stepan Kasal wrote:
>> this is another patch that lives in msysGit for a long time.
>> Originally, it had two parts:
>> (Cf https://github.com/msysgit/git/commit/64a8a03 )
>> 
>> 1) adding alias pwd='pwd -W' to git-sh-setup.sh
>>    This one went upstream, though as a shell function.
>> 
>> 2) revert of commit 4dce7d9b by Johannes Sixt <j6t@kdbg.org>
>> This mingw-specific commit was created less than 3 weeks before
>> it was reverted.  And it stayed reverted for two years.
>> 
>> Could you please either accept this patch, or revert 4dce7d9b ?
>> (Both alternatives are exactly the same.)
>
> Sorry for the late reply.  To me reverting (or omitting at the next
> rebasing merge) this patch sound fine, as it seems to be superseeded by
> the upstream change.
>
> As I can see thats already done on master, so it seems to be all good.

Are you guys talking about be39048a (git-sh-setup.sh: Add an pwd()
function for MinGW, 2012-04-17) which has been in since v1.7.11?

The change introduced by 4dce7d9b (submodules: fix ambiguous
absolute paths under Windows, 2012-03-04) still exists, but your
"reverting this patch sound fine" confuses me.
