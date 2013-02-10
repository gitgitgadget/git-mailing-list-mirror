From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sat, 9 Feb 2013 20:06:21 -0800
Message-ID: <20130210040621.GA8584@elie.Belkin>
References: <1359901085.24730.11.camel@t520>
 <510E8F82.9050306@gmail.com>
 <1359915086.24730.19.camel@t520>
 <510F03FC.6080501@gmail.com>
 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
 <1360425499.3369.10.camel@t520>
 <7vehgpum7n.fsf@alter.siamese.dyndns.org>
 <7vpq08u903.fsf@alter.siamese.dyndns.org>
 <1360468628.6610.5.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4OC8-0000xV-DL
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 05:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761048Ab3BJEGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 23:06:36 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59356 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761016Ab3BJEGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 23:06:35 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so2643093pab.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 20:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=axFUPrOMpxOXgEpNZ1fhndwlvjS4NsS/wZsGL0meIJ0=;
        b=XLd9ys1VEf4Fd6bKr5E4wpCBj1Heechl2Tc2nfJZR9/jrEL/gpADPZimyxJTToFPAS
         CSBjrGH23OyJ8U0O+mNDAVtI9FAvYXIz7X+CuPLyrU34JcPkJzWaxwbg9Ax0AYnWz6v9
         Uep58i3IOYcOQGXxcUnqRa4f09P+r+4OIzTmpveZrpu2j9oX1TjV7x8oGYsrYwCUID9Z
         qabL1KntiNN6Y4U6yJIjiWW3w74j7XRYrcMyQ9HRU2bPfXqPHSL3MoI1NXPRM8aO09x9
         NCn+MXR6Gk5EIJ0vDuEOLKdFzwi2QPHIPG4nTc5fvhxfbcbGDVHqlK9JrRr/KoD64sQd
         x0oQ==
X-Received: by 10.68.197.131 with SMTP id iu3mr7945581pbc.72.1360469194943;
        Sat, 09 Feb 2013 20:06:34 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ge5sm3320583pbc.45.2013.02.09.20.06.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 20:06:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360468628.6610.5.camel@t520>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215894>

Hi Robert,

Robert Clausecker wrote:

> There are two things git archive is missing that are needed in my use
> case:
>
> First, git archive in combination with tar won't remove unneeded files.
> You have to run rm -rf before manually which brings me to the next
> point; git archive can't really make incremental updates.

My advice is to keep a separate index file for your exported files.
Like this:

	GIT_DIR=$(readlink -f $(git rev-parse --git-dir))
	GIT_INDEX_FILE=$GIT_DIR/index-for-deployment
	export GIT_DIR GIT_INDEX_FILE

	cd $dest
	git read-tree -m -u <tree>

Hope that helps,
Jonathan
