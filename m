From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] fast-import: cache oe more often
Date: Tue, 20 Sep 2011 09:39:41 -0500
Message-ID: <20110920143941.GE7517@elie>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
 <7vy5xj7tf5.fsf@alter.siamese.dyndns.org>
 <20110920042655.GH6343@elie>
 <CA+gfSn-nh4BhCPf6m8+EN0zo=BuhxRNLcLBx7ynRWPA=GxfDyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 16:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R61UH-0002N4-Sk
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 16:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab1ITOjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 10:39:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54608 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab1ITOjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 10:39:47 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so373792gyg.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7/r/EkgQPl8/NOpXIvhOjp66XEeadW5zI5amTsExE4M=;
        b=hIsmXWmM8HFrcAmWpWGlZ5MVvzfMcb4NS+7q8bSMxU5hfi2dKDMyLbFv4avhTNWCAo
         ljl+G1xUsinEMYJauYVU9BdyJekzzKPkmfRVIHdtmoxFXVc653tNPLY5cbHBwp04K/Ii
         I6rixo5e1ljWBpxGCTrgj72fXN6uEhrvqDnW4=
Received: by 10.150.74.9 with SMTP id w9mr805422yba.108.1316529587545;
        Tue, 20 Sep 2011 07:39:47 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id m10sm11870669ang.12.2011.09.20.07.39.45
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 07:39:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn-nh4BhCPf6m8+EN0zo=BuhxRNLcLBx7ynRWPA=GxfDyg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181768>

Dmitry Ivankov wrote:

> The next step would be to replace sha1 with struct object_entry* in fast-import.
> So it'll be in struct tree_entry (twice, for each of versions[2]),
> branch, tag, hash_list (used to store merge from lists), last_object.
> Then some fields will be deleted as they can be accessed from
> object_entry:
> last_object->depth
> last_object->offset
> tree_content->delta_depth
> branch,tag->pack_id
> 
> And it all even slightly decreased memory consumption (checked some
> time ago, but think it's still true).

Yes, that sounds interesting, so:

[...]
> In short, if there is nothing bad with this patchset, it'll be
> absolutely natural one after switch to oe instead of sha1, but it's
> put before to split the big series. And of course this part may have a
> small speedup of it's own. If it's not too good to be accepted on it's
> own, I'll just include it into future series depending on it.

It would be indeed be more natural to review a single series that
combines this preparation with the change it prepares for.  (And the
change descriptions should explain on their own why they are
individually justified or what project they are contributing towards.)

My question was actually about this last point you made in the
second-to-last sentence: have you measured the speedup produced by the
patches you already sent?  I didn't think carefully about it, but my
first thought was that it might slow things down as the internal hash
tables (which still seem to be fixed-size in mainline git) start to
fill up.
