From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Mon, 26 Oct 2009 00:14:26 -0700
Message-ID: <7vbpjupqy5.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
 <7vljjfuibr.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
 <20091013215751.GA12603@coredump.intra.peff.net>
 <7vhbu2syi6.fsf@alter.siamese.dyndns.org> <4AE48F88.1030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Uri Okrent <uokrent@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 08:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2JnB-0000lv-MZ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 08:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbZJZHOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 03:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZJZHOu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 03:14:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbZJZHOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 03:14:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13CD5859B2;
	Mon, 26 Oct 2009 03:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YoECPnnCn12kLYbRoVkwQ1YEaZw=; b=d41uPlPFhgl5/uC3WQ8ZMZu
	wV5E08nDdRWNEHHqQuqSAnJBODXeT954/kl3TUfTXMX7zKhkkINQIbMFc1cMt9GH
	r2m3HwHGtipUlattbCgHyxQZqQrg7GWCioKCCj8gusdLnhBXgDHVzUGk3JmOOXa4
	z816QClRrzMotl/DXnnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GU1RpOr8AYVNWDt0OADwKMJGe7Qvvi7A78UeUnpP9l+1i/gdR
	cdbcyGrJ6Mu4eFl/y9s/9szYUiGgESvroKyhw5N+ixI5435t2tZ+QmcmG+88IXyt
	RQgZgqhNxjlBD+L95arTrWVffwX2W6omDvR75u+nq8W7i1AbWQk7Pp3rO8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 776FF859AE;
	Mon, 26 Oct 2009 03:14:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CDF5859AD; Mon, 26 Oct 2009
 03:14:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B5D307C-C1FF-11DE-9E06-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131244>

Uri Okrent <uokrent@gmail.com> writes:

> Junio C Hamano wrote:
>> In this sequence:
>>
>>     1$ git checkout $commit_name_that_is_not_a_local_branch
>>     2$ git commit; hack; hack; hack;...
>>     3$ git checkout $branch_name
>> [...]
>> Step #3 is where the state built in the detached HEAD "branch" vanishes
>> into lost-found.
>>
>> The experts argued that #3 is where it is dangerous...
>
> If step 3 is where the danger lies, wouldn't it then be most appropriate to put
> the warning message there?

You already get reminded that you were on a detached HEAD in step #3.

The primary point of the message you are replying to was that I do not
agree with the view that step #3 is the most problematic step.  The
existing reminder would help people who read it and are capable of
realizing "ah, I started it on a throw-away branch but ended up with
something I would rather keep" and doing "git branch topic HEAD@{1}".  

It will not help people who haven't got enough clue yet to know what a
detached HEAD is, or you can refer to your previous point with HEAD@{1}
notation.  We do give brief advice at step #1 to alleviate this issue.
