From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 34/48] merge-recursive: Consolidate process_entry() and
 process_df_entry()
Date: Thu, 21 Jul 2011 11:43:20 -0700
Message-ID: <7v39hz325z.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-35-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyDY-0004tH-02
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab1GUSnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:43:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab1GUSnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:43:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DBEC3040;
	Thu, 21 Jul 2011 14:43:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=V7aWyv3z4G5BDlv+0Z3wmnTNDqk=; b=tNM9I/ZZ1eLAElk3+Zhk
	rXnUPiJ28brTt1zXtHTQYf3YviRXKskgZGXEQmXDzd7Kk9WkdEmQIkIQhxtfNv85
	3EAXo+3YoTWBNJIalPRJcWDMc1lzGebJ0ynjigE2A42jJMhBav3qGq6NaIn922p0
	l8kdvTpnB+YwUjJLI/FFILo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=H3lZV4C95Oxti2a7Xbui722fiYBlzKhgKCkDlEoUfnNE7/
	guv9PJtv49k+LAKY4zwQHwKE9shR+xgumBaP5WzNyngxIVSbuPjmzVNSi4Ie+0Oq
	MotrW6WtjFtFtYmLZI6+IPBzH1d1mdKKO1PhDsdPkWxVfbt+eZVA7KwBKkuAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6531A303E;
	Thu, 21 Jul 2011 14:43:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C229F303D; Thu, 21 Jul 2011
 14:43:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F1A9A9C-B3C9-11E0-9A72-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177610>

Elijah Newren <newren@gmail.com> writes:

> The whole point of adding process_df_entry() was to ensure that files of
> D/F conflicts were processed after paths under the corresponding
> directory.  However, given that the entries are in sorted order, all we
> need to do is iterate through them in reverse order to achieve the same
> effect.  That lets us remove some duplicated code, and lets us keep
> track of one less thing as we read the code ("do we need to make sure
> this is processed before process_df_entry() or do we need to defer it
> until then?").
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c |  194 ++++++++++++++++------------------------------------
>  1 files changed, 60 insertions(+), 134 deletions(-)

;-).
