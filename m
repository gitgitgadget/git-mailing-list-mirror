From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Thu, 12 Jun 2014 12:12:58 -0700
Message-ID: <xmqqegyu54cl.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
	<20140605060640.GB23874@sandbox-ub> <5391FFC3.5010001@gmail.com>
	<20140610101744.GA23370@t2784.greatnet.de>
	<53981D6A.3090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:13:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAQw-0004HE-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaFLTNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:13:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52169 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbaFLTNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:13:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBFD21EE41;
	Thu, 12 Jun 2014 15:13:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tyAsbcfV5HEdYlBZD0M6xXq/o8o=; b=WJJbKN
	YXjS/uHzZ+qdqdCaHMS8pMLAaStQ9Jksg4wKtmPwBMDnw99U7leFDKfaiPo/yP4D
	xQEvrrAbhjXA+qdSOuw0F8bNYjcs4+tV6fP2/pS/TB0nIG4cUer7bBt6wx7NmozF
	/xa7f5xnZJ1NVDcD8VepOYIb+vH3ovdf4s71A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xKWxPrYJkmrDBfaBzy2cGbgcL4zctZbE
	VkfnNtZCC8YHHX6uOITbZ5gXcX2Q7SLbxmWUs8va98Hm+6RYs8t4ENAgtbx55Jhf
	xq/zXD6zxwS3D92ea9ygYK1I8ab3MOUz4zz99dYUa23DGpGNZRQfeY2gC01XEcg1
	YGkvopr0nlM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFB8D1EE40;
	Thu, 12 Jun 2014 15:13:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9C97B1EE34;
	Thu, 12 Jun 2014 15:12:59 -0400 (EDT)
In-Reply-To: <53981D6A.3090604@gmail.com> (Karsten Blees's message of "Wed, 11
	Jun 2014 11:12:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 916A880C-F265-11E3-84CF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251481>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 10.06.2014 12:17, schrieb Heiko Voigt:
>> The intention of Jonathans critique here[1] was that you do not see what
>> this parameter does on the callsite. I.e.:
>> 
>> 	hashmap_free(&map, 1);
>> 
>> compared to
>> 
>> 	hashmap_free(&map, HASHMAP_FREE_ENTRIES);
>> 
>> A boolean basically transfers the same information and would not help
>> the reader here.
>> 
>> Cheers Heiko
>> 
>> [1] http://article.gmane.org/gmane.comp.version-control.git/243917
>> 
>
> There are languages where you can have e.g. 'hashmap_free(...,
> free_entries: true)'. In C, however, you do not see what a
> parameter does at the call site. This is a general language
> feature, reducing redundancy and keeping it short and concise. IMO
> there's no reason to treat boolean parameters differently.

But given that you are writing in C, is any of that relevant?  We do
want to keep our call-sites readable and understandable, and 1 or
true would not help, unless (1) you are the one who wrote the
function and know that 1 means free the entries, or (2) the API is
so widely used and everybody knows what 1 means free the entries.
