X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS22107 204.16.104.0/24
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:24:24 +0200
Message-ID: <200705021624.25560.kendy@suse.cz>
References: <200705012346.14997.jnareb@gmail.com>
Reply-To: releases@openoffice.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, releases@openoffice.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: releases-return-10790-opof-releases=m.gmane.org@openoffice.org Wed May 02 16:24:39 2007
Return-path: <releases-return-10790-opof-releases=m.gmane.org@openoffice.org>
Envelope-to: opof-releases@gmane.org
Received: from s006.sjc.collab.net ([204.16.104.2] helo=openoffice.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1HjFl0-00085Q-1h
	for opof-releases@gmane.org; Wed, 02 May 2007 16:24:38 +0200
Received: (qmail 6002 invoked by uid 5000); 2 May 2007 14:24:35 -0000
Mailing-List: contact releases-help@openoffice.org; run by ezmlm
Precedence: bulk
X-No-Archive: yes
list-help: <mailto:releases-help@openoffice.org>
list-unsubscribe: <mailto:releases-unsubscribe@openoffice.org>
list-post: <mailto:releases@openoffice.org>
Received: (qmail 5988 invoked from network); 2 May 2007 14:24:35 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAABo8OEZSd/Jeh2dsb2JhbACBeY4vAgEIDio
X-IronPort-AV: i="4.14,480,1170662400"; 
   d="scan'208"; a="56605568:sNHT238867363"
X-IRONPORT: SCANNED
User-Agent: KMail/1.9.1
In-Reply-To: <200705012346.14997.jnareb@gmail.com>
Content-Disposition: inline
X-Gmane-Expiry: 2007-05-16
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46021>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On Tuesday 01 May 2007 23:46, Jakub Narebski wrote:

> OpenOffice.org is looking for a new SCM (Software Configuration
> Management) tool, or at least was on Friday, 19 Jan 2007;
> see: http://blogs.sun.com/GullFOSS/entry/openoffice_org_scm
>
> One of the SCMs considered is Git. One of others is Subversion.
> There is a functional git tree with the entire OOo history for testing
> purposes that can be found at: http://go-oo.org/git.
>
> What I am concerned about is some of git benchmark results at Git page
> on OpenOffice.org wiki:
>   http://wiki.services.openoffice.org/wiki/Git#Comparison
> Actually it is comparison with CVS and Subversion, although most
> benchmarks are done only for git.

I did the git numbers, so if they are wrong - blame me :-)  I am also curious
about the SVN numbers, because the SVN conversion [from my point of view]
cheats a lot.  From what I know, it does not contain the historical branches
(yes, the >3000 of them that are in the git tree), and if I understood that
correctly, instead of history in the branches, they commit just
'integration commits' [one commit for all the changes in the branch] which
breaks 'svn blame' completely.

Unfortunately, I did not have a chance to try the SVN tree yet to see it
myself to prove this true or false :-(

> In 'Size of data on the server' git has CVS beat hands down: 1.3G vs
> 8.5G for sources, 591M vs 1.1G for third party. I think it is similar
> for Subversion. I hope that repository is fully packed: IIRC the Mozilla
> CVS repository import was about 0.6GB pack file, not 1.3GB.
>
> The problem is with 'Size of checkout': to start working in repository
> one needs 1.4G (sources) and 98M (third party) for CVS checkout (it is
> 1.5G for sources for Subversion checkout). Ordinary for distributed SCM
> you would need size of repository + size of sources (working area),
> which is 2.8G for sources and 688M for third party stuff files you can
> hack on + the history]. This makes some prefer to go centralized SCM
> route, i.e. Subversion as replacement for CVS (+ CWS, ChildWorkSpace).

Considering the size OOo needs for build (>8G without languages),
the ~1.4G overhead for history is very well bearable.  I am surprised about
the 100M overhead for SVN as well - from my experience it is usually about
the size of the project itself; but maybe they improved something in SVN
in the meantime.

> What might help here is splitting repository into current (e.g. from
> OOo 2.0) and historical part,

No, I don't want this ;-)

> and / or using shallow clone. Implementing 
> partial checkouts, i.e. checking out only part of working area (and
> using 'theirs' strategy for merging not-checked-out part for merges)
> would help. Splitting repository into submodules, and submodule
> support -- it depends on organization of OOo sources, would certainly
> help for third party stuff repository.

We should better split the OOo sources; it's a process that already started
[UNO runtime environment vs. OOo without URE], and I proposed some more
changes already.

> 'Checkout time' (which should be renamed to 'Initial checkout time'),
> in which git also loses with 130 minutes (Linux, 2MBit DSL) [from
> go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from
> go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux,
> 2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows,
> 34Mbit Line) for Subversion, would also be helped by the above.

Good point, and I already changed the page in the morning.  I also added the
checkout time that I got over a fast line [it was 44min].

> What I'm really concerned about is branch switch and merging branches,
> when one of the branches is an old one (e.g. unxsplash branch), which
> takes 3min (!) according to the benchmark. 13-25sec for commit is also
> bit long, but BRANCH SWITCHING which takes 3 MINUTES!? There is no
> comparison benchmark for CVS or Subversion, though...

I am really curious about the SVN tree.  As I said, I did not see it yet.
There is just some info about it here:
http://wiki.services.openoffice.org/wiki/SVNMigration, but I cannot check it
now, the Wiki is down :-(

> Comparison / benchmark lacks some crucial info, like what computer was
> used (CPU, RAM, HDD), what filesystem was used, git version etc. It
> does have commands used for tests (benchmarks).

For the git tests, it was:

CPU: AMD Athlon(tm) 64 Processor 3200+

RAM: 1G RAM

Disk (info from bonnie):
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
one    1*2000 37819 77.6 44296 16.8 16982  5.1 35203 63.9 45915  6.6  152.4  0.4

Filesystem: ext3

> Could you confirm (or deny) those results? go-oo.org uses git 1.4.3.4;
> was there some improvement or bugfix related to the speed of checkout?

Regards,
Jan

