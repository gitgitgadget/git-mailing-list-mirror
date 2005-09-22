From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 6/8] cogito: Don't ever assume object type in
	cg-object-id
Date: Wed, 21 Sep 2005 23:27:05 -0400
Message-ID: <1127359625.8074.18.camel@dv>
References: <1127183120.31115.34.camel@dv>
	 <20050921100040.GE24902@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 22 05:27:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIHju-0005BJ-OL
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 05:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVIVD1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 23:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVIVD1M
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 23:27:12 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:51158 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030200AbVIVD1L
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 23:27:11 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EIHjo-0000Af-C7
	for git@vger.kernel.org; Wed, 21 Sep 2005 23:27:08 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EIHjl-0003Ry-D4; Wed, 21 Sep 2005 23:27:05 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050921100040.GE24902@pasky.or.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9093>

Hello, Petr!

On Wed, 2005-09-21 at 12:00 +0200, Petr Baudis wrote:
> Dear diary, on Tue, Sep 20, 2005 at 04:25:20AM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > Don't ever assume object type in cg-object-id.
> > 
> > If type is unknown in normalize_id(), make it empty so it's checked
> > later.  Check parent ID that it's a commit.
> 
> Why? In most of the cases, you have one pointless fork() more, and we
> "assume" only if it was in a parent line, and if that's not a commit,
> you've got a *serious* problem with your database. fsck should yell you
> to death, and I don't think you could even normally commit such a
> commit, so this should never happen. There's no point in wasting time
> trying to handle seriously messed up database.

I agree in this case.  I actually was unsure, but I decided to play safe
after reading this comment in cg-tag:

#       This is most usually the ID of the commit to tag. Tagging 
#       other objects than commits is possible, but rather "unusual". 

As for fsck "yelling to death", when was the last time you tried that on
the cogito repository fetched by cogito?  That's what I get:

[proski@dv cogito]$ git-fsck-objects
missing tree 0842d4cb3cd36675c518c241b16cf25fad0c5384
broken link from  commit 2c70421be7d88fbee49986d7a5584d1f010a25de
              to    tree 8c365c79293c9a8a86dc6802f6230e389e876acb
broken link from  commit 2c70421be7d88fbee49986d7a5584d1f010a25de
              to  commit 659bd6b6489ae254a07b1bc578ff44778ed7b8b4
broken link from  commit 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
              to    tree 0842d4cb3cd36675c518c241b16cf25fad0c5384
broken link from  commit 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
              to  commit ed34298a39b05e05bd333d9dac658df19e5b2dab
missing commit 659bd6b6489ae254a07b1bc578ff44778ed7b8b4
missing tree 8c365c79293c9a8a86dc6802f6230e389e876acb
missing commit c4cd9bc72a6e0ed355041d331bb4034d99738f82
broken link from  commit d14925c87cdb6ca6345bcb3c8e34a2d659c79451
              to    tree e5ea614d1884a02314a3be8e09cb3f8c786fc0e9
broken link from  commit d14925c87cdb6ca6345bcb3c8e34a2d659c79451
              to  commit c4cd9bc72a6e0ed355041d331bb4034d99738f82
missing tree e5ea614d1884a02314a3be8e09cb3f8c786fc0e9
missing commit ed34298a39b05e05bd333d9dac658df19e5b2dab


It's not like broken trees are exceedingly rare.  Sure, this must be
some "better" kind of breakage, but anyway.

-- 
Regards,
Pavel Roskin
