From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 14:57:13 -0800
Message-ID: <7v1udjto3a.fsf@alter.siamese.dyndns.org>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 <7vtxqftulq.fsf@alter.siamese.dyndns.org>
 <20130117210048.GI4574@serenity.lan>
 <7v622vtplm.fsf@alter.siamese.dyndns.org>
 <20130117223050.GL4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:57:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvyOz-0003Zy-5J
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3AQW5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:57:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270Ab3AQW5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:57:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6B17CB7B;
	Thu, 17 Jan 2013 17:57:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1/NQInILAfWcgKeKtDrK+d4++W8=; b=iFgzTC
	925vhXvjnBey2BsIe4ZV9ZpTU4lfEA8KCCrtNysHFZIX5T3mmbnhEbLFth5dtHFZ
	KMZzqhkjOtsB3jehJxz1ZadHqjYXTQrQR55kISyH0b/UyWwq3gsECC1z/NtrYvM2
	T0RpwZR332yiKnuPdKyLOsiU1ikC2Brd0Z3Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DrecUr8iH/A0IeQpLK1bVE2ROzbWwCAZ
	8e3Hzb5kLbi+3VRHaUDsM3qHNpvULezOpee4w5Uft1q8YhBZfS1n4nbgmZInO6jd
	iHM3LhX97pzyjhjqT2kCYPC5Th5a9OdlMv9RBM0Gblm0HyFY1DonPoAZIbgEQ/2h
	oRcz5LE2bYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B2B3CB7A;
	Thu, 17 Jan 2013 17:57:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E122CB79; Thu, 17 Jan 2013
 17:57:15 -0500 (EST)
In-Reply-To: <20130117223050.GL4574@serenity.lan> (John Keeping's message of
 "Thu, 17 Jan 2013 22:30:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C7512DA-60F9-11E2-9CFF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213888>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Jan 17, 2013 at 02:24:37PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>>> You're right - I think we need to add ", errors='replace'" to the call
>>> to encode.
>> 
>> Of if it is used just as a opaque token, you can .encode('hex') or
>> something to punt on the whole issue, no?
>
> Even better.  Are you happy to squash that in (assuming nothing else
> comes up) or shall I resend?

If you go the .encode('hex') route, the log message needs to explain
why the hashed values are now different from the old implementation
and justify why it is safe to do so.  I do not think I want to do
that myself ;-).

Thanks.


>
>>>>>  git-remote-testpy.py | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
>>>>> index d94a66a..f8dc196 100644
>>>>> --- a/git-remote-testpy.py
>>>>> +++ b/git-remote-testpy.py
>>>>> @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
>>>>>  from git_remote_helpers.git.importer import GitImporter
>>>>>  from git_remote_helpers.git.non_local import NonLocalGit
>>>>>  
>>>>> -if sys.hexversion < 0x01050200:
>>>>> -    # os.makedirs() is the limiter
>>>>> -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
>>>>> +if sys.hexversion < 0x02000000:
>>>>> +    # string.encode() is the limiter
>>>>> +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>>>>>      sys.exit(1)
>>>>>  
>>>>>  def get_repo(alias, url):
>>>>> @@ -45,7 +45,7 @@ def get_repo(alias, url):
>>>>>      repo.get_head()
>>>>>  
>>>>>      hasher = _digest()
>>>>> -    hasher.update(repo.path)
>>>>> +    hasher.update(repo.path.encode('utf-8'))
>>>>>      repo.hash = hasher.hexdigest()
>>>>>  
>>>>>      repo.get_base_path = lambda base: os.path.join(
