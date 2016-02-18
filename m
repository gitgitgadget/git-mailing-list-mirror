From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Thu, 18 Feb 2016 13:15:18 -0800
Message-ID: <xmqqh9h5g1p5.fsf@gitster.mtv.corp.google.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	<1455772670-21142-26-git-send-email-dturner@twopensource.com>
	<20160218085023.GA30049@lanh>
	<1455827001.7528.87.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:15:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWVv4-0008Sy-IA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 22:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948438AbcBRVPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 16:15:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1947811AbcBRVPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 16:15:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E214462D3;
	Thu, 18 Feb 2016 16:15:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tTHkE8zOLDY0afPdjOEchvD/BDo=; b=k/UQyd
	ZFLX2MbaP/6FD1UlhzfcAUNaOwCKfCIVOTZbtidhhL+BnFEOUz/wUghz0nDcKKZO
	L/CyPfo5SkXpZswHzZp1WdHmv3Kl3VAltBdJ8YvSTnBvtWDYialjWjiPBpRXzT5w
	nl9amFbX0EP7daaorX165R4hGujOLQIZX1MM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PxWTQkwW/P9v3T2rdMqv7rIwlIx90UfI
	BLN6yM4g7lfMT7O/jQdNYxv0wMo3k/eF4SUiqHRz1GjW5cjmvN+sxY75qxQgmrMS
	7bQAsPu8ftNz70Pm6GDDzE7ABJQkx1e8DfvvmVTYZFmkyozzB5n36+nJNgbQ6rPX
	zMwQZkVkJcE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15C09462D2;
	Thu, 18 Feb 2016 16:15:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7219B462D1;
	Thu, 18 Feb 2016 16:15:19 -0500 (EST)
In-Reply-To: <1455827001.7528.87.camel@twopensource.com> (David Turner's
	message of "Thu, 18 Feb 2016 15:23:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6C1154E-D684-11E5-9EEB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286620>

David Turner <dturner@twopensource.com> writes:

> On Thu, 2016-02-18 at 15:50 +0700, Duy Nguyen wrote:
>
> [snip]
>
> Thanks; applied the above

Please.  Your other messages did excessively quote parts of the
message you are not responding to, but this will not tell anybody
but you what "the above" refers to, not even to Duy if the message
suggested more than one thing and you took only some but not all of
them.

>> This permission makes me wonder if we need adjust_shared_perm() here
>> and some other places.
>
> So just add this after every mkdir?
>
> 	if (shared_repository)
> 		adjust_shared_perm(db_path);

That reads as if the caller is saying "if we are in a shared
repository, tweak the permission bits to make it sharable."

Rather, think of "adjust_shared_perm(path)" as a declaration that
you know "path" is something that needs to be accessible by those
who needs write access to the repository.  The caller does not need
"if (shared_repository)"; the callee knows to become no-op.
