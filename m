From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 0/4] Honor core.ignorecase for attribute patterns
Date: Wed, 14 Sep 2011 20:59:35 -0500
Message-ID: <1316051979-19671-1-git-send-email-drafnel@gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 15 04:00:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41FR-0007Af-J2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab1IOCAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:00:09 -0400
Received: from mail-gx0-f170.google.com ([209.85.161.170]:44916 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1IOCAI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:00:08 -0400
Received: by gxk27 with SMTP id 27so2967235gxk.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M47TD80PN7Qz/eHbHJHbCj//PqCo1cj4yPG6Bos6Y6E=;
        b=UU2yGMr/gw3wNzl01ACxD2XldSapA92hxVJFhTik5uhk/sojkld7RK/mLXhUSO73qw
         dtMm+2mrm2Ov2seQYW3s0ENhis4PQkF1Wiso8jWe0CllcjQJ+Ns+aEEcw0IskY3x31rU
         s7ADnctOoLu1wXRyzzWl2oxp3J/EfhN8gVM1Q=
Received: by 10.236.37.134 with SMTP id y6mr2849440yha.113.1316052007435;
        Wed, 14 Sep 2011 19:00:07 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id e61sm2291412yhm.2.2011.09.14.19.00.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:00:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181421>

On 09/13/2011 11:22 AM, Brandon Casey wrote:
> On 09/13/2011 11:05 AM, Jeff King wrote:
>> On Tue, Sep 13, 2011 at 10:15:15AM -0500, Brandon Casey wrote:
>>
>>> ...and I see there is already an fnmatch_icase() in dir.c which adds
>>> FNM_CASEFOLD when the global var ignore_case is set.  So, maybe it's as
>>> easy as:
>>> [...]
>>> -               return (fnmatch(pattern, basename, 0) == 0);
>>> +               return (fnmatch_icase(pattern, basename, 0) == 0);
>>
>> OK, wow. That's exactly the level of easy I was hoping for. Do you want
>> to roll that up into a patch with some tests?
>
> I haven't even tested that it runs. :)  No, I was hoping someone
> who was more interested would finish it, and maybe even test on
> an affected system.

Ok, I lied.  Here's a series that needs testing by people on a  
case-insensitive filesystem and some comments.

The first three patches are just housekeeping and can be accepted 
independently of the fourth patch which is marked WIP.

The last patch implements the case-insensitive matching of attribute
patterns, but I discovered that bad things can happen if git_config()
is called more than once.  Details are in the patch email.

-Brandon

[PATCH 1/4] attr.c: avoid inappropriate access to strbuf "buf"
[PATCH 2/4] cleanup: use internal memory allocation wrapper
[PATCH 3/4] builtin/mv.c: plug miniscule memory leak
[PATCH 4/4] attr.c: respect core.ignorecase when matching attribute
