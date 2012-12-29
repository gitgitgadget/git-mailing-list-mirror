From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sat, 29 Dec 2012 12:25:04 +0700
Message-ID: <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 06:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Toovi-0000OL-9Z
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 06:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab2L2FZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 00:25:36 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43547 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab2L2FZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 00:25:35 -0500
Received: by mail-ob0-f181.google.com with SMTP id oi10so10018450obb.40
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 21:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8iHYzp50aS4j+uFAgTYB3bylxXLbuywS60oZYpQ0+hU=;
        b=guL/l7X49MNXgebLSUp/6QJi/5MVs35wi9tdESelEAQzgaqLQh3YiiqYDnzjg7jGIV
         R5pLlws2/X/iT9zmtpboZrbMz7LUO/5J3SfxpHE4915Qv8VdKyin0O5WEuitx/mZNBoV
         gLz5kX4qNgjtLlLnfHU9sv/5Ts4FteZxVegHTD0DxlAuZuKF4CrYfTQ+gkSpNl6f/R3r
         Nm8O9h5mh9BMOjP4qohrYa4qyKPnfQaTPa5Cc2dJsY3g9AWboEWk4B5+Q/IbVprAEj16
         PvaQ8LreP40dyH4RHPkJeXB1zfSw/SjxFmsVuUXojQ3Tbg75vYJwFi35aeNTiao4xTUr
         IUcQ==
Received: by 10.60.30.70 with SMTP id q6mr17262730oeh.107.1356758734699; Fri,
 28 Dec 2012 21:25:34 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Fri, 28 Dec 2012 21:25:04 -0800 (PST)
In-Reply-To: <20121229050707.GA14475@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212290>

On Sat, Dec 29, 2012 at 12:07 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Dec 29, 2012 at 11:34:09AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Sat, Dec 29, 2012 at 7:41 AM, Jeff King <peff@peff.net> wrote:
>> > I wonder if we could do even better, though. For a traversal, we only
>> > need to look at the commit header. We could potentially do a progressive
>> > inflate and stop before getting to the commit message (which is the bulk
>> > of the data, and the part that is most likely to benefit from
>> > compression).
>>
>> Commit cache should solve this efficiently as it also eliminates
>> parsing cost. We discussed this last time as a side topic of the
>> reachability bitmap feature.
>
> I agree that a commit cache would solve this (though it can not help the
> tree traversal).

Yeah, caching trees efficiently is not easy.

> But just dropping the compression (or doing partial
> decompression when we only care about the beginning part) is way less
> code and complexity.

I think I tried the partial decompression for commit header and it did
not help much (or I misremember it, not so sure).

> There's no cache to manage.

If reachability bitmap is implemented, we'll have per-pack cache
infrastructure ready, so less work there for commit cache.
-- 
Duy
