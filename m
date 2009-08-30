From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove unused t/t8005/iso8859-5.txt file
Date: Sun, 30 Aug 2009 13:14:38 -0700
Message-ID: <7v3a79dpox.fsf@alter.siamese.dyndns.org>
References: <20090829161637.6117@nanako3.lavabit.com>
 <7vy6p3giwf.fsf@alter.siamese.dyndns.org>
 <20090829170809.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:15:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhqnh-0006H9-Ss
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZH3UOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbZH3UOt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:14:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbZH3UOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:14:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D7B1F16A;
	Sun, 30 Aug 2009 16:14:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+rkCM+i6s78HQ7TYckF8UQ5a09s=; b=R5EUMvGSRTrdfmTzvh2JmpC
	s+h7FTpXbizoUwXJX10LFf7U2n0VCNeLtwlIykswks76KimyTbNAGmXKs08zdujr
	c4wIfX5zweo3bcz5af9uCxaFyps3g5A3HU2kQgH1ujTuNya0TT8iD3PEFi2bJwuo
	M+8bttuSRNAJgQA4nidA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fKm00kGqq9e9NdijXjfUN2O9g8EG7ddFsKdxlPmKK6BePC+CW
	NO5rI0a+ymoO6yxLHhnSi1drirSHpTM9DvdU2+wg0FYECDPqh17CmVqoIeLtYwmW
	sks5FChE9TjTAn2WG7AJ7G14ZDAucTDBDkxbnJTH6n/MPmExnmrXYkcpzs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D97091F169;
	Sun, 30 Aug 2009 16:14:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 432C01F168; Sun, 30 Aug
 2009 16:14:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C49D1D14-95A1-11DE-BD9B-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127427>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Out of curiosity, how did you find this?
>
> Soon after you posted your original in
> http://thread.gmane.org/gmane.comp.version-control.git/121881, I applied
> it to my tree, and I have been running 'git pull --rebase' for ever. I
> noticed that rebase didn't remove the commit, even after your 54bc13c.
>
> Today I found that the rebased patch only removed that file. The real
> question is how you lost the deletion of the file when you applied. What
> happened?

My stupidity, and a little bit of danger in trusting "am -3" blindly.

The patch sent to the list was against the master, but the actual commit
created, 54bc13c, was on maint.  Back then, there was a commit in master
but not in maint that stopped using cp1251.txt and started using
iso8859-5.txt instead.

Because maint did not have iso8859-5.txt (which the patch wanted to
remove), when "am -3" did its fake 3-way merge, the removal of the path
did not even conflict.  It was the case of "neither side wants to have
this file".  As the result, cp1251.txt was left in the tree (which is
half-Ok, even though the updated test never looked at it anymore), and
merging the result back to master did not touch iso8859-5.txt.
