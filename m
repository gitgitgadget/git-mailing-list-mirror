From: Junio C Hamano <gitster@pobox.com>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 10:28:28 -0800
Message-ID: <7vwscgy56b.fsf@gitster.siamese.dyndns.org>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
 <20090127153837.GB1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRshI-0000NA-MK
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbZA0S2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbZA0S2k
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:28:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbZA0S2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:28:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4909D1D677;
	Tue, 27 Jan 2009 13:28:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83C881D673; Tue,
 27 Jan 2009 13:28:30 -0500 (EST)
In-Reply-To: <20090127153837.GB1321@spearce.org> (Shawn O. Pearce's message
 of "Tue, 27 Jan 2009 07:38:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F70025E-ECA0-11DD-85D5-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107381>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Abrahams <dave@boostpro.com> wrote:
>> 
>> For example, why couldn't the "index" be called the "stage" instead?
>> That, along with knowing that "git add" was a synonym for "git stage"
>> would have flattened the learning curve considerably for me.
>
> Historical reasons...
>
> Waaay back the "index" was an index of the files git knows about in
> your working directory.  It made sense to call it an index, as like
> a book index it was a full listing of what's here, sorted by name.
>
> That's pre-1.0 days.  Like the very first version Linus ever
> released.  Aka commit e83c5163316f89bfbde7d9ab23ca2e25604af290.

This part is a bit misleading, if not completely incorrect.

Since day 1, the entity we now call "the index aka staging area" has been
just that.  It was originally called "cache" and it implemented a cache of
_contents_ that are meant to go in the tree the next commit records.  It
was renamed to the "index" because it is an index, which you can consult
with a pathname as the key to get to the _contents_ as its value.

It never was "list of pathnames" without _contents_.  So it was a staging
area from day one.

The way to update the cache was called "update-cache" then "update-index".
Because it usually is much rare to actually add a new entry to the index
than updating an existing entry in the index, the command had a safeguard
against "update-cache a-newfile" without explicit request from the user to
say "oh by the way I know I am adding new entries".  "git add" came much
later to give you a shorthand for "update-index --add".  Updating existing
entries in the index was still done with "update-index".

Later Nico taught (after much discussion) "git add" to also serve as
"update-index" for existing entries in the index.

We could have called it "git update-index" when we did that switch-over,
because the operation is exactly that --- updating the index.

But the name somehow stuck.

> Only late last October at the GitTogether did we start to talk about
> creating a command called "git stage", because people have started to
> realize we seem to call it a "staging area" as we train newcomers...

Yeah, you may have to consider the possibility that that particular
training lingo is inconsistent with the rest of the system, exactly
because it came from outside.
