From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] revert: plug memory leak in "cherry-pick root commit"
 codepath
Date: Tue, 16 Aug 2011 13:56:16 -0500
Message-ID: <20110816185616.GE10336@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
 <20110814131303.GF18466@elie.gateway.2wire.net>
 <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
 <20110814152204.GJ18466@elie.gateway.2wire.net>
 <7v39h1i6rr.fsf@alter.siamese.dyndns.org>
 <20110816181633.GB10336@elie.gateway.2wire.net>
 <20110816183147.GA10117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 20:56:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtOoP-0004DE-58
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 20:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab1HPS4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 14:56:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38114 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1HPS4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 14:56:23 -0400
Received: by bke11 with SMTP id 11so154066bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LtgtyKvW24bdGvOwVh/x3svLmGeKEGwQNDchoL4GEHc=;
        b=Nq+ZiFfgBMrasknaVMZj4YiR7/dnEvTwqACoorpSIbJz2cGMw/x9lxTrJtSLrPItKZ
         VoyEPesoYh1DJoa/Bp6PQw6YQU8Vbg/aiamjOXcA4GRg6HmZuV1qDFf0LXSMozccIFMm
         OhlfhIZtrDjeLR0vQepPUoiPpshcXa2mMfAfQ=
Received: by 10.204.171.66 with SMTP id g2mr34425bkz.8.1313520982389;
        Tue, 16 Aug 2011 11:56:22 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-67-175.dsl.chcgil.ameritech.net [69.209.67.175])
        by mx.google.com with ESMTPS id x19sm116932bkt.9.2011.08.16.11.56.19
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 11:56:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110816183147.GA10117@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179469>

Jeff King wrote:
> On Tue, Aug 16, 2011 at 01:16:33PM -0500, Jonathan Nieder wrote:

>>  static struct tree *empty_tree(void)
>>  {
>> -	struct tree *tree = xcalloc(1, sizeof(struct tree));
>> -
>> -	tree->object.parsed = 1;
>> -	tree->object.type = OBJ_TREE;
>> -	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
>> -	return tree;
>> +	return lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
>>  }
>
> Much nicer. But doesn't your dab0d41 (correct type of
> EMPTY_TREE_SHA1_BIN, 2011-02-07) make the cast unnecessary?

Yes, I was working against an older codebase (for no particular
reason).
