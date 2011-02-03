From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Wed, 2 Feb 2011 23:53:59 -0600
Message-ID: <20110203055359.GA23220@elie>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com>
 <4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
 <201102021921.53755.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 06:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pks91-0000T1-0v
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1BCFyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:54:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47102 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1BCFyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:54:07 -0500
Received: by yxt3 with SMTP id 3so338028yxt.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 21:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=K3bga+V8k/E06TrOU9zGe0gmOj35ATh94CIwhjSSzOE=;
        b=jON9xn+dFdtZKMUGPe8ZfFAVAxRV448KEmA0w04wboAZ6zLhBPTtY9JZA3rvtp/KSJ
         jXY2azXq6DbHHN452lJIsv/5YyyziVfUn3dEvgzXeBR71gdkUj3j3ws2YW3mZ33y2Y2I
         ypSX2EUozQ/lF1UPQZEHf+dbQARzli281zk/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d3ZRm9CPXrvUxGRneH+a5NnjqoP8Y9RLPEoU+Iuk3k6TwNmyr/QCRtL8bqvyUhonwK
         Sq9YxiHS6XkCKUSJUFMRPy4wF+LigQiOl9ry2wKwUBKntcAOoPzjyQJkH4Cbn49AjTuM
         2rLRYg8T1lERo6M9I+iUUsbw2cjTmhF/x3hL8=
Received: by 10.100.216.11 with SMTP id o11mr6348846ang.117.1296712446973;
        Wed, 02 Feb 2011 21:54:06 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id 17sm555823anx.33.2011.02.02.21.54.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 21:54:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102021921.53755.wjl@icecavern.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165957>

Wesley J. Landaker wrote:

>   1) Why WOULDN'T you want to track empty directories? We track empty files: 
> isn't that just as pointless?

See http://thread.gmane.org/gmane.comp.version-control.git/52875

>   2) One of git's best strengths is that it's so easy to interact with other 
> SCM software, primarily because git's features are a SUPERSET of other SCMs. 

Not really.  For example, many other SCMs can store per-file comments,
arbitrary revision properties, a detailed provenance of a file, and
detailed permissions for each directory entry.

What might make git nice as an interoperability tool is that it tracks
the _relevant_ information for the history of a software project.
Example of what is not relevant information and why that matters:

 http://thread.gmane.org/gmane.comp.version-control.git/53494

All that said, I do want support for explicitly[1] tracking empty
directories, mostly for the sake of the ability to clone an svn repo
with empty directories in a simple way.

The aforementioned "share a project skeleton" use case is just a nice
bonus.

Hope that helps,
Jonathan

[1] Part of the value of the "explicitly" is to make it explicit that
early adopters are asking for trouble. :)  FWIW I imagine a transition
like this:

 1. Teach "git read-tree" and "git checkout-index" to honor empty
    directories (but not "git update-index" or "git write-tree").

 2. Teach "git write-tree" to accept empty directories.

 3. Teach "git update-index" to accept empty directories if a
    configuration item indicates so.  That configuration would
    default to false.

 4. (Maybe) add porcelain support for tracking of empty directories.
    Also teach "git diff-tree" and "git apply" about empty
    directories.

 5. Change the default to true.

An orthogonal question is how the empty directories would be stored.
I do not like the idea of a ".empty-directory" file, since what
happens when you try to import a repository with a genuine
".empty-directory" file?

Based on a quick test, currently read-tree _ignores_ empty tree
entries.  Would it be okay to say that anyone who turns on the switch
from step (3) has declared he is willing to write tree objects that
git fsck versions before v1.5.5-rc0~63 (fsck.c: fix bogus "empty tree"
check, 2008-03-04) will reject and current git might mishandle?
