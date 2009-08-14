From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git stash: Give friendlier errors when there is nothing to apply
Date: Sat, 15 Aug 2009 06:39:56 +0900
Message-ID: <20090815063956.6117@nanako3.lavabit.com>
References: <200908111409.04506.trast@student.ethz.ch>
	<4a81787d.0e0f660a.5238.4c8b@mx.google.com>
	<7v3a7ujhqb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ori Avtalion <ori@avtalion.name>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc4Vn-0003to-PZ
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbZHNVkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbZHNVkZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 17:40:25 -0400
Received: from karen.lavabit.com ([72.249.41.33]:32853 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbZHNVkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 17:40:24 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id DAED911B8FA;
	Fri, 14 Aug 2009 16:40:25 -0500 (CDT)
Received: from 3486.lavabit.com (195.116.69.252)
	by lavabit.com with ESMTP id C0GK6SV0LZX7; Fri, 14 Aug 2009 16:40:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=zVM5/lN/zLRFhM/jThSK4UnH5J0cJJlmIi/2QiJ8ahgyaKteqi1SOq8CeXHgTosC/0Wehr2Nvb/xTQyOuE7D3SaNpYkVvyJ3MgNLQo2L8hzxrRvnhA7ULy1PGAZ8hJIbBjhXeRrV5dQnY9Pd7W5hPvmGNEm1sA0BNzIAWX+mtvQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v3a7ujhqb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125957>

Quoting Junio C Hamano <gitster@pobox.com>

> Ori Avtalion <ori@avtalion.name> writes:
>
>> The change makes sure a stash (given or default) exists before
>> checking if the working tree is dirty.
>>
>> If the default stash is requested, the old message was scary and
>> included a 'fatal' error from rev-parse:
>>      fatal: Needed a single revision
>>      : no valid stashed state found
>>
>> It is replaced with a friendlier 'Nothing to apply' error, similar to
>> 'git stash branch'.
>>
>> If a specific stash is specified, the 'Needed a single revision' errors
>> from rev-parse are suppressed.
>>
>> Signed-off-by: Ori Avtalion <ori@avtalion.name>
>> Acked-by: Thomas Rast <trast@student.ethz.ch>
>
> I do not see anything that might break existing usage of the command.
> Comments?

The patch looks good to me. I think it was my fault but you can avoid 
adding two extra --quiet by inspecting i_tree (in other words, "$s^2:") 
before w_tree and b_tree. Because a commit that is a stash exactly has 
two parents, it may be good to also make sure 'git rev-parse "$s^3"' 
fails.

	s=$(git rev-parse --verify --default $ref_stash "$@") &&
	! git rev-parse --quiet --verify "$s^3" >/dev/null &&
	i_tree=$(git rev-parse --quiet --verify "$s^2:") &&
	b_tree=$(git rev-parse --verify "$s^1:") &&
	w_tree=$(git rev-parse --verify "$s:") ||
		die "$*: no valid stashed state found"

> A tangent; we might want an analogue to "shortlog -s -n" but based on
> "blame".

I'm sorry, I don't understand what you mean.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
