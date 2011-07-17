From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/17] revert: Don't create invalid replay_opts in
 parse_args
Date: Sun, 17 Jul 2011 13:43:19 -0500
Message-ID: <20110717184319.GE27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-10-git-send-email-artagnon@gmail.com>
 <20110712182958.GE14120@elie>
 <CALkWK0kcZi87watFTZCFUJpNf1T-wnRPyQ6FcDxmvFzAZE3osg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 20:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiWJO-0006cW-Rz
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab1GQSn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 14:43:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44808 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1GQSnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 14:43:25 -0400
Received: by iyb12 with SMTP id 12so2526897iyb.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7IU7faai0/aIYhAUQPUpEWMOz80oET9yV26HmS/HtNM=;
        b=m7NpyDxaK4MjgdZ7K9VHz9WLAuZtYIbjFDWQXEFxl5MVEQFE/aRKbmySTIUyMD9jLp
         lhnTWlODwupKF8Mv42Fy0GHQFAOp6o3Pg+GHG2oP53QI5cEkyWnX9BLS5HSOqSVR5BLo
         48Y7n+cFtZrf01QkhrgPnHJv0HLfAvk4mn9pg=
Received: by 10.42.178.68 with SMTP id bl4mr6498043icb.343.1310928205055;
        Sun, 17 Jul 2011 11:43:25 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id fw9sm2368173ibb.30.2011.07.17.11.43.23
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 11:43:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kcZi87watFTZCFUJpNf1T-wnRPyQ6FcDxmvFzAZE3osg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177311>

Ramkumar Ramachandra wrote:

> Thanks.  New commit message de-emphasizing "four":

Looks good.  While at it, it might be nice to simplify the final
sentence:

> revert: Don't create invalid replay_opts in parse_args
>
> The "--ff" command-line option cannot be used with some other
> command-line options.  However, parse_args still parses these
> incompatible options into a replay_opts structure for use by the rest
> of the program.  Although pick_commits, the current gatekeeper to the
> cherry-pick machinery, checks the validity of the replay_opts
> structure before before starting its operation, there will be multiple
> entry points to the cherry-pick machinery in future.  To futureproof
> the code and catch these errors in one place, make sure that an
> invalid replay_opts structure is not created by parse_args in the
> first place.  Also ensure that regressions in maintaining this
> invariant are caught in the future by adding an assertion in
> pick_commits.

I think the idea is "we still check the options struct for validity
in pick_commits, but this is an assert() call now to emphasize that
it's the caller's responsibility to get it right".
