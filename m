From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Wed, 11 Sep 2013 13:27:58 +0200
Message-ID: <20130911112758.GB14259@raven.wolf.lan>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 13:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJick-00061Y-HP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 13:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab3IKLaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 07:30:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:56394 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab3IKLaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 07:30:11 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VJicb-0001aZ-18; Wed, 11 Sep 2013 13:30:09 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 42DDA7619A; Wed, 11 Sep 2013 13:27:58 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234560>

On Di, Sep 10, 2013 at 10:51:02 -0700, Junio C Hamano wrote:
> Consider this simple history with only a handful of commits (as
> usual, time flows from left to right):
> 
>               E
>              /   
>     A---B---C---D
> 
> where D is at the tip of the sending side, E is at the tip of the
> receiving side.  The exchange goes roughly like this:
> 
>     (receiving side): what do you have?
> 
>     (sending side): my tip is at D.
> 
>     (receiving side): D?  I've never heard of it --- please give it
>                       to me.  I have E.

At this point, why would the receiving side not tell all the heads it knows
about? That would enable the sending side to see whether it knows any of those
commits. It then would be able to remove from the sending list all the objects
that can be reached from the commits it knows about.

>     (sending side): E?  I don't know about it; must be something you
>                     created since you forked from me.  Tell me about
>                     its ancestors.

This is not exactly true. In the example I had given, the sending side has all
three commits: C, D and E. So the sending side has no reason to say that it
doesn't know anything about E. Therefore the sending side has all information
it needs to deduce exactly which objects need to be sent to the receiving side.

What needs to be sent are all the objects in C..D but without all the objects
in C..E. I guess this operation would be called set-difference in english.

And if the receiving side would have told that it has heads X Y Z in addition,
and the sending side happens to have Y, then the sending side could in
addition remove any objects that can be reached from Y from the sending list.

-- 
Josef Wolf
jw@raven.inka.de
