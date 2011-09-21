From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: How to use git attributes to configure server-side checks?
Date: Wed, 21 Sep 2011 21:32:46 +0200
Message-ID: <4E7A3BDE.3040301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 21:32:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6SXN-0006Iv-VY
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 21:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab1IUTct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 15:32:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41220 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1IUTcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 15:32:48 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8LJWk8F013623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 21 Sep 2011 21:32:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181858>

I was thinking of using git attributes to configure a server-side
"update" hook that does some basic sanity checking before accepting a
push.  I thought I could do something like

~/.gitattributes:
    *.c whitespace

~/crappy-vendor-code/.gitattributes:
    # This code doesn't conform to our standards; disable check:
    *.c -whitespace

This would allow fine-grained specification of which checks are applied
to which files, and ensure that the hook configuration is kept
synchronized with changes to the content.

What I can't figure out is how a server-side update hook can inquire
about the gitattributes that were associated with a file *in a
particular commit*, as opposed to in the current working tree.  I would
like to ask questions like "was the "whitespace" attribute set on file F
in commit C?"

I see that there is an (undocumented) API involving
git_attr_set_direction() that seems to let gitattributes to be read out
of the index instead of the working tree.  But I am still confused:

1. The "git check-attr" program doesn't seem to expose the
git_attr_set_direction() functionality.

2. Even if it did, would that be enough?  It seems like the update hook
(assuming a bare repository) would have to "git reset" the index to the
commit that it wants to check.  Is that allowed?  Is the index a scratch
space that the update hook can use however it likes?  If so, is there
some kind of locking that would prevent multiple simultaneous pushes
from overwriting each other's index stat, or would the update script
have to implement its own locking scheme?

Am I going about this entirely the wrong way?

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
