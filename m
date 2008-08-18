From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Tue, 19 Aug 2008 00:06:46 +0100
Message-ID: <20080818230646.GA11044@cisco.com>
References: <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net> <20080818061236.GF7376@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 01:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDqu-0003Al-Iq
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYHRXI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbYHRXI2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:08:28 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:11506 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYHRXI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:08:27 -0400
X-IronPort-AV: E=Sophos;i="4.32,230,1217808000"; 
   d="scan'208";a="17516769"
Received: from ams-dkim-2.cisco.com ([144.254.224.139])
  by ams-iport-1.cisco.com with ESMTP; 18 Aug 2008 23:08:26 +0000
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m7IN8Quo018564
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 01:08:26 +0200
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7IN8PsU021893
	for <git@vger.kernel.org>; Mon, 18 Aug 2008 23:08:25 GMT
Received: from dfawcus-laptop (localhost [127.0.0.1]) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) with ESMTP id m7IN8PX21937 for <git@vger.kernel.org>; Tue, 19 Aug 2008 00:08:25 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20080818061236.GF7376@spearce.org>
User-Agent: Mutt/1.4.2.3i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=1397; t=1219100906; x=1219964906;
	c=relaxed/simple; s=amsdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20[RFC]=20Plumbing-only=20support=20for=2
	0storing=20object=20metadata
	|Sender:=20;
	bh=nWvogVwsC85hz82bF7PyPmJW05lzs/K0yfKhl8zbPVM=;
	b=QErEMlAsYUQX1WSESnDgIOV4CqtHjbX5ddkslauqhmT9HgdJq2r9QPYzB1
	jaXdpvT39rjjgxu1WDrILzzPXywSXYB+ZKCz+XyEMvvw0LUmo8ddcAGkbGzZ
	yDnMS35Jsx;
Authentication-Results: ams-dkim-2; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim2001 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92751>

On Sun, Aug 17, 2008 at 11:12:36PM -0700, Shawn O. Pearce wrote:
> Adding a new type bit is a lot more than just adding it to the pack
> data field.  Look at the amount of code that needed to be changed to
> support gitlink in trees, and that was "reusing" the OBJ_COMMIT type.
> Anytime you start poking at the core object enumeration code with
> new cases there's a lot of corners that are affected.

Actually,  I'd been thinking of how to attach metadata - but more from
the perspective of attaching it to commits,  rather than individual
blobs or trees.

At the moment,  my workaround is simply to add well known lines to
the end of the commit comments,  the downside being that it makes
the comments a bit ugly,  and one needs to know the protocol for
parsing them.

My other hacky thought was that tag object could be overloaded for
this purpose.  It is already sort of an indirect object,  but seems
to be limited to appearing at the edge of the graph.

If we could say have:

  commit -> tag -> tree

then arbitrary data could be stored in the tag,  similarly this
could be extended for when a tree or blob object is expected
(I'm not sure about the blob case).

I guess there'd have to be some rule - like only one indirect
object allowed to be inserted (otherwise its awkward to check
for loops),  and there would need to be some custom merge rules.

DF
