From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: [RFC] Fsck while fetching
Date: Tue, 4 Mar 2008 08:55:45 +0100
Message-ID: <20080304075545.GA31793@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 08:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWS0j-0006K0-R3
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbYCDHzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2008 02:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbYCDHzs
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:55:48 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60370 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbYCDHzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:55:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 5AC436CF0063
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 08:55:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DShdJF64UFqZ for <git@vger.kernel.org>;
	Tue,  4 Mar 2008 08:55:45 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 3C76D6CF0060; Tue,  4 Mar 2008 08:55:45 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76044>

As the infrastructure for checking the objects and their connectivity
while pushing is in place, it is easy to do the same while fetching on
non shallow repositories.

On shallow repositories this is currently only possible, if the list
of shallow commits does not change (eg. no depth option).

The neccessary changes are:
* Read a config option in fetch-pack to disable it (default: true)
* Add in fetch-pack --strict to the command lines of index-pack and=20
  unpack-objects, if the config option is true and args.depth is 0.

This leads to the question:
* How should the config option be named? fetch.fsckObjects? Should
  receive.fsckObjects be reused? Should receive.fsckObjects be renamed
  to a new name, which is used in both cases?

On additional question:
* fsck has a strict option, which looks for files with 0664 mode. How
  should such files be handled with the checking while pushing/fetching=
:
  ignored, rejected or config option for the behaviour?

mfg Martin K=F6gler
