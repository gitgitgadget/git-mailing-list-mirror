From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/20] log_ref_setup(): improve robustness against races
Date: Thu, 18 Feb 2016 14:17:58 -0800
Message-ID: <xmqq4md5fysp.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<9cee9cea6d284315f9a30e925dd0057bddc77c82.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:18:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWti-0004F1-HW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965513AbcBRWSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:18:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965203AbcBRWSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:18:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 290A345203;
	Thu, 18 Feb 2016 17:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0jJxQU5pMIdFwWt9kvAbvc2k7Dg=; b=oXZ/pm
	12iOPExsenrpFcOWgXI7AcPi3jgIHZTulVGaMDMp9izGDH8WHvJvhKZ4049YYLhr
	yt6mdMS11aorMDjcZjJEbHTl4Qh7ggT9toTHm5ifLtcb1OMUNJoXjoBqkjTwBnoM
	KAMSmWFyGh9nWUysFacC5znH67q3UJvcAs9BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NmtUtNDQ3DtAMPS4fO0y/cDwVOYfzZ2B
	G+E+RB+Qm6fbOjMzONq64WgWQkmi5NeHY5z/tC3F6i0DvHEAIklLzZZuw5wYVd/E
	vEtRWKdgWU9dZTSJSAByTVtZQ87xrTMz9pRzO14m/bmvB6Kh6uG1ojasrUPtFlFC
	9IGREJH/K4E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F5AB451FF;
	Thu, 18 Feb 2016 17:18:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92BC2451FE;
	Thu, 18 Feb 2016 17:17:59 -0500 (EST)
In-Reply-To: <9cee9cea6d284315f9a30e925dd0057bddc77c82.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77F8261E-D68D-11E5-9402-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286624>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change log_ref_setup() to use raceproof_create_file() to create the new
> logfile. This makes it more robust against a race against another
> process that might be trying to clean up empty directories while we are
> trying to create a new logfile.
>
> This also means that it will only call create_leading_directories() if
> open() fails, which should be a net win. Even in the cases where we are
> willing to create a new logfile, it will usually be the case that the
> logfile already exists, or if not then that the directory containing the
> logfile already exists. In such cases, we will save some work that was
> previously done unconditionally.

Makes sense.
