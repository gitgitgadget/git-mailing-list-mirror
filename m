From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: merge smart enough to adapt to renames?
Date: Fri, 20 Feb 2009 09:24:12 +0200
Message-ID: <499E5A9C.6090900@dawes.za.net>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>	 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>	 <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net> <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 08:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaPnO-0004KZ-Ci
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 08:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbZBTHZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 02:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZBTHZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 02:25:26 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:33227 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbZBTHZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 02:25:25 -0500
Received: from spunkymail-a9.g.dreamhost.com (sd-green-bigip-66.dreamhost.com [208.97.132.66])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 11A31179E5D
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 23:25:25 -0800 (PST)
Received: from artemis.local (unknown [41.246.10.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id 985F31FC8F;
	Thu, 19 Feb 2009 23:24:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110807>

Caleb Cushing wrote:
>> Not sure I understood this completely, but I've found it
>> helps to make the rename/move as a separate commit, then
>> start changing stuff.  In other words, do too many things in
>> the same commit, and you could lose this coolness.
> 
> well I the problem is.. in a sense I need to unmerge 2 files that I
> once merged... they currently have the same name and are in the same
> place, and where I merge them from they'll continue to have that  name
> (although they are different files with the same purpose) but I want
> them to have different names and spots in my tree/repo.
> 

Not having done this myself, I'd take this following suggestion with a
grain of salt! :-)

It seems to me that git is smart enough to figure out where contents get
moved to, once. Of course, if you have conflicting moves in the same
repo, git's automation falls down. So, if you need to move the "same"
file in different repositories to different places, you need to do it
via an intermediate repo that will be able to "remember" which movement
you chose.

e.g.
upstream A:
data <- contains one set of data

upstream B:
data <- contains another set of data

pull upstream A into intermediate A, move the file as desired, and commit:
Intermediate A:
data/upstreamA

pull upstream B into intermediate B, move the file as desired, and commit:
Intermediate B:
data/upstreamB

merge Intermediate A and Intermediate B in master:
master:
data/upstreamA
data/upstreamB

Then, subsequent pulling from upstream A into Intermediate A will
"remember" the move of "data" to "data/upstreamA", and similarly with B.
Subsequent merges of Intermediates A & B into master will end in the
desied result.

Hope this helps.

Rogan
