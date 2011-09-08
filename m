From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Thu, 08 Sep 2011 09:46:21 -0700
Message-ID: <7vr53rx9r6.fsf@alter.siamese.dyndns.org>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vaaah6zx0.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1109062136350.12564@debian>
 <7vzkifzol6.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1109080458500.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nbX-00077n-9U
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1IHXBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:01:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685Ab1IHXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 926265DC6;
	Thu,  8 Sep 2011 12:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7yJczrln5dbHu1qiGVQxbz3Xaa8=; b=xgn13R
	SWkeY0rH+/KE+enA4FAUk4MKe6dYdCrpAbR+XBkl8IP4KuvhjlfkFVs2kGV/Xh8B
	rKIA/TXo3SWKF76CB0W+7NPoaYllad679fa7/8NNCX0p82qIF5e49CjLqjscfvoM
	W5mcKHsK4lT5vpoz70QKkzF4NOLka3HId3GyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uv7zO3CNhepknp7TVql7bisAIQelYe3c
	b6Ck4L0EzlsH94xZpEmzkcdjXw5nslpM9qeo0XyrDrEA4aIKflOv11R1OrdAr500
	Pj2kpF0wuglvB9zGNTLbkFTA7hmAlmMFxVWatXHkc99mld6//hnIynvipMU3b6CO
	0EKGyLtlGwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A21D5DC5;
	Thu,  8 Sep 2011 12:46:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FEDA5DC4; Thu,  8 Sep 2011
 12:46:23 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1109080458500.12564@debian> (Martin von
 Zweigbergk's message of "Thu, 8 Sep 2011 05:08:16 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E51EE0-DA3A-11E0-8378-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180991>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Wed, 7 Sep 2011, Junio C Hamano wrote:
>
>> Later in the same mv() function, the other one renames refs/remotes/$OLD/
>> to refs/remotes/$NEW/, even when you did not find any fetch refspec that
>> stores under "refs/remotes/$OLD/<anything>" in the earlier logic.
>
> Ah, of course. Sorry for being slow and thanks for the explanation. So
> if there are two configured refspecs with RHSs "refs/remotes/$OLD/foo"
> and "refs/remotes/$OLD/bar/*", we should remember that we updated
> those and only update refs that match the same patterns. I will see
> what I can do and will hopefully soon get back with a "patch 4/2".

What I had in mind was nothing that elaborate--it would be sufficiently
safe to just remember if you replaced any in the config, and if you
didn't, not to move anything.
