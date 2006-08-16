From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: gitweb / cg-export
Date: Wed, 16 Aug 2006 22:05:57 +0200
Message-ID: <20060816200557.GB9575@c165.ib.student.liu.se>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org> <44E2F911.6060002@gmail.com> <ebuvok$vnv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 22:06:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDReO-000422-SF
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 22:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWHPUGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHPUGA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 16:06:00 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:30206 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932199AbWHPUF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 16:05:59 -0400
Received: from c165 ([213.114.27.99] [213.114.27.99])
          by mxfep02.bredband.com with ESMTP
          id <20060816200558.FOYG11843.mxfep02.bredband.com@c165>;
          Wed, 16 Aug 2006 22:05:58 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GDReH-0007Mn-00; Wed, 16 Aug 2006 22:05:57 +0200
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <ebuvok$vnv$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25523>

On Wed, Aug 16, 2006 at 05:02:36PM +0530, Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V wrote:
> >Jakub Narebski wrote:
> >>Toby White wrote:
> >>
> >>>I was wondering if a feature like the following would be of
> >>>use to anyone except me: I'd like to be able to download
> >>>the full source of a given tree from gitweb.
> >>[...]
> >>So you want to have snapshot of a tree. Why not snapshot of a commit, 
> >>or of a tag?
> >>
> >>>I've quickly hacked gitweb to do this for me - patch below.
> >>>
> >>>It adds an extra link to the 'commit' page. Next to the link
> >>>that would lead you to 'tree', there is 'tar.gz' which simply
> >>>returns the tar.gz of the same tree.
> >>>
> >>>The patch is against the version of gitweb currently in
> >>>Debian, which is, erm, '264-1', apparently, because that's
> >>>what I had to hand.
> >>
> >>It is really better to hack git with git. And you can use current gitweb
> >>with old git (well, not always, as current gitweb requires --full-history
> >>option to git-rev-list to be available).
> >>
> >
> >How about the below on top of latest git
> 
> Add it to git_commit too. The patch contains the pervious changes also.
> 

Nice.

> +sub git_snapshot {
> +	if (!defined $hash) {
> +		$hash = git_get_head_hash($project);
> +	}
> +	print $cgi->header(-type=>'application/x-tar',
> +			  -Content-Encoding=>'x-gzip', -status=> '200 OK');
> +	open my $fd, "-|", "$GIT tar-tree $hash $project | gzip -c9" or die_error(undef, "Execute git-tar-tree failed.");

It might be better to use -6 (the default compression/speed trade-off)
instead of using -9 (best but slowest compression) here.  Or maybe
even make it configurable. On some servers it is probably preferable
to make the snapshot (slightly) larger and gain some cpu time.

To get some numbers I made a small benchmark with the current git
tree. I get the following on my machine:

Compression/speed    Size   Time
-1                   1.1M   0.16s
-6                   923K   0.36s
-9                   917K   0.50s  

- Fredrik
