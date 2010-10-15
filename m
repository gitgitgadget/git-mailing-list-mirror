From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] do not overwrite files in leading path
Date: Fri, 15 Oct 2010 11:47:24 -0700
Message-ID: <7vfww7e1j7.fsf@alter.siamese.dyndns.org>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-6-git-send-email-drizzd@aon.at>
 <7v1v7tkb6g.fsf@alter.siamese.dyndns.org> <20101013223425.GB2558@localhost>
 <20101015064835.GA12119@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 15 20:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6pJe-0002WZ-M1
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 20:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab0JOSrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 14:47:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab0JOSrf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 14:47:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C575DE73C;
	Fri, 15 Oct 2010 14:47:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qXVIRlJlOamUvgsbR9CeXgOoEg8=; b=WEoL1u
	z7yxw6SZE14cYhfo8RQQ2iiQ5Z897bIlzECcqZRGvpOK0SFONyq67u6dErYuDMa7
	/DzRnO4kIc+O7MJ9Z3SjgsXxkpncZZSKzppF7IehAf/RJoWxeObKELE5RceSCXQd
	jy6Ktul9spz5idKP5g5nfuGj6k1y6X3YMvi0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycAsGX6rwrGOo/lUcF6vmzwJFmrv+JT1
	Yhb1MEOAs6Z0VKI7jVyl054U6AptuelDGTDNtrJdE2cY/situ8PSsWiiUwTKp2ke
	wTk4KDTPnG1of2oiUgVVLw54CAubnjKUhZ3OuilIi0RmfJzO7M1QS2q4olOSuU6U
	S7TvI1VmCEk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D742DDE737;
	Fri, 15 Oct 2010 14:47:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FBAFDE734; Fri, 15 Oct
 2010 14:47:26 -0400 (EDT)
In-Reply-To: <20101015064835.GA12119@localhost> (Clemens Buchacher's message
 of "Fri\, 15 Oct 2010 08\:48\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA4C13BE-D88C-11DF-9EB5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159129>

Clemens Buchacher <drizzd@aon.at> writes:

> On Thu, Oct 14, 2010 at 12:34:25AM +0200, Clemens Buchacher wrote:
>> 
>> If lstat returns with an error other than NOENT, or if
>> check_ok_to_remove is called with anything other than a directory
>> and cache_entry is NULL, we get a segmentation fault. Before, an
>> error was simply ignored. I don't know which is worse.
>
> I suppose we only need the following additional changes.
>
> - die if lstat returns an error other than ENOENT.
>
> - Rewrite verify_clean_subdirectory to not require a cache_entry.
>
> - Expose lstat result and path cache to the caller of
>   lstat_cache_matchlen() in verify_absent_1().
>
> - rewrite check_leading_path (or 'verify_clean_path') to
>   check the full path and return zero if
>   + the leading path contains a symlink or
>   + the leading path exists, but the full path does not
>   and returns the path length of the offending entry otherwise.
>   
> I think that's manageable and much cleaner. I will start to work on
> it as soon as possible.

Thanks.  I like seeing people thinking things through ;-).
