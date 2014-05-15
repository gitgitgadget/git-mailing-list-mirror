From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: request-pull with signed tag lacks tags/ in master
Date: Thu, 15 May 2014 15:13:57 -0700
Message-ID: <xmqqtx8qd716.fsf@gitster.dls.corp.google.com>
References: <20140515163901.GA1403@redhat.com>
	<xmqqzjiiev1a.fsf@gitster.dls.corp.google.com>
	<xmqqr43uetyp.fsf@gitster.dls.corp.google.com>
	<20140515213925.GI1699@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:14:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3uj-0006os-8T
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbaEOWOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:14:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60028 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbaEOWOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:14:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6017318EF0;
	Thu, 15 May 2014 18:14:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XE01lu/+AsdfWvfdBQ+1099LRWU=; b=CgUgN5
	fign//i3RXpAoPaktBubnTObHdaMCnQQKTZ5HxPVPpE1rciTzAzJG3FzTTVA141y
	K+pCyFSJ5osw8l8KK3PnAJbgpMKAICVx2TUgGoonCO+I+APkk4u3eKlMn/k9UEBR
	eM+LfThJYn1sRY4XNeFKBGPcGrPlQ4VGTXBUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vn5WleWzHwRoy0vKBE8+H0mNq3oqsrMG
	EIP2WAaEmc/Bbmr1gUvDi5CBsgWk3/ESNDxAxjwRmZ+fTPL5QNjccVaHqBXnWBe4
	Fo0hBSMy8xk/kSsyejMOofHQ58IvdEIjFWJLWMX2NEoGsgBLSO6pyxOIGQJnIa4P
	v5RHyzmnmT4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 548DB18EEF;
	Thu, 15 May 2014 18:14:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7485818EE9;
	Thu, 15 May 2014 18:13:59 -0400 (EDT)
In-Reply-To: <20140515213925.GI1699@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 16 May 2014 00:39:25 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36D05C02-DC7E-11E3-B90C-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249210>

"Michael S. Tsirkin" <mst@redhat.com> writes:

>> My reading of the earlier parts of the series is that Linus wanted
>> us never dwim "for-upstream" to "tags/for-upstream" or any other ref
>> that happens to point at the same commit as for-upstream you have.
>> The changes done for that purpose covered various cases a bit too
>> widely, and "request-pull ... tags/for_upstream" were incorrectly
>> stripped to a request to pull "for_upstream", which was fixed by
>> 5aae66bd (request-pull: resurrect "pretty refname" feature,
>> 2014-02-25).
>> 
>> But that fix does not resurrect the dwimming forbid by the earlier
>> parts of the series to turn "for_upstream" into "tags/for_upstream".
>> 
>> What would you get if you do this?
>> 
>>     $ git request-pull origin/master \
>>       git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git \
>>       tags/for_upstream | grep git.kernel.org
>
>
> I get
>  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

Thanks for double-checking.  Let's close this as working as
intended, then.

I personally feel that the "intention" tightened the logic a bit too
much [*1*], and with the updates mentioned in [*2*], existing users
may find it still too tight, but that is what we have today.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/240860
*2* http://thread.gmane.org/gmane.comp.version-control.git/240886
