From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 14:24:37 -0800
Message-ID: <7v622vtplm.fsf@alter.siamese.dyndns.org>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 <7vtxqftulq.fsf@alter.siamese.dyndns.org>
 <20130117210048.GI4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:25:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvxtN-0007jW-N1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab3AQWYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:24:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3AQWYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:24:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11756A996;
	Thu, 17 Jan 2013 17:24:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0gRfpMSCCmJCNRbgvd4ocuEOu0Q=; b=KrY1E9
	qBE1Uz5lKtLsi0YjpFyvTfRcb8c0jtZBTeFm3f5PC13oWeYbo6C+FJKQuxGUZzHg
	7LbSi8WyeN6SydGTSUTzO5Uj33OmePZIX3Gw5FlLXELPRfM6QdQ08bxV4amw6rec
	ctfHX7juswdWMbF29mhRh96Zp0lBQ1h+7zwmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fNQHOPnCFSVKUVEceEIJXqkk/rldKSbI
	sMr2kN8Zliuc7WFmDX9ijhIY6UQf6wPgu9/SeyKf722ggfpFAmTVLpM/LBVkK1iS
	gHHQPoT7rSBLeah2g3RFCZCDm3zyoQefEuyUpMoGLd7/FVVSxTaFag99b4EpZeAk
	WkWCq1eIZNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06194A995;
	Thu, 17 Jan 2013 17:24:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51AB5A994; Thu, 17 Jan 2013
 17:24:39 -0500 (EST)
In-Reply-To: <20130117210048.GI4574@serenity.lan> (John Keeping's message of
 "Thu, 17 Jan 2013 21:00:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEAD9340-60F4-11E2-9728-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213885>

John Keeping <john@keeping.me.uk> writes:

> You're right - I think we need to add ", errors='replace'" to the call
> to encode.

Of if it is used just as a opaque token, you can .encode('hex') or
something to punt on the whole issue, no?

>
>> >  git-remote-testpy.py | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/git-remote-testpy.py b/git-remote-testpy.py
>> > index d94a66a..f8dc196 100644
>> > --- a/git-remote-testpy.py
>> > +++ b/git-remote-testpy.py
>> > @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
>> >  from git_remote_helpers.git.importer import GitImporter
>> >  from git_remote_helpers.git.non_local import NonLocalGit
>> >  
>> > -if sys.hexversion < 0x01050200:
>> > -    # os.makedirs() is the limiter
>> > -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
>> > +if sys.hexversion < 0x02000000:
>> > +    # string.encode() is the limiter
>> > +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>> >      sys.exit(1)
>> >  
>> >  def get_repo(alias, url):
>> > @@ -45,7 +45,7 @@ def get_repo(alias, url):
>> >      repo.get_head()
>> >  
>> >      hasher = _digest()
>> > -    hasher.update(repo.path)
>> > +    hasher.update(repo.path.encode('utf-8'))
>> >      repo.hash = hasher.hexdigest()
>> >  
>> >      repo.get_base_path = lambda base: os.path.join(
