From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Mon, 17 Nov 2014 18:51:31 -0800
Message-ID: <20141118025131.GH4336@google.com>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
 <20141118023112.GA14034@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 03:51:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqYtE-0008NU-U9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbaKRCvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:51:31 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:56033 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbaKRCva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:51:30 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so3760161ieb.9
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bx34r1FV8A5ycTFyqXtzKHCgch/hr9ZaCQOT0X9xM+Y=;
        b=gkq9KFRaMDumCvDxyWrJlWC80BfI2J6pHOaNeNy/uoH/ILQuHKUh07lWOcr1WWcufC
         3kAse8SwuQAfChnViB4e9O61YdYMUYUVjhyLr0/oezlIPrqZuRKWzLlH7iHwpe8yQj/S
         AiazYMBsOLW62cA0hNm/UcPRMFWuNRI0tFWxu1jDYZXCqxTeMtNx1BhTTCU0GRLvBMCd
         +WoaG1bhWXf7k4q0HgAPbq3wNjj5Rp16zofJeDgPvq/ljLO5EqvaPtLlX/ivrgIfgTpP
         pQRiv/Mi5o61Bg9iNuX3NrIhhbwLBvMrrns0JdbbnUd1yXg3f85ziOfOKXnSa0CWZ6HW
         SK1A==
X-Received: by 10.107.150.9 with SMTP id y9mr9716535iod.25.1416279089951;
        Mon, 17 Nov 2014 18:51:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id o70sm4887709ioe.20.2014.11.17.18.51.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:51:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118023112.GA14034@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote:
> On Mon, Nov 17, 2014 at 05:40:28PM -0800, Jonathan Nieder wrote:

>> How did you get that "Not a blob" message?
>
> When trying to *create* a tree with a commit in it, so instead of giving
> the mark for a blob to a filemodify command, giving a mark for a commit.
> That is what fails with "Not a blob".

Ah, I see what you were trying now.  It's complaining that the data
and mode don't match up.  See <mode> under 'filemodify' in the manual.

Something like

	M 160000 :1 mycommit

should work fine, though that's a pretty ugly workaround for the
inability to do

	ls :1

[...]
>> I think a good fix would be to teach parse_ls a mode with no <path>
>> parameter.  Something like this (untested; needs cleanup and tests):
>
> This would make both your commands output the same thing, right? It
> wouldn't help my case :)

It's easily possible my patch has a typo somewhere, but the expected
output format would be

	commit 6066a7eac4b2bcdb86971783b583e4e408b32e81

That wouldn't help?

Puzzled,
Jonathan
