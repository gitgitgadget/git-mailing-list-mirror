From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] receive-pack: Add receive.denyObjectLimit to refuse
 push with too many objects
Date: Fri, 13 May 2011 10:09:53 -0700
Message-ID: <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
References: <201105131854.31540.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 13 19:10:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvsQ-0003O1-Gl
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 19:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759562Ab1EMRKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 13:10:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759142Ab1EMRKC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 13:10:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B00A4D29;
	Fri, 13 May 2011 13:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E93HsSoXpdNSC+2YYN3ErPtA09s=; b=WPGrpx
	jU1WQLsuzwNsYrKRGSVrZoNdobKNs2WD0ly76ZQnNMj3epUpqqWJPHMKz5owvAa1
	050Kf7t0JL83cZtaee+QzFKCsWxXKB/dXBPwMO4CL1azlF5Avn4N8Nm3D/kH3Auq
	n1n22Sdg787IMTgxIS9+n2qFk4LgXlCUIhTmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CKcL7/5MDLUjNH0vCjFiEesJC2vlwhqz
	IIehnEF8VBrwQAMphdrHyHCQfDjvYkpNnjtikTeoOWfg8dt2DQx59/OChkuovMcQ
	DVZwmD8hxblx3tZaeYm4Rb8BgafGuumT4jaP+KPFUtGhP8eesx5NvNTND2P91I/1
	6U8S3ZE/Pes=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4C164D28;
	Fri, 13 May 2011 13:12:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C68304D24; Fri, 13 May 2011
 13:11:59 -0400 (EDT)
In-Reply-To: <201105131854.31540.johan@herland.net> (Johan Herland's message
 of "Fri, 13 May 2011 18:54:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EBF6EC0-7D84-11E0-B7F3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173553>

Johan Herland <johan@herland.net> writes:

> The new receive.denyObjectLimit config variable defines an upper limit on the
> number of objects to accept in a single push. If the number of objects in a
> push exceeds this limit, the entire push is immediately aborted without
> storing the pushed objects on the server at all.

Where does the error message go?  Can clients pushing over various
transports receive the reason without your server consuming the data from
them?  Don't you want to "receive-in-core-and-discard" instead?

For the purpose of "preventing an accidental push", I suspect that people
would expect you to limit either by number of commits (i.e. depth of
history) or by the total size of the data being transferred.

The name "objectlimit" sounds as if you are doing the latter and we can
use "200MB" there, but you are only limiting by count, so it is somewhat
misleading.  We would want to see "count" or "number" somewhere in its
name.
