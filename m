From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Sat, 5 Dec 2015 06:33:47 +0100
Message-ID: <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net> <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
 <20151204215158.GA27987@sigill.intra.peff.net> <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 06:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a55Um-0003Et-PA
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 06:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbbLEFeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 00:34:19 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36583 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbLEFeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 00:34:18 -0500
Received: by lfs39 with SMTP id 39so121213871lfs.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 21:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7imcaIKZ68/b6KOg6jyJTFuSHXeASUKGupxWRg4rv0o=;
        b=PLBOi01fBkUD7Osv5NashsSseaQ32c3hMnaXaM8KejM0C1lcfULiSQT0LP9eaCBOTm
         q2sZvMjNTkv9EUtlktA9Iwaht0wnIgKmdcNdpAyCcIcE3QyJg2hHuQvomOAaLggqrKKZ
         PLuZtgV4wMA8xFm2JPWIy+5CyB/dk43rWJfnG6XiZdS30Ow7YMcI3fFbvUagHtWTt6mp
         fZBCDKIF1E/ZQ29si/sVx00oGFU3v7pGlS7pTZUYJf+IldTt8rXI/5GYsotomuX3pJUZ
         2zEKagKbC4b9APIVs7hNldzflmeACgV5BVNtxKusMRRu80PtJ1FtM3sG7A0nOtwAdhVM
         syIw==
X-Received: by 10.25.170.149 with SMTP id t143mr9620801lfe.162.1449293656701;
 Fri, 04 Dec 2015 21:34:16 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 4 Dec 2015 21:33:47 -0800 (PST)
In-Reply-To: <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282025>

On Fri, Dec 4, 2015 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>> But why would fetching a tag (or set of tags) merit a depth of zero?
>>> Doesn't depth 1 mean "give me the the objects, and none of their
>>> descendants"?  Why use 0?
>>
>> That comes from this line:
>>
>>   transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>>
>> That line blame back to b888d61 (Make fetch a builtin, 2007-09-10),
>> which isn't incredibly helpful.
>
> Hmm, "0" means "no depth limitations", which is exactly what we want
> in this "unshallow" case, I would think.  The behaviour observed is

No depth 0 means "do not change depth", which is why Jeff saw no
'deepen' lines (and those lines should be rejected any way). It's
equivalent of doing "git fetch" without --depth.

> just like a regular fetch that auto-follows tags, where it has to
> make a second fetch if the primary fetch fails to include everything
> that is needed for propagating the tag for whatever reason.
>
> Having said that, IIRC, these days a depth limited clone is created
> implicitly with --single-branch option, and I am not sure what the
> right behaviour for the auto-following of tags in such a repository.

I suppose followtags feature has been around long enough that we can
simply trust that and skip the second fetch? But it's not that easy
for subsequent fetches after the initial fetch in git-clone, because
we no longer know if --single-branch was used (of if there is any new
branch fetched since).
-- 
Duy
