From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Sun, 17 Mar 2013 20:21:13 +0700
Message-ID: <CACsJy8CPXFhUYz2f1wuxJvqwknJr5VFNFrs3b_4pS14cxf=3Wg@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh> <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
 <20130131110656.GA28093@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 14:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHDXS-0005y3-GI
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 14:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab3CQNVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 09:21:46 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:55741 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3CQNVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 09:21:45 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so4857100oag.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=e6c/IsOT2NaTN6SNLLFX2/Iv3EMo5u/sCyMd9GZ3e44=;
        b=G3w0lclSxJWrMQa0gYEl8rYTcu0UF5rrtKNhF0UbgDobPTjvHWN2uMmXrartBaL5Ot
         kq0OwSBWkP2G4p6FEV1Rq7xxbEgIir82jbGvhQvZz5XWm/gfaI4uQPF00wb9Buwhwtgv
         ONrEB6MRH8XOM2G0MHPoQGS+b1Nze8WwtWYmchyHHcDXbyQTqQ/j/4KY3eVHXQ1dkZET
         FYm5QiCTTOSywG5ZNICpwqOgDkEX1H4/AUZqVdbqGekeDl/hr4GSFRxakFZ/ae76XxqI
         OAV7n+Uy4oNiZ9QVw4nLnj7Nfo0u66rAZ3NfFB07KNW417kac8sRIzP7JH6wDklOdSOy
         MXyw==
X-Received: by 10.60.171.167 with SMTP id av7mr5373418oec.77.1363526505198;
 Sun, 17 Mar 2013 06:21:45 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 17 Mar 2013 06:21:13 -0700 (PDT)
In-Reply-To: <20130131110656.GA28093@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218362>

On Thu, Jan 31, 2013 at 6:06 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 30, 2013 at 09:16:29PM +0700, Duy Nguyen wrote:
>> Perhaps we could store abbrev sha-1 instead of full sha-1. Nice
>> space/time trade-off.
>
> Following the on-disk format experiment yesterday, I changed the
> format to:
>
>  - a list a _short_ SHA-1 of cached commits
> ..
>
> The length of SHA-1 is chosen to be able to unambiguously identify any
> cached commits. Full SHA-1 check is done after to catch false
> positives. For linux-2.6, SHA-1 length is 6 bytes, git and many
> moderate-sized projects are 4 bytes.

And if we are going to create index v3, the same trick could be used
for the sha-1 table in the index. We use the short sha-1 table for
binary search and put the rest of sha-1 in a following table (just
like file offset table). The advantage is a denser search space, about
1/4-1/3 the size of full sha-1 table.
-- 
Duy
