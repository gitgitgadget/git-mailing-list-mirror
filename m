From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 20:24:55 +0700
Message-ID: <CACsJy8C6E0orN1a6WbkFCiyBtfp94y4XMLS3-i=_6s4WADicCw@mail.gmail.com>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
 <20150605094545.GB11855@peff.net> <CACsJy8CnWo=s1onqY33K+DwFmB1baQ-uwu9Fbwm+UB30kDTwQw@mail.gmail.com>
 <20150605103639.GB19033@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 15:25:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0rcu-00058H-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 15:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbbFENZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 09:25:27 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36555 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbFENZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 09:25:26 -0400
Received: by ieclw1 with SMTP id lw1so57840769iec.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EIxj9f9GkMmmBballofpFm7wkoRe5MZTw/1FgSNFoVQ=;
        b=0FKVTGiPkIfxgsLVZHIyVQ2clHRAQFXncA52z4yiRLdH+9Vh2OTfd+Ttsnsv+4adJe
         3QhrNyn7JlZHsV5PS7pakWdQH5eTdZDMkTU1YtjXj+DTccManxSPtSG/ZdK0oQV398tH
         jVTIVGs2wEjti50RrA67+1VbZXAAcJo7DwRlVyTIHDvJFmcp8mW0N1GXoT2GHJBDuawE
         o1yJ3cgs/ITrzq88MrpyHOURR/XHQCIais5Ky31QunZQCvVgl89P0NePloLpJjEpJTS7
         Z2ojtxABecFMsUhmbrtUva0Kz0Y5VNmnqdWvt2iIwCnzQBj0ixvcyMkpVJ1tnzv7Ipi1
         gfig==
X-Received: by 10.42.93.17 with SMTP id v17mr10706450icm.42.1433510725798;
 Fri, 05 Jun 2015 06:25:25 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Fri, 5 Jun 2015 06:24:55 -0700 (PDT)
In-Reply-To: <20150605103639.GB19033@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270832>

On Fri, Jun 5, 2015 at 5:36 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 05, 2015 at 05:14:25PM +0700, Duy Nguyen wrote:
>
>> I'm more concerned about breaking object_id abstraction than C
>> standard. Let's think a bit about future. I suppose we need to support
>> both sha-1 and sha-512, at least at the source code level.
>
> I think that's going to be a much bigger issue, because we are casting
> out of a defined, on-disk data structure here. So I'd rather defer any
> code changes around this until we see what the new data structure (and
> the new code) look like.

Yeah.. I don't have a clear idea what it would look like either. What
I didn't think of is this object_id may turn around and influence how
new on-disk format looks like, to make it easier to work with
object_id. So there's an option..

>> That might make casting tricky. Maybe we should deal with it now
>> instead of delaying because if the final solution is vastly different,
>> we may be redoing this conversion again. In any case, if we cast, we
>> should make it grep-able (maybe hide the casting in a macro so we can
>> grep the macro's name) so we can examine them when the time comes for
>> us to move away from sha-1.
>
> I think that is sensible. Something like:
>
>   #define SHA1_TO_OBJID(sha1) ((struct object_id *)sha1)
>
> would probably be a good start.

Yep.
-- 
Duy
