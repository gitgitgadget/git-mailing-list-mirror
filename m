From: James Cloos <cloos@jhcloos.com>
Subject: efficient cloning
Date: Sun, 19 Mar 2006 16:16:16 -0500
Message-ID: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 19 22:40:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL5dM-0003KS-Vc
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 22:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWCSVkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 16:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWCSVkS
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 16:40:18 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:37637 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751085AbWCSVkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 16:40:16 -0500
Received: from lugabout.jhcloos.org (host-69-48-10-108.roc.choiceone.net [69.48.10.108])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP id D4B6B1C496
	for <git@vger.kernel.org>; Sun, 19 Mar 2006 15:40:12 -0600 (CST)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 39A2B12561D; Sun, 19 Mar 2006 21:16:17 +0000 (GMT)
To: git@vger.kernel.org
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:060319:git@vger.kernel.org::JJHl9tGsrY4EYR1u:000000000000000000000000000000000000000000Nds+
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17724>

Is there a way to accomplish the effect of this script w/o having to
download any unnecessary objects?

==================================================
#!/bin/bash

lt="/gits/linux-2.6/.git"

if [ $# -ne 2 ]; then
    echo >&2 "Usage: $0 <repo> <target-dir>"
    exit 1
fi

git-clone $1 $2
mkdir -p $2/objects/info
{
 test -f "$lt/objects/info/alternates" &&
 cat "$lt/objects/info/alternates";
 echo "$lt/objects"
} >"$2/objects/info/alternates"

cd $2
git-repack -a -d -s
git-prune-packed
==================================================

I tried to modify git-clone to add an alternates file before calling
fetch, but that file just gets deleted.

I presume I need to clone -s -l the local alternate, re-parent it to
the new URL and grab anything missing, but how can I assure that it
results in exactly the same repo as this script?

I'm often behind tiny straws, so efficiency is important.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
