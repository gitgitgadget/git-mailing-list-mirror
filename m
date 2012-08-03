From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC remote-svn: branch detection
Date: Fri, 3 Aug 2012 11:17:28 -0700
Message-ID: <20120803181728.GA21745@copier>
References: <12682331.q6WHVv9EKU@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 20:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxMRT-0006AM-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 20:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab2HCSRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 14:17:38 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36013 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab2HCSRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 14:17:37 -0400
Received: by ghrr11 with SMTP id r11so1168894ghr.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZG+8KIyNiOk3p7sH2G00u3xUwQ4sfqy+5LWOHBs3K+E=;
        b=G58EVRk5mbD6nGOTsPQvPVXC3ipZF0qyj2nUKdDRmsX6EPGJ7kxIPLiEDj9oCErIMF
         JURD35LM4XJ8KrkXjrPBHa/ttaWM8OgVK6tOCcXE/3CVGyy/mLUGUQ36YdcSSmBn63rF
         KrmZPVLg8xBR6WkfsyoJ9lLFDOAJ2o62Z21BhoIf3muaWGP4gEXepMk9/Squ7Q/emhYK
         zVl7dSIT1GaXyGPiLA69JvjYUcug9/q1Imtq77wNx5Ugp7sfBlRtsbN5PAA9SKw8OFxZ
         48ipvbshSWoLOIOWAxmTy3QioGm7L+krEcJzLSZ7N1GltnCtN+Zk0juFNxsVD/jcrrIy
         vu4A==
Received: by 10.43.43.194 with SMTP id ud2mr4022094icb.13.1344017856675;
        Fri, 03 Aug 2012 11:17:36 -0700 (PDT)
Received: from copier (cl-711.phx-01.us.sixxs.net. [2001:1938:81:2c6::2])
        by mx.google.com with ESMTPS id aj7sm23201087igc.16.2012.08.03.11.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 11:17:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <12682331.q6WHVv9EKU@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202846>

Hi,

Florian Achleitner wrote:

> Two approaches:
> 1. Import linearly and split later:
> One idea is to import from svn linearly, i.e. one revision on top of it's 
> predecessor, like now, and detect and split branches afterwards. The svn 
> metadata is stored in git notes, so the required information would be 
> available.
> + allows recovery, because the linear history is always here.
> + it's easier to peek around in the git history than in the svn dump during 
> import to do the branch detection.
> - requires creation of new commits in the branch detection stage.
> - this results in double commits and awkward history, linear vs. branched.

I don't think you've captured the real pros and cons here.

+ Divides responsibility between a component that fetches and a component
that splits branches, making for easier debugging, independent refactoring
of components, reuse in other contexts (e.g., splitting out branches in
other similar VCSen, etc)

- Divides responsibility between a component that fetches and a component
that splits branches, which is tricky because it involves designing an
interface between them and documenting it.  And maybe a different
interface would be better.

There are also performance and history-clarity ramifications as you've
mentioned, but they do not seem as important.

Hope that helps,
Jonathan

> 2. Split during import:
