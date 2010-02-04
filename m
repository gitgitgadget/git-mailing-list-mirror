From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Wed, 3 Feb 2010 18:30:56 -0800
Message-ID: <20100204023056.GQ14799@spearce.org>
References: <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> <20100129183705.GB22101@spearce.org> <7vockc45ut.fsf@alter.siamese.dyndns.org> <7vmxzw15dt.fsf@alter.siamese.dyndns.org> <7v3a1oyrkp.fsf@alter.siamese.dyndns.org> <20100201152826.GE8916@spearce.org> <7v7hqtzrmq.fsf@alter.siamese.dyndns.org> <20100204020756.GP14799@spearce.org> <7vock5yby2.fsf@alter.siamese.dyndns.org> <7vk4utybur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:31:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrUo-0004Uw-BU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059Ab0BDCbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:31:00 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:34654 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab0BDCa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:30:59 -0500
Received: by iwn39 with SMTP id 39so2446299iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 18:30:58 -0800 (PST)
Received: by 10.231.146.79 with SMTP id g15mr848890ibv.49.1265250658779;
        Wed, 03 Feb 2010 18:30:58 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm6051866iwn.9.2010.02.03.18.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 18:30:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4utybur.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138937>

Junio C Hamano <gitster@pobox.com> wrote:
> And this is a fix-up for the mismerge.  I didn't touch max-pack-size stuff.
> 
>  fast-import.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index ca21082..a6730d0 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2800,7 +2800,10 @@ static int parse_one_option(const char *option)
>  	if (!prefixcmp(option, "max-pack-size=")) {
>  		option_max_pack_size(option + 14);
>  	} else if (!prefixcmp(option, "big-file-threshold=")) {
> -		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
> +		unsigned long v;
> +		if (!git_parse_ulong(option + 19, &v))
> +			return 0;
> +		big_file_threshold = v;

Yup, looks good to me.

-- 
Shawn.
