From: Marinescu Paul dan <pauldan.marinescu@epfl.ch>
Subject: Running commands in wrong environment
Date: Thu, 3 Dec 2009 20:19:05 +0100
Message-ID: <D6F784B72498304C93A8A4691967698E8EE2C44FE5@REX2.intranet.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 20:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGHCt-0000tf-Qt
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 20:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbZLCTTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 14:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbZLCTTD
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 14:19:03 -0500
Received: from smtp0.epfl.ch ([128.178.224.219]:44312 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755680AbZLCTTB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 14:19:01 -0500
Received: (qmail 5364 invoked by uid 107); 3 Dec 2009 19:19:06 -0000
X-Virus-Scanned: ClamAV
Received: from slb-nat-128-178-224-64.epfl.ch (192.26.45.64)
  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy); Thu, 03 Dec 2009 20:19:06 +0100
Received: from REX2.intranet.epfl.ch ([128.178.50.202]) by
 ewa4.intranet.epfl.ch ([128.178.224.64]) with mapi; Thu, 3 Dec 2009 20:19:05
 +0100
Thread-Topic: Running commands in wrong environment
Thread-Index: AQHKdE16zgFoJXlAykaznNOPSahXbA==
Accept-Language: en-US, fr-CH
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, fr-CH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134466>


git's start_command (run_command.c) executes a command (e.g. hook) but does not verify that it has properly set up the environment. It seems that in the unlikely case where putenv (run_command.c:117) fails, the command may have undesirable effects e.g. GIT_INDEX_FILE should have been set (interactive pre-commit hooks) but the default index will be used instead. It would be safer not to run the command but just exit in that case.