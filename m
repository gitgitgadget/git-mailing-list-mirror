From: "Olsen, Alan R" <alan.r.olsen@intel.com>
Subject: Interesting git-format-patch bug
Date: Mon, 26 Nov 2012 21:33:01 +0000
Message-ID: <4B2793BF110AAB47AB0EE7B9089703854CA7BA61@fmsmsx110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Olsen, Alan R" <alan.r.olsen@intel.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6J7-0002Cg-9T
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab2KZVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:33:22 -0500
Received: from mga03.intel.com ([143.182.124.21]:56504 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab2KZVdV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2012 16:33:21 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 26 Nov 2012 13:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,323,1352102400"; 
   d="scan'208";a="222597523"
Received: from fmsmsx107.amr.corp.intel.com ([10.19.9.54])
  by azsmga001.ch.intel.com with ESMTP; 26 Nov 2012 13:33:01 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.19.9.28) by
 FMSMSX107.amr.corp.intel.com (10.19.9.54) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Mon, 26 Nov 2012 13:33:01 -0800
Received: from FMSMSX110.amr.corp.intel.com ([169.254.12.223]) by
 fmsmsx109.amr.corp.intel.com ([169.254.11.8]) with mapi id 14.01.0355.002;
 Mon, 26 Nov 2012 13:33:01 -0800
Thread-Topic: Interesting git-format-patch bug
Thread-Index: Ac3MHZwvKxrkzk+KR0yPkX50Nyat4Q==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.108]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210499>

I found an interesting bug in git-format-patch.

Say you have a branch A.  You create branch B and add a patch to it. You then merge that patch into branch A. After the merge, some other process (we will call it 'gerrit') uses annotate and changes the comment on the patch that exists on branch B.

Now someone runs git-format-patch for the last n patches on branch A.  You should just get the original patch that was merged over to branch A.  What you get is the patch that was merged to branch A *and* the patch with the modified commit comment on branch B. (Double the patches, double the clean-up...)

This is should be one of those rare corner case "don't do that" occurrences. Unfortunately it does happen once in a while on our branches and it screws up some of the automated processes we rely on.

Is there a way around that (other than "don't") or can this be fixed?
