From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Check revision and if no files modified (looking for svnversion
 equivalent)
Date: Sun, 9 Oct 2011 13:10:40 -0500
Message-ID: <20111009181040.GA31303@elie.hsd1.il.comcast.net>
References: <20111009162902.GA3000@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "fkater@googlemail.com" <fkater@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 20:11:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCxq8-0006wO-5W
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab1JISK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 14:10:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40684 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab1JISK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 14:10:57 -0400
Received: by gyg10 with SMTP id 10so4774346gyg.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nC0fRIrTnwPZCrD7O5WWYzxZorPe4/tjWrO78k3xCIg=;
        b=xFYIxyUMsTIe5JCGFff27wLRSKAI5gNJl83+MFuI/OFm71xNdoLn8HwlFbAsfppKsc
         3dtf1I7JzNm55fdsyXn/fSxdcWAtcXjmFPNc54b5i5/QyrWEDw4js0f/nz9DVf+BffeZ
         IKCR+NOqRs4INc6e2jyWYn8sk2vLd1/j3ZJ7I=
Received: by 10.236.180.168 with SMTP id j28mr19890935yhm.15.1318183856652;
        Sun, 09 Oct 2011 11:10:56 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x12sm22328881yhi.10.2011.10.09.11.10.55
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 11:10:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111009162902.GA3000@comppasch2>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183207>

fkater@googlemail.com wrote:

> - get the last revision (e.g. r1001)
> - check for modified files not yet checked in (e.g. r1001 M)

"git describe --dirty", maybe.  Thanks to Jean Privat for inventing
it.

> Both information is required for the application's build
> process (Makefiles):
>
> - to display the version in the application
> - to refuse to build a proper 'release' version if something
>   was not checked in

Ok, this seems like two different needs.

- For the former, see GIT-VERSION-GEN in git.git for inspiration.
- For the latter, I'd recommend something like

	git update-index -q --refresh &&
	git diff-index --quiet HEAD ||
	{
		echo >&2 fail
		exit 1
	}

Hope that helps,
Jonathan
