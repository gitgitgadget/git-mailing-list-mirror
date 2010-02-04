From: Sitaram Chamarty <sitaram@atc.tcs.com>
Subject: Re: [gitolite] repo config for delegated projects
Date: Thu, 4 Feb 2010 06:48:42 +0530
Message-ID: <20100204011842.GB497@atcmail.atc.tcs.com>
References: <20100203035718.GA30644@lapse.rw.madduck.net> <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com> <20100203202249.GA27125@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcqvQ-0002EF-R3
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab0BDBy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:54:27 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:59628 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0BDBy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:54:27 -0500
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id o141Ihlj002134;
	Thu, 4 Feb 2010 06:48:43 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id o141Ighv002131;
	Thu, 4 Feb 2010 06:48:42 +0530
Content-Disposition: inline
In-Reply-To: <20100203202249.GA27125@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/10354/Wed Feb  3 16:33:21 2010 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138929>

On Thu, Feb 04, 2010 at 09:22:49AM +1300, martin f krafft wrote:
> Dear Sitaram, dear Teemo, dear gitolite-fans,
> 
> src/gl-compile-conf:261 prohibits delegated repositories to make use
> of the functionality to configure config variables of the
> repositories:
> 
>   die "$WARN $fragment attempting to set repo configuration\n"
>     if $fragment ne 'master';
> 
> This is a bit unfortunate and makes me reconsider the use of
> delegations.
> 
> What is the reason for this restriction?

Like Teemu said, inability to think through all the possible
repurcussions of allowing a delegated admin to set config
variables.  There are too many of them for me to go through,
and they'll keep changing.

To recap, what gitolite wants to do is broadly the
following:

  - no one who is not admin can do anything to a repo that
    the config file does not permit him to do (this is not
    affected by the topic of this email; just adding it for
    completeness)

  - the main admin (who has RW/RW+ access to all of the
    gitolite-admin repo) cannot get shell access on the
    server.  This is a relatively new restriction; initially
    I did not think to keep these two privileges separate

  - a delegated admin cannot manage any sort of access to
    repos that the main admin did not delegate to him.

> 
> Are there settings that are potentially compromising?
> 
> Would it be worth to consider making it configurable (e.g.
> ~/.gitolite.rc) whether to allow delegated repos to set config
> variables?

I wouldn't mind making it configurable, with the default
being off.  Rather than a blanket

    $ALLOW_DELEGATE_CONFIGS = 1;

how about

    $DELEGATED_CONFIGS = "hooks.mailinglist,hooks.showrev";

(to take Teemu's example config file and the config
variables he uses), so that you (or whoever has shell
access, which is required for changing RC file) can sort of
limit the potential damage.

And the defaults would all be commented out anyway so people
who don't car about this will never have to worry about it.

Regards,

Sitaram
