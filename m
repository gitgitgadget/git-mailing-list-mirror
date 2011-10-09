From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 5/5] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Sun, 09 Oct 2011 17:16:24 +0200
Message-ID: <4E91BAC8.9060606@alum.mit.edu>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil> <U4wiHVyDLLG1PhI-8iY3YhHT7CEcTMEfg9MCDSaeuwAkg0N1a5wRE5NXaKAVQx8kpEYt75REVpRavoc-HiKe6rLk2AUepzHWptkevo08MRbGyWxqBHT_rySLemcbi66NKLRXwFGtaRQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	j.sixt@viscovery.net, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Oct 09 17:16:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCv7P-00018o-3r
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 17:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab1JIPQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 11:16:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54516 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1JIPQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 11:16:41 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFD0.dip.t-dialin.net [84.190.223.208])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p99FGQZk023856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Oct 2011 17:16:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <U4wiHVyDLLG1PhI-8iY3YhHT7CEcTMEfg9MCDSaeuwAkg0N1a5wRE5NXaKAVQx8kpEYt75REVpRavoc-HiKe6rLk2AUepzHWptkevo08MRbGyWxqBHT_rySLemcbi66NKLRXwFGtaRQ@cipher.nrlssc.navy.mil>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183202>

On 10/06/2011 08:22 PM, Brandon Casey wrote:
> The last set of tests is performed only on a case-insensitive filesystem.
> Those tests make sure that git handles the case where the .gitignore file
> resides in a subdirectory and the user supplies a path that does not match
> the case in the filesystem.  In that case^H^H^H^Hsituation, part of the
> path supplied by the user is effectively interpreted case-insensitively,
> and part of it is dependent on the setting of core.ignorecase.  git should
> only match the portion of the path below the directory holding the
> .gitignore file according to the setting of core.ignorecase.

Isn't this a rather perverse scenario?  It is hard to imagine that
anybody *wants* part of a single filename to be matched
case-insensitively and another part to be matched case-sensitively.
ISTM that a person who is using a case-insensitive filesystem and has
core-ignorecase=false is (1) a glutton for punishment and (2) probably
very careful to make sure that the case of all pathnames is correct.  So
such a person is not likely to benefit from this schizophrenic behavior.

> [...]  If git instead built the attr
> stack by scanning the repository, then the paths in the origin field would
> not necessarily match the paths supplied by the user.  If someone makes a
> change like that in the future, these tests will notice.

Your decision to treat path names as partly case-insensitive will make
this kind of improvement considerably more complicated.

Therefore, weighing the negligible benefit of declaring this
schizophrenic behavior against the potential big pain of remaining
backwards-compatible with this behavior, I suggest that we either (1)
declare that when core.ignorecase=false then the *whole* filenames
(including the path leading up to the .gitignore file) must match
case-sensitively, or (2) declare the behavior in this situation to be
undefined so that nobody thinks they should depend on it.

But given that I'm a potential implementer but not a potential Windows
user, perhaps my judgment is biased...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
