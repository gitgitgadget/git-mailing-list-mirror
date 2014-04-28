From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 28 Apr 2014 13:00:09 -0700
Message-ID: <xmqqppk1p6ly.fsf@gitster.dls.corp.google.com>
References: <1398713704-15428-1-git-send-email-dborowitz@google.com>
	<xmqqtx9dp6rd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weriv-000871-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275AbaD1UAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:00:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbaD1UAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:00:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F7ED8185B;
	Mon, 28 Apr 2014 16:00:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pRb3RgqEL7tdLMt6THnSWLv2o2s=; b=NKhFQR
	AvdMIYS98JKqO1OgHr2WfEY21UgDtFHksgkVEn09cnCjFrU66itdfWGUDJkgNMy8
	o0Qas6gm1HsdbJtWxIiguLgPzEkw0N/OVwn/AN1PLCiEtokAfxqBn8gG5I1cIHPf
	F4olpxXVppAM6EWG/wBtY+4nOe9uXt/JLOShM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XPgnZu7SvctbuCGDSuRBChu/hMzAYXoG
	Dbk+MEhvdns6yrbVm3CmDPE9urHV5++Z/5T00o3IteOSvLVBC+Kl4mutrhhKwZLq
	4MsFxIVLvaNwp7hR6hfoSO+XeLmN32ap3y0syu5CAFMYMY9wk8/4P+AZa0JIPCEp
	OlA29E9Xwms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B878185A;
	Mon, 28 Apr 2014 16:00:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53C058183F;
	Mon, 28 Apr 2014 16:00:11 -0400 (EDT)
In-Reply-To: <xmqqtx9dp6rd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Apr 2014 12:56:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4A97CD4-CF0F-11E3-9844-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247432>

Junio C Hamano <gitster@pobox.com> writes:

> That does not mean the patch will give us a broken behaviour,
> though.  It just means the ifeq/else part will be redundant.
>
>>  	endif
>> +
>> +	ifeq "$(CURL_LIBCURL)" ""
>
> This will catch the "$(shell $(CURL_CONFIG) --libs) assigned an
> empty string to CURL_LIBCURL" case, so the result is good.
>
> I haven't checked what it would look like if we turn this into an
> incremental patch to be applied on top of 'master' (which would give
> us a place to document better why we do not rely on the presense of
> curl-config), but if we can do so, that would be more preferable
> than having to revert the merge of the previous one and then
> applying these two patches anew.

And I just checked; it is not very pretty to call it "trivially
correct", and I would feel safer to revert the merge for 2.0, and
queue the new one for the next cycle, cooking it in 'pu' and then
'next' in the meantime.
