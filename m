From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Tue, 23 Jun 2015 14:05:28 -0700
Message-ID: <xmqq1th2cezr.fsf@gitster.dls.corp.google.com>
References: <20150623105042.GA10888@peff.net>
	<20150623105411.GB12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:05:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7VNv-0005b0-A9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbbFWVFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 17:05:32 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35322 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbbFWVFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 17:05:30 -0400
Received: by igblr2 with SMTP id lr2so62624813igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5GHCm6rjzyFSKa5PTuj/XH6r0Wiy5+czdxKMz+9qkOM=;
        b=MiylkALiu8IGmcUV1/krR9jN16dQCehd7jH6jWDMrX8zmrgyh3GOI5tQ9OdKELTcvE
         o9ysZn0gDF3Aei2bsRcV2/rOTw0GKlnmBDEwqWdI7AfCEqmhOyEx9BLZCjiV8TM7ZcVc
         NV1I5Ho6cWsYNgHP71oCgpWZtlvmbNsJlbgxiLMT8DoAIdZYGBkCjEW94lr9U4FzBQP0
         asap6ygpK9ypw2dBb7DE+OikazgTbKXPIAZVFjjg8p0sKDxpNM3y1CDThNp1eT2M33a7
         B28sm3gcjJQUUZrzsp8fWR0hqGMOABGm1AIsF8/QtY5hDH/Lbdy+ZsCriPX9OSOjZgXY
         V44Q==
X-Received: by 10.107.156.140 with SMTP id f134mr46951675ioe.34.1435093529800;
        Tue, 23 Jun 2015 14:05:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id s28sm14485505ioi.31.2015.06.23.14.05.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 14:05:29 -0700 (PDT)
In-Reply-To: <20150623105411.GB12518@peff.net> (Jeff King's message of "Tue,
	23 Jun 2015 06:54:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272518>

Jeff King <peff@peff.net> writes:

>  This extension does not change git's behavior at all. It is useful only
>  for testing format-1 compatibility.
> +
> +`preciousObjects`
> +~~~~~~~~~~~~~~~~~
> +
> +When the config key `extensions.preciousObjects` is set to `true`,
> +objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
> +`git repack -d`).

OK.  In essense, the 'extension' on the disk is like 'capability' on
the wire, in that you are not supposed to ask for capability they do
not understand, and you are not supposed to touch a repository you
do not understand.

And the above looks like a reasonable sample "feature" to protect by
the 'extension' system.

> +	if (delete_redundant && repository_format_precious_objects)
> +		die("cannot repack in a precious-objects repo");

This message initially threw me off during my cursory reading, but
the code tells me that this is only about "repack -d".

Unfortunately the users do not get the chance to read the code;
perhaps s/cannot repack/& -d/; or something?
