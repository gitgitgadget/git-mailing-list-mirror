From: Jamie Couture <jamie.couture@gmail.com>
Subject: Re: How to delete all merged branches?
Date: Sun, 16 Feb 2014 14:17:22 -0500
Message-ID: <20140216191721.GA29471@neptune>
References: <5300F748.2060805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 20:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF7DX-0004W7-He
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 20:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbaBPTR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 14:17:26 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:59493 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbaBPTR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 14:17:26 -0500
Received: by mail-ie0-f170.google.com with SMTP id lx4so4528846iec.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 11:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fJehm/Ywp0cp99pBXKs1VGHRgdDkRdeALUVmaTjxSpA=;
        b=GwkiLtpQlgtlDZ6lq50sNzps43Qu0zA9tF2XX2dgMSaiTYGP5Q9gxfQo9vVidxctAI
         1FRHn90Yuv/2fDfiGSvqMzGxaPDnWI9k7wGaCMX1+skt7BMn5UTz17gukqqr3hUVkyiJ
         BNplCZuALPrh8U9LEUVPDrIZehGAv0PN+VKm651Nqc5TuNlR9xNOctqZRoARNJm+OZIY
         bLUeuOTeNDgYRDWRJ1pjly1VDBQWosZCnCpmTh1A+Ts1ewHUravRz+ZJCZ+gQwc+PQqh
         uBEUXCVKnwUWQgnZptjNbgSfXgK0F8OsINB4KkVr6oqABXvb4rP0kYdizDXteWGnOO4o
         Obwg==
X-Received: by 10.42.52.209 with SMTP id k17mr14298875icg.1.1392578245788;
        Sun, 16 Feb 2014 11:17:25 -0800 (PST)
Received: from neptune (198-84-246-171.cpe.teksavvy.com. [198.84.246.171])
        by mx.google.com with ESMTPSA id vu3sm24598246igc.6.2014.02.16.11.17.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Feb 2014 11:17:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5300F748.2060805@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242241>

On Sun, Feb 16, 2014 at 06:37:12PM +0100, Stefan Beller wrote:
> Hi,
> 
> so I tend to accumulate lots of branches as I'd do one 
> branch per feature. When cleaning up, I'd like to 
> delete all branches, which have been merged.
> I could use 
> 	$ git branch -d (which was merged already?) ^C
> 	$ git branch --merged # let's find out
> 	...
> 	$ # Now run git branch -d with each of the branches.
> 
> This kind of question has already been discussed, 
> http://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-are-already-merged
> suggests:
> 	git branch --merged | grep -v "\*" | xargs -n 1 git branch -d

probably saner to check where you are first, and have it conform to
some branch naming scheme; maybe someting like:

 - check you're on master
 - only consider branches that begin with first-last-/

-- 8< --
head=$(git rev-parse --verify HEAD)
master=$(git rev-parse --verify master)

if test "$head" != "$master"; then
    echo "You must be on master"
    exit 1
fi

git branch --merged  |
sed -n -e 's/\ *//' -e '/^[^/][^/]\//p' |
xargs git branch -d
-- 8< --

> 
> Now it seems as if this operation would be needed by quite a few people
> actually. Maybe it's time to integrate into git? I'd be interested, which
> way would be the most git-like way to do it.
> I could think of:
> 	$ git branch -d --merged # no need to specifiy a branch iff --merged is given with -d
> 	$ git branch --delete-merged 	# comes as an new extra option, doesn't clutter other commands
> 	$ git branch -d keyword-for-all-merged-branches
> 
> Before starting such a feature, I'd like to hear input of others.
