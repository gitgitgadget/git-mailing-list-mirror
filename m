From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch/checkout --track: Ensure that upstream branch
 is indeed a branch
Date: Thu, 17 Feb 2011 20:32:28 -0800
Message-ID: <7vk4gy55er.fsf@alter.siamese.dyndns.org>
References: <201102151852.03881.johan@herland.net>
 <201102161146.23749.johan@herland.net>
 <7vwrkzhc7x.fsf@alter.siamese.dyndns.org>
 <201102170012.20964.johan@herland.net>
 <alpine.DEB.2.00.1102171937460.14950@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:32:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqI1U-0000rV-SW
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab1BREcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:32:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BREcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:32:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CE5A49AF;
	Thu, 17 Feb 2011 23:33:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6LpcYshiImv2VQx+HmxG3KOhwUs=; b=UO8+yMweaYiCa/dAfJHAu0r
	B4SRfyIvzNBik+4HQTjEE+EbYXGDuKlyJ9loQfylO1guFqpxxxWCp5pzED2fNZPd
	u1tUayXGJlOMkGnmj5PTLHMbpJmIZdCHY8IskW8oCLKCLgGlh+tcZZ+FCXh5kjMC
	elBLx75O4QZ8oMN1gYB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TuhskvgliwkAKeGoqd2/d3ScHSv7EMbw/FiY6moUA3nhAgPZU
	V4HaCKwoLy7gTbSLxRO9Tzj26Efm8MOsEMIGHyDSShFq4BbEJ0OqMPx3HcuwajCd
	OL/0qPcQxfwQhR+B9WPQWlj3xu4dt9ImfnLO04kzEXgYArefvycn7zmRiE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C4C849AA;
	Thu, 17 Feb 2011 23:33:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 020B249A6; Thu, 17 Feb 2011
 23:33:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44363584-3B18-11E0-81B1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167168>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> In some workflows (e.g. Linux kernel, IIRC), it is recommended to base
> your work on a tag.

But the thing is, "base your work on some known point" is a rule invented
exactly to discourage casual and frequent rebasing.

If you started your work on v2.6.36 and need to rebase to a more recent
version, you won't be using "rebase @{upstream}" notation _anyway_, as the
old base you forked your work from that you would refer to as @{upstream}
will not be moving.  You will instead rebasing on top of a _different_
commit, perhaps v2.6.38 or something.

So the workflow would look more like: 

	$ git checkout -b frotz-2.6.36 v2.6.36
        ... develop "frotz" feature on top of 2.6.36

        ... time passes ...

	$ git checkout -b frotz-2.6.38 frotz-2.6.36
        $ git rebase --onto v2.6.38 v2.6.36
	... inspect the result and it looks good.
        ... if  you don't want frotz in 2.6.36 then...
        $ git branch -D frotz-2.6.36

There is not much point in using @{upstream} when your branch management
is as disciplined as that recommended practice you cited.
