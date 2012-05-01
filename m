From: Junio C Hamano <gitster@pobox.com>
Subject: Re: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Mon, 30 Apr 2012 23:17:22 -0700
Message-ID: <7vzk9sbf2l.fsf@alter.siamese.dyndns.org>
References: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
 <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
 <CAJDDKr778t=CufdtitbrhB-vJ3F=xSpSJ_G8e-VK8qCy8Fcfmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 08:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP6Ow-0003xP-H8
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 08:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab2EAGR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 02:17:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab2EAGRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 02:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 537765F0D;
	Tue,  1 May 2012 02:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJ/rqdJGd61/h3ThkLBbGWKzSDM=; b=Ukpj9Q
	nCcMJflZ5Kws1kIqaacolh5qOCHF/0Z6zO0a55pK3Y2Zuawo7812iwUpbeor54o8
	vvBa9A0PYE5swPv9gZq1sj6MzfhVyEZNIsbnkLjCFfUrMwGNeskBUeE00mvjjE8s
	5CaqCxXjQPVSwmSq2LuvtONjhNrhbv5WtuL4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKoiabJSbGo+otvSKf8NM4vw+2JhFw/Y
	Obt/bVmQHZc0V0lKfvMRYMXdcpemixvRsDqI9OVix/1Q3cnebTvT+9xq1+tp87yu
	h2qJJPJkfL1dN2N56pJxGz0NaKIKmvOFrmS8aoGuAUnIaYHkuIa4g9TF68bFSEwo
	016Y0Gr4H28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4989E5F0C;
	Tue,  1 May 2012 02:17:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA7145F0B; Tue,  1 May 2012
 02:17:23 -0400 (EDT)
In-Reply-To: <CAJDDKr778t=CufdtitbrhB-vJ3F=xSpSJ_G8e-VK8qCy8Fcfmg@mail.gmail.com> (David
 Aguilar's message of "Mon, 30 Apr 2012 22:32:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5101D174-9355-11E1-AA50-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196661>

David Aguilar <davvid@gmail.com> writes:

>> +       if (sizeof(long) == 8) {
>
> Isn't the whole point of this code to be fast?
>
> This should be a compile-time check... conditionals hurt perf.

Depends on how good your compiler is, no?  The above if () selects based
on a constant expression, so on 64-bit archs with a good compiler, there
won't be a jump instruction nor a single opcode for the else clause.
