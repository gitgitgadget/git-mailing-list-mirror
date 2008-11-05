From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git SVN Rebranching Issue
Date: Tue, 4 Nov 2008 19:40:39 -0500
Message-ID: <32541b130811041640x18e3bbfewa639df356ff7561e@mail.gmail.com>
References: <20081103140746.GA5969@mars.cyantechnology.local>
	 <20081104084111.GB14405@untitled>
	 <20081104094224.GC24100@dpotapov.dyndns.org>
	 <20081105003318.GA5666@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Matt Kern" <matt.kern@undue.org>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 01:41:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxWT6-00041U-89
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 01:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbYKEAkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 19:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbYKEAkm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 19:40:42 -0500
Received: from mail-gx0-f15.google.com ([209.85.217.15]:33341 "EHLO
	mail-gx0-f15.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbYKEAkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 19:40:41 -0500
Received: by gxk8 with SMTP id 8so91671gxk.13
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 16:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=g5tu0s2sDXKFF9+TsNagKfxGOsmuMX8WzqwwCkUuOrs=;
        b=mcPZZsGEX7hpgQXZq0E9DTUCOTQMia8eD5kKBUOWTj0A/Gz3FEm79mQyPkCZDV8DBA
         8dfQidq5ZxOnCT1KezfpX1KOkP4JNu8YCP6PvBa2Pu0zo4uLmqXmIyv/o5h3bZG/uh6x
         9jze6+0fuelzWJjT/0oNwhv90zf2jndbu2lWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Qyp1zYQYRVK2XcqHecgOLMt1BQnym+Tupjzf7EEwMXB20WuEr4b978mCaCKpqqHxvF
         nUdgJKJ+HQwiYTET7XWq94IGYa8KCWD1jiQMQfdLKGE159HWSnnq5RhcLgS/WDfb8UZs
         eej6P4Lb4tVlXO3VLp8d5I3nXMXPSDJXb1vec=
Received: by 10.151.155.9 with SMTP id h9mr603710ybo.8.1225845639439;
        Tue, 04 Nov 2008 16:40:39 -0800 (PST)
Received: by 10.150.96.5 with HTTP; Tue, 4 Nov 2008 16:40:39 -0800 (PST)
In-Reply-To: <20081105003318.GA5666@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100132>

On Tue, Nov 4, 2008 at 7:33 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Dmitry Potapov <dpotapov@gmail.com> wrote:
>> On Tue, Nov 04, 2008 at 12:41:11AM -0800, Eric Wong wrote:
>> >
>> > Short answer: you can use grafts to remove parents.
>>
>> Using grafts requires some cautious, especially when it is used to make
>> some commits unreachable, because git gc can remove unreachable commits.
>> Also, a repository with grafts cannot be cloned.  So using grafts looks
>> like more as workaround rather a real solution.
>
> I don't think extra history is harmful at all, so the grafts could even
> be temporary.  AFAIK, the extra history is only an aesthetic issue in
> visualizers (and I actually like to see it myself).

But it's *lying* history in this case; it doesn't reflect what really
happened in svn *or* in real life.  I'd say lying history is most
often harmful.  "git blame" and "git log" will lie in this case, for
example.

>> Would it not be better to save the old branch using "@SVN-NUMBER" as
>> suffix? Thus, those do not need the old branch can easily delete it.
>
> That would require renaming _existing_ branches to their "@SVN-NUMBER"
> name; which would break mechanisms for tracking branches based on
> refname.

Well, you wouldn't have to rename the existing branch.  You would
simply create the new @SVN-NUMBER branch when it became clear that
that commit is no longer reachable from the undecorated branch ref.
Isn't that why the @SVN-NUMBER branches are needed in the first place?

As for tracking branches based on refname, it seems like the current
behaviour of pretending to merge histories together wouldn't work too
well anyway.  For someone pulling from the messed-up branch, they
really *will* need to rewind and re-pull, since that's exactly what
happened in svn.  I don't think git has any chance of doing this
automatically just because of a new commit with two parents.

Disclaimer: I haven't run into any of this myself since I don't
recycle branch names in svn :)

Have fun,

Avery
