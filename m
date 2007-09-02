From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Buffer overflows
Date: Sun, 2 Sep 2007 16:11:32 +0100
Message-ID: <3f4fd2640709020811r4ea8f01fw775257859e26af29@mail.gmail.com>
References: <1188502009.29782.874.camel@hurina>
	 <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
	 <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
	 <200709021542.31100.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>, "Timo Sirainen" <tss@iki.fi>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 17:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRr71-0006Xp-Iq
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 17:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933789AbXIBPLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 11:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbXIBPLe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 11:11:34 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:37154 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933790AbXIBPLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 11:11:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so752097rvb
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 08:11:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ABZlp1UjsQ19PLinwnCzHlUuxfS9gHBCilcl8p+aqA2/8ASqyMxS/a966N5vXFgmqNKtwnXvcnzzzBiIfAs2PtHNvVGvnhdE5FGVB27j9bMwmnB4lgfpvjxd6ZHzmSM+7e8/1OeHxyB8nd6y4Z57EkKUrg6HXdVi1mIgSkJJ/eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V8KaBr1BzA8pFlSXB1MuIagzCGWnff4reM9WwDB2E0HpUegENv8vzzvim3eAIR9Tp1bbgDLwfYcLS3nMZuF2u+yb6m+BFdkMAzq33tQ0oGzkCIxBH7GHUHOT1d2bdcCPc32v1332f6sj3YFPf/vH49eH7HD1i9Dd7QdR/CZE1hA=
Received: by 10.141.48.10 with SMTP id a10mr1578646rvk.1188745892437;
        Sun, 02 Sep 2007 08:11:32 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Sun, 2 Sep 2007 08:11:31 -0700 (PDT)
In-Reply-To: <200709021542.31100.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57337>

On 02/09/07, Johan Herland <johan@herland.net> wrote:
> On Friday 31 August 2007, Junio C Hamano wrote:
> > The API needs to justify itself to convince the people who needs
> > to learn and adjust to that the benefit far outweighes deviation
> > from better known patterns, and I do not see that happening in
> > Timo's patch.
>
> So in general, git people seem to be saying that:
>
> 1. Yes, we agree that the C string library suX0rs badly.
>
> 2. There are more than 0 string manipulation bugs (e.g. buffer overflows) in
> git. The number may be small or large, but I have yet to see anyone claim
> it's _zero_.
>
> 3. Timo's patches (in their current form) are not the way to go, because of
> non-standard API, implementation problems, whatever...
>
> So why does the discussion end there? Lukas proposed an interesting
> alternative in "The Better String Library" (
> http://bstring.sourceforge.net/ ). Why has there been lots of bashing on
> Timo's efforts, but no critique of bstring? I'd be very keen to know what
> the git developers think of it. AFAICS, it seems to fulfill at least _some_
> of the problems people find in Timo's patches. Specifically, it claims:
>
> - High performance (better than the C string library)
> - Simple usage

Performing a brief look at the documentation, the bstring library
looks promising.

It looks like it has an allocate and grow internal buffers on demand
policy. This is similar to what the C++ std::basic_string does, as
well as the string helpers in the Boost version of Jam (written in C).
This hides the buffer management from the user of the library, rather
than obfuscating it like in Timo's patch.

The API defined in the documentation is well thought out and
extensive, moreso than in the efforts by Timo and others. It has the
traditional C API, along with other API found in other string
libraries (such as split and join). I am not sure how much of git
could make use of these, but they have the pontential to simplify some
areas of the codebase.

Looking at the documentation, it is clear that this is a well thought
out library, both from the problems/security issues of the C library
and to how it compares with other string libraries. As well as
covering buffer overflow, it also deals with things like integer
overflow.

They have also done performance tests comparing the bstring library to
the C API and C++ std::string. With the C API comparison, the library
performs about 10% slower for string assignment, but other areas don't
have a slowdown. In fact, string concatenation is _considerably_
improved, something that will help git performance. I suspect (but
have not verified) that the slowdown on assignment is due to buffer
allocation.

> I'd also say it's probably more widely used than Timo's patches.

Which is good, as this means that along with the tests in the library,
it will be more stable and less likely to be buggy than something that
is written from scratch.

> If the only response to Timo's highlighting of string manipulation problems
> in git, is for us to flame his patches and leave it at that, then I have no
> choice but to agree with him in that security does not seem to matter to
> us.

I would not like to see that happen. It seems that the bstring library
will help git in more ways than security, by improving string
concatenation performance and giving a richer string API without
sacrificing performance (except where noted) and code clarity.

It would be interesting to see how the 10% performance drop on string
assignment impacts git performance, when balanced with the drastic
(92x in the performance table) increase on string concatenation.

The only major issue that I can see with bstring is that it does not
have a wchar_t version, but git is using chars internally, so this is
not a problem for git.

- Reece
