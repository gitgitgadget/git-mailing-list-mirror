From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: large files and low memory
Date: Mon, 4 Oct 2010 14:16:57 -0500
Message-ID: <20101004191657.GC6466@burratino>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
 <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: weigelt@metux.de, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qaJ-0006Pc-0O
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab0JDTUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:20:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64669 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab0JDTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:20:16 -0400
Received: by eyb6 with SMTP id 6so2137422eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ALrHNcfb3QryV8pozzH0R85bTd097rax4CShcd07Seo=;
        b=fnn/oChytmfndNJqzFu5lagmFG7IxFPOV41PeEbDqa9Fm1A1yhyqV+VlmddR+uiuI9
         mc7qxm4N/8K565qrtLmv/GwI5vuh354Zp2iNLBCRRIU5ZfELSqsN8DDpSGCdj9p+w/dh
         UNbnazZsSPlUL7WTvgLRwV07i09LiqVM27K2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PP46v3Mjg6DA3UOnVfdAm3KXYGbJUQsA/8EvITrez4cChCLJtDfNy69XP9W7gCe3MP
         M9is+g1Tk9aErCRVtsaFQXOlKkSg+CRTQvIwY4XqZmmhXbIzsSnNdhhz4YLzRtiIciTl
         Ua6C6kyViZhIWMDHwsdg4k2iZXd0ecHKcSs+Y=
Received: by 10.223.114.194 with SMTP id f2mr9565891faq.71.1286220015092;
        Mon, 04 Oct 2010 12:20:15 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r8sm2427998faq.34.2010.10.04.12.20.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 12:20:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158101>

Shawn Pearce wrote:

> This change only removes the deflate copy.  But due to the SHA-1
> consistency issue I alluded to earlier, I think we're still making a
> full copy of the file in memory before we SHA-1 it or deflate it.

Hmm, I _think_ we still use mmap for that (which is why 748af44c needs
to compare the sha1 before and after).

But

 1) a one-pass calculation would presumably be a little (5%?) faster
 2) if there are smudge/clean filters or autocrlf involved, the
    cleaned-up file is backed by swap and this all becomes moot.
