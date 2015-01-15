From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Advise on a push only repo
Date: Thu, 15 Jan 2015 13:02:19 -0500
Organization: PD Inc
Message-ID: <9782FD24F9FA45659CCE5171E73E49E7@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:02:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBokU-0001w1-59
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbbAOSCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:02:22 -0500
Received: from mail.pdinc.us ([67.90.184.27]:56127 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbbAOSCV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 13:02:21 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t0FI2KwK017001
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 13:02:20 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdAw7WdqDCff8GD0RiSLtgYhGWeY3A==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262496>

I am setting up a continous integration (CI) system for an open source project and I want to allow forking developers to use the system, but I do not want anyone to do a clone or fetch from the CI git repo, the repo.

Any advice on limiting the https smart protocol to push only, blocking clone and fetch?

Looking at http-backend.c
   542  static struct service_cmd {
   543          const char *method;
   544          const char *pattern;
   545          void (*imp)(char *);
   546  } services[] = {
   547          {"GET", "/HEAD$", get_head},
   548          {"GET", "/info/refs$", get_info_refs},
   549          {"GET", "/objects/info/alternates$", get_text_file},
   550          {"GET", "/objects/info/http-alternates$", get_text_file},
   551          {"GET", "/objects/info/packs$", get_info_packs},
   552          {"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
   553          {"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
   554          {"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
   555
   556          {"POST", "/git-upload-pack$", service_rpc},
   557          {"POST", "/git-receive-pack$", service_rpc}
   558  };


I feel I could just filter /git-receive-pack and /objects/ .

I am going to build my test system now.

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
