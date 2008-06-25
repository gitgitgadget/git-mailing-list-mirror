From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Created git-basis and modified git-bundle to accept --stdin.
Date: Wed, 25 Jun 2008 02:21:44 +0200
Message-ID: <8fe92b430806241721j43f9443eu80e16dcd64b8d143@mail.gmail.com>
References: <1214273297-8257-1-git-send-email-adambrewster@gmail.com>
	 <m3iqvzl091.fsf@localhost.localdomain>
	 <c376da900806240830p2a48aff0uaf6f22372fead5ef@mail.gmail.com>
	 <200806242055.53776.jnareb@gmail.com>
	 <c376da900806241655q85fc1d9r5bf67096a7930f94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Brewster" <adam@adambrewster.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 02:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBImX-0006Uw-V1
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 02:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYFYAVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 20:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYFYAVq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 20:21:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:6529 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYFYAVp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 20:21:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7903005rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 17:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fAHBZbd7jzrAa5EfmlO+1ZavKiY8AGzb2DSlnleyBvQ=;
        b=hRg/NMFMlUTzz8rKZOn4LoqGj7XlWCNSssUReqJ7rA5kWFbbdV/8n/WfpW+arLgxYx
         YB4IBDjLxR9Iaux2sj5YebvCmsEPzbTUPeuBzt2/VmpWNwjB4K1DQYb/UT8M2yi72bO6
         wzPGm7zGYv+4ybsZ8Ms1xxYkduK2EddawYFCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wTjz/eoMD9mWFoLS7OJm8OwMsKm0afAEUTWHu7M97dRXHmv277rofUa4VKmafH3JpS
         e/qXjh1XVAxT4uFo4rCrBSRPVOo7bdpHkaKxTdYwiHVhaoo0w4YHRVKk0NZ/n34KD0Rw
         OgrnebEuttwX/Kid3YUKNphI0rfj9pK5piC00=
Received: by 10.141.20.7 with SMTP id x7mr15665888rvi.183.1214353304757;
        Tue, 24 Jun 2008 17:21:44 -0700 (PDT)
Received: by 10.141.45.15 with HTTP; Tue, 24 Jun 2008 17:21:44 -0700 (PDT)
In-Reply-To: <c376da900806241655q85fc1d9r5bf67096a7930f94@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86192>

On 6/25/08, Adam Brewster <adam@adambrewster.com> wrote:
>>
>> I was thinking about
>>
>>  $ git bundle create my-bundle --all --not $(git ls-remote my-bundle | cut -f1)
>
> Not a bad idea, but it seems like I might be close to the maximum
>  length for a command line (about 3200 objects) in a couple of cases
>  (git-svn creates lots of branches).

Ah, sorry, I have forgot about that. This is definitely, both in the
case of revisions
packed in bundle, and basis (cutoff) of bundle, case for some kind of --stdin.

>  This also means that I have to remember where I save the old bundles.

That's what second solution was to save only bases in some file.

>> Or even
>>
>>  $ git ls-remote my-bundle | cut -f1 > my-bases
>>  [...]
>>  $ git bundle create my-bundle --all --not $(cat my-bases)
>>
>
>
> That's basically all the perl script does, except it will also create
>  an intersection of several bases (I don't want to remember the options
>  to comm).

Does it prefix bases with ^, i.e. ^basis (negative revision)?
I think it should, then there would be no need for strange --stdin
semantic, or implementing --stdin in such way that --not--stdin
works as expected.

>  Now that you mention it, a --basis option in setup_revisions would be
>  handy, but if I can't sell this, then I probably can't sell that
>  either.

I think that --stdin would be better idea, as it can be used to enumerate
all refs to send, even if they are too many or they have too long names  to
use arguments.

[...]
>>> I'll prepare another patch with documentation and changing --stdin to
>>> --revs when I get a chance.
>>
>> I'm not sure if another name, like --bases=<filename / basename> wouldn't
>> be better.  Perhaps --stdin is a good name...
>
> On second thought I'm going to defend my choice of --stdin now that I
>  remember why I chose it.
>
>  The docs for git-bundle specify the syntax is "git-bundle create
>  <file> <git-rev-list args>", where <git-rev-list args> is defined as
>  "A list of arguments, acceptable to git-rev-parse and git-rev-list,
>  that specify the specific objects and references to transport. ..."
>  Git-rev-list takes --stdin, so it seems reasonable to expect that
>  git-bundle will as well.

Ahh... git-rev-list... well, I though about git-pack-objects and its different
--stin semantic (which might make no sense for git-bundle).

[Sorry for bad wrapping, I'm sending it from GMail Web interface]
-- 
Jakub Narebski
