From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCHv4] Add Gitweb support for XZ compressed snapshots
Date: Fri, 31 Jul 2009 11:07:47 -0700
Message-ID: <4A7332F3.50908@eaglescrag.net>
References: <828BD9FC-1238-4B2E-858D-248977F04D31@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:08:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWwWR-0006W8-0S
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 20:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbZGaSHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 14:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZGaSHz
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 14:07:55 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:35283 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbZGaSHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 14:07:54 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n6VI7lHx003075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 31 Jul 2009 11:07:48 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <828BD9FC-1238-4B2E-858D-248977F04D31@uwaterloo.ca>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9634/Wed Jul 29 20:03:31 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 31 Jul 2009 11:07:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124587>

Mark A Rada wrote:
> Ok, so I got a good nights sleep now, and reviewed the results of my
> benchmarks to make sure they were consistent (turns out I had the
> archive sizes in the wrong order for the XZ repository tests).
> 
> I also reworded a number of things and added a conclusion to the
> benchmarks.
> 
> Let me know what you think.
> 
> 
> -- 
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca
> 
> 
> ------->8--------------
> From: Mark Rada <marada@uwaterloo.ca>
> Date: Thu, 30 Jul 2009 08:56:42 -0400
> Subject: [PATCH] Add Gitweb support for XZ compressed snapshots
> 
> The XZ compression format uses the LZMA2 compression algorithm, which
> often yields higher compression ratios than both GZip and BZip2 at the
> cost of using more CPU time and RAM. Though, while XZ is the slowest
> for compression, it is much faster than BZip2 for decompression, almost
> comparable to GZip (see benchmarks below).
> 
> You can enable XZ compressed snapshots by adding 'txz' to the list of
> default options for snapshots in your $GITWEB_CONFIG.
> 
> I did some simple benchmarks, starting with an already tarballed
> archive of the repos listed below. Memory usage seemed to be consistent
> for any given algorithm at their default compression level. Timings were
> gathered using the `time' command.
> 
> CPU: AMD Sempron 3400+ (1 core @ 1.8GHz with 256K L2 cache)
> Virtual Memory Usage
>     GZip: 4152K    BZip2: 13352K    XZ: 102M
> 
> Linux 2.6 series (f5886c7f96f2542382d3a983c5f13e03d7fc5259)     349M
> gzip     23.70s user        0.47s system      99% cpu  24.227 total     76M
> gunzip     3.74s user         0.74s system      94% cpu  4.741 total
> bzip2     130.96s user       0.53s system      99% cpu  2:11.97 
> total     59M
> bunzip2 31.05s user        1.02s system      99% cpu  32.355 total
> xz     448.78s user     0.91s system      99% cpu  7:31.28 total     51M
> unxz     7.67s user         0.80s system      98% cpu  8.607 total
> 
> Git (0a53e9ddeaddad63ad106860237bbf53411d11a7)             11M
> gzip     0.77s user     0.03s system     99% cpu  0.792 total     2.5M
> gunzip     0.12s user     0.02s system     98% cpu  0.142 total
> bzip2     3.42s user     0.02s system     99% cpu  3.454 total     2.1M
> bunzip2 0.95s user     0.03s system     99% cpu  0.984 total
> xz     12.88s user     0.14s system     98% cpu  13.239 total     1.9M
> unxz     0.27s user     0.03s system     99% cpu  0.298 total
> 
> XZ (669413bb2db954bbfde3c4542fddbbab53891eb4)             1.8M
> gzip      0.12s user     0.00s system     95% cpu  0.132 total     442K
> gunzip     0.02s user     0.00s system     97% cpu  0.027 total
> bzip2      1.28s user     0.01s system     99% cpu  1.298 total     363K
> bunzip2 0.15s user     0.01s system     100% cpu 0.157 total
> xz     1.62s user     0.03s system     99% cpu  1.652 total     347K
> unxz       0.05s user     0.00s system     99% cpu  0.058 total
> 
> Purely from a time and memory perspective, nothing compares to GZip in
> each of the three tests. Though, if you have an average upload speed of
> 20KB/s, it would take ~400 seconds longer to transfer the kernel snapshot
> that was BZip2 compressed than it would the XZ compressed snapshot, the
> transfer time difference is even greater when compared to the GZip
> compressed snapshot. The wall clock time savings are relatively the same
> for all test cases, but less dramatic for the smaller repositories.
> 
> The obvious downside for XZ compressed snapshots is the large CPU and
> memory load put on the server to actualy generate the snapshot. Though XZ
> will eventually have good threading support, and I suspect then that the
> wall clock time for making an XZ compressed snapshot would go down
> considerably if the server had a beefy multi-core CPU.
> 
> I have not enabled XZ compression by default because the current default
> is GZip, and XZ is only really competitive with BZip2. Also, the XZ format
> is still fairly new (the format was declared stable about 6 months ago),
> and there have been no "stable" releases of the utils yet.

One thing that would concern me greatly, is not so much the CPU time 
(though that's a *huge* change in comparison to gz) but the memory 
usage.  Where gzip and bzip2 are chewing 4M and 13M respectively, xz 
chews 102M.  From a 'beefy' server perspective chewing up that much 
memory per snapshot for that long could be bad.  This is likely 
something that needs to have some sort of enable/disable switch if it's 
going to be included.

Good analysis btw, though I'll admit it makes me leary of something 
dynamically generating xz compressed files.

- John 'Warthog9' Hawley
