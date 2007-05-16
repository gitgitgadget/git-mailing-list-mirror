From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Wed, 16 May 2007 21:40:02 +0200
Message-ID: <20070516194002.GA17805@diana.vm.bytemark.co.uk>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515182549.GB17851@diana.vm.bytemark.co.uk> <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com> <20070516071130.GB7453@diana.vm.bytemark.co.uk> <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 21:40:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoPM6-0008Nr-1a
	for gcvg-git@gmane.org; Wed, 16 May 2007 21:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759400AbXEPTkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbXEPTkH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 15:40:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2699 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759114AbXEPTkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 15:40:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HoPLu-00058L-00; Wed, 16 May 2007 20:40:02 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47453>

On 2007-05-16 13:07:14 +0100, Catalin Marinas wrote:

> I did a quick test of 'stg series' with the DAG patches applied, on
> a Linux kernel repository ('du -sh .git' is 285M) with 42 patches
> (only 25 applied). It constantly takes over 2 seconds to complete
> (compared to < 200ms without the DAG patches). The problem is that
> this delay will happen for bash completion as well.

This is more than ten times as expensive as in my measurement.
Curious. And the algorithm is designed so that it shouldn't take time
proportional to the repository size, just proportional to the number
of patches.

There are three git calls involved:

  * List the references. There can't be more than a few hundred of
    them.

  * rev-list all patches, subtracting everything that's reachable from
    the branch head. This set of commits should not be much larger
    than the number of unapplied patches.

  * rev-list the branch head, but stop walking as soon as all applied
    patches have been seen. This set of commits should not be much
    larger than the number of applied patches.

None of the calls should be expensive.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
