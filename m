From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 11:42:00 -0800
Message-ID: <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
 <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRuqX-0000Qz-O5
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407AbYBTTmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756823AbYBTTmP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:42:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbYBTTmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:42:13 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 008095142;
	Wed, 20 Feb 2008 14:42:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 17B8E5141; Wed, 20 Feb 2008 14:42:07 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802201418590.19024@iabervon.org> (Daniel
 Barkalow's message of "Wed, 20 Feb 2008 14:24:50 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74539>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 20 Feb 2008, Junio C Hamano wrote:
> ...
>> To me, "url.$this_is_what_I_use.aka = $how_they_might_call_it"
>> initially felt backwards, but the point of the facility is to
>> allow mapping many ways other people might call it to how you
>> would (and the other way would not make sense as allowing to map
>> one thing to multiple is only to introduce unnecessary
>> ambiguity), so it makes perfect sense.
>
> This order of values is definitely the right thing, for the mapping 
> reasons you saw. And I think "aka" is generally used to indicate 
> additional non-canonical names for something with an official name (see, 
> for example, IMDB's usage). I haven't been able to come up with anything 
> better to indicate "this is a name that I will recognize but not use 
> myself".

Yeah, that "aka" is still disturbing.

	[url A]
        	aka = B

would read to me: "A is also known as B" but that is clearly not
what it means here.  You would want this:

	[url A]
        	aka = B 
		aka = C

to mean "B is also known as A.  C is also known as A."  IOW, you
are using it backwards, because their name is more official and
you are using your own unofficial name to call it.

Sorry, but I cannot think of a better way to resolve this, other
than by spelling the keyword backwards, but that still makes it
"aka".

>> > diff --git a/Documentation/urls.txt b/Documentation/urls.txt
>> > index 81ac17f..0115af7 100644
>> > --- a/Documentation/urls.txt
>> > +++ b/Documentation/urls.txt
>> > @@ -44,3 +44,26 @@ endif::git-clone[]
>> > ...
>> > +If you have a section:
>> > +
>> > +------------
>> > +	[host "git://git.host.xz/"]
>> > +		aka = host.xz:/path/to/
>> > +		aka = work:
>> > +------------
>> > +
>> > +a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
>> > +rewritten in any context that takes a URL to be
>> > +"git://git.host.xz/repo.git".
>> 
>> This still stands???
>
> And missed the "host"->"url" bit while I fixed the rest of the example. 

So this part is not wanted, right?

> Want a replacement, or can you make the obvious corrections just as 
> easily yourself?

If my above rant about "aka" is not a total misunderstanding,
I'd rather see somebody (could be you, or others on the list) to
come up with a better keyword and have a replacement patch based
on it.
