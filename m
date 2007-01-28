From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT and repo-config
Date: Sun, 28 Jan 2007 23:30:26 +0000
Message-ID: <b0943d9e0701281530x791078ebk78070252251323a4@mail.gmail.com>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com>
	 <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <Pine.LNX.4.63.0701270008410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070127103354.GE4036@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 00:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBJTj-0006Ci-Fl
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 00:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbXA1Xa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 18:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbXA1Xa2
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 18:30:28 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:8571 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977AbXA1Xa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 18:30:27 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1188092nze
        for <git@vger.kernel.org>; Sun, 28 Jan 2007 15:30:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KFgSjGSjMupEm/+C2ySzABPoR543kMsJ5UOwE/sF39SnCBxQzTfmg+WMI/uMSjYMIgtE5EeO8hSGmVZlo354O8dQzEWTT/YwrH9KGZzLvYJh/DKCWU+WfYidj5Owfie5s0djSoqFoSMo2sAVdO1+ynpwNybWUCMX6lSoWLD+a4g=
Received: by 10.114.13.1 with SMTP id 1mr228425wam.1170027026472;
        Sun, 28 Jan 2007 15:30:26 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Sun, 28 Jan 2007 15:30:26 -0800 (PST)
In-Reply-To: <20070127103354.GE4036@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38055>

On 27/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Sat, Jan 27, 2007 at 12:12:36AM +0100, Johannes Schindelin wrote:
> > Well, we have only two multi-valued keys at the moment (AFAIK):
> > remote.<branch>.fetch and remove.<branch>.push.
> >
> > Even if there are more, they are hardly interesting to StGIT, right?
>
> Not completely right.  It is precisely remote.<branch>.fetch I'm
> needing, to be able to locate which remote a parent branch belongs to
> when creating a stack.

You could have a dictionary with list of values instead of just one
overriding the former. The config object can have 2 methods -
get_option(), returning config_dict[option][-1] (i.e. always the last,
most specific option) and get_moption() returning the whole list. The
code requiring the options should know which method to call for either
getting a single value or multiple values.

> > The point is: it is very easy and short to just stash everything into a
> > dictionary, and retrieve it from there.
>
> OTOH, it is equally easy (if not easier) to call "git repo-config
> --get" or --get-all when needed :)

It is possible that we'll end up calling it too many times when
working on huge series (a very good benchmark is the -mm kernel
series, it really shows performance bottlenecks, mainly caused by GIT
operations for writing the index).

You could also cache the values only when asked for an option the
first time but given the relatively small size the config files, there
isn't any performance impact in caching all the options at once.

-- 
Catalin
