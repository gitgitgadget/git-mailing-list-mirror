From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 06 Feb 2013 11:17:06 -0800
Message-ID: <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3AV8-0004IK-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927Ab3BFTRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:17:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab3BFTRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:17:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC3B6D3BD;
	Wed,  6 Feb 2013 14:17:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZp7s8Iiv2i8ALvYJDHExml9jWg=; b=MHNrZm
	Qs06UjrMZpv2up31ZBeommBUxw46y3nJPt4hnojVFxaeSznEyaI2xxAxjWF3j45K
	s9seanDs1tUzqdNUJjDic3hDy9eYY8BLsZIBZ4Kgd6Qg+Nqk7T6Yyrmk8qerZab+
	vKkZQVRM5c6bnQ2KS0pdFNqff/j+WFgBDHBwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oh0yfrlMX+UWXyr7hXebQ60EjUVufm61
	G6c9ZTuUAzBAyPnIYT7cFhi7QLASlbYojRLhoDvICsFMajv8SmG/cDeaLOB9K4Rr
	ksBruAJ3Zp597GOPTCLphX3YWVyxNA8E65S7gU+RFb5XE+vcvfaK5KLGksKVSCT7
	sSF+xpp7hY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0939D3BC;
	Wed,  6 Feb 2013 14:17:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 281F2D3BB; Wed,  6 Feb 2013
 14:17:08 -0500 (EST)
In-Reply-To: <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 6 Feb 2013 17:34:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCB845EA-7091-11E2-A789-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215623>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 5, 2013 at 5:29 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Hiderefs creates a "dark" corner of a remote git repo that can hold
>> arbitrary content that is impossible for anybody to discover but
>> nevertheless possible for anybody to download (if they know the name of
>> a hidden reference).  In earlier versions of the patch series I believe
>> that it was possible to push to a hidden reference hierarchy, which made
>> it possible to upload dark content.  The new version appears (from the
>> code) to prohibit adding references in a hidden hierarchy, which would
>> close the main loophole that I was worried about.  But the documentation
>> and the unit tests only explicitly say that updates and deletes are
>> prohibited; nothing is said about adding references (unless "update" is
>> understood to include "add").  I think the true behavior should be
>> clarified and tested.
>>
>> I was worried that somehow this "dark" content could be used for
>> malicious purposes; for example, pushing compromised code then
>> convincing somebody to download it by SHA1 with the implicit argument
>> "it's safe since it comes directly from the project's official
>> repository".  If it is indeed impossible to populate the dark namespace
>> remotely then I can't think of a way to exploit it.
>
> Or you can think hiderefs is the first step to addressing the
> initial ref advertisment problem.  The series says hidden refs are
> to be fetched out of band, but that's not the only way.

Let me help unconfuse this thread.

I think the series as 8-patch series was poorly presented, and
separating it into two will help understanding what they are about.

The first three:

  upload-pack: share more code
  upload-pack: simplify request validation
  upload/receive-pack: allow hiding ref hierarchies

is _the_ topic of the series.  As far as I am concerned (I am not
speaking for Gerrit users, but am speaking as the Git maintainer),
the topic is solely about uncluttering.  There may be refs that the
server end may need to keep for its operation, but that remote users
have _no_ business knowing about.  Allowing the server to keep these
refs in the repository, while not showing these refs over the wire,
is the problem the series solves.

In other words, it is not about "these are *usually* not wanted by
clients, so do not show them by default".  It is about "these are
not to be shown, ever".

OK?

Now, there may be some refs that are not *usually* wanted by clients
but there may be cases where clients want to

 (1) learn about them via the same protocol; and/or
 (2) fetch them over the protocol.

If you want to solve both of these two issues generally, the
solution has to involve a separate protocol from the today's
protocol.  It would go like this:

 * The upload-pack-2 service sits on a port different from today's,
   waits for a ls-remote/fetch/clone client to connect to it, makes
   a default advertisement that only includes the refs that are
   usually wanted by clients with hints on what other refs the
   initial advertisement omitted, to let the client know that it is
   allowed to ask for them.

 * An updated client, if it sees that some refs are omitted from the
   initial advertisement *and* what the user told it to fetch or
   list may be one of the omitted ones (this is why the server gives
   hints in the previous step in the first step; when the server
   says it did not omit anything, or when it says it omitted only
   refs/pull/*, a client that wanted to fetch refs/heads/frotz will
   know the request will fail without continuing this step), then
   makes a "expand-refs" request to the server, asking for the refs
   it did not see and the server could supply.

 * When the server sees "expand-refs", it responds with additional
   advertisement.  "expand-refs refs/pull/*" may result in listing
   of all refs in that hierarchy.  "expand-refs refs/changes/1/1"
   would result in listing that single ref.  "expand-refs no-such"
   may result in nothing, indicating an error.

 * After the (possible) expand-refs exchange, the client knows
   exactly the same and necessary information as the current
   protocol gives it in order to go to the common ancestor discovery
   step, and the protocol can continue the same way as the current
   protocol.

Note that this cannot sit on the current port in general, as
existing clients will not be able to tell some refs are not
advertised, so unless you are hiding large and truly unused part of
the refspace, interoperability with older clients will render the
mechanism useless.  You cannot use this to delay the refs/tags/
hierarchy with this mechanism and have older client come to the
updated service that by default does not advertise tags, for
example.

The above is what I called the "delayed advertisement" in the
discussion, which was brought up several months ago but nothing
materialized as the result.  People who are interested in pursuing
this can volunteer and start discussing the design refinements now
and submit implementation for reviews.

But in the meantime, if there is a niche use case where a solution
to only the second problem is sufficient (and Gerrit and GitHub pull
requests could both be such use cases), the remainder of the series
can help, without waiting the solution to solve "usually not wanted
but may need to be learned" problem.  That is the latter 4 patches
(the very last one is a demonstration to illustrate why allowing a
push to hidden ref hierarchy would not and should not work, and is
not for application):

  parse_fetch_refspec(): clarify the codeflow a bit
  fetch: use struct ref to represent refs to be fetched
  upload-pack: optionally allow fetching from the tips of hidden refs
  fetch: fetch objects by their exact SHA-1 object names
