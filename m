From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: [PATCH 0/4]  git-diff: use mode for tree:name syntax (was: Re: [PATCH 2/7] gitweb: Support comparing blobs with different names)
Date: Sat, 21 Apr 2007 14:23:48 +0200
Message-ID: <20070421122348.GA29174@auto.tuwien.ac.at>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <200704201234.50134.jnareb@gmail.com> <7vabx3z3tf.fsf@assigned-by-dhcp.cox.net> <200704202249.08464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 14:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfEd9-00080e-JN
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 14:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030776AbXDUMXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 08:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030777AbXDUMXw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 08:23:52 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37217 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030776AbXDUMXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 08:23:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2A45D73EA3C0;
	Sat, 21 Apr 2007 14:23:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fpzfl9tbG4NE; Sat, 21 Apr 2007 14:23:48 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 926617000CF2; Sat, 21 Apr 2007 14:23:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200704202249.08464.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45168>

On Fri, Apr 20, 2007 at 10:49:08PM +0200, Jakub Narebski wrote:
> So from me it is slight Nak to this patch, at least unless "git diff=20
> <tree1>:<path1> <tree2>:<path2>" will take the information about file=
=20
> name and mode (permissions) from <tree1> and <tree2>, and included su=
ch=20
> information in extended git diff header.

I created a prototyp implemention:

* Patch 1:
 add a parameter to get_sha1 to store the mode, if it is known.
 If it is not possible to dermine the mode, it stores S_IFINVALID.

* Patch 2:
 add space for the mode in object_array (unknown mode is S_IFINVALID).

* Patch 3:
 stores the mode for <tree>:<filename> syntax

* Patch 4:
 use mode information for comparing two blobs

The patches are large, as some heavy used functions get a new
parameter. The changes should not increase the CPU time. Patch 2
increases the storage size for each object of object_array by an
unsigned for the mode.

My blobdiff patch will need some small adaptations:
* we need to add --raw -p --full-index as diff arguments
* we must pass $hash_parent_base.':'.$file_parent and
  $hash_base.':'.$file_name to git-diff instead of=20
  $hash and $hash_parent, if possible.

mfg Martin K=F6gler
