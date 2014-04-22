From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 01:24:09 -0500
Message-ID: <53560b09bbe96_2400128531085@nysa.notmuch>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
 <20140422060120.GA10198@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUHy-0008Ok-0u
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbaDVGeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:34:36 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36380 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbaDVGed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:34:33 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so5159409oag.6
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=8WigICutX76qeZLhCqsGS0NPx0dsRlXBxkhKp00plJM=;
        b=rAaCjBlLMNDWHj7xhb88s1l7DqdyraCMoByB7lSUyGWRWG2XV0GV/dxGx+DhcwOEHl
         mSqxh3CcBFt9CValpZoNOGqooRvv3s2GXtORWl9dvecanbkHGG6M+Z2OQlrTHAW7zRyg
         j068eCsv+xhohOxIirGdxcjhsuWJ7cUNl/oIpCyHbTSkKiAocrE6xoTCxSwI8JWhSHM7
         n2HeCSOFUXHcp3tTBohyne/zFyUug1woSwdakZUEbnz3Y0MLP0B/g0Y6WwT3/ISpLePP
         AvuW/LfsExQ2nsoSUeeCNrbDSCxOR7NtHMm+DCOog2ATRxr2AbIkY3Kgf34+WprpaYNt
         OgxQ==
X-Received: by 10.182.38.199 with SMTP id i7mr100591obk.68.1398148472553;
        Mon, 21 Apr 2014 23:34:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm174163516oej.5.2014.04.21.23.34.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 23:34:31 -0700 (PDT)
In-Reply-To: <20140422060120.GA10198@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246699>

Charles Bailey wrote:
> On Mon, Apr 21, 2014 at 09:59:52PM -0700, David Aguilar wrote:
> > [Cc:ing Charles in case he has an opinion, this behavior dates back to the original MT]
> > 
> > On Sun, Apr 20, 2014 at 07:17:34PM -0500, Felipe Contreras wrote:
> > > It's annoying to see the prompt:
> > > 
> > >   Hit return to start merge resolution tool (foo):
> > > 
> > > Every time the user does 'git mergetool' even if the user already
> > > configured 'foo' as the wanted tool.
> > > 
> > > Display this prompt only when the user hasn't explicitly configured a
> > > tool.
> > 
> > I agree this is probably helpful.
> > Most users I've met end up configuring mergetool.prompt=false.
> 
> From my memory, the reason that we choose to prompt by default is to
> help new users or users who have just changed their choice of mergetool.
> 
> Because we never use the exit code of the tool to determine whether a
> tool "worked", if we don't prompt and the tool fails (bad custom
> command, requires X when no X available, etc.) then we'll repeatedly run
> the command for all paths requiring resolution leading to, potentially,
> a lot of trace with whatever error the tool might happen to report.
> 
> We prompt by default to give users a chance to abort the mergetool
> session at the first opportunity that they see that the configured tool
> is not working.

This is what I get when a tool is not working:

  Documentation/config.txt seems unchanged.
  Was the merge successful? [y/n]

> Personally, I leave mergetool.prompt unset (default true) because one
> extra click in a complex merge resolution is relatively low overhead and
> to catch myself when I forget that I'm in a no-X environment.
> 
> I glanced at the patch and it seems to subvert this intent for users
> who have  configured a merge tool. Is my understanding correct?

Yes, that's correct. If the user has *manually* configured a tool, why would
you ask him again? We are annoying the overwhelming the vast majority of users
who already configured the right tool in order to avoid issues with a minute
minority that might potentially but unlikely have a problem once or twice.

That's not productive.

-- 
Felipe Contreras
