From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 workflow suggestions?
Date: Wed, 11 Mar 2009 05:58:05 -0700
Message-ID: <20090311125805.GA28155@padd.com>
References: <20090309142108.GK12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhO1N-000567-3l
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbZCKM5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbZCKM5W
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:57:22 -0400
Received: from marge.padd.com ([99.188.165.110]:60373 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbZCKM5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 08:57:20 -0400
Received: from honk.padd.com (honk.padd.com [209.17.171.228])
	by marge.padd.com (Postfix) with ESMTPSA id C05EB10F8274;
	Wed, 11 Mar 2009 05:57:18 -0700 (PDT)
Received: by honk.padd.com (Postfix, from userid 7770)
	id 534E61C400CE; Wed, 11 Mar 2009 05:58:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090309142108.GK12880@zoy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112923>

sam@zoy.org wrote on Mon, 09 Mar 2009 15:21 +0100:
>    I have modified git and git-p4 to a point where they are usable in
> my work environment. I am now faced with a new problem: Perforce's
> composite workspaces. They allow you to "mount" parts of the repo onto
> other directories, even nonempty ones.
> 
>    Take the following example repository, where a "framework" project
> contains an example subdirectory with build files and other directories,
> and a "project1" project contains subdirectories that are meant to
> replace the ones in "example":
> 
>    //work/framework/example/src/
>                            /include/
> 			   /Makefile
> 			   /...
>    //work/project1/src/
>                   /include/

In perforce terms, your "view mapping" looks like:

    //work/framework/example/src/... //client/src/...
    //work/project1/src/include/...  //client/src/include/...

?

I'm not a pro with p4, but do deal with many-line mappings like
this.  Stock git-p4 handles these, except doesn't map correctly to
the right-hand side.  I haven't tried to see if it would correctly
use the include files from project1 instead of framework in your
example.

If you can get git-p4 to figure out the mapping correctly, I don't
expect any problems with respect to atomicity of commits.  As far as
perforce goes, a server seems to manage its entire p4 space as one
big single project.  Similarly with the git side of things---it's
just a matter of getting this mapping correct.

I too hacked the getClientSpec() part of git-p4 to put files into
the correct directories in the git side.  My changes are a bit
messy, and may interfere with other usage models, hence not
submitted.  Maybe we should make an effort to get this right though.
Do you have any changes to show how you are modifying things?

		-- Pete
