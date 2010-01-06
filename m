From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Tue, 05 Jan 2010 17:06:43 -0800
Message-ID: <7v4on0oxcs.fsf@alter.siamese.dyndns.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
 <1262122958-9378-10-git-send-email-gitster@pobox.com>
 <4B43AE38.9070800@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKMS-0006ox-0f
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab0AFBGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510Ab0AFBGw
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:06:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab0AFBGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:06:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 164C98E262;
	Tue,  5 Jan 2010 20:06:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SgfaiQYQnV33aiz+rNKIBQDhXW8=; b=k8UXHAoqqqVe3dxfSAkWO86
	edzt9cn+LzckIdIEdyFRjNyRvtt549K+SDtCoQk2rQbL+09O22aQdyya2Te2TSTr
	BCdi90FtW4YIAQ9bCcSykqtIXl9onkziYyWSqCTqXKOdg04uH2/kPvXxDubEaNZp
	UkxTq/0uDK4BReyaTFg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=deyj3CdKdbyj7Yp+Zc77mwadIV819wxsh3tYLlD853n3p4A/Z
	/ZHwG1CWCFzhzD6V6mCjLHzWhq1TEfh0Bznn//GQoxtFUZ3VsBCmgtgOcNfsc0iQ
	vNjxfpws+GrLHhvXrBKg+h0rhaS/0qtd4KqPieIRNQjcOYLyIWBnjxJ498=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE2B78E261;
	Tue,  5 Jan 2010 20:06:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4E848E260; Tue,  5 Jan
 2010 20:06:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C436ADC2-FA5F-11DE-AD0A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136229>

Johannes Sixt <j6t@kdbg.org> writes:

> Junio C Hamano schrieb:
>> After you find out an earlier resolution you told rerere to use was a
>> mismerge, there is no easy way to clear it.  A new subcommand "forget" can
>> be used to tell git to forget a recorded resolution, so that you can redo
>> the merge from scratch.
>> ...
>> diff --git a/rerere.c b/rerere.c
>> index f013ae7..c1da6f6 100644
>> --- a/rerere.c
>> +++ b/rerere.c
>> ...
>> +static int handle_cache(const char *path, unsigned char *sha1)
>> +{
>> +...
>> +	ll_merge(&result, path, &mmfile[0],
>> +		 &mmfile[1], "ours",
>> +		 &mmfile[2], "theirs", 0);
>
> When you simply call ll_merge(), will it obey any merge drivers that
> are defined in .gitattributes? Do we care about them?
>
> I already had an implementation of "rerere forget" before you
> presented this solution, but it relies on that the user calls
> "checkout --conflict=merge" first. One reason (besides its simplicity)
> was that it does not have to care how the merge is computed.

Doesn't "checkout --conflict=merge" use the same ll_merge() machinery?

> [I haven't submitted my solution, yet, because I haven't had the time
> to do this large merge where I expect to make use "rerere forget",
> testing its usefulness.]
>
> -- Hannes
