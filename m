From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Wed, 05 Mar 2014 10:40:08 -0800
Message-ID: <xmqq38iwij5j.fsf@gitster.dls.corp.google.com>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
	<87eh2hi7jk.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:40:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGjs-00050J-M7
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbaCESkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:40:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbaCESkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:40:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD856F5D6;
	Wed,  5 Mar 2014 13:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ReQ1u1LdvGWzvLnCN1rJNJhq7aI=; b=fLgG4w
	R8RGmUr82cstdYefD9UMogjVmNF6249789tQG8ifAH12/CrIo3y/gRSGoSE5HJKu
	Yu/DgGVYT2+/+FMWEDU2OHMwhIgTC/bwqcIKSE/jilnLjsX2yoXUaEWH/hsOubx0
	vplG3UTs+qKZHAJ8z/l4wHZ8kgS2qnevg3BWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L/5+qTjxy0V8c0IY4R0e+sbspYM2OKmv
	kQlzBwaQc9RinjdCrjdlnq3/cZqJM9g2jPbuBESZYrrgT13fqCN7ks0z73nA3OEs
	vdjO5uSny65hUmB2ezFq97GwG9TOiSdi17P4cyeFJFeN/2kW239IjmbYxXV1VXHA
	0BWD/8elFo4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4D2B6F5D5;
	Wed,  5 Mar 2014 13:40:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E5F86F5D0;
	Wed,  5 Mar 2014 13:40:11 -0500 (EST)
In-Reply-To: <87eh2hi7jk.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 05 Mar 2014 05:38:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 95310FBA-A495-11E3-ACF2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243460>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>>  	while (*path) {
>>> -		const char *slash;
>>>  		struct cache_tree_sub *sub;
>>> +		const char *slash = strchr(path, '/');
>>>  
>>> -		slash = strchr(path, '/');
>>>  		if (!slash)
>>>  			slash = path + strlen(path);
>>
>> Isn't the above a strchrnul()?
>
> Yes.  I realized that previously, but since it's a GNU extension rather
> than part of the C standards, I discarded that idea.  Calling
>
>     git grep strchrnul
>
> shows, however, that it _is_ used plentifully already.

Yes, we have a fallback definition in compat-util, I think.

> Still worth thinking about whether there is no better name than slash
> for something that indicated the end of the current path name segment.

end_of_path_component?  Sounds a bit too long ;-)
