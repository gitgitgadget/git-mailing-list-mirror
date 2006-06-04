From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 11:54:25 +0200
Message-ID: <e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 04 11:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmpJg-00053b-Me
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 11:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWFDJy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFDJy1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 05:54:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:47500 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751350AbWFDJy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 05:54:26 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1142291wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 02:54:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rk+0URYKgw3qPxdJYV8NvsKADIUciwBZsLK8mYMTAA8t/L9jr7jYuEqBWklxQCIOBXx8L5TRQ1rv5GHeItrWdYLsaBODfoqZE1FnsruvXO8TWJNqjXmfbhz9+JkaMQKH4qwN5fRgFHLDQcgVUUzTbyDZmm75IJKPjxusHjWyR2I=
Received: by 10.64.76.8 with SMTP id y8mr2798907qba;
        Sun, 04 Jun 2006 02:54:25 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 02:54:25 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21258>

On 6/4/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > As example given a selected revision with id <sha> is it possible to
> > do something like this to fond the ancestor?
> >
> > 1) get the tag list with git-peek-remote or something similar if tags
> > are not already loaded
> >
> > 2) given the tagList vector with n elements run
> >
> >    git-rev-list  --topo-order <sha> ^tagList[0]  ^tagList[1]   ....
> >  ^tagList[n-1]
> >
> > 3) take the last sha spit out by git-rev-list, be it <lastSha>.
> >
> > 4) Previous nearest tag is the parent of lastSha
>
> Sorry, I do not understand what you are doing here at all.
> Suppose you have this simple history.
>
>   (root)
>
>          a---b---d---e---f---g
>          t1   \ /        t3
>             ---c
>                t2
>
> and <sha1> in (2) is "e".  When tagList = (t1, t2, t3), the
> above rev-list would return empty.

This is enough!

Empty list is an useful and enough information.

It means:

1) Parent of current revision ("e" in our case) is a tag, indeed our seeked tag.
2) If previous point is not true then there are no previous tags.

In a less corner case, just to better explaing my idea, consider this:

          a---b---d---e---f---g---h
          t1   \ /              t3
             ---c
                t2

Where our sha1 is still "e", in this case

git-rev-list  --topo-order <e>  ^a  ^c   ^g

gives, as last revision in output list, "f"
Then parentOf(<f>) is <g> and our looked for tag is t3

   Marco
