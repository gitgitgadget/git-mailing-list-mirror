From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] custom format for interactive rebase todo
Date: Tue, 09 Sep 2014 10:07:12 -0700
Message-ID: <xmqqha0glo3j.fsf@gitster.dls.corp.google.com>
References: <864mwhi9qu.fsf@gmail.com>
	<xmqqtx4gloii.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Clifford <mr.william.clifford@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:07:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XROt9-00077I-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 19:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbaIIRHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 13:07:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53429 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbaIIRHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 13:07:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7D83377CE;
	Tue,  9 Sep 2014 13:07:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9knlz7Nx1BsUj9n4mkBM/JMTYX8=; b=fNI7Af
	bznybtt2Rq3WAIKsxq4yt9sSAF5CgacuTc9urn6IFmrdVsL2uy/Cgs9gpMDkefAr
	3OE/ZVBsNk8lDHvPMD1p9Qt3xO1mvAu0GPUsRoRAIqlPdfGrjxXSg53VDPkRBw5K
	W4DtIwcJC8mW9sdpaJMdofnPMrXWLR18Pe7FY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TdEW/D7vC63YhsiUSUdcOAfnlocr0H3x
	vemwFoG5fqvY06L2frdw/Hf9ZK61GnOFN1nAap2MqSbBvTKfoVwnWEO0ad1fp5p4
	svqI/Tsyc0mER82c9EhMJWDCoLwod2GGMoIkTscfPcn+MSoxycc7Y7a7z9VE8R9X
	Rd2abyLewc8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF781377CC;
	Tue,  9 Sep 2014 13:07:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D451377C5;
	Tue,  9 Sep 2014 13:07:14 -0400 (EDT)
In-Reply-To: <xmqqtx4gloii.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Sep 2014 09:58:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEF89F2E-3843-11E4-B77C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256696>

Junio C Hamano <gitster@pobox.com> writes:

> William Clifford <mr.william.clifford@gmail.com> writes:
>
>> A couple of examples:
>>
>> - `git config sequence.format "%<(12,trunc)%ae %s"`
>> - `git config sequence.format "%s <%aN %aE>"`
>> - `git config sequence.format "%s%n%%n%b"`
>> ... I'm unsure what would happen if I tried to rebase with the
>> third style unedited or uncommented.
>
> It should be simply forbidden.  The body part may have a line that
> is similar enough (i.e. starting with one of the command words and
> then a hexadecimal string) to confuse the sequencing machinery.
>
> Other than that safety issue, I am not fundamentally opposed to the
> idea.
>
> As to the implementation in 1/2, your unconditional use of ">%h" is
> wrong (you would end up including the commits from the left side).
>
> Use '%m' instead of a hardcoded '>', perhaps?

Also, I do not think you want to make the prepending of "%m%h "
conditional.  If the user for whatever silly reason asks to use a
format "%m%h %m%h %m%h", let her have that _after_ the "%m%h " the
machinery needs to operate, i.e. "%m%h %m%h %m%h %m%h".  It is far
easier to explain to the users and you can lose three lines from the
second patch.
