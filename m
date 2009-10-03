From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] allow mangling short options which take integer
	arguments
Date: Sat, 3 Oct 2009 11:23:32 +0200
Message-ID: <20091003092332.GA10570@localhost>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091001202301.GB12175@localhost> <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de> <20091002074317.GB9444@localhost> <20091002075012.GB27664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 03 11:27:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu0tJ-0000Na-C6
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 11:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZJCJXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 05:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbZJCJXm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 05:23:42 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:21461 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbZJCJXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 05:23:42 -0400
Received: by ey-out-2122.google.com with SMTP id 4so163614eyf.5
        for <git@vger.kernel.org>; Sat, 03 Oct 2009 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=78ggKD3R2e/KKh3ZoNJZRuat9H9pj7yUenFeHoICvaE=;
        b=dWLrgj9+Qj8SIQFQwS8/XbfUA6GdMiVJoGIdqpgXTZXL5Uny/TuUu/W54ezA4llvqB
         tfavCUpER/Lv2kDqcPFaPJvjU4ODcscr/UL5Bkomjud10uv/DXOcthNYph3DVMU+uuss
         abyWb8xzCDuO73mGq5mbptdrfnOq5HCuJjzrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=jf8H4yr0VHA4WEzjk5tZbXdzH8KKdTDnCrNXMLSYIVhW//V0XrPY88d+1eZZsLeST2
         S9btHox8DSMcVBO1FgZpzN7HTiKNrHnjE4kXJ9uA07ja8mWmBvv58zU7fySS2K1Rgmva
         Fdm7exS6rRCQfx9V4UrSbPcQo589hCU1uqHww=
Received: by 10.211.129.20 with SMTP id g20mr4528230ebn.12.1254561824882;
        Sat, 03 Oct 2009 02:23:44 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 25sm4600805ewy.46.2009.10.03.02.23.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Oct 2009 02:23:43 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mu0pw-0002xP-Vd; Sat, 03 Oct 2009 11:23:32 +0200
Content-Disposition: inline
In-Reply-To: <20091002075012.GB27664@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129479>

On Fri, Oct 02, 2009 at 03:50:12AM -0400, Jeff King wrote:

> On Fri, Oct 02, 2009 at 09:43:17AM +0200, Clemens Buchacher wrote:
> 
> > On Thu, Oct 01, 2009 at 11:55:03PM +0200, Johannes Schindelin wrote:
> > 
> > > And this patch looks even more straight-forward than 1/2, _but_... what 
> > > about cases where there are short options that are digits?
> > 
> > Could you point me to one of those? I did not find any during my
> > non-exhaustive search. We should be able to handle them easily by adding
> > PARSE_OPT_MANY.
> 
> The one that comes readily to mind is "git log -1", but that is actually
> parsed by the revision options parser, which doesn't use parseopt. But
> there are a few done by parseopt:
> 
>   $ git grep "OPT_.*'[0-9]'"
>   archive.c:              OPT__COMPR('1', &compression_level, "compress faster", 1),
>   archive.c:              OPT__COMPR_HIDDEN('2', &compression_level, 2),
>   archive.c:              OPT__COMPR_HIDDEN('3', &compression_level, 3),
>   archive.c:              OPT__COMPR_HIDDEN('4', &compression_level, 4),
>   archive.c:              OPT__COMPR_HIDDEN('5', &compression_level, 5),
>   archive.c:              OPT__COMPR_HIDDEN('6', &compression_level, 6),
>   archive.c:              OPT__COMPR_HIDDEN('7', &compression_level, 7),
>   archive.c:              OPT__COMPR_HIDDEN('8', &compression_level, 8),
>   archive.c:              OPT__COMPR('9', &compression_level, "compress better", 9),
>   builtin-checkout.c:             OPT_SET_INT('2', "ours", &opts.writeout_stage, "stage",
>   builtin-checkout.c:             OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",

Those are not affected by this patch series. They can be cuddled with other
short options just like before, since they don't take arguments.
