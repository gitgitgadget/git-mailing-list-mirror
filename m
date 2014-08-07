From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Thu, 07 Aug 2014 13:31:13 -0700
Message-ID: <xmqqoavwjb3i.fsf@gitster.dls.corp.google.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<vpqy4v1vdui.fsf@anie.imag.fr>
	<xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>
	<vpq61i4nld7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 07 22:31:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFULQ-0005Dv-PE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 22:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbaHGUbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 16:31:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52090 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbaHGUbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 16:31:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0340A2E34A;
	Thu,  7 Aug 2014 16:31:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ucH2aZHcpdKXD1S1puYMNtDrLkM=; b=VdefFB
	8s/roGeZT4YJdvFVhGC2333Tjl+BV6FIuvh/ofgWSzARhvJhs10KeJymp6RXsN5m
	tcLV+GTPdsJ+sZK1jNXpC8xstHQ2K0baF1lwEmf7czbXWDqkbQf3aef7tSyPKvMG
	AA7gO4oEk8/G+0QGeNd/cmDSrE4ta489QG+SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1vvbbbND0KBXTsTQj+jAZwTPq7cXyLl
	dMOBwkjFRevAsoxBgBU+K7ruEfdX94R45vj6J3Pvdr2yaDxSW+YarwlXlOZzTKbS
	N09HVGczi0DpoC2VMUebk62R+/PXA/KZCp04QiAo7gGqJdppFZ2+KoHpky3O9b+f
	VwSDjbsOqXM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6E2E2E349;
	Thu,  7 Aug 2014 16:31:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 05FD92E341;
	Thu,  7 Aug 2014 16:31:14 -0400 (EDT)
In-Reply-To: <vpq61i4nld7.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	07 Aug 2014 21:35:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C73743CA-1E71-11E4-B507-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254996>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> Why is this needed? Are you now using key_value_info outside config.c?
>>> Or is it a leftover from a previous experiment?
>>
>> Has this been resolved in the new round?
>
> Tanay explained in another subthread why this was needed. For callers
> iterating over the string_list who want to get the file/line info, they
> need to be able to cast the void * pointer to struct key_value_info *.

For callers that want to see all the multi-values, it would be
preferrable for the iterator to pass the filename and the linenumber
to the callback function, instead of exposing its implementation
detail as a single string list and telling them to pick it apart,
no?

Not a very convincing argument, but OK for now in the sense that we
can fix it later if we wanted to before it gets too late.
