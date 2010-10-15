From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 16:22:59 -0700
Message-ID: <7viq13avn0.fsf@alter.siamese.dyndns.org>
References: <loom.20101012T114900-532@post.gmane.org>
 <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
 <loom.20101014T095743-275@post.gmane.org> <i9a6kn$d7o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 01:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tcI-000841-QE
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0JOXXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 19:23:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab0JOXXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:23:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A5ADDEAC1;
	Fri, 15 Oct 2010 19:23:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qM72D1xtjmfPCgq9i0rq6E5Xm/g=; b=wdw5v1
	SY4iTbnOwng0QGKja5S1ggEsbWkny4rC0055i3+pN2UZtcXvXvbeD4jMwrB2770o
	6u/jjOsB8xieywNvmfFSdRkxhGBa1EdMCGmqwvaLx2dNRIFHpTYSEOkNu4LilhG8
	QVu/y4K5VO7mSKONRA+M6ymIyG+bterBLWEG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMgRU5fzUlf8bP3sx49fnwQ3VCYGZmp0
	7LIy5uqTXpV6IAQfiGIBFm6aCRpHXh474MIeir9IAvH623SMisITkzg9OuaVBFWX
	C7yp3F561xGjekZfiWKN1lOauPGUssUXagnLtOjH2VUsDnh4tR5mvKPTyc4oz/dD
	OL8H7JsZEXI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3414BDEAC0;
	Fri, 15 Oct 2010 19:23:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36173DEABF; Fri, 15 Oct
 2010 19:23:01 -0400 (EDT)
In-Reply-To: <i9a6kn$d7o$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Fri\, 15 Oct 2010 13\:30\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28ED7566-D8B3-11DF-A476-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159142>

"Neal Kreitzinger" <neal@rsss.com> writes:

> FWIW, my understanding of the index is that it is the middle-man for moving 
> things from your work-tree to the object-store AND for moving things from 
> the object-store to your work-tree.

While there is nothing technically incorrect in the above, it probably
is easier to explain/understand why it works in the direction from the
object store and to the working tree if you state it this way instead:

  The index is where you build the contents for your next commit.

   - You build your next commit starting from the current commit,
     so when you do "checkout" from the object store, both the
     index and the working tree are populated with the blob.

   - You then modify that state in your working tree, hopefully
     testing, reviewing, and thinking about your change while
     doing so.

   - There may be good changes, not good enough changes, and
     perhaps only for debugging changes in your working tree.  You
     can decide to make commits out of only the good bits, leaving
     others uncommitted.  You add only good bits to your next
     commit, and the command to do so is naturally called "git
     add" (and "git add -p" for add changes to a file partially by
     picking patch hunks).

   - There may be a time where you regret that some changes you
     made to your working tree are not good, and want to start
     over.  You may even do so after you added some changes to
     the index (i.e. your next commit).  By checking the path
     out of the current commit would give you the original
     version of the path both in the index and in the working
     tree file to help you start over.

   - After making that commit, you will keep working to create
     the commit next to that commit you created.  To help you
     work incrementally, the index at that point contains what
     you committed.
 
> However, there is an option in git-commit to copy files directly from the 
> working-tree to the object-store by totally bypassing the index, but no one 
> seems to do this or recommend doing this as normative practice.

This is wrong.  People do this all the time with "git commit $path".

What happens behind the scene is:

 - git prepares a temporary index that matches the contents of the
   current commit;

 - the contents for $path from the working tree is then added to that
   temporary index;

 - a new commit is written out of that temporary index; and

 - the $path is also added to the real index (this is a very important
   detail---otherwise the next commit will lose the change to $path).

Notice that in no step the index is really bypassed.  Everything
literally goes through the index.

If you want to bypass the index, you can do so with cat-file or show; it
just is not a useful operation in a normal workflow of building the next
commit on top of the current one, and that is the only reason why there
is no option such as "checkout --no-index HEAD~47 path".  If somebody
can write a convincing use case that shows why it is useful, such an
option shouldn't be very hard to add.  But I don't think of any.  For
example, this is not it:

    I start from a clean slate and start working.

    $ git checkout
    $ edit; git diff; compile; test; git add path ;# repeat

    At this point I have some cooked contents added for the next commit
    in the index for path.  But I realize that the contents of that path
    in another branch might be even better.  But I do not want to lose
    the state I arrived at, which might be better than that alternative.
    I cannot decide, so I'll keep that in the index for now.

    $ git checkout --no-index the-other-branch path
    $ edit; compile; test; ...

    case I. yes the other one indeed is better
    $ git add path

    case II. no the other one is inferiour
    $ git checkout path ;# out of index

While superficially this looks promising, this is unwieldy.  For one
thing, you cannot easily check what you changed anymore, as "git diff
path" would show the difference between the index, i.e. a version that
was modified in a different way from the current version, and the
working tree, i.e. another version that was modified starting from a
totally different version in the-other-branch.
