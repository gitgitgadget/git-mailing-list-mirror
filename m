From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 01 Mar 2015 15:06:59 -0800
Message-ID: <xmqqwq30fhbg.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
	<CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 00:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSCx3-0003tK-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 00:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbCAXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 18:07:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751877AbbCAXHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 18:07:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 001933CE78;
	Sun,  1 Mar 2015 18:07:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tIe1zqsydECXOObiT/vGyY/hlsw=; b=msuInZ
	+yDdW+ZlwiPidIM3eFEEUgXy0nyFcQaw+BxqXYopeAc7sco0BY+HxADxnMrbGZHs
	IhldqauCADaeHgmZBUfH9NNPNJr3OrGUKHx9aRoT/dPTyKSi8WhQqL/ndy170Y76
	gvynlxLGNyFzXsTZ9So4G6oNjK9BJ3v02Nlec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbhpXJ2CmbOYyQ+0Rd1GW0jt61GhonU+
	8Lo5ldlolJjBW3rjhxMkuNWwWWcTd5H3s6AVnJXHiWMTJaJgOMbj1WOepq4GkfyO
	A+ulebzddfUNmLUfgF1kFtgSAkH6m9hIoJSSSyzLoiTo6a2lRV0rJJL4CjqrrSsH
	qAIifyXdpl8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9A623CE77;
	Sun,  1 Mar 2015 18:07:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 090D43CE74;
	Sun,  1 Mar 2015 18:07:00 -0500 (EST)
In-Reply-To: <CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 1 Mar 2015 18:32:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB0CFC2E-C067-11E4-843B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264566>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Mar 1, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  - Because the protocol exchange starts by the server side
>>>    advertising all its refs, even when the fetcher is interested in
>>>    a single ref, the initial overhead is nontrivial, especially when
>>>    you are doing a small incremental update.  The worst case is an
>>>    auto-builder that polls every five minutes, even when there is no
>>>    new commits to be fetched [*3*].
>
> Maybe you can elaborate about how to handle states X, Y... in your
> footnote 3. I just don't see how it's actually implemented.  Or is
> it optional feature that will be provided (via hooks, maybe) by
> admin?

These footnotes are not the important part (I wanted us to agree on
the problem, and the ideas outlined with the footnotes are only an
example that illustrates how a potential solution and the problem to
be solved are described in relation to each other), but I'll give a
shot anyway ;-)

I am actually torn on how the names X, Y, etc. should be defined.

One side of me wants to leave its computation entirely up to the
server side.  The client says "Last time I talked with you asking
for refs/heads/* and successfully updated from you, you told me to
call that state X" without knowing how X is computed, and then the
server will update you and then tell you your state is now Y.  That
way, large hosting sites and server implementations can choose to
implement it any way they like.

On the other hand, we could rigidly define it, perhaps like this:

 - Imagine that you saved the output from ls-remote that is run
   against that server, limited to the refs hierarchy you are
   requesting, the last time you talked with it.

 - Concatenate the above to the list of patterns the client used to
   ask the refs.  This step is optional.

 - E.g. if you are asking it for "refs/heads/*", then we are talking
   something like this (illustrated with optional pattern in front):

        refs/heads/*
        8004647...      refs/heads/maint
        7f4ba4b...      refs/heads/master

 - Run SHA-1 hash over that.  And that is the state name.

I.e. if you as a client are doing

    [remote "origin"]
        fetch = refs/heads/*:refs/remotes/origin/*

and if the only time your refs/remotes/origin/* hierarchy changes is
when you fetch from there (which should be the norm), you can look
into remote.origin.fetch refspec (to learn that "refs/heads*" is
what you are asking) and your refs/remotes/origin/* refs (and
reverse the mapping you make when you fetch to make them talk about
refs/heads/* hierarchy on the server side), you can compute it
locally.

The latter will have one benefit over "opaque thing the client does
not know how to compute".  Because I want us avoid sending unchanged
refs over connection, but I do want to see the protocol has some
validation mechanism built in, even if we go the latter "client can
compute what the state name ought to be" route, I want the servrer
to tell the client what to call that state.  That way, the client
side can tell when it goes out of sync for any reason and attempt to
recover.

> Do we need to worry about load balancers?

Unless you are allowing multiple backend servers to serve a same
repository behind a set of load balancers in an inconsistent way
(e.g. you push to one while I push to two and you fetch from one and
you temporarily see my push but then my push will be rejected as
conflicting and you fetch from one and now you see your push), I do
not think there is anything you need to worry about them more than
what you should be worrying about already.

There would be a point where all backend servers would agree "This
is the set of values of these refs" at some point (e.g. a majority
of surviving servers vote to decide, laggers that later join the
party will update to the concensus value before serving the end-user
traffic), and they would not be showing half-updated values that
haven't ratified by other servers to end users (otherwise they may
end up showing reversion).

>>    - Is band #2 meant for human consumption, or do we expect the
>>      other end to interpret and act on it?  If the former, would it
>>      make sense to send locale information from the client side and
>>      ask the server side to produce its output with _("message")?
>
> No producing _(...) is a bad idea. First the client has to verify
> placeholders and stuff, we can't just feed data from server straight
> to printf(). Producing _() could complicate server code a lot. And I
> don't like the idea of using client .po files to translate server
> strings. There could be custom strings added by admin, which are not
> available in client .po. String translation should happen at server
> side.

What I meant to say was (1) the client says "I want the human
readable message in Vietnamese" and (2) the server uses .po on
_("message") in its code and send the result to sideband #2.  There
is no parsing, interpolation, or anything of that sort necessary on
the server end.

Because potential problem you mention looks to me about a different
design where the server talks "message" and client side applies
_($msg) to it, I suspect that you misread what I meant to say.
