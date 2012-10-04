From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 04 Oct 2012 13:44:06 -0700
Message-ID: <7v8vbmx90p.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7vhaqaxawh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJthr-00033L-7i
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab2JDUoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:44:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab2JDUoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:44:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D21FF96EF;
	Thu,  4 Oct 2012 16:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dVvcGsD9hElzuVwyQOG9MRuhXsw=; b=vNuta6
	lbzLBWX3cO+p6OIftF5JRzs7MzWhNU53CjS4Yw/NMKok0B4Q0G2HwHTF7la4HvAD
	Fgp9oZphyOnizmQVOPkuBrWxop4Bd593LxlVUU6ZJgNxwjiXqKUIqYXYvHMDsMFa
	JMGuSuRXY8ggEbhPoo8zygT//1yAbY2MtvMW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qT64QOMvHOSt5fDZ3nTuR0UwYH+Gnquu
	qQYmWtpPMxDwQI2La/p720lscuvdtFRTihRJ6eKc3xWm5Kmk8jSjypw/Thyf7voL
	5JtzSzCPj0gP3ljziFq+P+bwOrzYFJuFaoddBpmpM/1dXx8oj08hH+6f60v4Leth
	ZI0MGUZmu9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD7CE96ED;
	Thu,  4 Oct 2012 16:44:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35C0896EB; Thu,  4 Oct 2012
 16:44:08 -0400 (EDT)
In-Reply-To: <7vhaqaxawh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Oct 2012 13:03:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E7AB91E-0E64-11E2-B7B4-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207023>

Junio C Hamano <gitster@pobox.com> writes:

> It gets more curious, though.
> ...
> However.
>
> If I revert 5802f81 that updated the implementation of fmt-merge-msg
> on top of 'master', *without* reverting 34f5130^2, I get ~4.5 seconds.
> As we are doing an "Already up-to-date" pull, I thought there is no
> need to call fmt-merge-msg in the first place?
>
> Which may indicate that "git merge" has been broken for a long time
> and making unnecessary calls.
>
> Hrmmm...

Actually there is nothing curious about this.  "git pull" prepares
the merge message before it calls "git rebase" or "git merge", and
there is no fast-path that detects "Already up-to-date" in it.
