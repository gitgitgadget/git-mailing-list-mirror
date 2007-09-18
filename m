From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 08:49:18 -0700
Message-ID: <20070918154918.GA19106@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org> <46EF7DD1.9090301@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXfKM-0003sz-NE
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291AbXIRPtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759255AbXIRPtU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:49:20 -0400
Received: from mail.davidb.org ([66.93.32.219]:44384 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759291AbXIRPtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:49:20 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IXfKA-0006Wd-Rr; Tue, 18 Sep 2007 08:49:18 -0700
Mail-Followup-To: Sam Vilain <sam@vilain.net>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46EF7DD1.9090301@vilain.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58620>

On Tue, Sep 18, 2007 at 07:27:13PM +1200, Sam Vilain wrote:

>I'm pretty close to giving a newer one a spin, that actually imports
>from the raw perforce back-end files without needing the perforce
>server.  I am hoping that this should give a very clean import and will
>be very fast and efficient, sending files that share ancestry to gfi in
>sequence so that the on-the-fly delta system works.

Unfortunately, this isn't something I'm going to be able to use.  The
Perforce server will remain live, and resides on a machine I don't have
access to.

>It could possibly be adapted to use the p4 client (though I'd expect
>that to be relatively slow per-revision), and possibly be extended to be
>bidirectional as all of the upstream change number information is
>recorded, a la git-svn.

I was able to get 'git-p4' to work a lot better by using @all, but it still
has some problems, at least bad interactions with P4.

   - It doesn't use any client spec.  Our P4 server space is a complete
     mismash and has to be fixed up to get a sane directory layout.  For
     example, some revisions have hundred-MB tar files sitting in the root
     directory and I don't want that in the repo.  I also need to exclude
     directories, and in some cases completely rearrange the directory
     layout.

   - Our P4 server is set to be case insensitive.  'git-p4' ignores paths
     that come back from the server that are specified using a different
     case.  Unfortunately, this means that a handful of files just get
     randomly dropped from each revision.

     I tried importing a client path instead of a depot path, but the names
     that come back from 'p4 files' are depot based so none ever match.  I
     end up with a nice revision history of entirely empty trees.

I'm probably going to end up writing an importer that uses an actual client
workspace to let Perforce do the client mapping.  I'm also going to have to
put some work into some code to clean up the log messages, since most of
our changes have as a first line "New Features:", which makes for a rather
uninformative shortlog.

But, I did learn about 'p4 -G' from git-p4 so that will help in getting
information from the repository.

Thanks,
David
