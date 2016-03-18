From: "Richard Furness -X (rfurness - ENSOFT LIMITED at Cisco)" 
	<rfurness@cisco.com>
Subject: 2.8.0 gitignore enhancement not working as expected
Date: Fri, 18 Mar 2016 09:31:21 +0000
Message-ID: <4a4980485c234280bce91be87d213216@XCH-RCD-003.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 10:41:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agqu8-0005D3-ES
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 10:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbcCRJlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 05:41:09 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:49375 "EHLO
	alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcCRJlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 05:41:06 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Mar 2016 05:41:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1138; q=dns/txt; s=iport;
  t=1458294066; x=1459503666;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4mlF9SMdvWWE7xkAEc0Hz9r7V2i5IBQgufEYipAYpTk=;
  b=bW1AyOkms7hzOPHFh4PiHQgVfgB3XoKrdpJmjuxDj80pGbMXyMcX9R1F
   VdHx6W6uApJq+PotJx8ScpYJln3UyJAmxJ0tRIyavddm95USY4+NMvnzf
   ETH43X7j5B8AbqOV39uGnnGcGe1rO1J5aV2wI6UMCzzOhweyCuq493J2g
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D0AQAzyutW/4MNJK1eg0WBSLoSAQ2Bb?=
 =?us-ascii?q?4c9OBQBAQEBAQEBZBwLhEg6UQE+LxMmAQQbiB+iB585AQEBBwEBAQEBG5R0BZd?=
 =?us-ascii?q?WARaITIUajw6PBAEeAQFCg2WKEgQ5fgEBAQ?=
X-IronPort-AV: E=Sophos;i="5.24,354,1454976000"; 
   d="scan'208";a="250698572"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2016 09:31:21 +0000
Received: from XCH-ALN-004.cisco.com (xch-aln-004.cisco.com [173.36.7.14])
	by alln-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id u2I9VLDe016705
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 18 Mar 2016 09:31:21 GMT
Received: from xch-rcd-003.cisco.com (173.37.102.13) by XCH-ALN-004.cisco.com
 (173.36.7.14) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Fri, 18 Mar
 2016 04:31:21 -0500
Received: from xch-rcd-003.cisco.com ([173.37.102.13]) by
 XCH-RCD-003.cisco.com ([173.37.102.13]) with mapi id 15.00.1104.009; Fri, 18
 Mar 2016 04:31:21 -0500
Thread-Topic: 2.8.0 gitignore enhancement not working as expected
Thread-Index: AdGA+Oope1o05p+SRVOEuS4waIVawg==
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.23.173]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289213>

Hi,

I've been testing out git 2.8.0 rc3 due to having a particular interest in this enhancement from the changelog:
" Another try to improve the ignore mechanism that lets you say "this
   is excluded" and then later say "oh, no, this part (that is a
   subset of the previous part) is not excluded".  This has still a
   known limitation, though."

Currently, in order to include ONLY the files under a/b/c I have the following in .gitignore:
/*             - Ignore everything
!/a             - Except directory "a"
/a/*            - Ignore all sub-directories of "a/"
!/a/b           - Except "a/b"
/a/b/*          - Ignore all sub-directories of "a/b/"
!/a/b/c         - Except "a/b/c"

My hope was that with this enhancement I could massively simplify this to:
/*             - Ignore everything
!a/b/c      - Except "a/b/c"

However this doesn't seem to work - instead I find that NOTHING is ignored (i.e. it's as if the 2nd line completely cancels the first).

Is this a bug or am I mis-understanding what the enhancement does? Or is this the known limitation referred to?

Thanks,

Richard
