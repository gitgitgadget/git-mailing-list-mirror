From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] remote.c: add command line option parser for --lockref
Date: Wed, 17 Jul 2013 10:09:42 -0700
Message-ID: <7vip096rl5.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-5-git-send-email-gitster@pobox.com>
	<20130716221318.GA2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 19:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzVEb-0001jp-MN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 19:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab3GQRJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 13:09:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab3GQRJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 13:09:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CEA131D82;
	Wed, 17 Jul 2013 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YaRXoZmcf/1BuuvwViRJoOQeijw=; b=bKcpwj
	dL4mjWSfBSEIG/bASa8PPL6gMhGChZbrgOhyGQMOScKjQLddB6dWFpB0IgPjK1ER
	fkLxpxM/X32i86ZNQL6vYLNcveQNBfO8vexF+Xnlj463Uh2qdITBCN3C4JjNQl1i
	nQGnl/YUnhKh1TIfWyjlMH6/3lfUZbBg0H6KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UWHLQlxTfs8nEjCmSVW4D/D/xDfAdE5t
	k36+Kxb4dlhzcCND4j/HWxmExbEOHH05Rt1bHVn321vDtSBxgh4oOsRqdqANsk0s
	h24QDh38Mf16CTuehi40il6Js9xo8f2v8Oc0VZl12bDJSvrJk0HTuquE089rj8HO
	jpgu6sCc6bk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F9A731D81;
	Wed, 17 Jul 2013 17:09:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B78B731D7E;
	Wed, 17 Jul 2013 17:09:43 +0000 (UTC)
In-Reply-To: <20130716221318.GA2337@serenity.lan> (John Keeping's message of
	"Tue, 16 Jul 2013 23:13:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACCCEDC6-EF03-11E2-BA30-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230637>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Jul 09, 2013 at 12:53:27PM -0700, Junio C Hamano wrote:
>> diff --git a/remote.c b/remote.c
>> index 81bc876..e9b423a 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1938,3 +1938,62 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
>>  	string_list_clear(&ref_names, 0);
>>  	return stale_refs;
>>  }
>> +
>> +/*
>> + * Lockref aka CAS
>> + */
>> +void clear_cas_option(struct push_cas_option *cas)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cas->nr; i++)
>> +		free(cas->entry->refname);
>
> Should this be
>
> 	free(cas->entry[i]->refname);
>
> ?

Yes, more like "free(cas->entry[i].refname)".

Thanks for spotting.

>
>> +	free(cas->entry);
>> +	memset(cas, 0, sizeof(*cas));
>> +}
