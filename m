From: Matteo Bertini <naufraghi@develer.com>
Subject: Re: [PATCH/RFC 0/4] Add option to enable filters in git-svn
Date: Tue, 31 May 2016 22:34:46 +0200
Organization: Develer srl
Message-ID: <cb49a08e3ec44f7d37603e5b1fe20a22@develer.com>
References: <20160531150749.24840-1-naufraghi@develer.com>
 <33130d8be1ad6edaa75a75c43901a2fa@develer.com>
 <20160531181241.GA28818@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue May 31 22:34:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7qNM-0001Jv-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 22:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbcEaUew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 16:34:52 -0400
Received: from neo.develer.net ([2.228.72.10]:50469 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbcEaUev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 16:34:51 -0400
Received: from webmail.develer.com (neo.develer.net [IPv6:2001:b02:400:1::10])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id 1965C5E311E;
	Tue, 31 May 2016 22:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464726887;
	bh=jjI2ZEJaQnFXFRL/B3Fh2/+6+D95oZ5PZ6maoiOLa5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yo+8/VredhPqby9uzPCJfE3pdjwdiUF6gB42U3C184ef+S26ZV84Oajwj332d5odj
	 XajXgNXfVH/6FSMN2MVtiTexWkphrn/V3Lc1wRw3dvnwFT5alDfeLIsfBGOqsTD74g
	 TBVz6DkR+bt7cCR0vKanjdjhVj3w48QZNqTGP3ZI=
In-Reply-To: <20160531181241.GA28818@dcvr.yhbt.net>
X-Sender: naufraghi@develer.com
User-Agent: Roundcube Webmail/0.9.5
X-Remote-Browser: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:46.0)
 Gecko/20100101 Firefox/46.0
X-Originating-IP: 151.41.50.206
X-RoundCube-Server: 2.228.72.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296014>

Il 2016-05-31 20:12 Eric Wong ha scritto:
> Matteo Bertini <naufraghi@develer.com> wrote:
>> Sorry to all, but I missed a Checksum mismatch error, I'll have a
>> look and submit an update.

I've had a look, the problem is a missing smudge filter.
Unluckily the small svn revision range i was using was never updating
a filtered file.

The code actually uses `cat-file --batch` to get the blobs,
but the stored blob is not what SVN::TxDelta::apply need.
What I need is the smudged blob, but cat-file does not supports it.

I can modify cat-file with a new option to call 
`convert_to_working_tree`,
and have the filters applied, for example --use-filters, that expects an
extra field, like $sha\t$path, in the stdin stream.

I don't like a lot putting an high level feature in a low level command,
but --textconv seems very similar to this.

Opinions or other suggestions?

> Sure, when you reroll can you also ensure lines are wrapped at
> 80 cols or less? (at least for the git-svn code, but probably
> for the rest of it, too).

Sure

> As for the option name, the "enable" prefix doesn't seem
> right.  We already have some "use" prefixes (use-svm-props),
> so maybe "--use-filters" is better.

Ok

> I haven't looked into filters at all, yet, but you can probably
> use the existing rot13 filter in t0021 for writing tests.

Thanks for the pointer, I'll have a look.

-- 
Matteo Bertini - naufraghi@develer.com
Develer S.r.l. - http://www.develer.com/
.hardware .software .innovation
Tel.: +39 055 3986627 - ext.: 211
