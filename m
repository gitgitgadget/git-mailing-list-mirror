From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 11:13:33 -0800
Message-ID: <7vaavzqs2q.fsf@alter.siamese.dyndns.org>
References: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <alpine.LNX.2.00.1001271335140.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:16:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaDKp-0006jz-6J
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 20:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0A0TNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 14:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568Ab0A0TNp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 14:13:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434Ab0A0TNo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 14:13:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 165D594082;
	Wed, 27 Jan 2010 14:13:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qFg5DQQB1+mnfrkaJl5GA5YubY8=; b=OVot1i
	EicP86rZP02G7Bo8reCjswWY9+xIjzwnzk2iZrKHGcqEibBpe3M6cUmTEkp7f5x3
	jEnSP2gkDfH+LhulQQsmjLo9EzFC/4rOuvZztOuw+A24K6en3czi7Xuv/Wu9AESD
	d5O5TZduzodL2fp0IA9AOswmWXM0iZDmWK4lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYPp9Pwme6BLhOhWqe9xklYO16FcAVzz
	rvfccHdoMl/1eV3uwZzm++ZtMS2d+zzUol0w5X6eTNI+SdgyMnbEJcXAso64dLZd
	069cHB1E0wLwxYuwFX+RjuBW0hWuIY0QiqtzyHuBz+KxUFQ30h+RzIo9lH2VUD9r
	YgJbj0u9pYg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEEDC9407C;
	Wed, 27 Jan 2010 14:13:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABBE894078; Wed, 27 Jan
 2010 14:13:34 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1001271335140.14365@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 27 Jan 2010 13\:39\:00 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13984A28-0B78-11DF-833F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138187>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Except that you missed the "remote == NULL" case (noted below), this is 
> what I was thinking of.
>
> Acked-by: Daniel Barkalow <barkalow@iabervon.org>


>>  	if (!remote)
>>  		die("No remote provided to transport_get()");
>>  
>>  	ret->remote = remote;
>> +	helper = remote->foreign_vcs;
>
> Needs to be "helper = remote ? remote->foreign_vcs : NULL", for the same 
> reason that the test below had been "remote && remote->foreign_vcs".

Even in the presense of "if remote is NULL then we die" in the context
above?

>>  
>>  	if (!url && remote && remote->url)
>>  		url = remote->url[0];
>>  	ret->url = url;
>>  
>> -	/* In case previous URL had helper forced, reset it. */
>> -	remote->foreign_vcs = NULL;
>> -
>>  	/* maybe it is a foreign URL? */
>>  	if (url) {
>>  		const char *p = url;
>> @@ -933,11 +932,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
>>  		while (isalnum(*p))
>>  			p++;
>>  		if (!prefixcmp(p, "::"))
>> -			remote->foreign_vcs = xstrndup(url, p - url);
>> +			helper = xstrndup(url, p - url);
>>  	}
>>  
>> -	if (remote && remote->foreign_vcs) {
>> -		transport_helper_init(ret, remote->foreign_vcs);
>> +	if (helper) {
>> +		transport_helper_init(ret, helper);
>>  	} else if (!prefixcmp(url, "rsync:")) {
>>  		ret->get_refs_list = get_refs_via_rsync;
>>  		ret->fetch = fetch_objs_via_rsync;
>> -- 
>> 1.7.0.rc0.19.gb557e6
>> 
>> 
