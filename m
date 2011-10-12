From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 12 Oct 2011 11:07:27 -0700
Message-ID: <7vr52i9j8g.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3DU-0006Fo-TD
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab1JLSHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:07:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab1JLSHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:07:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A04C5A75;
	Wed, 12 Oct 2011 14:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t63a413trKdOe3/JTz89mCnFo68=; b=mfoYZi
	RHhx0yxFncCfm13443fc0Y7V9W9uj283S+K5aIkWVoj2yUm4uOlEozVqmfOt+8sr
	ThpUN9DpoqPOcyDeXWwfzHZGKB8I5PImws7DtjRcdgjGer3p9S1rsCYJ8vji+/Qu
	b/0Ka2af35TUZWsi0ALqozPyZw2gWBh4/vLGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDfw5zOzaTN9UaWMpHbxMOQuwDLC5sbK
	40pzZjv+TWsJsciAwoxugSG4mfdcTTUh/ZBJIhHwwKI2G3BEYuwkVMeziSnPI7/G
	7gPsu1jCH6ZQomRc1pvhBsYt5LCv06OpIKtpI1SdhaLDzYkB1fFLdMiwtONObbNT
	x6Bow+eHUpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 709BD5A74;
	Wed, 12 Oct 2011 14:07:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0ACA5A73; Wed, 12 Oct 2011
 14:07:28 -0400 (EDT)
In-Reply-To: <4E95D60B.5030904@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 12 Oct 2011 20:01:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C3B1A56-F4FD-11E0-BF1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183383>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/12/2011 07:49 PM, Junio C Hamano wrote:
>> diff --git a/refs.c b/refs.c
>> index e3692bd..e54c482 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -994,12 +994,34 @@ const char *ref_fetch_rules[] = {
>>  	NULL
>>  };
>>  
>> +static int refname_ok_at_root_level(const char *str, int len)
>> +{
>> +	int seen_non_root_char = 0;
>> +
>> +	while (len--) {
>> +		char ch = *str++;
>> +
>> +		if (ch == '/')
>> +			return 1;
>> +		/*
>> +		 * Only accept likes of .git/HEAD, .git/MERGE_HEAD at
>> +		 * the root level as a ref.
>> +		 */
>> +		if (ch != '_' && (ch < 'A' || 'Z' < ch))
>> +			seen_non_root_char = 1;
>> +	}
>> +	return !seen_non_root_char;
>> +}
>> +
>
> Nit: the seen_non_root_char variable can be replaced by an early "return
> 0" from the loop and "return 1" if the loop falls through.

Hmm, I thought that would fail when you feed "refs/heads/master" to the
function.
