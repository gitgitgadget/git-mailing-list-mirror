From: Joe Perches <joe@perches.com>
Subject: Re: problem when using --cc-cmd
Date: Wed, 20 Apr 2011 12:48:20 -0700
Message-ID: <1303328900.24766.29.camel@Joe-Laptop>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	 <20110419215239.GA22632@elie> <1303268630.24766.9.camel@Joe-Laptop>
	 <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCdNz-0002Lj-7p
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 21:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab1DTTsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 15:48:21 -0400
Received: from mail.perches.com ([173.55.12.10]:4853 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab1DTTsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 15:48:21 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 4DEA024368;
	Wed, 20 Apr 2011 12:48:20 -0700 (PDT)
In-Reply-To: <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171874>

On Wed, 2011-04-20 at 12:45 -0300, Thiago Farina wrote:
> On Wed, Apr 20, 2011 at 12:03 AM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2011-04-19 at 16:52 -0500, Jonathan Nieder wrote:
> >> Thiago Farina wrote:
> >> > when I run:
> >> > $ git send-email --to linux-kernel@vger.kernel.org --cc-cmd
> >> > scripts/get_maintainer.pl foo
> >> > I'm getting some lines like:
> >> > Use of uninitialized value $cc in string eq at
> >> > /home/tfarina/libexec/git-core/git-send-email line 964.
> >> Yes, sounds like a bug.  Cc-ing some send-email people for tips.
> > I haven't seen this.
> > What versions of ./scripts/get_maintainer.pl and git are
> > you using?
> $ scripts/get_maintainer.pl --version
> scripts/get_maintainer.pl 0.26
> $ git version
> git version 1.7.5.rc2.5.g60e19

To get this to work properly, the output of cc-cmd
(scripts/get_maintainer.pl) must be valid email addresses.

The git send-email --help for cc-cmd says:

       --cc-cmd=<command>
           Specify a command to execute once per patch file which should
           generate patch file specific "Cc:" entries. Output of this command
           must be single email address per line. Default is the value of
           sendemail.cccmd configuration value.

You'll need to add "--norolestats" to the cc-cmd if
you use scripts/get_maintainer.pl.

$ git send-email --to linux-kernel@vger.kernel.org \
	--cc-cmd "scripts/get_maintainer.pl --norolestats" foo

I suppose you could call it a defect that the
output of cc-cmd isn't screened for invalid
email addresses but I think it's not really a
problem.
