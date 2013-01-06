From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] git-clean: Display more accurate delete messages
Date: Sun, 6 Jan 2013 15:40:22 -0800
Message-ID: <20130106234022.GB3823@elie.Belkin>
References: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 00:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trzpg-0002vK-7g
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 00:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3AFXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 18:40:29 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:62127 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab3AFXk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 18:40:27 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so8345503dam.18
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 15:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6GNgycTRJ6tsCSDiI+MpaP9CE/mHWN2EKv7SQy5Kxmw=;
        b=u+eRiqZ2tVplU8XWjkWYJ+oQoZ85xEjUt/HRHogsLNDVisEqWPyswirLM1e89Txl9N
         GyOwp/XAg8xAILzJQ75L4XY3sbNwIxZfT3ZNXugm0KxIeE1q9etYqWGN1cbKIZjss5vX
         oIzH6XSFw1TFTnlk0psWr/kIiyY6gKk5+2HkhiMgoET+E59mP4gl7NPApX1imcM/yKDM
         BkgU4JrTaf8U5kLkuKGdNSpi7GYbbNKISo2nfulDWeiZgWRNctOZb+cbvJDvDLepcuOi
         yKR8ZtsEbP2SviKNzJrPkRPBSG+pkSaA+oGhSbFcsWCqmby/nk0Qr5QEj3Cbrr7ikGJw
         +9PQ==
X-Received: by 10.68.237.135 with SMTP id vc7mr181677926pbc.2.1357515627328;
        Sun, 06 Jan 2013 15:40:27 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pu5sm36459328pbb.73.2013.01.06.15.40.24
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 15:40:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212860>

Zoltan Klinger wrote:

>   $ git clean -fd
>   Removing tracked_dir/some_untracked_file
>   Removing untracked_file
>   Removing untracked_foo/
>   Removing untracked_some.git/
>
> The message displayed to the user is slightly misleading. The foo/
> directory has not been removed because of foo/frotz.git still exists.
> On the other hand the subdirectories 'bar' and 'emptydir' have been
> deleted but they're not mentioned anywhere. Also, untracked_some.git
> has not been removed either.
[...]
> Consider the output of the improved version:
>
>   $ git clean -fd
>   Removing tracked_dir/some_untracked_file
>   Removing untracked_file
>   warning: ignoring untracked git repository untracked_foo/frotz.git
>   Removing untracked_foo/bar
>   Removing untracked_foo/emptydir
>   warning: ignoring untracked git repository untracked_some.git/

Thanks, this looks like a nice improvement.

I wonder whether it's possible to make the output more consistent,
as in:

	Removing tracked_dir/some_untracked_file
	Removing untracked_file
	Skipping repository untracked_foo/frotz.git
	Removing untracked_foo/bar
	Removing untracked_foo/emptydir
	Skipping repository untracked_some.git

or similar.  What do you think?

Thanks,
Jonathan
