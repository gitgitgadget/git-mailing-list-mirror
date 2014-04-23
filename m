From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Archiving off old branches
Date: Wed, 23 Apr 2014 11:15:01 -0700
Message-ID: <xmqqvbtzzzdm.fsf@gitster.dls.corp.google.com>
References: <20140423120850.3f6fb535@bigbox.christie.dr>
	<20140423175820.GE15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Chase <git@tim.thechases.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 20:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1hV-0008OX-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 20:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbaDWSPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 14:15:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756420AbaDWSPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 14:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7327D93C;
	Wed, 23 Apr 2014 14:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sCHUQ8itw3sVlYW6o5Xq8kAjWW8=; b=Wi+4lF
	hEVvftj/bvyS7PyyCqs8HANgjQfyXCGp5rx1F6Irak4DiqF4dIeeUfnhhIWkVaPK
	NVCgc0jHFipr3Q2REeyDmT5UANm2R4SV9hBA2p+KQZ2aKq5o4ByX4Q9K8RE5+lN3
	m5L/BUzjQRMove7U23cnndKuuDBBTEQeaaXB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H88W55Ylwpq6HVYIe+va6QgyH89e9999
	tOc6ieepZLVqfCZlEBAjWmlqjbQMZO3zM2GOe370NXDkRKE1qVMn6xar3hzLkvK7
	xTtjJQPdvXjnlhCYmoCzxf0xkkKNu5W35O3BmYbEYAKu4ZuHRRbz7+0/j6lU3Hw+
	0Ju7jLDnsQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5D697D93B;
	Wed, 23 Apr 2014 14:15:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9D37D935;
	Wed, 23 Apr 2014 14:15:02 -0400 (EDT)
In-Reply-To: <20140423175820.GE15516@google.com> (Jonathan Nieder's message of
	"Wed, 23 Apr 2014 10:58:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 305E1598-CB13-11E3-820B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246863>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Tim Chase wrote:
>
>>   cd .git/refs
>>   mkdir -p closed
>>   mv heads/BUG-123 closed
>
> That breaks with packed refs (see git-pack-refs(1)), which are a normal
> thing to encounter after garbage collection.

Specifically,

 - if BUG-123 branch was placed in packed-refs file in the past
   (which may be older than what you have right now at heads/BUG-123
   as a loose ref), the above procedure will still make it appear in
   your "git branch --list" output, pointing at a possibly old
   commit that may even have been pruned away.

 - if BUG-123 branch was placed in packed-refs file and you haven't
   touched that branch since then, heads/BUG-123 file would not
   exist, "mv" will fail, and you won't see closed/BUG-123 at the
   end of the procedure.
