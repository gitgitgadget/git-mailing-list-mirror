From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: provide better prefix to go back to original
 cwd
Date: Wed, 06 Oct 2010 11:32:20 -0700
Message-ID: <7v4ocz18az.fsf@alter.siamese.dyndns.org>
References: <1286373578-2484-1-git-send-email-pclouds@gmail.com>
 <20101006180727.GA2118@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, judge.packham@gmail.com, Jens.Lehmann@web.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 20:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3YnR-0004Fa-Fr
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 20:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759680Ab0JFScf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 14:32:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759667Ab0JFScf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 14:32:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB8EDC524;
	Wed,  6 Oct 2010 14:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kFjlTDBxQYxgEM4Evtj9oIsCawo=; b=PmlPe5
	jiWwTG5Mz+wKFWry39+oIjB+iUe5mHdwy4wkdmu561KcoTbFAYjUvi8oqTZDSWDQ
	JTeGXnW9nSQDbMn/GzOUFPEpRYZRCQL9tkqGlmip1kg2zu/2R4iyoEkvKPFlR1HH
	W56IcA41kSzC8E9mNDt2a2GIilKqQR2WU42bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MR1Wwqza2YTLLowEItbW5MUiCerz32O/
	vNWlzYjledCs42nn0mfQey1vbzg+2E8FUikwrF3EWmRZOSCLFCCV1/aPxLYXeHCc
	rNbev6F6852CBGrPtAMsZJtxHiMQCySYFIm2SGcH/6wQaeUj0XNR4qIr4DkN2RkC
	l+1Rc99nL04=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB3BDC520;
	Wed,  6 Oct 2010 14:32:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30056DC51C; Wed,  6 Oct
 2010 14:32:22 -0400 (EDT)
In-Reply-To: <20101006180727.GA2118@burratino> (Jonathan Nieder's message of
 "Wed\, 6 Oct 2010 13\:07\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 129975A4-D178-11DF-BCCA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158300>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Are there any examples to illustrate whether teaching --show-prefix to
> do what your --worktree-to-cwd does would be a good or bad idea?
> (Just curious.)

Do these additions interact well with the notion of "we are in the working
tree" vs "we are outside the working tree"?  Even when we happen to know
via GIT_WORK_TREE that the root of the working tree is /var/tmp/junk, we
should correctly diagnse that we are outside the working tree when we are
in /var/tmp/, and require_work_tree should say "no you are not allowed to
do this", no?

>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1110,6 +1110,8 @@ const char *split_cmdline_strerror(int cmdline_errno);
>>  /* git.c */
>>  struct startup_info {
>>  	int have_repository;
>> +	char *cwd_to_worktree; /* chdir("this"); from cwd would return to worktree */
>> +	char *worktree_to_cwd; /* chdir("this"); from worktree would return to cwd */
>
> Comment nit: would
>
> 				/* path from original cwd to worktree */
> 				/* path from worktree to original cwd */
>
> be clearer?

Much better.
