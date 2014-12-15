From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: remote helper example with push/fetch capabilities
Date: Mon, 15 Dec 2014 12:47:40 -0800
Message-ID: <20141215204740.GI29365@google.com>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Klein W <wineklein@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 21:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0cYV-0000hO-Gx
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 21:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbaLOUro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 15:47:44 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36805 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaLOUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 15:47:43 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so6626051igi.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 12:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xW0CGzeGKOGe3I8B9La3j2Kxvr7xo6K5Tyy9KXqxgAU=;
        b=FEezfQV9A2SZRXtFGrGtYD/dmF01XITlMCnaGOOZJoKsb0oMGena5R92LUwf4DrQ9V
         hoYYNTqkZgqD1I6qClpfHaJ1ZR+n5RkfjOn0SnPSyHCjqqiayKL1xTzMk8uItLnHNLt9
         lqzQUDubyPoG84FJAgSIAAWEUsv3HLCEuE5hLCLzS86h6ND9i85S5ddBDcA+EZ7vLEMT
         4u75bvyA+DlRfQIzFUQ4AhWMd94zHtRG/mYewy+qZhYnb+ROZSPGTki3JEnV5HYqBJI1
         p6wKQD+7/d0pnXn6STVB2EgzMQ5qV9PtPS3A4l2Yw8We0aBlDFngCTnoQF3Q2gEkV68+
         LSmg==
X-Received: by 10.50.30.33 with SMTP id p1mr20121082igh.22.1418676462753;
        Mon, 15 Dec 2014 12:47:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f581:e7a2:ee7:8026])
        by mx.google.com with ESMTPSA id p198sm5188805iop.36.2014.12.15.12.47.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 12:47:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261421>

Hi,

Klein W wrote:

> Is there any example of a remote helper [0] with push and fetch capabilities?

Sure --- see remote-curl.c.

There's also the "connect" capability.  builtin/remote-ext.c and
builtin/remote-fd.c are examples using that one.

[...]
> Also, what are the advantages and disadvantages of a remote helper
> with push/fetch capabilities vs a remote helper with import/export
> capabilities?

It mainly has to do with what it is convenient for your helper to
produce.  If the helper would find it more convenient to write native
git objects (for example because the remote server speaks a
git-specific protocol, as in the case of remote-curl.c) then the
"fetch" capability will be more convenient.  If the helper wants to
make a batch of new objects then a fast-import stream can be a
convenient way to do this and the "import" capability takes care of
running fast-import to take care of that.

Thanks and hope that helps,
Jonathan
