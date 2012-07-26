From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: Handle compare() returning -1
Date: Thu, 26 Jul 2012 12:07:51 -0700
Message-ID: <7vd33i733s.fsf@alter.siamese.dyndns.org>
References: <1343282878-86431-1-git-send-email-davvid@gmail.com>
 <1343282878-86431-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuTPj-0001IF-L0
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 21:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab2GZTHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 15:07:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab2GZTHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 15:07:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27EB790F2;
	Thu, 26 Jul 2012 15:07:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mszgFUkyfeMuguaNDVkWzToCGt8=; b=Sdrolm
	rQwDvrCms8LwH2nhArv+ZfrZ2uWK3usTAL9W38IoxLKkaBmV7iVEtR9/NwpJ0jkz
	4pB3UpT/3CfRUk+vroepqMAlHsjI/jL433XcInq/I+Aq5DMRzQGns7MG3V8iWnWB
	rlPEHaYWiH0CRcVEnDGqlR7dnA3s59yRCJ9sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CgVLYwXECzQm+t6CB4p+G/ZlrD84Z5XR
	X7yLjA0SwUFDDaklTbTIzcJh8dGJYoRao/1J1EiQ2B7tfL22VmumFS3c50z+xuBH
	m+Z6GWAG8zKDmIYd7TyAfg577gvrCQ+vSAFUxtyb0g1ORBAedupYN3vy8aTZqFpT
	sMNG9aoNgc8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15B7D90F1;
	Thu, 26 Jul 2012 15:07:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83D9F90F0; Thu, 26 Jul 2012
 15:07:52 -0400 (EDT)
In-Reply-To: <1343282878-86431-2-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Wed, 25 Jul 2012 23:07:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32FD4D2C-D755-11E1-A3C2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202293>

David Aguilar <davvid@gmail.com> writes:

> +sub exit_cleanup
> +{
> +	my ($tmpdir, $status) = @_;
> +	rmtree($tmpdir);
> +	if ($status and $!) {
> +		my ($package, $file, $line) = caller();
> +		warn "$file line $line: $!\n";

Are you sure rmtree() would not clobber $! before the code checks it
here?
