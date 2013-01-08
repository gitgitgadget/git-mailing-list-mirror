From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Mon, 07 Jan 2013 23:36:21 -0800
Message-ID: <7vd2xggm8a.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsTjp-0000Gg-S5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 08:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab3AHHg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 02:36:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab3AHHgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 02:36:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C578D6915;
	Tue,  8 Jan 2013 02:36:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Py0CjafvAfgJFk3Q09xDLfU+NU=; b=irz51q
	7pbrs3140Re+6QWH49Wkfxyd/uNT6u29JlKWZAaxw6Zo79so314JQi6J/A1S7Hc4
	+g4/ksRojVNTqg/0iBKOFrzV/gPEYr4SRrUjmmxmtsYwigMJPn2iPSjDJXYpWdh1
	Eae8XUZ6arSBjj+O0h9RdvL1zq3mKNeKSqulg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQB9Lb8cHkcG0amFZIkwclAlGzKF/g9t
	VeYjT2+n1S/sNF9P3V9pcmrTMw02PLnAOG86u9d8UxSQjdkSXeu+kOWX7ph4dygA
	pl9rgTVCuXTY3FAi+TV7iWSLujhAL0ne4T9s2xMRmLUdK71BC5pwt587X6uvWjtv
	MPqsGew1i+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFC7F6914;
	Tue,  8 Jan 2013 02:36:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBC696913; Tue,  8 Jan 2013
 02:36:23 -0500 (EST)
In-Reply-To: <7vip78go6b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Jan 2013 22:54:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A67D0FA-5966-11E2-AAE6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212940>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Stefan Beller wrote:
>>
>>> Currently it is not possible to have a shallow depth of
>>> just 0, i.e. only one commit in that repository after cloning.
>>> The minimum number of commits is 2, caused by depth=1.
>>
>> Sounds buggy.  Would anything break if we were to make --depth=1 mean
>> "1 deep, including the tip commit"?
>
> As long as we do not change the meaning of the "shallow" count going
> over the wire (i.e. the number we receive from the user will be
> fudged, so that user's "depth 1" that used to mean "the tip and one
> behind it" is expressed as "depth 2" at the end-user level, and we
> send over the wire the number that corresponded to the old "depth
> 1"), I do not think anything will break, and then --depth=0 may
> magically start meaning "only the tip; its immediate parents will
> not be transferred and recorded as the shallow boundary in the
> receiving repository".
>
> I do not mind carrying such a (technially) backward incompatible
> change in jn/clone-2.0-depth-off-by-one branch, keep it cooking in
> 'next' for a while and push it out together with other "2.0" topics
> in a future release ;-).

Speaking of --depth, I think in Git 2.0 we should fix the semantics
of "deepening" done with "git fetch".

Its "--depth" parameter is used to specify the new depth of the
history that you can tangle from the updated tip of remote tracking
branches, and it has a rather unpleasant ramifications.

Suppose you start from "git clone --depth=1 $there".  You have the
today's snapshot, and one parent behind it.  You keep working happily
with the code and then realize that you want to know a bit more
history behind the snapshot you started from.

 (upstream)
  ---o---o---o---A---B

 (you)
                 A---B

So you do:

    $ git fetch --depth=3

 (upstream)
  ---o---o---o---A---B---C---D---E---F---...---W---X---Y---Z

 (you)
                 A---B                         W---X---Y---Z

But in the meantime, if the upstream accumulated 20+ commits, you
end up getting the commit at the updated tip of the upstream, and 3
generations of parents behind it.  There will be a 10+ commit worth
of gap between the bottom of the new shallow history and the old tip
you have been working on, and the history becomes disjoint.

I think we need a protocol update to fix this; instead of sending
"Now I want your tips and N commits behind it, please update my
shallow bottom accordingly", which creates the above by giving you Z
and 3 generations back and updates your cut-off point to W, the
receiving end should be able to ask "I have a shallow history that
cuts off at these commits. I want to get the history leading up to
your tips, and also deepen the history further back from my current
cut-off points by N commits", so that you would instead end up with
something like this:

 (you)
     o---o---o---A---B---C---D---E---F---...---W---X---Y---Z

That is, truly "deepen my history by 3".  We could call that "git
fetch --deepen=3" or something.
