From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/17] revert: Introduce a layer of indirection over
 pick_commits
Date: Tue, 12 Jul 2011 15:03:24 -0500
Message-ID: <20110712200324.GD14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 22:03:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgjBC-0005Uj-PC
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 22:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab1GLUDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 16:03:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34702 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab1GLUDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 16:03:32 -0400
Received: by iwn6 with SMTP id 6so4941267iwn.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wvn+mg4cVQFzoNOcnBL1ILUENVxZkpQIGHsChOV/q88=;
        b=tRbkRA7hUGf553DgmQLNBUeLAP66dbkCKn+t1lORTRHiNmlBOWyPPuxTZrezKLEa3G
         HaIH3FnOrq0s7JteYE86KE1uf1ukfA2/+C9eG7YLOr+gAFjNYj81+MOGsAqZ2cpnyGmH
         iJtFd910/6UDHZ4aMWuYhLGrVadrrjbBt4uA4=
Received: by 10.231.45.80 with SMTP id d16mr249784ibf.111.1310501012343;
        Tue, 12 Jul 2011 13:03:32 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id m18sm4482334ibc.28.2011.07.12.13.03.30
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 13:03:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-14-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176976>

Ramkumar Ramachandra wrote:

> Write a new function called process_subcommand to prepare a todo_list
> to call pick_commits with; the job of pick_commits is simplified into
> performing the tasks listed in todo_list.  This will be useful when
> subcommands like "--reset" and "--continue" are introduced later in
> the series.

Could you give an example of how this function is used?  The name
"process_foo" does not mean much more to me than "do_it" --- i.e., it
does not tell what the function actually does.

Looking at this code, it does not just prepare a todo_list (so
fill_todo_list would not be a good name for it); it actually calls
pick_commits.  This is the main (only?) entry point to the cherry-pick
machinery, so it's worthwhile to give it a good name.  How about
pick_commits?

Meanwhile I would prefer to have multiple entry points to the
cherry-pick machinery, which would avoid this question altogether,
though I imagine you have some reason not to do that.

The mechanics of the patch (splitting out a separate function for
the actual "for each commit" loop) look like a good idea.
