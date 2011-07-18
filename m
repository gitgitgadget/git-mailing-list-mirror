From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/48] t6039: Add tests for content issues with
 modify/rename/directory conflicts
Date: Mon, 18 Jul 2011 16:37:52 -0700
Message-ID: <7vvcuzdusv.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:38:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixNw-0002jU-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab1GRXh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab1GRXhz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 831EC41B2;
	Mon, 18 Jul 2011 19:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VYr1H9fcSbTSBDQPRtSFhR859Oo=; b=hcOArIfYg1lUf67mp+XV
	NEln/Cxeu9bEUSrbtzdSsJRUmsym5eMS6hNWf86DV/od6KBN7XyjMquoUrgb75D3
	JMFwSjwedGUaRWoiFVT6YiyWg11lZyndKCzWrtKfBsFqAKWj7amDAnf7Xa/nGVP5
	eC+rDplxrWtU6NoxOiqX2iA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AhRhnSOcy5bSh7jyHWc55tTl2vyCWZdkWtuT3nxuvsD2s6
	H7m9RqxnmM+SAJjqmys8Jg9UMMlQReC6YzFigIiEHQ9V58/jcU3Po1c/86zkFjLl
	DHjrXZntvHX5UspU2f7RRHlFCYPcCF0wR0eSbu2acCYO8UH0a4hxf76QjHXek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79AE041B0;
	Mon, 18 Jul 2011 19:37:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 051E841AE; Mon, 18 Jul 2011
 19:37:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5551822-B196-11E0-BF5E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177414>

Elijah Newren <newren@gmail.com> writes:

> Signed-off-by: Elijah Newren <newren@gmail.com>

Could you add a description for this? Your description on 06/48 is
beautifly done. Here is my attempt.

    One branch renames a file and creates a directory where the file used to
    be, and the other branch updates the file in place. Merging them should
    resolve it cleanly as long as the content level change on the branches do
    not overlap and rename is detected, or should leave conflict without
    losing information.

    One branch renames a file and makes a file where the directory the renamed
    file used to be in, and the other branch updates the file in
    place. Merging them should resolve it cleanly as long as the content level
    change on the branches do not overlap and rename is detected, or should
    leave conflict without losing information.

I think I said this in my earlier review, and this is not limited to 05/48
but also applies to 03/48 and 04/48 as well, but there won't be perfect
rename detection, and the rename detection logic could change (improve)
over time. Ideally, I think the test should declare either case as a
success: (1) detection succeeds and avoids unnecessary conflict, or (2)
rename is missed and conflict is reported, but otherwise there is no data
loss. If it expects only one but not the other, any time the rename logic
is improved, the behaviour could change between (1) and (2) and it will
cause a false positive "breakage" of these tests.

Thanks.
