From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Sat, 06 Mar 2010 19:42:17 -0800
Message-ID: <7vaaukdch2.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <20100306003946.GD27414@genesis.frugalware.org>
 <7vr5nykx55.fsf@alter.siamese.dyndns.org> <4B92EDFA.1000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 04:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No7Nz-0001sl-MX
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 04:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab0CGDma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 22:42:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab0CGDma (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 22:42:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C779FC17;
	Sat,  6 Mar 2010 22:42:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s3N5C8CfgP5pSzCp/N8NZQnwqtg=; b=aGAjDv
	W1Waj/HvReB5cZftpvEEosb1W/T3ty2hweJs6LyQgY37zNTncgmLvqzn7Wn4fqY9
	u5Lx5PWdMtJeToVUSnmUI0XoUlfr4v+m2/+8v22IxLiuK9o67cojb9l9cyJlEiuj
	DVpKGRjREQKBJygZZCVCEZ5BSj5PO6P5z5ZQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S4T9m1VeJ5xdJ0USRmhwzy8X0ndmXNia
	qU/JRWyhxiiq77+2NpPwtHHyGXmGhzvbjHXqJuEs/7AvfAV8phAjedQKJ68f2YsM
	cUGhJ7Wz+OkG9p3C6THACLFPoo1PTkdKb/iq9vIJCB5rA19u1vTmp2bvfJIAqhrJ
	AErZS5DLX7A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A15019FC13;
	Sat,  6 Mar 2010 22:42:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE3519FC0C; Sat,  6 Mar
 2010 22:42:18 -0500 (EST)
In-Reply-To: <4B92EDFA.1000602@gmail.com> (Stephen Boyd's message of "Sat\,
 06 Mar 2010 16\:06\:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70F70B78-299B-11DF-BE1E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141643>

Stephen Boyd <bebarino@gmail.com> writes:

> On 03/05/2010 06:21 PM, Junio C Hamano wrote:
>> This reveals that --to does not follow the usual rule to override
>> corresponding configuration.  Is that really what we want?  IOW, when the
>> command line says scipient, shouldn't we stop sending to recipient that
>> comes from the configuration?  How else would a user override this?
>>
>> So I guess the topic wasn't ready for 'next' yet, after all.
>
> The same applies to the fomat.headers and format.cc config options. How
> is this different?

Not different.  Perhaps we should fix them now you noticed they share the
same problem?

An obvious alternative is to keep format.to not get overriden by --to as
the original patch did; that would at least make the handling between
config and option consistent inside the command, but at the same time, it
means format-patch behaves differently from everything else in git.

I don't have strong preference either way myself, and while I know
"fixing" the ones you listed would affect existing users, I have this
suspicion that it wouldn't be too big a problem.  After all, format-patch
does not _send_ mails; these MUA-like "features" doesn't belong to the
program, and nobody should be relying on them heavily in the first place.
