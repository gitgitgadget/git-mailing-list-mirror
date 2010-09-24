From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: git-1.7.3 breakage: "git stash show xxx" doesn't show anything
Date: Fri, 24 Sep 2010 16:27:42 -0400
Message-ID: <00400143-1A23-4245-9D7C-4AC9093785F5@gernhardtsoftware.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net> <iET3wn06TheqzndLNXxSuZJHDP5RwU5NWenjr2MQJI96tqWxE3MYjw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>, jon.seymour@gmail.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzEs8-0006WD-34
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757813Ab0IXU1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:27:50 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:36320 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab0IXU1t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 16:27:49 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 175351FFC6B6; Fri, 24 Sep 2010 20:27:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id A99D21FFC544;
	Fri, 24 Sep 2010 20:27:37 +0000 (UTC)
In-Reply-To: <iET3wn06TheqzndLNXxSuZJHDP5RwU5NWenjr2MQJI96tqWxE3MYjw@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157051>


On Sep 24, 2010, at 4:01 PM, Brandon Casey wrote:

> Probably,
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index 7ce818b..4fbfb62 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -265,7 +265,7 @@ parse_flags_and_rev()
>        i_tree=
> 
>        REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
> -       FLAGS=$(git rev-parse --no-revs -- "$@" 2>/dev/null)
> +       FLAGS=$(git rev-parse --no-revs --flags "$@" 2>/dev/null)
> 
>        set -- $FLAGS

I bisected the issue to a9bf09e (detached-stash: simplify git stash show), which is when "git stash show" started using parse_flags_and_rev (via assert_stash_like()).

More worrying to me is that the tests for "git stash show" don't bother to test the output.  I'll be working on that now.

~~ Brian
