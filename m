From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Re: Interesting git-format-patch bug
Date: Mon, 26 Nov 2012 20:15:24 -0800
Message-ID: <50b4304c.EwQy4JquPwsUyMfZ%perryh@pluto.rain.com>
References: <4B2793BF110AAB47AB0EE7B9089703854CA7BA61@fmsmsx110.amr.corp.intel.com>
 <7vobikotwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, alan.r.olsen@intel.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 27 05:26:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdCkt-0003NT-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 05:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230Ab2K0E03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 23:26:29 -0500
Received: from agora.rdrop.com ([199.26.172.34]:1367 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933209Ab2K0E02 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 23:26:28 -0500
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id qAR4QML7003357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Nov 2012 20:26:22 -0800 (PST)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id qAR4QM3P003356;
	Mon, 26 Nov 2012 20:26:22 -0800 (PST)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA06348; Mon, 26 Nov 12 20:15:22 PST
In-Reply-To: <7vobikotwd.fsf@alter.siamese.dyndns.org>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210531>

Junio C Hamano <gitster@pobox.com> wrote:
> "Olsen, Alan R" <alan.r.olsen@intel.com> writes:
> > I found an interesting bug in git-format-patch.
> >
> > Say you have a branch A.  You create branch B and add a patch to
> > it. You then merge that patch into branch A. After the merge,
> > some other process (we will call it 'gerrit') uses annotate and
> > changes the comment on the patch that exists on branch B.
> >
> > Now someone runs git-format-patch for the last n patches on
> > branch A.  You should just get the original patch that was
> > merged over to branch A.  What you get is the patch that was
> > merged to branch A *and* the patch with the modified commit
> > comment on branch B. (Double the patches, double the
> > clean-up...)
>
> As you literally have patches that do essentially the same or
> similar things on two branches that was merged, you cannot
> expect to export each individual commit into a patch and not
> have conflicts among them.  So I do not think there is no
> answer than "don't do that".

To me, this seems to miss Alan's point:  only one patch was merged
to branch A, so git-format-patch applied to branch A should find
only one patch.  It can be argued either way whether that one-patch
report should include the gerrit annotations, but surely the
application of gerrit on branch B, _after the merge to branch A
has already been performed_, should not cause an additional patch
to magically appear on branch A.
