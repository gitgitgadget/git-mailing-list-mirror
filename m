From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/16] index-helper: use watchman to avoid refreshing index with lstat()
Date: Thu, 07 Apr 2016 15:52:52 -0700
Message-ID: <xmqqd1q1xc8r.fsf@gitster.mtv.corp.google.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	<1459980722-4836-10-git-send-email-dturner@twopensource.com>
	<xmqqh9fdxcht.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 00:53:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoInS-0005IQ-QK
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 00:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbcDGWxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 18:53:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752627AbcDGWw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 18:52:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B716F53FE5;
	Thu,  7 Apr 2016 18:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E2mZnlnrqlRlMLwrEBmlQNirSO0=; b=EcaMdc
	V8xkLPLGS9QQzvHV9WvKyGGL+f/0JVU6jtUbILl/Xb/iRGnuFJQOGPB192AbJL1m
	zVuDFkwBd3rB2mQfMfhmbDa5tTiSxm6w2Uq39mNbxBj97DDo2idb/ZBbfdlBJgj1
	VMn2s0FmhU7Z3MqAslO52fcPYza6f0aUQeSn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mL/uBiGBi/rDEEdam3wmjTLSZN6Z4ODw
	AxATAPJzJumGJXDY27g7GubIVxROOgTPZrHr85WlPxf0S6hWTtEn+cHMSDDqnT56
	X3KvDgtqOQgmav8vIIqGqM6uiFeyX/CQUIMYV7zZYnyMyyT2Bz3LXs4ColbWjc4c
	M3jjsOxTid8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC9FA53FE4;
	Thu,  7 Apr 2016 18:52:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FFCD53FE3;
	Thu,  7 Apr 2016 18:52:53 -0400 (EDT)
In-Reply-To: <xmqqh9fdxcht.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Apr 2016 15:47:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76171F4C-FD13-11E5-A3D4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290994>

Junio C Hamano <gitster@pobox.com> writes:

>> +		untracked = data + len + 8 + bitmap_size;
>
> This breaks compilation as data here is of type (void *).
>
> There may be similar breakages in this patch.

It turns out that this is the only one, and

	untracked = (char *)data + len + 8 + bitmap_size;

is a sufficient fix (I've squashed it in to my copy).

Thanks.
