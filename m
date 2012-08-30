From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GC of alternate object store
Date: Thu, 30 Aug 2012 09:03:34 -0700
Message-ID: <7vbohstlih.fsf@alter.siamese.dyndns.org>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <loom.20120827T233125-780@post.gmane.org> <hbf.20120828vnfp@bombur.uio.no>
 <20120829074249.GA14408@ugly.local> <7v3935y9tw.fsf@alter.siamese.dyndns.org>
 <20120830095314.GA29038@troll08.europe.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Oswald Buddenhagen <ossi@kde.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T77Dc-0004Am-18
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 18:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab2H3QDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 12:03:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab2H3QDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 12:03:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32B7E7958;
	Thu, 30 Aug 2012 12:03:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wADMs8oM+RJCA7XOHIMFHP0BHKQ=; b=wiklvN
	GTmoTaQ7dqESCZ8OfYAHSxBSEJWZ2Jgc+Jyxi5Qx4GGVMg6B2ibknygv19vI2cv/
	lGaLQSnEU6XH4FVpb7FRtNc3F/0Dorg/1IcJI4hfI6AmJOS5H5wI2LisZRJl2763
	R1fp2PJ9sdGYKLNHNqSpmPfcUv1iXB1cb59mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E/Fc3CNaQyxh/fZLFeKH0TI3Mya5yElr
	O6CSl4ZkTWLCJ7cXOfRZt+iFpV/qohvUUAZUDpQHxaTbJq3IHmZ913aAt5YD4ztV
	4I2gUm9vjI76TwODulrqGO/16jseK0u/WFAM/vsz+UVmAAHKrBHTC7grH9KI0kQn
	Q4ZzT4gO2BQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2008F7957;
	Thu, 30 Aug 2012 12:03:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 918747956; Thu, 30 Aug 2012
 12:03:35 -0400 (EDT)
In-Reply-To: <20120830095314.GA29038@troll08.europe.nokia.com> (Oswald
 Buddenhagen's message of "Thu, 30 Aug 2012 11:53:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40FEAC72-F2BC-11E1-A71C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204544>

Oswald Buddenhagen <ossi@kde.org> writes:

>> Doesn't
>> 
>> 	git push $over_there 'refs/*:refs/remotes/mine/*'
>> 
>> push your tag v1.0 to refs/remotes/mine/v1.0 over there?  The
>> version of git I ship seems to do this just fine.
>> 
> as i wrote before, i'm pulling, not pushing,...

You would need to decline the automatic tag following with --no-tags
(which in hindsight is misnamed; it really means "do not auto-follow
tags"), like so:

	cd $over_there &&
        git fetch --no-tags $my_repository 'refs/*:refs/remotes/mine/*'

Otherwise, you will also get tags in refs/tags/.
