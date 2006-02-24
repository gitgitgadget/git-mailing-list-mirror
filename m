From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-annotate efficiency
Date: 24 Feb 2006 11:06:08 -0800
Message-ID: <86oe0wbmqn.fsf@blue.stonehenge.com>
References: <118833cc0602240737i42acdc90sb8f93dde1a1bc035@mail.gmail.com>
	<118833cc0602241000p4e4c8017u3e3afe76fbbd75a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:06:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCiGn-0003jY-Gy
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 20:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWBXTGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBXTGL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 14:06:11 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:54703 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932427AbWBXTGJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 14:06:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6887A8F366;
	Fri, 24 Feb 2006 11:06:09 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19830-01-2; Fri, 24 Feb 2006 11:06:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id EA02B8F3F1; Fri, 24 Feb 2006 11:06:08 -0800 (PST)
To: "Morten Welinder" <mwelinder@gmail.com>
x-mayan-date: Long count = 12.19.13.1.8; tzolkin = 8 Lamat; haab = 6 Kayab
In-Reply-To: <118833cc0602241000p4e4c8017u3e3afe76fbbd75a4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16728>

>>>>> "Morten" == Morten Welinder <mwelinder@gmail.com> writes:

Morten> It looks like handle_rev is seeing the same revisions over and over again.
Morten> I don't know why that would be, but the following patch just skips dups.
Morten> I have no idea if it is right, though.

Morten> Morten


Morten> diff --git a/git-annotate.perl b/git-annotate.perl
Morten> index 3800c46..a5e2d86 100755
Morten> --- a/git-annotate.perl
Morten> +++ b/git-annotate.perl
Morten> @@ -117,7 +117,10 @@ sub init_claim {

Morten>  sub handle_rev {
Morten>         my $i = 0;
Morten> +       my %seen = ();
Morten>         while (my $rev = shift @revqueue) {
Morten> +               next if $seen{$rev};
Morten> +               $seen{$rev} = 1;

Morten>                 my %revinfo = git_commit_info($rev);

The traditional idiom for that is

        next if $seen{$rev}++;

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
