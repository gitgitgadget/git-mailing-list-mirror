From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Thu, 13 Mar 2014 10:47:28 -0700
Message-ID: <xmqq4n32j8i7.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqha73jb6q.fsf@gitster.dls.corp.google.com>
	<877g7yipf9.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Quint Guvernator <quintus.public@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9jE-00079v-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbaCMRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:47:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397AbaCMRrb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 13:47:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 922BC7333F;
	Thu, 13 Mar 2014 13:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mgBh/Cup/rG3q2Zhbf//ww4BTHE=; b=CPG4Nm
	YGY+nv5iqcJ59Mhxa4VIpFdpex8OglLCPbcjUxa9mBiOYx40oWBNUC7+JPMGFzUd
	b1sIbbkKpg8FmfHdn0mExmdyr3Ft4m+5CCN3T53634e8ZyRqum8Kg0Nso6/4KcNF
	/DBhVZqRDelpI+2N8g9zyB632XJgJVz9GuKxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cuPGMcbIiQrTfLGtKtaJ4A6I6UkQzDQF
	QQR6ZENpvw19CH84X0a/yUKFZJ77B/vCdq8EaZ03nsoKdDpY3iH6QCY3TscoG/K8
	eIFv+aW3K1nNmxe0/nvDImjiBO6//O/MCjk1MuPGbom31/r+7OTimgx1Cb0c6hR3
	Y+R1BZkmLMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 787A37333D;
	Thu, 13 Mar 2014 13:47:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB6E573339;
	Thu, 13 Mar 2014 13:47:30 -0400 (EDT)
In-Reply-To: <877g7yipf9.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 13 Mar 2014 07:27:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8CBD427A-AAD7-11E3-8A63-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244039>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Taking two random examples from an early and a late parts of the
>> patch:
>>
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -82,7 +82,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>>  				enum object_type type;
>>  				unsigned long size;
>>  				char *buffer = read_sha1_file(sha1, &type, &size);
>> -				if (memcmp(buffer, "object ", 7) ||
>> +				if (!starts_with(buffer, "object ") ||
>
> [...]
>
>> The original hunks show that the code knows and relies on magic
>> numbers 7 and 8 very clearly and there are rooms for improvement.
>
> Like: what if the file is empty?

Yes.
