From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn clone behaves non-deterministic
Date: Thu, 27 Nov 2008 23:40:42 +0100
Message-ID: <20081127224042.GC12716@raven.wolf.lan>
References: <20081127075351.GA12716@raven.wolf.lan> <492E6E80.7010209@drmicha.warpmail.net> <20081127182947.GB12716@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 23:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5phw-0002Hl-68
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 23:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYK0WuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 17:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYK0WuP
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 17:50:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:50586 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbYK0WuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 17:50:14 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1L5pgb-0005Yy-8b; Thu, 27 Nov 2008 23:50:13 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 85C783A72C; Thu, 27 Nov 2008 23:40:42 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081127182947.GB12716@raven.wolf.lan>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101844>

On Thu, Nov 27, 2008 at 07:29:47PM +0100, Josef Wolf wrote:

> - "HEAD points to unborn branch" confirms that the import failed
> - there are exactly 2000 "Checking reflog" lines.  Since the last
>   imported revision was 2008, I would have expected 2008 (or 2007
>   or 2009) such lines.  My first thought was this might be related
>   to the --repack option defaulting to 1000.  But with --repack=570
>   it also stops after r2008.

I've done lots of trial-and-error and I think I've finally found the
point where the script stops working.  Fortunately, git-svn is a perl
script :-). So I've found in the sub gs_do_update, the
statement

   $reporter->finish_report($pool);

is the last executed function.  Here is what Data::Dumper says about
the $pool parameter:

  $VAR1 = bless(
              do {
                  \(
                      my $o = bless(
                         do{
                              \(my $o = 148559280)
                         },
                         '_p_apr_pool_t'
                      )
                   )
              },
              'SVN::Pool'
          );

I have tried to format the Data::Dumper output more readable.

Any hints how to get closer to the problem?
