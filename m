From: Ed Santiago <santiago@redhat.com>
Subject: Re: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Wed, 14 Apr 2010 09:44:10 -0600
Message-ID: <20100414154409.GA28268@f.santiago.vpn.redhat.com>
References: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
 <7vfx2yqf9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 17:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O24lt-0000Qr-I7
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 17:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab0DNPov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 11:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863Ab0DNPou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 11:44:50 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3EFiDu7022793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 14 Apr 2010 11:44:13 -0400
Received: from f.santiago.vpn.redhat.com (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3EFiCJx020253;
	Wed, 14 Apr 2010 11:44:13 -0400
Received: by f.santiago.vpn.redhat.com (Postfix, from userid 14904)
	id 4162C2801EA; Wed, 14 Apr 2010 09:44:10 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <7vfx2yqf9s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144884>

On Wed, Apr 14, 2010 at 07:29:03AM -0700, Junio C Hamano wrote:
> 
> I agree that people may want to optionally replace them to avoid mapping
> two originally different tags into the same one.

I considered that but decided that it was beyond the scope of
what I wanted to tackle.  My intent was to suggest an incremental
fix, not a revolutionary one.  I also wished to remove a misleading
diagnostic[1] and provide a way for others to do the same as needed.

 [1] The error I saw was "Cannot create tag mumblefoo{?dist}: Illegal seek",
     where "Illegal seek" is due to an uninitialized/invalid $!

A proper solution would, I believe, be uncomfortably complex.
Some of the approaches I considered are:

  * command-line option '--tag-replace <from-char>=<to>', eg '?=-'
  * replacing a (hardcoded) list of chars with %xx hex codes
  * option a la -A, with a file listing <oldtag>=<newtag>
  * like above, but the file lists perl expressions such as s/\?/./g

I used git-cvsimport because I've used tailor[2] before and
dreaded the thought of running it again.  I love how easy
git-cvsimport was to use!  I see it as a great tool for
quick jobs, for proof-of-concept situations: it has a low
cost of entry, works well with a remote CVS repo, and was
easy to debug.  But if it were to become as configurable -- and
as complex -- as tailor, I think it might lose much of its value.

 [2] http://wiki.darcs.net/RelatedSoftware/Tailor

> Does your regexp chain check other invalid refname sequences, such as ".name",
> "na..me", etc.?

Eek, no.  Again, this was a purely incremental fix, an addition
to an existing (simple) check.  Duplicating the functionality
of git-check-ref-format would be a terrible idea.  But if there's
already a perlified library for this, or a portable hook into
git itself (I haven't looked), it might be wise to have
git-cvsimport use that to check/convert tags.  At the very
least it would give a much better error to the end user.

> Sign-off?

My apologies.  I'm new to this.

How would you like me to proceed?  I'm reluctant to code a
full general solution to the tag-validity problem, but am
happy to rework my changes into something better.

Thanks for your feedback,
Ed
-- 
Ed Santiago             Software Engineer             santiago@redhat.com
