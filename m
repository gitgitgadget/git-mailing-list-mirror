From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/20] log_ref_setup(): pass the open file descriptor back to the caller
Date: Thu, 18 Feb 2016 14:21:37 -0800
Message-ID: <xmqqziuxek26.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<10ca076856c8695723f1f5fae1fee2f38fa778fd.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWxE-0007Pv-G1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947246AbcBRWVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:21:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946227AbcBRWVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:21:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D98A452F5;
	Thu, 18 Feb 2016 17:21:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wXKZ8WDYJvFHLTl6lBLxjUeaiwc=; b=EuYRs+
	o/42XrADvn6oEhkr5V6HzMVgikFoPDrnnkItIGFYEOVHL41HL4I7/L0YuNf3RbvR
	CliBuoZKPtYMtcabhRzXWDpXDtxxea1jnoH1DOuRihBuBL8d7++9IH/IXyARdyRy
	3062G99Ok+bd/5Rf7X+jNiYGu2IGL1k66T70M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTQPWUpAhVGgV+CS/PgAADggc4sHWGlH
	0RT+GMd1w7wurqv+/XkB31s13rL9mORMierO8LFlRCR7zAvFMhIwnZ7qlqOePZi0
	Wt3GkW9nKKVpW4nKmlg8MWFAcI+flETwCVRBeb00wNu2dA9724ZX4Bc2/1Jo+4ZV
	H93RFFU/hvU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 860E8452F4;
	Thu, 18 Feb 2016 17:21:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 092DA452EE;
	Thu, 18 Feb 2016 17:21:38 -0500 (EST)
In-Reply-To: <10ca076856c8695723f1f5fae1fee2f38fa778fd.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FAC320F8-D68D-11E5-83A1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286633>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This function will most often be called by log_ref_write_1(), which
> wants to append to the reflog file. In that case, it is silly to close
> the file only for the caller to reopen it immediately. So, in the case
> that the file was opened, pass the open file descriptor back to the
> caller.

Makes sense.

>  		} else {
>  			adjust_shared_perm(logfile->buf);
> -			close(logfd);
>  		}

I briefly wondered if permission twiddling on an open fd may have
negative effect on certain platforms, but the original was doing so
already (even before step 08/20), so that shouldn't be an issue with
this change, either.

Nicely done.
