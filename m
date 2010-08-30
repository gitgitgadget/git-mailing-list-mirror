From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/13] transport-helper: implement marks location as
 capability
Date: Sun, 29 Aug 2010 20:31:56 -0500
Message-ID: <20100830013156.GD2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-11-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 03:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptFt-00059s-Mr
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0H3Bdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 21:33:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35431 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab0H3Bdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 21:33:40 -0400
Received: by ywh1 with SMTP id 1so1483771ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/klnFOD6nfhpXnfdAkPwsy5AwEpEJaMHlctcu8qcKb4=;
        b=MF+4OboDkbaTDsyFS9GrVt9RowSdkEOk4I9TOJ684OtxATBilCxdAic5ZdSpFq1xRd
         xhgCqOMvHcUBtdQne7iklLLwEiB5JbMjILKmjipHBd/tEu/v1XxaHGBD65CC8Ks4CjQf
         mock86Im2JAFzPQshYSV4OZWXZciFFKA4O+Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XFKJ+X6c733KK3yvr8ZeF9ILFu/4rfI9bgCKfAFAbrab1LZcI+WtWNBA5hy1ZOCCox
         eG5QNBFO8D+U9cVde9YcRLeottaNmBBY1osYVaK4GeI510tS/HRVB00L7Nux1uV8rads
         yON06k1DXeq+MA5qGaSEbIR6/E+ul2DOzIkxY=
Received: by 10.100.31.15 with SMTP id e15mr3787034ane.119.1283132020018;
        Sun, 29 Aug 2010 18:33:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm11631487ann.7.2010.08.29.18.33.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 18:33:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-11-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154739>

Sverre Rabbelier wrote:

> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -71,8 +71,24 @@ def do_capabilities(repo, args):
>      print "import"
>      print "export"
>      print "gitdir"
> +
> +    sys.stdout.flush()
> +    if not read_one_line(repo):
> +        die("Expected gitdir, got empty line")

This seems fragile to me: shouldn't the remote helper check somehow
that the line it read was actually a gitdir line?

No other complaint on my part.  Requiring a flush seems entirely
appropriate to me, and if someone comes up with something nicer than
the "capabilities" sequence for requesting information, it would not
be the end of the world to have two ways to discover the .git dir.
