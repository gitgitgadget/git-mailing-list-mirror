From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: Gitk --all error when there are more than 797 refs in a repository
Date: Thu, 17 Sep 2009 15:07:33 -0400
Message-ID: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 21:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoMKg-0007h3-SW
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 21:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619AbZIQTHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZIQTHk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 15:07:40 -0400
Received: from vamx04.bankofamerica.com ([171.159.192.80]:46864 "EHLO
	vadmzmailmx04.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360AbZIQTHj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 15:07:39 -0400
Received: from vadmzmailmx03.bankofamerica.com ([171.182.200.79])
	by vadmzmailmx04.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8HJ7gfs008858
	for <git@vger.kernel.org>; Thu, 17 Sep 2009 19:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1253212932;
	bh=EZ8oTLBBhqnwwy2CLieWi38t38037Xhz46OVCXA+KRc=;
	h=Date:From:Subject:To:Message-id:MIME-version:Content-type:
	 Content-transfer-encoding;
	b=ZCJG8v056yrFx5R1Qz8kKud4TU1vITuZrisuua2RsNmRdWeZDOTTCL2HlbJL8lwjX
	 X6NSu+QMtZUWo/Mz5KFRABzxmzJPp68hoqcB0Bxc06tACQkz6ueDcQlMYkRKOulQdU
	 jNAfqWXfxjcnJ8aBQ1GoolD7hAKIk2cza00YE4dA=
Received: from memva2mta01.bankofamerica.com (memva2mta01.bankofamerica.com [171.186.140.73])
	by vadmzmailmx03.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8HJ6mDJ028977
	for <git@vger.kernel.org>; Thu, 17 Sep 2009 19:07:42 GMT
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: Gitk --all error when there are more than 797 refs in a repository
Thread-index: Aco3yhy4F3EWqGnnS0WdMd4ykkWPOw==
x-cr-puzzleid: {9B26CD19-BD64-4032-9B80-51217346E630}
x-cr-hashedpuzzle: BQH5 BSCI ByD8 B1lc CPco Chda D6te EPvg FI9L FR+n Gqr4 G/I2 Ifkt JeOW KYTN
 LPnR;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwAuAA==;Sosha1_v1;7;{9B26CD19-BD64-4032-9B80-51217346E630};agBvAGgAbgAuAG0AdQByAHAAaAB5AEAAYgBhAG4AawBvAGYAYQBtAGUAcgBpAGMAYQAuAGMAbwBtAA==;Thu,
 17 Sep 2009 19:07:33
 GMT;RwBpAHQAawAgAC0ALQBhAGwAbAAgAGUAcgByAG8AcgAgAHcAaABlAG4AIAB0AGgAZQByAGUAIABhAHIAZQAgAG0AbwByAGUAIAB0AGgAYQBuACAANwA5ADcAIAByAGUAZgBzACAAaQBuACAAYQAgAHIAZQBwAG8AcwBpAHQAbwByAHkA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 17 Sep 2009 19:07:36.0482 (UTC) FILETIME=[1E4DD820:01CA37CA]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-09-17_09:2009-09-17,2009-09-17,2009-09-17 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128767>

There is a error when running =A0gitk --all when there are more than 79=
7 refs in a repository.
We get an error message:

Error reading commits: fatal ambiguous argument '3': unknown revision o=
r path not in the working tree.
Use '--' to separate paths from revisions.

I believe issue is with this line of the code in proc parseviewrevs:

       if {[catch {set ids [eval exec git rev-parse "$revs"]} err]}

When there are more than 797 refs the output of git rev-parse is too la=
rge to fit into the string, ids.

797 refs =3D 32,677 bytes.
798 refs =3D 32,718 bytes my guess is a little too close for comfort to=
 32,768 bytes.

As I was deleting refs locally the error message would change from '3' =
to any char [A-Z,0-9].

I am a novice tcl programmer but is seems like ids could be an array.
There are also many other areas in the code where git rev-parse is call=
ed and using array may also be necessary.

We were using:
git 1.6.3.2.314.ge3519

and then I upgraded to test if there was a change:
git 1.6.5.rc1.18.g401ce7

We are also using:
tcl 8.4.1
cygwin 1.5.25-7
Windows XP Pro SP3
