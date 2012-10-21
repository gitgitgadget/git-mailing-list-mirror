From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Sat, 20 Oct 2012 23:51:09 -0700
Message-ID: <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPpNo-0005w8-Cq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 08:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab2JUGvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 02:51:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab2JUGvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 02:51:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A47456866;
	Sun, 21 Oct 2012 02:51:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a3SXM6VKOSRLLHEyDzKlCtQZyMI=; b=C9uRwG
	8vjd59/aQa/xUe4BDUl7pRmSndUZJl5ybj9/Aa+IknZQPQV8ky8C76Rx0TkzyIAM
	Zo1FrDfTpHoqdFXJWu0uMcs4DUXtNILHo+hFbSZICgw7ZdMQ19yEn6QI/nkay4Jr
	PKItfmJfM9POqwGi06G6lJAkvEstrn1IXFeZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m4sS6kYo2uKdItMCui+e6YRtGmt0qvHq
	bXeScdW2aawnP4L9c+y5VoxflnNe9mNWqabB78XLHboqknvEF3uZHWlDgrU+VIRx
	z4QyCn3iYxFCd/UN5U/TNRoYlADgVnrZzGRwRP0JQcswF7CypWuFVgoQAlfsUywK
	7MH6CCFa3IA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 913626865;
	Sun, 21 Oct 2012 02:51:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CCE86864; Sun, 21 Oct 2012
 02:51:10 -0400 (EDT)
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 21 Oct 2012 07:57:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2C9EF1C-1B4B-11E2-B159-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208114>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This patch series has the side effect that all of the directories
> listed in GIT_CEILING_DIRECTORIES are accessed *unconditionally* to
> resolve any symlinks that are present in their paths.  It is
> admittedly odd that a feature intended to avoid accessing expensive
> directories would now *intentionally* access directories near the
> expensive ones.  In the above scenario this shouldn't be a problem,
> because /home would be the directory listed in
> GIT_CEILING_DIRECTORIES, and accessing /home itself shouldn't be
> expensive.

Interesting observation.  In the last sentence, "accessing /home"
does not exactly mean accessing /home, but accessing / to learn
about "home" in it, no?

> But there might be other scenarios for which this patch
> series causes a performance regression.

Yeah, after merging this to 'next', we should ask people who care
about CEILING to test it sufficiently.

Thanks for rerolling.
