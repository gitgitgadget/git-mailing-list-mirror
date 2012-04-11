From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] completion: Use parse-options raw output for simple
 long options
Date: Wed, 11 Apr 2012 08:09:24 -0500
Message-ID: <20120411130924.GD3161@burratino>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
 <1334140165-24958-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, szeder@ira.uka.de,
	felipe.contreras@gmail.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHxIr-0008K7-09
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 15:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760149Ab2DKNJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 09:09:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46672 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab2DKNJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 09:09:36 -0400
Received: by iagz16 with SMTP id z16so1257397iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0Semxb4eLBvADV2Yr0auPiDOS+iiG7fdCR7S48BncqI=;
        b=HSylvVKEcwjQntQxCDL7lbyI5l5LRsnJD4iXdxyCvVPDFN2pDh47XCzUa0otk4tALs
         Fm/6Jo06lAUrpvFLGrxW8jlOcFhxUXOR+q8a6gaN/MIyBtoMAXS2vp4UXCGpHTtZ1akp
         F9ppvCFM33PFXwQwwZ4CopG9v1SfHZ3UxzWttWG4x/Wo7+DiO4BJkIfioPuWksXlevGG
         tGqItmUfdkBIzg5Bwn3rRvWvR/wyeXIyt0J6cf3U7ujKpwex4diGRewBRZmFG/rs6UDV
         aPMzYmq21nel/y+f4SiRPti2oHrJPL+boNUMxKDkS2tgYCNu8L6oIVUps76S3i9lqP6s
         PVjw==
Received: by 10.50.95.167 with SMTP id dl7mr2373976igb.6.1334149775664;
        Wed, 11 Apr 2012 06:09:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id re5sm25075190igb.0.2012.04.11.06.09.30
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 06:09:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334140165-24958-3-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195179>

Stephen Boyd wrote:

> Is there some way to compute these lists with some magical function instead
> of duplicating that logic over and over?

Maybe roughly like this.

	for command in $porcelain
	do
		eval "__git_${command//-/_}_options="
	done
	__git_complete_for_command ()
	{
		local options
		local options_var="__git_${command//-/_}_options"

		eval "options=\$$options_var"
		if test -z "$options"
		then
			eval "$options_var=\$(__git_list_command_options \$command)"
			eval "options=\$$options_var"
		fi

		...
	}

	_git () {
		...
		__git_complete_for_command "$command"
	}

Jonathan
