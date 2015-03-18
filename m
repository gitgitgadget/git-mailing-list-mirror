From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 18:14:11 +0700
Message-ID: <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:14:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYBvz-0005NH-9v
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 12:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbbCRLOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 07:14:42 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36405 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbbCRLOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 07:14:42 -0400
Received: by iegc3 with SMTP id c3so35333340ieg.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IbOKTilgjw+Ph1PHmfGEI6d1NNAbj/kNuWpmACDLNr4=;
        b=0FA4zhHeNg6nwHPG6DUKwEc6KGlpemzKinn4vyba+gPoHVdajvCsD/gj71BYb9A9sN
         Js8Jd9HLZMezmCvA8bGUickSJWkQK4o9RV5zcUEgt5DjTENnsUIpzep8An9f3eQoWFz1
         827/ChgEFbNr1OtOO9x+eEtsi2WEiSp7Idkjo76WigVcENb/YOO6dfGdsXbWzOTBNUpQ
         HeHAbcpId9mZjqayPC7Chb7e1NJohgD0vgXcgQ5zbR9JhdO1bQrHy6I5iA7rYkBD/XWz
         Sn9CWXSQgp44uPpS35g329ZiA6gSss/+EsG1FrUjNrOdaAjer9fhwHNf6SoWSDtr9tkL
         0Qtg==
X-Received: by 10.42.236.79 with SMTP id kj15mr3353688icb.40.1426677281640;
 Wed, 18 Mar 2015 04:14:41 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 04:14:11 -0700 (PDT)
In-Reply-To: <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265717>

On Wed, Mar 18, 2015 at 5:55 PM, Graham Hay <grahamrhay@gmail.com> wrote:
> We have a fairly large repo (~2.4GB), mainly due to binary resources
> (for an ios app). I know this can generally be a problem, but I have a
> specific question.
>
> If I cut a branch, and edit a few (non-binary) files, and push, what
> should be uploaded? I assumed it was just the diff (I know whole
> compressed files are used, I mean the differences between my branch
> and where I cut it from). Is that correct?
>
> Because when I push, it grinds to a halt at the 20% mark, and feels
> like it's trying to push the entire repo. If I run "git diff --stat
> --cached origin/foo" I see the files I would expect (i.e. just those
> that have changed). If I run "git format-patch origin/foo..foo" the
> patch files total 1.7MB, which should upload in just a few seconds,
> but I've had pushes take over an hour. I'm using git 2.2.2 on Mac OS X
> (Mavericks), and ssh (git@github.com).
>
> Am I "doing it wrong"? Is this the expected behaviour? If not, is
> there anything I can do to debug it?

It would help if you pasted the push output. For example, does it stop
at 20% at the "compressing objects" line or "writing objects". How
many total objects does it say?

Another question is how big are these binary files on average? Git
considers a file is "big" if its size is 512MB or more (see
core.bigFileThreshold). If your binary files are are mostly under this
limit, but still big enough, then git may still try to compare new
objects with these to find the smallest "diff" to send. If it's the
case, you could set core.bigFileThreshold to cover these binary files.
-- 
Duy
