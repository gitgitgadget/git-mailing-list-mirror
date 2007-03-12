From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A tracking tree for the active work space
Date: Sun, 11 Mar 2007 21:39:24 -0400
Message-ID: <9e4733910703111839jca1eef5l70c097deb241b602@mail.gmail.com>
References: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com>
	 <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com>
	 <Pine.LNX.4.63.0703112209160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 02:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQZVb-0003Jv-Qe
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 02:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXCLBj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 21:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbXCLBj2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 21:39:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:7590 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbXCLBj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 21:39:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2057463uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 18:39:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O86X1x9xpbEZ0iouNzPjyJ9YhMIWGRyZo2aKdSJyUVO/QgjG5/YTgHWJYoO0U/bGsR5/XgCByIg5/kcrtpivWQXFjuZZXwzJaUGeLE3Lblfu6/pUpEcQeIXCeN6/BTa0qIHArGeku4eDyJ+eTDt9ClJl0crfIDTIjwDAevXHBIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S8U40wSBoR1XztW0dD62S3wuNRZC0sgPkWiKP/4Hiyk+tXJjb5kJt1IBYrX73DPesqpA9NwnFiODhOolqjsGEKnQiVutA/rghqcxmisShrjsimnlP7FXCnL52W+OYtulssLzVD6EPMWekvoqRg8/iwGaeOYZvGdBEpRraicCpHg=
Received: by 10.114.167.2 with SMTP id p2mr1056719wae.1173663564949;
        Sun, 11 Mar 2007 18:39:24 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sun, 11 Mar 2007 18:39:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703112209160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42002>

On 3/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 11 Mar 2007, Jon Smirl wrote:
>
> > As for the part about 'git grep' Shawn and I have been talking off and
> > on about experimenting with an inverted index for a packfile format. The
> > basic idea is that you tokenize the input and turn a source file into a
> > list of tokens. You diff with the list of tokens like you would normally
> > do with text. There is a universal dictionary for tokens, a token's id
> > is it's position in the dictionary.
>
> All in all, this is an interesting idea.
>
> However, I see some problems I'd like to know solutions for:
>
> - how to determine the optimal length of the tokens? (It is easy if you
>   tokenize on the word level, but you suggested that it is more efficient
>   to have longer phrases.)
>
> - the search terms can be _part of_ the tokens. In fact, a search term can
>   be the postfix of one token, then a list of other tokens, and then a
>   prefix of yet another token. It might not be really cheap to construct
>   _all_ possible combinations of tokens which make up the search term...
>
> - how do you want to cope with regular expressions? (The previous problem
>   only addresses simple, constant search terms, i.e. no true regular
>   expressions.)

I just described a simple scheme. This is an area where a lot of
research has been done and the previous three problems have been
addressed by many papers. For example there are more complicated index
forms which support queries like find hat within ten words of cat.
Another feature is word stemming which can be used to do regular
expression searching. Let's get a basic version working first and then
go for the fancier ones.

> - at the moment, most objects which are contained by a pack are relatively
>   cheaply transported via the pack protocol. IIUC your new pack format
>   would need _exactly_ the same dictionary to be transmitted as-is. IOW
>   how do you want to make on-the-fly pack generation cheap again?

You can either copy down an entire pack including the dictionaries; or
expand the tokenized text back into normal text, gzip it and send it
down the wire. Dictionaries are only a few MB so everything fits into
RAM.

> Don't get me wrong: I don't want to discourage you, but it is too easy to
> optimize for the wrong use cases (I expact a repack, or a fetch, to happen
> much more often than a grep). If you can address above-mentioned issues,

When I am working on other people's code in the kernel I do greps all
of the time. When working on your own code you don't need it as much
since you know where everything is.

Support like this could also be the basis for future IDE integration.
The indexes would allow an IDE to quickly do refactoring operations
like renames. Mozilla is doing some major refactoring currently and
they are writing custom programs to do it since they lack efficient
tools.

The indexes don't have to be simple word lists. I've used systems
where the index is closer to being a parse tree of the C code. In
those systems refactoring is trivial to do, it's more like doing
operations on a database of code than using a normal text editor. You
can also easily query things like all users of a variable, the
definition, etc. Operations like these aren't a problem on small
projects but trying doing them when there are 20M lines of source.

Also note that these are just indexes and pack formats. I can chose to
convert my git db to this form and you don't have to follow my choice.

> I see no reason why the new pack format should not be used instead of the
> current one.
>
> Ciao,
> Dscho
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
