From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 01 Feb 2010 09:19:19 -0800
Message-ID: <7vvdeg50x4.fsf@alter.siamese.dyndns.org>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:19:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbzw2-0006Ne-HT
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0BARTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:19:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0BARTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:19:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DB0696C7E;
	Mon,  1 Feb 2010 12:19:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SuQEJ1AjED2KNx6Mry3YdQK8kQo=; b=tCyG+l
	rS02+hY4esX7Fy3s8yjSlqmhj33xpm0B3FY8oZYWIMdMAJm1BJupT3L7kT2qrpZO
	QVX0qAb/4aiAjFq2jLTpqQ9TwHrdQs6qbxmO0Udq/WJAvPDy6Pf/JZvi6kSbh8OG
	jttr9YV2CzlHFVlRliIDntsO3psIbfrnffHes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SLuFBbF2t+dGUO85BmholVK8m6TyjXlJ
	IyESb3fCnqrKm9B9PmvDLOUSdpp2MhqM5bpDBzjquJFo/xA6mP+ezcJPO1o8Lhy4
	/4em1Ao71ttQYaRYv9TfZAdaGPGinElbsYGZLgLwnNYHoFpi1gpNVo4I9F7PJEaG
	mfiLeajiFuM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB22B96C77;
	Mon,  1 Feb 2010 12:19:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3862296C73; Mon,  1 Feb
 2010 12:19:21 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002011100550.1681@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 01 Feb 2010 11\:11\:55 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F27CC15C-0F55-11DF-86F4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138626>

Nicolas Pitre <nico@fluxnic.net> writes:

> Grrrrr.  This is a terrible discrepency given that all the other 
> arguments in Git are always byte based, with the optional k/m/g suffix, 
> by using git_parse_ulong().  So IMHO I'd just change --max-pack-size to 
> be in line with all the rest and have it accept bytes instead of MB.  
> And of course I'd push such a change to be included in v1.7.0 along with 
> the other incompatible fixes.

All of the "other incompatible" changes had ample leading time for
transition with warnings and all.

I am afraid that doing this "unit change" is way too late for 1.7.0, and
it makes me somewhat unhappy to hear such a suggestion.  It belittles all
the careful planning that has been done for these other changes to help
protect the users from transition pain.

Introduce --max-pack-megabytes that is a synonym for --max-pack-size for
now, and warn when --max-pack-size is used; warn that --max-pack-size will
count in bytes in 1.8.0. Ship 1.7.0 with that change.  --max-pack-bytes
can also be added if you feel like, while at it.

But changing the unit --max-pack-size counts in to bytes in 1.7.0 feels
a bit too irresponsible for the existing users.
