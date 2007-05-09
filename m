From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 9 May 2007 09:42:05 -0700
Message-ID: <56b7f5510705090942qe574e11h4f52f204d68a40b8@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
	 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
	 <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
	 <alpine.LFD.0.99.0705091048120.24220@xanadu.home>
	 <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 18:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpEx-0005J6-FD
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbXEIQmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755687AbXEIQmI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:42:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:21056 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707AbXEIQmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:42:06 -0400
Received: by wr-out-0506.google.com with SMTP id 76so285286wra
        for <git@vger.kernel.org>; Wed, 09 May 2007 09:42:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cTQUPCxFBQFMOx71runIrI5BuSymiXUWZBaSATz10uD3j7GdefHtNS3RQ9SfywFrB1AIEqGi9rD8XhSikeIu7gxSZtd1fPcPMGfSmyamyEtmmrsQShJitk3zhIO1jIaVupdhA/3LoeY+uTG7ux3bFoDgN0rBH2AtTMnGE95AgdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FUOb+El2C2r9BFO0hyZAg/WFBNwm3aWwmgLmoS+fLCr8JTBfrn1WmlUyFweVH4IrRqhftWB3Ze8e09d83pE9CgzTybxjKNqXMVV/jc6rSFPOD56BbYd2QyQppnQL2O+NN3g7wX0AvrYeFKsvqW67scUJhT1WsCaZIvRsnVh1Yi4=
Received: by 10.114.89.1 with SMTP id m1mr251445wab.1178728925159;
        Wed, 09 May 2007 09:42:05 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 9 May 2007 09:42:05 -0700 (PDT)
In-Reply-To: <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46747>

On 5/9/07, Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
>
> > So I suggest that we get rid of core.legacyheaders, preserve the legacy
> > format as the only writable loose object format and deprecate the other
> > one to keep things simpler.  Thoughts?
>
> I agree with your analysis, especially when deeper delta chains
> are allowed, straight copy of loose object becomes less and less
> likely.
I too agree with the logic in the original <tangential comment>,
and deprecation is the appropriate thing.  So I'm not actually
going to change anything here in today's patch.

> > What we need instead is a --no-reuse-object that would force
> > recompression of everything when you really want to enforce a specific
> > compression level across the whole pack(s).
>
> Yeah.  Or maybe --no-reuse to mean both and make '-f' a
> short-hand synonym for that.
>
> I do not see much reason to want to tweak them independently;
> recomputing delta is much more expensive than recompressing
> anyway, and when the user says 'repack -f', it is a sign that
> the user is willing to spend CPU cycles.
We have the same idea about git-repack -f -- it implies both
--no-reuse-delta and --no-reuse-object , and I will do that.
I will incorporate Nicolas's new --no-reuse-object
in my patch to builtin-pack-objects.c .
I won't go so far as collapsing --no-reuse-* to --no-reuse in this patch.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
