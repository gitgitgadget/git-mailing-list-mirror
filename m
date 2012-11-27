From: "Olsen, Alan R" <alan.r.olsen@intel.com>
Subject: RE: Interesting git-format-patch bug
Date: Tue, 27 Nov 2012 20:31:50 +0000
Message-ID: <4B2793BF110AAB47AB0EE7B9089703854CA7C128@fmsmsx110.amr.corp.intel.com>
References: <4B2793BF110AAB47AB0EE7B9089703854CA7BA61@fmsmsx110.amr.corp.intel.com>
 <7vobikotwd.fsf@alter.siamese.dyndns.org>
 <50b4304c.EwQy4JquPwsUyMfZ%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Perry Hutchison <perryh@pluto.rain.com>,
	"gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:32:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdRpc-0006UJ-J1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540Ab2K0UcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:32:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:53893 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab2K0Ub7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 15:31:59 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 27 Nov 2012 12:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,174,1355126400"; 
   d="scan'208";a="253672863"
Received: from fmsmsx108.amr.corp.intel.com ([10.19.9.228])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2012 12:31:52 -0800
Received: from FMSMSX110.amr.corp.intel.com ([169.254.12.223]) by
 FMSMSX108.amr.corp.intel.com ([169.254.10.149]) with mapi id 14.01.0355.002;
 Tue, 27 Nov 2012 12:31:51 -0800
Thread-Topic: Interesting git-format-patch bug
Thread-Index: Ac3MHZwvKxrkzk+KR0yPkX50Nyat4QAC7LJpABvkbAAAESAUEA==
In-Reply-To: <50b4304c.EwQy4JquPwsUyMfZ%perryh@pluto.rain.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.106]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210591>

[Sorry for the top posting. Outlook is crap.]

You are correct. I should only get one copy of the patch on branch A. Branch B was modified after the merge and git-format-patch includes the original patch from the merge and a duplicate copy with the changed comments.  Note that this patch only has different comments. The body of the patch is exactly the same.

How gerrit mangles things is out of my control.  I would prefer that they cherry-pick instead of merges. I have to live with the bad choices of both gerrit and developers in this case.

I guess I will have to diagram out a better example of what is happening here.

-----Original Message-----
From: Perry Hutchison [mailto:perryh@pluto.rain.com] 
Sent: Monday, November 26, 2012 8:15 PM
To: gitster@pobox.com
Cc: git@vger.kernel.org; Olsen, Alan R
Subject: Re: Interesting git-format-patch bug

Junio C Hamano <gitster@pobox.com> wrote:
> "Olsen, Alan R" <alan.r.olsen@intel.com> writes:
> > I found an interesting bug in git-format-patch.
> >
> > Say you have a branch A.  You create branch B and add a patch to it. 
> > You then merge that patch into branch A. After the merge, some other 
> > process (we will call it 'gerrit') uses annotate and changes the 
> > comment on the patch that exists on branch B.
> >
> > Now someone runs git-format-patch for the last n patches on branch 
> > A.  You should just get the original patch that was merged over to 
> > branch A.  What you get is the patch that was merged to branch A 
> > *and* the patch with the modified commit comment on branch B. 
> > (Double the patches, double the
> > clean-up...)
>
> As you literally have patches that do essentially the same or similar 
> things on two branches that was merged, you cannot expect to export 
> each individual commit into a patch and not have conflicts among them.  
> So I do not think there is no answer than "don't do that".

To me, this seems to miss Alan's point:  only one patch was merged to branch A, so git-format-patch applied to branch A should find only one patch.  It can be argued either way whether that one-patch report should include the gerrit annotations, but surely the application of gerrit on branch B, _after the merge to branch A has already been performed_, should not cause an additional patch to magically appear on branch A.

  
