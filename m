From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Sun, 23 May 2010 12:36:51 +0200
Message-ID: <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 23 12:37:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG8YH-0002Bf-Lb
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 12:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab0EWKg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 06:36:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54201 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0EWKgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 06:36:55 -0400
Received: by wyb29 with SMTP id 29so862761wyb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=nB3rU+A3FRKlLGKg3SZDf4YtZrCN6SHbsm4kU8rh8bk=;
        b=Ssu/3nq8ecxghyqZqbKYLjJP7BP+LAtotB3A4yRX2+cEdeuwzvan98PUo0jRYoa7XZ
         4ThLl0l6avKL/LuPeToEw9lxsgAIuuPFhlw4RQdgsWtmGlRHX+QHMlpQSrBjxNiixM+8
         69zSFZAQkSRr4aP9RjsBQH3+HdqEsUg9NlkG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=bAC1RkFBfTcK86qj93wJ+AN89sZxOgvWeaOxAiMzSzRI3NCOPCvNb75k8tvR9CUKpT
         6Ra2zdfx3d6hIN4pH6u2DH5Cwh+w/DmMLvBrq10ElLaMeSIICapSgFMf8O/mFPw5uk4W
         cNEyKrFgVyZrMizKRp3U/WcTkH9pAtNbUSReg=
Received: by 10.227.157.201 with SMTP id c9mr3880087wbx.89.1274611013647;
        Sun, 23 May 2010 03:36:53 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1370570ewy.15.2010.05.23.03.36.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 03:36:53 -0700 (PDT)
In-Reply-To: <20100522222746.GA2694@localhost>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147572>

On 23. mai 2010, at 00.27, Clemens Buchacher wrote:

> Hi Eyvind,
> 
> Thanks for the extended summary. I still have several doubts, as
> detailed below. But I understand that this has been heavily
> discussed and if the discussion has indeed come to a conclusion,
> then I will not complain about it now.

I appreciate your comments.  The more people who take a critical look at the series, the better :)  I think most of your concerns were covered during the discussion, but it's always good to have more sanity checks.

[...]

> For all my comments below I am assuming that the behavior of
> autocrlf will be changed to respect the crlf/text attribute by
> default.

That's right, the attribute is used regardless of what autocrlf is set to.

>> The "eol" attribute is used for files that need a specific line
>> ending.  Setting it also sets "text".
> 
> If a file needs specific line endings, why enable conversion for
> this file at all? Just make sure the repository contains the
> correct version and unset the crlf attribute.

Yeah, that's what I initially thought too, but it makes sense to be able to use normalization to prevent line ending breakages in your repository.  If a file needs CRLFs for some tool to work, you don't want anyone to inadvertently convert it to LF, and "eol=crlf" makes git enforce that.

[...]

>> There is a backwards compatibility wrinkle in that core.autocrlf
>> will override core.eol if the latter isn't explicitly set, so
>> that "core.autocrlf=true" still results in CRLFs in the working
>> directory on Linux.
> 
> This also makes sense. I just fear that making this frequently
> misunderstood feature even more complex will only confuse users
> further.

I agree, but I really wanted to avoid breaking any settings.  I'm thinking of submitting a patch to remove the backwards compatibility for 1.8, leaving core.autocrlf as a simple boolean meaning "* text=auto".

> I do see the value of a global core.eol option, however, since it
> allows me to convert to LF instead of CRLF, which AFAIK is not
> currently possible.

Actually, since git normalizes to LF, "eol=lf" simply means "convert on input but not on output", which is what "core.autocrlf=input" currently does.  The fact that you didn't know this reflects the poor usability of core.autocrlf, which is one of the things this series is trying to rectify :)

It also allows for the possibility of supporting other line endings such as the classic Mac "CR only".  That might not be a good thing.

> On the other hand, this will cause users to stop caring whether or
> not a file in the repository has LF or CRLF line endings. I am not
> sure if that is a good thing, but I suppose it is better than what
> we have now.

The problem is that users don't care anyway, and they've been trained by other VCSes that they shouldn't need to care.  This series allows me to put "* text=auto" in my repository and git will automatically normalize text files regardless of the user's configuration, which wasn't possible before.

[...]

> I see. Well, if we rename the "crlf" attribute then we will have a
> macro attribute "binary" and an attribute "text", which are not the
> opposite of each other. That is a bit strange.

Yes, but I don't think it should cause any problems in practice.  Since the "binary" attribute just means "-text -diff" it will override a "* text=auto", which I is the only relevant interaction I can see.
-- 
Eyvind
