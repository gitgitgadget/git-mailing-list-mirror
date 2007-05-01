From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 7/8] git-repack --max-pack-size: split packs as asked by write_object/write_one
Date: Mon, 30 Apr 2007 23:05:31 -0700
Message-ID: <56b7f5510704302305s5cf0d0cbg52906e400bcc4a22@mail.gmail.com>
References: <46367AA1.8080009@gmail.com> <20070501054034.GB5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 08:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HilUW-00048I-Mn
	for gcvg-git@gmane.org; Tue, 01 May 2007 08:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423536AbXEAGFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 02:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423560AbXEAGFe
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 02:05:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:38134 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423536AbXEAGFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 02:05:33 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1819620wra
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 23:05:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+ryYnsgmfF6TxhCuZx+YFdWCpyi5rNJ5k5yN5UTo0K5gg3e2lwJDlOFiMcvXboKNXdWXA2svuHYDEANgjRS/24H1xd1VSsLSThe7q2a2H3oif+GVPi92SJrXDBiVUQNuJde2O6UBP4u9Au3X6vFRCqin8Az6G4SlYCHC7pLAds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=klsSRpuC18xDIWB8wrsXad0tE4dHwgP4o+FrUYB3xWORgapONFD2JpiyUsumKi1X0J8//Na6uPkOf4SKjIJSJErUie0vseYR8WLcLAWfSQsL9OakOWnAF4hwyutBglganV4H2llTQ+9OWf6FA6zAbiau701cJnyAwc0ip6unTR4=
Received: by 10.114.12.9 with SMTP id 9mr2292196wal.1177999531919;
        Mon, 30 Apr 2007 23:05:31 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 30 Apr 2007 23:05:31 -0700 (PDT)
In-Reply-To: <20070501054034.GB5942@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45921>

On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > Rewrite write_pack_file() to break to a new packfile
> > whenever write_object/write_one request it,  and
> > correct the header's object count in the previous packfile.
> > Change write_index_file() to write an index
> > for just the objects in the most recent packfile.
> ...
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> ...
> > +             hdr.hdr_signature = htonl(PACK_SIGNATURE);
> > +             hdr.hdr_version = htonl(PACK_VERSION);
> > +             hdr.hdr_entries = htonl(nr_result);
>
> What about keeping track of how many objects in nr_result that
> have been written already in the prior iteration of this do{}
> while loop and using that to set hdr_entries?  This way if you are
> splitting into multiple packfiles the last packfile won't need to
> do a header/footer fixup.
Cool --
I had the same thought (late),
but figured I would address it in a follow-on.
I was thinking of adding nr_left, which would be initialized
from nr_result, and have nr_written repeatedly subtracted.
nr_result in your quote would change to nr_left
(also later, where we decide whether or not to fix up the header).

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
