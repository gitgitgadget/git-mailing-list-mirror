From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: PATH_INFO support improvements
Date: Thu, 2 Oct 2008 10:49:59 +0200
Message-ID: <cb7bb73a0810020149l4722be08p52be3b4703be0e41@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810021019.27383.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 10:51:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlJty-0006Rz-6y
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 10:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYJBIuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 04:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYJBIuB
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:50:01 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:63670 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbYJBIuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 04:50:00 -0400
Received: by gxk9 with SMTP id 9so1150591gxk.13
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x+eEyDDGOwL5/zK5+5gyVHHQjItiT918NaWdMNB97Es=;
        b=Mt2+mr3TOCAx83+bAysJAI0KgCq68Me5zQx4OHGAKHN+NwK1VVNFWe9rksh0Rm1x4T
         /HfZp23aOaHwI+ZvcCI75b3Mfg7oEarCJC1mnptKvBtRY15c16jkJBWaPnVI5hs2eyOc
         xXhelTLyNgPeGststp7s+06tXi5oW+4ZI3QAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FG7sTll0XNKgzIVQpReGXDFph/rVJglceXIftHbe108c0s6n8eyUk8oeGTPBR3yZU7
         M39nmzNhuG1U2FfGa1Y166Yhuc61mnaT5kSHMwr7NuJkARidTPxjpDrvK73TvaneZ9hG
         kuCrrHYCEg0ypfWTqG1XkzT+lDyety1EdovV4=
Received: by 10.90.70.15 with SMTP id s15mr10289604aga.81.1222937399435;
        Thu, 02 Oct 2008 01:49:59 -0700 (PDT)
Received: by 10.90.29.8 with HTTP; Thu, 2 Oct 2008 01:49:59 -0700 (PDT)
In-Reply-To: <200810021019.27383.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97294>

On Thu, Oct 2, 2008 at 10:19 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>
>> Fourth version of my gitweb PATH_INFO patchset, whose purpose is to
>> reduce the use of CGI parameters by embedding as many parameters as
>> possible in the URL path itself, provided the pathinfo feature is
>> enabled.
>
> A nit: when sending longer patch series you should use numbered
> format in the form of [PATCH m/n] or [PATCH m/n vX] prefix.

W00t, I still manage to get this wrong. Kudos to me 8-/

I wonder why these options are not the default when there is more than
one patch, btw?

(And yes, I tried looking into the builtin-log.c code but making it
automatic is somewhat less trivial than I can dedicate time to.)

>> The new typical gitweb URL is therefore in the form
>>
>> $project/$action/$parent:$file..$hash:$file
>>
>> (with useless parts stripped). Backwards compatibility for old-style
>> $project/$hash URLs is kept, as long as $hash is not a refname whose
>> name happens to match a git action.
>
> Minor nit: there was also old-style $project/$hash_base:$file_name
> path_info format.

Right, forgot about that.

>> The main implementation is provided by paired patches (#1#3, #5#6)
>> that implement parsing and generation of the new style URLs.
>>
>> Patch #2 deals with a refactoring of the input parameters parsing and
>> validation, so that the rest of gitweb can be agnostic wrt to the
>> parameters' origin (CGI vs PATH_INFO vs possible other future inputs
>> such as CLI).
>>
>> Patch #4 is a minor improvement to the URL syntax that allows web
>> documents to be properly browsable in raw mode.
>
> Very nice summary of patchset and patch  coverage in this cover letter.

Thanks. At least I'm learning from my past errors. I'll manage to send
the perfect patchset sooner or later ;)


-- 
Giuseppe "Oblomov" Bilotta
