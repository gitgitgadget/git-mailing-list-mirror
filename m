From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 15:23:24 -0700
Message-ID: <7vljysy78j.fsf@gitster.siamese.dyndns.org>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
 <20080819185804.GA17943@coredump.intra.peff.net>
 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
 <20080819190832.GC17943@coredump.intra.peff.net>
 <20080819195928.GB24212@spearce.org>
 <d411cc4a0808191326s35a56c1i2e20d82e3885298@mail.gmail.com>
 <20080820062636.6117@nanako3.lavabit.com>
 <d411cc4a0808191445o22eb57b5tfaa37d715524f55a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:25:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVZdP-0002FM-GO
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 00:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbYHSWXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 18:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbYHSWXk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 18:23:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbYHSWXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 18:23:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A2ED0518FE;
	Tue, 19 Aug 2008 18:23:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5BA9A518FC; Tue, 19 Aug 2008 18:23:27 -0400 (EDT)
In-Reply-To: <d411cc4a0808191445o22eb57b5tfaa37d715524f55a@mail.gmail.com>
 (Scott Chacon's message of "Tue, 19 Aug 2008 14:45:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75A0AB9A-6E3D-11DD-A318-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92928>

"Scott Chacon" <schacon@gmail.com> writes:

> On Tue, Aug 19, 2008 at 2:26 PM, しらいしななこ <nanako3@lavabit.com> wrote:
>> Quoting Scott Chacon <schacon@gmail.com>:
>>
>>> I thought the point of these kind of hooks was to make stuff like this
>>> automatic and easy to standardize for a project, so people working on
>>> a dozen git repos don't have to remember all the aliases they set up
>>> in each one.
>>
>> This topic seems to come up every once in a while.
>>
>>  http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=71069
>>  http://thread.gmane.org/gmane.comp.version-control.git/79306/focus=79321
>>
>> Somebody needs to describe the general rules in SubmittingPatches, perhaps?
>>
>> I do not understand why Junio said he thinks this pre-push hook is a good idea.  This clearly is "you always would want to do before running a git command" case.
>
> I don't think I understand how this is different than 'pre-commit'
> (or, alternatively, how this does not fall under #1 in that list).  If
> the script exits non-0, it stops the push, isn't that exactly what
> pre-commit does, but with 'push' instead of 'commit'?

[jc: trimmed excessive quotes --- please don't quote e-mail sigs]

The primary reason I said it would be a good thing to have is that it
could be common enough.

On one hand, the fact that this pre-push proposal came very late after
everybody used "git push" for eternity might mean that this is not common
requirement at all, and the wrapper approach Shawn and Jeff suggested may
be the right thing to do for minorities who want it.

The pre-commit hook has a good reason behind its existence than merely
being a "pre-something" hook that interferes.  If you only think about
"git commit -a" run by the end user, yes, the whole working tree can be
validated by your wrapper script before making the commit without any need
for a hook, but the user can also say "git commit this-path-only" and give
other options, and at that point, a wrapper approach would not fly well
unless your wrapper simulates what the underlying "git commit" would do
given the set of parameters.

Similarly, a pre-push hook, if done correctly, needs to see what is about
to be pushed (e.g. the user may only say "git push" without saying where
to push to and what ref to update with which commit) to base its
validation decision on, but that cannot be easily checked without actually
simulating the push.  IOW, it has criteria (2) component in it as well,
just like pre-commit hook does.
