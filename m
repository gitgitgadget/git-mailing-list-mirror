From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 07 Nov 2011 13:48:49 -0800
Message-ID: <7vd3d31u4e.fsf@alter.siamese.dyndns.org>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
 <20111107194912.GA12469@elie.hsd1.il.comcast.net>
 <7vlirr1vi5.fsf@alter.siamese.dyndns.org>
 <20111107213219.GA13537@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>, git@vger.kernel.org,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:48:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNX3p-0000gQ-3R
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab1KGVsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 16:48:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab1KGVsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:48:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C0A366D0;
	Mon,  7 Nov 2011 16:48:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WldQg0Z/D/fS8xIZ6fl5Kh1y27w=; b=igWvLv
	f7k1BRtk2KnwcvPVn4h/Q1YjsXIe6xvepauvuzU1WihRh4YXsIIEIapjJ3vYxJXG
	m1Qi83yDm9Lwrg8LOLVvMOkh5LiTJ/gtNrf/XJ4IGLIJBQTBKMnhtMnNmG6hY0Xi
	/TFeolkFiOujTW5TkwKiYCpvnsM6uL/vfL6K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2+xGOmcTu06JH8bBwNtK+Aiyt7n5ytn
	0i/HJT18z+HKoz3zwzqwXN2dJKJB4UeMlmZT9y7Lj77DvrKMQg7Pb76R4RbmqPmN
	ipLpYzqpnWGA6kYKEVX2l/r+v/cy7u2PaaQ9KPqCugliEIQnqD9i4z844lGHAP7q
	CJ4FTZhcwxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5373666CF;
	Mon,  7 Nov 2011 16:48:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7A8066CE; Mon,  7 Nov 2011
 16:48:50 -0500 (EST)
In-Reply-To: <20111107213219.GA13537@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Mon, 7 Nov 2011 15:32:19 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47907FAA-098A-11E1-A292-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185037>

Jonathan Nieder <jrnieder@gmail.com> writes:

> So, the purpose of this patch was to work around this common bug in
> static analyzers.

I fail to see how it could be even considered a work around.

If you do not use static analyzers, you do not have to do such a change,
and the resulting code would (not the "negative" side, but the "positive"
side) catch real bugs when somebody screwes up and stuffs a bogus oob
value in p->field.

With the removal of the check, you _have_ to rely on static analyzers to
do the _right thing_, but if you have static analyzers that do the right
thing, you do not have to have such a workaround to begin with.
