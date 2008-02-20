From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 15:42:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802201520450.19024@iabervon.org>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org> <7vzltv4ey8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802201418590.19024@iabervon.org> <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 21:42:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRvmF-0005tL-LQ
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 21:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbYBTUmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 15:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbYBTUmO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 15:42:14 -0500
Received: from iabervon.org ([66.92.72.58]:47452 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764717AbYBTUmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 15:42:11 -0500
Received: (qmail 6306 invoked by uid 1000); 20 Feb 2008 20:42:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 20:42:10 -0000
In-Reply-To: <7vskzn4dpz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74546>

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Wed, 20 Feb 2008, Junio C Hamano wrote:
> > ...
> >> To me, "url.$this_is_what_I_use.aka = $how_they_might_call_it"
> >> initially felt backwards, but the point of the facility is to
> >> allow mapping many ways other people might call it to how you
> >> would (and the other way would not make sense as allowing to map
> >> one thing to multiple is only to introduce unnecessary
> >> ambiguity), so it makes perfect sense.
> >
> > This order of values is definitely the right thing, for the mapping 
> > reasons you saw. And I think "aka" is generally used to indicate 
> > additional non-canonical names for something with an official name (see, 
> > for example, IMDB's usage). I haven't been able to come up with anything 
> > better to indicate "this is a name that I will recognize but not use 
> > myself".
> 
> Yeah, that "aka" is still disturbing.
> 
> 	[url A]
>         	aka = B
> 
> would read to me: "A is also known as B" but that is clearly not
> what it means here. 

But it is; the thing which we will call "A" is also known (and 
sometimes called by other people, or us speaking informally) as "B".

> You would want this:
> 
> 	[url A]
>         	aka = B 
> 		aka = C
> 
> to mean "B is also known as A.  C is also known as A."  IOW, you
> are using it backwards, because their name is more official and
> you are using your own unofficial name to call it.

No, "A" is the *real* name, the one that actually works. B and C are 
pseudonyms, of which there may be multiple, both from more "official" (but 
git is decentralized, and doesn't care for officialness) and less official 
sources.

I think you're seeing this feature as taking "correct" URLs and rewriting 
them to be local aliases, when the only thing that makes sense for a 
system like git is really to say that whatever URL works for us is 
"correct", and everybody else is speaking their own local dialect.

In fact, one case I anticipate using extensively is:

[url "git://iabervon.org/~barkalow/"]
	aka = ":"

Such that, once clone is using remote.{c,h}, "git clone :git" would clone 
my home git repository. Obviously ":" isn't the real name in this 
rewriting.

> >> > diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> >> > index 81ac17f..0115af7 100644
> >> > --- a/Documentation/urls.txt
> >> > +++ b/Documentation/urls.txt
> >> > @@ -44,3 +44,26 @@ endif::git-clone[]
> >> > ...
> >> > +If you have a section:
> >> > +
> >> > +------------
> >> > +	[host "git://git.host.xz/"]
> >> > +		aka = host.xz:/path/to/
> >> > +		aka = work:
> >> > +------------
> >> > +
> >> > +a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
> >> > +rewritten in any context that takes a URL to be
> >> > +"git://git.host.xz/repo.git".
> >> 
> >> This still stands???
> >
> > And missed the "host"->"url" bit while I fixed the rest of the example. 
> 
> So this part is not wanted, right?

The first part (not quoted) is not wanted (it was left over from when I 
combined the three entries into one and moved it under 'u' instead of 
'h'). This part *is* wanted, but should say:

+	[url "git://git.host.xz/"]

instead of

+	[host "git://git.host.xz/"]

since I changed the option name.

	-Daniel
*This .sig left intentionally blank*
