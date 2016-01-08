From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Fri, 8 Jan 2016 17:44:30 +0700
Message-ID: <CACsJy8CBj-oMTLrn8gVudhLPEixZfkwFv9BaN8LSNFvOHkqKkg@mail.gmail.com>
References: <20160107165417.GB3397@logi.codethink.co.uk> <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
 <20160108101903.GC3397@logi.codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Maw <richard.maw@codethink.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 08 11:45:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHUXj-0002C6-M6
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 11:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbcAHKpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 05:45:03 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34287 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcAHKpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 05:45:01 -0500
Received: by mail-lf0-f53.google.com with SMTP id d17so6745821lfb.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hyS/ZQ4PCov5/eCE5Z3fGwY74/POhDuJXD8sfKF3oSc=;
        b=Mp/Z1uSmo0Oozn1IMKxFfiyy/dtrAcA1v4BIOoSRvjAqO+7D8SGeNRY5WLdTCb6m1e
         kvrwRLgx2zRcyTUND+9/LVEjSlegIHzGwJIblG8YzMMaaD5SAiv8RCbUyfCnXngPFxOC
         DjtPe+XtmT2i7XlD1Y4LM0OM/07TDNGp1DW28qcd1b9Ddpa8/bJgMwgc+Q/wk2b2YPL/
         k4H3rW+Gxq9WaZ0OTesv+vFJBNhumWsAY7O+kVhqv+sbljSeuTLVXL4FMsQ+TPS9p+Y7
         h015qWKSSm4SyiMRG4d+/IZLvROne65oOdXayMyFC6/IfkjBBs5N/BFkIXw41Q/pLkrn
         1MOg==
X-Received: by 10.25.161.144 with SMTP id k138mr31904428lfe.83.1452249900376;
 Fri, 08 Jan 2016 02:45:00 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 8 Jan 2016 02:44:30 -0800 (PST)
In-Reply-To: <20160108101903.GC3397@logi.codethink.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283533>

On Fri, Jan 8, 2016 at 5:19 PM, Richard Maw <richard.maw@codethink.co.uk> wrote:
> On Thu, Jan 07, 2016 at 10:00:07AM -0800, Junio C Hamano wrote:
>> Richard Maw <richard.maw@codethink.co.uk> writes:
>> > This is inconvenient for us,
>> > as we were explicitly using refspecs which didn't force the fetch,
>> > since we were using the "non fast-forward update" errors
>> > to detect whether upstream force pushed important refs
>> > which could be a sign of tampering.
>> >
>> > While the client doesn't have enough information
>> > the server has those commits.
>> > Would it make sense for the server to be able to tell the client
>> > "trust me, that commit is a descendant of the previous one"?
>>
>> It does not in our security model, as you do not blindly trust the
>> other side, whether you are a "client" or a "server".
>
> Fair enough.
> I didn't know whether Git passed responsibility for that to the transport layer.
>
> Would a mode for fetch to also include the commit chain without the trees fit
> the security model?

It sounds a lot like what I did with narrow clone [2] prototype. A
narrow clone only contains enough objects for certain paths so there's
a chance that we just don't have enough to do a proper merge. A
server-side command was added [1] to retrieve enough objects for the
task. If you fetch commit chain without all necessary trees and
objects, your repo is "broken" from Git point of view and you'll need
to do some extra work to make sure your repo is not actually broken.

[1] http://article.gmane.org/gmane.comp.version-control.git/154371
[2] http://thread.gmane.org/gmane.comp.version-control.git/154343
-- 
Duy
