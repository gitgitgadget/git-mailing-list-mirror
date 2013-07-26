From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "fatal: reference is not a tree:" on git checkout <branch>
Date: Fri, 26 Jul 2013 18:46:38 +0700
Message-ID: <CACsJy8BWnrH2J+BhG09BpfzMUFw=-XirP7EAa3QKuXtbvQr18Q@mail.gmail.com>
References: <CC257523-1C84-4F73-9AB0-D1B5A5ECDC45@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Abdurachmanov <david.abd@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 13:47:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2gUN-0005m8-HM
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 13:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab3GZLrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 07:47:11 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36656 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab3GZLrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 07:47:10 -0400
Received: by mail-ob0-f173.google.com with SMTP id er7so4001224obc.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PGqw5jXIqGke8WVIPqKfmFhSbNxEKlrcZE3MeU4ioIM=;
        b=akj+kMntOdS3itCF6OHqGCZI77UBwvjIL3jwm+T3tflq4OdU1VM3ZuRfMuL1A5y6UA
         jYsIHHh6rZrYA/ux5XLOulcnfea4eRSJfsIVHS8kYBiTjcpOdYJoV2A49PX4KjNBvRgn
         Q+D8hw0jtXUANq1vtT0ewXGsWNvwhfJaI8Np3LZcBcLMRx4PqCFDCHsDJ70K0Jjk4IpE
         O+p5yZocv/PbzXUKeT0W+9X9sED82EXV7MeyJgKzhpmC4TI+nknCUrpLuXjXo0xRkyUr
         xR8AZsQ4mpWlT8zdX8/R0BC0h1wkUs9rDzaAXr2QVBG5NRqWFTJisYvECAA0HGhZXCi0
         flqg==
X-Received: by 10.60.55.196 with SMTP id u4mr46726316oep.57.1374839229804;
 Fri, 26 Jul 2013 04:47:09 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Fri, 26 Jul 2013 04:46:38 -0700 (PDT)
In-Reply-To: <CC257523-1C84-4F73-9AB0-D1B5A5ECDC45@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231181>

On Fri, Jul 26, 2013 at 4:52 PM, David Abdurachmanov
<david.abd@gmail.com> wrote:
> Hi,
>
> Reproduce:
>
> $ git clone https://github.com/cms-sw/cmsdist.git
> $ git branch -a | grep devel-gcc48
> remotes/origin/IB/CMSSW_7_0_X/devel-gcc48
> $ git checkout IB/CMSSW_7_0_X/devel-gcc48
> fatal: reference is not a tree: IB/CMSSW_7_0_X/devel-gcc48
>
> It has stopped to work with the last pull request. All the references on Google
> talk about submodules, which I don't use. Any ideas what could be causing this
> issue?

"Bad" naming. It interprets the branch name as something-gHEX like the
output from git-describe. Coincidently "cc48" is an umambiguous short
sha-1. check_tracking_name, which prefix "origin/" in, never has a
chance to run.

We should probably check in get_describe_name() that the returned
value is a commit or a tag, but that doesn't really solve the problem.
I think check_tracking_name should have higher priority than
get_describe_name()..
-- 
Duy
