From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--interactive: don't enforce valid branch
Date: Sun, 14 Mar 2010 22:42:03 -0700
Message-ID: <7vvdcygmz8.fsf@alter.siamese.dyndns.org>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com>
 <7vsk82i2kd.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 06:42:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr34D-0001yX-1b
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 06:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759660Ab0COFmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 01:42:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759645Ab0COFmL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 01:42:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3843A2C94;
	Mon, 15 Mar 2010 01:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pzxpZCZfe3wleofulFvxgqFfarI=; b=VD2Nee
	GQt9BuIjizudShaMNWxiYGptckf7FGNdbqHM2YePH7XHJ3J+A35SoFeqvIe2nm6C
	APpZrV2OdGUYEQxX4VqpyoarFpQZyMtiGhTXVjBYBIUnMA9eZi3csQPIEE+dFyHd
	A6JFvq9nAEDdWJvtVV89tGETKSSZn0HhEHnFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cE3p+VtrdCBG1e+OS9bB4GeCjIhF1mZk
	S1PaHBJ7xvgGe9HxzKiN7LWyLSL3mmRKSVzPbxDSIbMoVdl3iJ5hr3XyeD8yo+of
	KWeXnn/Ojuls0pvGBR5swzPch+lfAxVn/rJJz7CSQEM3CVkAXXcET8Uf7fhPufeA
	OJgj7K9h7l4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D71EA2C93;
	Mon, 15 Mar 2010 01:42:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1D22A2C90; Mon, 15 Mar
 2010 01:42:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net>
 (Dave Olszewski's message of "Sun\, 14 Mar 2010 22\:28\:43 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7EC6BFCC-2FF5-11DF-86B5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142171>

Dave Olszewski <cxreg@pobox.com> writes:

>>> +test_expect_success 'rebase while detaching HEAD' '
>>> +	grandparent=$(git rev-parse HEAD~2) &&
>>> +	test_tick &&
>>> +	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
>>
>> What's the point of saying this?  You could instead say:
>>
>> 	git rebase -i HEAD~2
>>
>> no?
>
> There's already a test for rebasing on a previously detached HEAD.  The
> form "git rebase -i HEAD~2" specifies a non-branch upstream, but doesn't
> take the branch argument which is the point of the change.

What I meant was that if you prefer to work on a detached HEAD (and I
sometimes do), then your HEAD would likely to be detached already when you
run rebase.  IOW, I would expect that 

	git checkout HEAD^0
        ... perhaps do something, perhaps do nothing, here ...
        git rebase -i HEAD~2

would be a lot more natural thing to do, and in that case you do not need
to say HEAD^0 there.
