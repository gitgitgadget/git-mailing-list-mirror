From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Add --force option for git submodule update
Date: Wed, 30 Mar 2011 14:08:45 -0700
Message-ID: <7vd3l8mi3m.fsf@alter.siamese.dyndns.org>
References: <4D92E225.3040602@morey-chaisemartin.com>
 <4D93773C.2010807@web.de> <4D937B7E.10808@morey-chaisemartin.com>
 <4D937F09.10000@web.de> <4D93905E.5030806@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 23:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q52xp-0000b1-TQ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 23:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062Ab1C3V3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 17:29:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965018Ab1C3VI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 17:08:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 141B445BF;
	Wed, 30 Mar 2011 17:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sUM3qhoyVScxpDeddDiBIRMvvdA=; b=w7hPWz
	taRveHlLYrhtegMd6a1PAeKppDgZsjiCGBuSLxVxJRaNu0WH/ORxIazfCcqlC/oH
	ATuxG0aUKY+LFctRhx3x3P5yZZwgBFtZodmwOyD1gn5nH9oXL1ywTAV11zy1B3N+
	505qvMMSrcgjL1rltgTcUcBNmTOzfdlzEk3Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzFjhRodQmStW3x1wTiS8ayrosF9w20Z
	ZgPllxPG0TFN6ffQn12nOvEhCaVbJwNXYHwI69J23q3i5VCHbyvZ6pQUQa1AZnwY
	OeUYDSSEOTx5ICoPUXjSna0I6hDvQuJb0ZRcUe2qR3sJDjvfMqejTD1hthgt5p30
	75ttjkQjpzs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6BA045BD;
	Wed, 30 Mar 2011 17:10:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A79EB45BC; Wed, 30 Mar 2011
 17:10:34 -0400 (EDT)
In-Reply-To: <4D93905E.5030806@morey-chaisemartin.com> (Nicolas
 Morey-Chaisemartin's message of "Wed, 30 Mar 2011 22:19:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29AF3B2E-5B12-11E0-9937-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170426>

Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> writes:

> On 03/30/2011 09:05 PM, Jens Lehmann wrote:
>>> I know it is very intrusive. The main reason for that is I wanted the -f option to always behave the same (meaning throw away changes),
>>> whether the submodule is already on the right commit or not.
>> 
>> Hmm, I don't know if that is a good thing to do. People are used to
>> "git submodule update" to only touch those submodule where the HEAD
>> differs from the commit recorded in the superproject (And I often
>> find myself using "-f" if the command didn't succeed without it).
>> But when using "-f" touches other submodules than not using it the
>> user might experience a rather unpleasant surprise, I'm not sure we
>> want to go that way.
>
> Well I was'nt sure about it either.
> The idea for me was to be able to put the repo and submodules in the cloned state (except for ignored files)
> In the current version the right thing to do is a bit of a mess:
> $ git submodule foreach --recursive 'git checkout -f HEAD'
> $ git submodule foreach --recursive 'git clean -f' # An untracked file on HEAD may be overwrittent by the new HEAD so checkout may fail if you don't do that
> $ git submodule update --recursive

Shouldn't you be questioning _why_ your users have such changes that
require them to run "checkout -f" everywhere in the submodule forests and
still want to run "submodule update" in the first place?  If it happens
very often and your users are constantly discarding what they have half
accomplished, there is something wrong with the way your project works.

If we read your motivation section in your original,

  > This implies that to reset a whole git submodule tree, a user has to run
  > first 'git submodule foreach --recursive git checkout -f' to then be
  > able to run git submodule update.

this is about "resetting", i.e. throwing away the work.  I think that is a
sensible thing to do, but it is a very different purpose than "updating
submodules so that I can work on top of what other people did", which
would happen a lot more often than that.

Wouldn't it be both safer and easier to understand for the users if this
"obliterate all my uncommitted work" were a separate subcommand, e.g. "git
submodule reset --recursive" or something?
