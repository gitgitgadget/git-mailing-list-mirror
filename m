From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [RFC/PATCHv2 5/6] check commit generation cache validity against
 grafts
Date: Wed, 13 Jul 2011 10:26:28 -0400
Message-ID: <4E1DAB14.5040001@gmail.com>
References: <20110713064709.GA18499@sigill.intra.peff.net> <20110713070616.GE18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 16:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh0Oe-0003Af-9k
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 16:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab1GMO0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 10:26:35 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36178 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab1GMO0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 10:26:35 -0400
Received: by qyk9 with SMTP id 9so3424876qyk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZT81j2XBXfBtUKzT87N1L18oQVtmYEj/e7CaJxOrtWs=;
        b=x9sqcURcLj1mXr9e8TtSL/701HKJgOgAuG3iBc/BU55+6pGWj7HkQ1OuvlyBYv20gv
         6wvgycAxuOPX2TXu0vpjJnCfmk5bmUbuXbAyw8W3q7/BEGDKJ1zMXhWyXXPJI18/7O6E
         wH20YxN2lMAsOWdexwYneJP9zFaZWu9YOT4Vs=
Received: by 10.229.66.200 with SMTP id o8mr958875qci.250.1310567193979;
        Wed, 13 Jul 2011 07:26:33 -0700 (PDT)
Received: from [192.168.1.1] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id g7sm11943453qck.20.2011.07.13.07.26.30
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 07:26:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110713070616.GE18566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177042>

On 7/13/2011 3:06 AM, Jeff King wrote:
> +void metadata_graph_validity(unsigned char out[20])
> +{
> +	git_SHA_CTX ctx;
> +
> +	git_SHA1_Init(&ctx);
> +
> +	git_SHA1_Update(&ctx, "grafts", 6);
> +	commit_graft_validity(&ctx);
> +
> +	git_SHA1_Update(&ctx, "replace", 7);
> +	replace_object_validity(&ctx);

The implementation of metadata_graph_validity() makes it clear that 
commit_graft_validity() and replace_object_validity() are computing 
checksums in aid of validity-checking of the generations cache. However, 
the naive reader seeing the names commit_graft_validity() and 
replace_object_validity() in the API is likely to assume that these 
functions are somehow checking validity of the grafts and replace-refs 
themselves, which is not the case. Perhaps better names would be 
commit_graft_checksum() and replace_object_checksum()?

The name metadata_graph_validity() also suffers from this shortcoming. 
The actual validity check is performed by check_cache_header(), whereas 
metadata_graph_validity() is merely computing a checksum.

-- ES
