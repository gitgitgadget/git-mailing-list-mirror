From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parseopt: do not translate empty help string
Date: Mon, 20 Aug 2012 15:04:28 -0700
Message-ID: <7vzk5pi5jn.fsf@alter.siamese.dyndns.org>
References: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch> <7vboi5jrn1.fsf@alter.siamese.dyndns.org> <87obm5jpdy.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3a5b-0007rB-S9
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab2HTWEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 18:04:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755864Ab2HTWEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 18:04:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 039D98A5A;
	Mon, 20 Aug 2012 18:04:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1wNf/oRBmx3uw8Rjk0xAobQDKMc=; b=eaRzqL
	0RO5atY4+g5Aiqgr42gQMyNJsBKtsx5HZ2rw9pjlOV/YJBMKt5SjQUJP8KRCjvbB
	btYXtTUCL777HwnazF2TE69ziSX+/T8xH6HrvFY3T8ZHM/Ri5pnRQoC/7siqgUnW
	DOJn01sU5p9a+TcXEwrJ6fhJpcJaV8REfGKxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SbNF9AavjI2OljxHGCC2StKeueOV9JoU
	FehltoJelAvca4Yyvup5lgahwb/cJFJ5dE0qeX49tENvwRR65V1odSYS02FHil/z
	pEMI3Mafv/8OEbT3+JkxH40ZqlrOJn1PMaFt9qLP0upoDAeE/Z1F/30qiGJiAGPs
	WwCSTZ7pE/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E52DD8A59;
	Mon, 20 Aug 2012 18:04:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B48A8A57; Mon, 20 Aug 2012
 18:04:30 -0400 (EDT)
In-Reply-To: <87obm5jpdy.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 20 Aug 2012 22:10:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04141BE0-EB13-11E1-864C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203899>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> The gettext .po files have a header, but it looks like the translation
>>> specification for an empty string.  This results in _("") actually
>>> returning that header.
>>
>> Thanks; this is a tricky bit to catch and makes me wonder where else
>> we have a similar breakage.
>>
>> Perhaps we would want to do this instead?  I dunno.
>>
>>  gettext.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git i/gettext.h w/gettext.h
>> index 57ba8bb..376297b 100644
>> --- i/gettext.h
>> +++ w/gettext.h
>> @@ -44,6 +44,8 @@ extern int use_gettext_poison(void);
>>  
>>  static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
>>  {
>> +	if (!*msgid)
>> +		return "";
>>  	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
>>  }
>
> Oh, I forgot that we actually had a wrapper instead of the usual _.
> Yes, I think that would be the better solution to guard against this.

OK, then let's replace the patch text of your commit ;-).
