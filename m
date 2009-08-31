From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Mon, 31 Aug 2009 16:35:29 -0700
Message-ID: <7vhbvnzhdq.fsf@alter.siamese.dyndns.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908292116060.28290@iabervon.org>
 <7vskfat07h.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908311130190.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGPZ-0002QX-IS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbZHaXfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 19:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbZHaXfg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:35:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbZHaXff (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 19:35:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B59120B6D;
	Mon, 31 Aug 2009 19:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Up5AXBqqEB+zrxlfwrDwNwjXgSM=; b=Gm6Xb7yhzDRfcdOmcnoU3AL
	1xpvMi1ED0mDm5aUQbsWV64Z0HBgwZ9TYQD6pgqzTjTokohpl30jPmSEi47+g8Ln
	iQn0r0ZdJfdzMpZcLvAa3J+15BJStjO5mB6ZClTcOqKu/goA5zUbMUplIdYh8IGt
	/BSgNbRYC+6xjB578XY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VCUuIAI0oTZKlaBepMw10AcSY4IYiWiL21otw2L74Yi844zhu
	0Nl8dU3bOjuSzq6o74AywH1gLz907THuEf4y4/53opiEy46Z2TcFQs409pa6kVli
	fEkrkpVJuWc1NFlkIGdeuWv9r5v5GnEFvHkrLs9nxr9i0t6YpAOXQjH1zw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C12B20B6C;
	Mon, 31 Aug 2009 19:35:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99D5B20B6B; Mon, 31 Aug
 2009 19:35:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA27BD78-9686-11DE-8709-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127506>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 29 Aug 2009, Junio C Hamano wrote:
>
>> ..., if only to avoid confusion with our own earlier misdesigned
>> syntax git+ssh://), so the canonical syntax would be:
>
> (with the syntax <helper>+, "git+ssh://" would specify the helper "git", 
> which is as good an explicit identifier of the internal handling as any)

Sure but how would you explain "ssh+git://" then ;-)?

Luckily neither is advertised in our documentation set as far as I can
tell, so I do not think it is a huge deal between + vs ::, but as Peff
says in

    http://thread.gmane.org/gmane.comp.version-control.git/125615

I think the latter is probably less problematic.

With plus, a helper that talks with a Subversion repository whose native
URL is http://host/path would look like svn+http://host/path, which is
reasonable.  When talking the Subversion protocol over SSH, however, the
native URL for the repository would be svn+ssh://host/path, so the URL
with helper name on our side becomes svn+svn+ssh://host/path.  We could
recognize "svn+" part and implicitly pass the whole thing to svn helper
upon seeing svn+ssh://host/path, but I do not think we would want to make
the dispatcher too familiar with what the backends do.  Using something
other than plus sign would avoid this issue.

> If the policy is that we're going to have "traditionally supported" 
> schemes, where the internal code knows what helper supports them, I can 
> fix up the series so that the curl-based helper is named "curl", and we 
> can say that the check for "http://", "ftp://", and "https://" is
> recognizing traditionally-supported schemes, and we can defer coming up 
> with what the syntax for the explicit handler selection is. (For that 
> matter, if there's a // after the colon, it's obviously not a 
> handy ssh-style location, since the second slash would do nothing)

That sounds like a sane approach to first get the "eject curl from
builtin" out the door.  We might extend the dispatcher in the future by
changing "traditionally supported" criterion to "commonly used",
e.g. recognize "svn+ssh://" as something the svn helper would want to
handle, but that is a future extension we do not have to address right
now.

>> After you explained this in the thread (I think for the second time), I
>> see no problem with this, except that I think to support this we should
>> notice and raise an error when we see a remote has both vcs and url,
>> because the only reason we would want to say "vcs", if I recall your
>> explanation correctly, is that such a transport does not have the concept
>> of URL, i.e. a well defined single string that identifies the repository.
>
> A user who mostly uses Perforce as a foreign repositories but is using a 
> SVN repo on occasion might want to use "vcs" regardless, but I agree with 
> forcing the helper to use a different option for the case of a URL that 
> git isn't going to look at. That is, you ought to be able to use:
>
> [remote "origin"]
> 	vcs = svn
> 	(something) = http://svn.savannah.gnu.org/...
>
> But "(something)" shouldn't be "url".

I actuallly do not have a strong opinion on this one either way.  I said
"I think" when I suggested it, but it was actually without thinking too
deeply, hoping that you would come up with a good counter-argument.

For example, if we envision that for most of the helpers there will be one
primary string that identifies the repository, but the primary string
alone is not enough for the helper without some auxiliary information, it
would be natural to use remote.$name.url for that primary string.  I do
not know if that would be the case, but I was hoping that you would have a
better intuition[*1*], as you have thought this topic through a lot longer
and deeper than I have.  So I'd rather leave the decision on that "no
vcs/url at the same time restriction" up to you.  It is in general easier
to start more strict and then loosen the restiction later, than the other
way around, when we cannot decide, though.

Thanks.

[Footnote]

*1* What I mean by intuition is that you do not have to have the right
answer backed by research _now_, but have a good guess as to what the
right answer would be.
