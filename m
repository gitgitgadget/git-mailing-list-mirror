From: Joachim Berdal Haga <cjhaga@student.matnat.uio.no>
Subject: Re: Compression speed for large files
Date: Mon, 03 Jul 2006 15:32:42 +0200
Message-ID: <44A91C7A.6090902@fys.uio.no>
References: <loom.20060703T124601-969@post.gmane.org> <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 15:33:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxOXk-000566-Pa
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 15:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWGCNcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 09:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGCNcs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 09:32:48 -0400
Received: from pat.uio.no ([129.240.10.4]:4062 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751161AbWGCNcs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 09:32:48 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.43)
	id 1FxOXe-00038u-SK; Mon, 03 Jul 2006 15:32:47 +0200
Received: from fnasa.simula.no ([129.240.228.53] helo=[192.168.100.115])
	by mail-mx2.uio.no with esmtp (Exim 4.43)
	id 1FxOXc-0003Ai-5Y; Mon, 03 Jul 2006 15:32:44 +0200
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12,
	autolearn=disabled)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23175>

Alex Riesen wrote:
> On 7/3/06, Joachim B Haga <cjhaga@fys.uio.no> wrote:
>> So: is it a good idea to change to faster compression, at least for 
>> larger files? From my (limited) testing I would suggest using 
>> Z_BEST_COMPRESSION only for small files (perhaps <1MB?) and 
>> Z_DEFAULT_COMPRESSION/Z_BEST_SPEED for
>> larger ones.
> 
> Probably yes, as a per-repo config option.

I can send a patch later. If it's to be a per-repo option, it's probably 
too confusing with several values. Is it ok with

core.compression = [-1..9]

where the numbers are the zlib/gzip constants,
   -1 = zlib default (currently 6)
    0 = no compression
1..9 = various speed/size tradeoffs (9 is git default)

Btw; I just tested the kernel sources. With gzip only, but files 
compressed individually:
   time find . -type f | xargs gzip -9 -c | wc -c

I found the space saving from -6 to -9 to be under 0.6%, at double the 
CPU time. So perhaps Z_DEFAULT_COMPRESSION would be good as default.

-j
