From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Tue, 19 Aug 2014 16:29:28 -0700
Message-ID: <CAPc5daWgPgxPf2gL1e+-nwj7kGGBPDnGpA1syLVSVcqug+pEZw@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com> <CACsJy8AMCR5v1YYfA1AWWWXuYyuvOpsuXUfYzWfxhPYZE9SbcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:30:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJsql-0004be-7r
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 01:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbaHSX3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 19:29:51 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43868 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbaHSX3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 19:29:50 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so6216238lbi.27
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=foHlAt8sM7B1So1M5oD271sEsgm7dHwEsjF6tawAKI8=;
        b=jwhrONd0MuDFG7/QAJ0npQQyEqi3K58c9NXi7X0jHwbgNALZRFfnlMGjaHkYYBSv8c
         RmCV/mdDKurOtmAPs7Couy9Qa/4q+5LjMyMlfJ2lRdIvfLHdUBo4sXw6/5n+0ue46JF2
         QDlRnu/GUZAtNDasRe70MprGK6WcUzSNFD9LQnP8VskhuH1v4G1BsBrD7BP4FVdsXfNy
         BixjUhF8TmfjSXnVxoXKeFH42p+E22e+V2/3AHBsBq5gMosB16YMYuliH49Z8OFiARx/
         Dxhhui1ni9YWOoaUaRVfDgtRbR9N8iTkNn9FCN9pF+yLgSvzYWtjPEXBohAPB5d/c5Q8
         gx/g==
X-Received: by 10.152.28.230 with SMTP id e6mr39456150lah.62.1408490988833;
 Tue, 19 Aug 2014 16:29:48 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Tue, 19 Aug 2014 16:29:28 -0700 (PDT)
In-Reply-To: <CACsJy8AMCR5v1YYfA1AWWWXuYyuvOpsuXUfYzWfxhPYZE9SbcQ@mail.gmail.com>
X-Google-Sender-Auth: 6iQyZrR5mm6dzP3QuBOtAUWC9uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255544>

I don't think anybody can come up with a good auditing and recording
scheme without sufficient experience. Because I want to avoid whatever
random scheme we happen to implement first in git-core, even if it is
way suboptimal, ends up as the de-facto standard, I deliberately stayed
away from adding one of my own in this initial series, whose purpose is
to lay a groundwork for server operators can build on.  For the same
reason, I tried to avoid anything that defines and forces a particular policy
(e.g. does a server that accepts push certificate accept an unsigned
push to some of its refs? Is it OK if the GPG key is slightly stale? etc.).

"git notes" may or may not be a good vehicle to store them. This series
deliberately refrains from making that judgement. I'd rather leave these
operational issues to folks who work on systems like Gitolite and Gerrit.


On Tue, Aug 19, 2014 at 4:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Aug 20, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> While signed tags and commits assert that the objects thusly signed
>> came from you, who signed these objects, there is not a good way to
>> assert that you wanted to have a particular object at the tip of a
>> particular branch.  My signing v2.0.1 tag only means I want to call
>> the version v2.0.1, and it does not mean I want to push it out to my
>> 'master' branch---it is likely that I only want it in 'maint', so
>> the signature on the object alone is insufficient.
>>
>> The only assurance to you that 'maint' points at what I wanted to
>> place there comes from your trust on the hosting site and my
>> authentication with it, which cannot easily audited later.
>
> I only had a quick read of a few important patches and may miss
> something. But all this audit recording is left to the hook, right? I
> suppose git-notes could be used to store the push cert. blob, or the
> server could make a signed tag to record this info in the ref.. or do
> you intend any other way to record these blobs?
> --
> Duy
