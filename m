From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too
 early
Date: Mon, 28 Jun 2010 05:13:35 -0500
Message-ID: <20100628101335.GA5007@burratino>
References: <20100626192203.GA19973@burratino>
 <20100628094033.GA18629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 12:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTBLl-0000Po-22
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 12:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab0F1KN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 06:13:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40876 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0F1KN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 06:13:57 -0400
Received: by mail-iw0-f174.google.com with SMTP id 39so36864iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=00IjiWqY5FodMYZ8LXQjGLAfdy/XF9U/gtTnop3N9tM=;
        b=Q9vUgJQI7zsJQ37vTDRn8T69w4l6Uz8KUUovpQ0gZb1Q3fqmtp/pDSns0Ht+TQLhue
         RMPKaVTzviXuEarI+uXUkrrAkCIpAt3qXHhaHyaRsnKoBcMnGGml3giKOeCxjN9ljNd6
         igjuE9Y2P8wep7SbB5OGUPMixKK2J3IR/0U+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EUdb5u48C1yg05bw1DmsOCB+yJ8/4ctmgB/+nTiPLJp6Po13gIMNTBFtOVxnbNNi5n
         JFT3W3qnePCFIeGr8YO7AVhiJ7M55OpTk3ymttY8aNmjAIe8wD5f9fjskrq+g0deonUA
         7YA3JE7bMnqUjzvz07YAqs7NPeLXyRb++peq8=
Received: by 10.231.39.196 with SMTP id h4mr1684399ibe.64.1277720036193;
        Mon, 28 Jun 2010 03:13:56 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm9852655ibk.7.2010.06.28.03.13.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 03:13:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100628094033.GA18629@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149827>

Jeff King wrote:

> But reading the message for patch 4/4, I can't help but wonder if the
> right way forward is for the git wrapper to _always_ find the reposit=
ory
> as the very first thing.
[...]
> the worst case should be a little bit of
> wasted effort.

This is a very useful thought.  Git without the chdir() to toplevel
would be pleasanter, I think.  (Yes, I realize you weren=E2=80=99t nece=
ssarily
suggesting suppressing a chdir_to_toplevel() in place of
setup_git_repository() and friends.)

Regarding the repository search: automounters can cause pain if
DISCOVERY_ACROSS_FILESYSTEM is set and GIT_CEILING_DIRECTORIES is not
set appropriately.  An important script that does

  tmpdir=3D$(mktemp -d)
  cd "$tmpdir"
  ...

  git diff --no-index a b
  ...

could hang indefinitely if some nut has created a named pipe at
/tmp/.git.  I haven=E2=80=99t come up with any non far-fetched reason t=
o mind
the repository search, though.

Will think about this.
