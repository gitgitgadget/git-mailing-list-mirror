From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 11/11] tree-diff: reuse base str(buf) memory on
 sub-tree recursion
Date: Thu, 13 Feb 2014 17:25:24 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140213132524.GA15450@tugrik.mns.mnsspb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
 <645beb40c13912e87f6fe67d46af2b5e81dcaaca.1391794688.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 14:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDwGX-000531-Iz
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 14:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbaBMNXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 08:23:41 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:58991 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbaBMNXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 08:23:41 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WDwGN-0008Ek-SF; Thu, 13 Feb 2014 17:23:35 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WDwI8-00041R-4K; Thu, 13 Feb 2014 17:25:24 +0400
Content-Disposition: inline
In-Reply-To: <645beb40c13912e87f6fe67d46af2b5e81dcaaca.1391794688.git.kirr@mns.spb.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242061>

On Fri, Feb 07, 2014 at 09:48:52PM +0400, Kirill Smelkov wrote:
> instead of allocating it all the time for every subtree in
> __diff_tree_sha1, let's allocate it once in diff_tree_sha1, and then all
> callee just use it in stacking style, without memory allocations.
> 
> This should be faster, and for me this change gives the following
> slight speedups for `git log --raw --no-abbrev --no-renames`
> 
>                 navy.git    linux.git v3.10..v3.11
> 
>     before      0.547s      1.791s
>     after       0.541s      1.777s
>     speedup     1.1%        0.8%

The timings above was done with

    `git log --raw --no-abbrev --no-renames --format='%H'`
                                            ^^^^^^^^^^^^^

Please change them to correct timings:


                navy.git    linux.git v3.10..v3.11

    before      0.618s      1.903s
    after       0.611s      1.889s
    speedup     1.1%        0.7%



Thanks,
Kirill
