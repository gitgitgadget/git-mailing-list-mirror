From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn clone -r HEAD
Date: Sun, 19 Jul 2009 22:55:14 -0700
Message-ID: <20090720055514.GA3229@dcvr.yhbt.net>
References: <1247771532.7382.115.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ka-Hing Cheung <kcheung@riverbed.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 07:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSlqO-00060R-SM
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 07:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbZGTFzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 01:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZGTFzP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 01:55:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48185 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbZGTFzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 01:55:15 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id F15731F585;
	Mon, 20 Jul 2009 05:55:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1247771532.7382.115.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123570>

Ka-Hing Cheung <kcheung@riverbed.com> wrote:
> Hi (not subscribed),
> 
> git-svn uses $ra->get_latest_revnum to find out the latest revision, but
> that can be problematic, because get_latest_revnum returns the latest
> revnum in the entire repository, not restricted by whatever URL you used
> to construct $ra. So if you do git svn clone -r HEAD
> svn://blah/blah/trunk, it won't work if the latest checkin is in one of
> the branches (it will try to fetch a rev that doesn't exist in trunk,
> making the clone useless).
> 
> This change seems to work, sorry it's not a proper diff:
> @sub fetch_all {
> -       my $head = $ra->get_latest_revnum;
> +       my $head = undef;
> +       $ra->get_log("", -1, 0, 1, 0, 1, sub { $head = $_[1] });

Thanks Ka-Hing,

There's an unrelated issue with $ra->get_log being broken with http(s)
URLs that need escaping, so t9118 is failing on me when SVN_HTTPD_PORT
is set (I just found another fix that broke that test, too).  I'll push
out this fix when I can get t9118 fixed with HTTP.

-- 
Eric Wong
