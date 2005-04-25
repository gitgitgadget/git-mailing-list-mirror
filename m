From: Morten Welinder <mwelinder@gmail.com>
Subject: unpack_sha1_file issues
Date: Sun, 24 Apr 2005 22:01:38 -0400
Message-ID: <118833cc05042419012f425f0d@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 25 03:57:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsq9-00075A-1m
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVDYCBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 22:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVDYCBk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 22:01:40 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:42091 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262426AbVDYCBi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 22:01:38 -0400
Received: by rproxy.gmail.com with SMTP id a41so834232rng
        for <git@vger.kernel.org>; Sun, 24 Apr 2005 19:01:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sTG8BFNAVMdydBp1XGpepIXqXC9E0CToXcUpNqrJdcF6D8YEno/b5CIB3CUAKS4cP/0whQtmzxDVYrZQIlf4dW2vsbyfMaeCQ9CfA8KBljj2i8aha84PwluYRFCV0xCLXoQtcguHFwdQW/OB5x++HXb2o+E6FNoXwrzQdiUZE8s=
Received: by 10.38.86.49 with SMTP id j49mr3451888rnb;
        Sun, 24 Apr 2005 19:01:38 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sun, 24 Apr 2005 19:01:38 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

unpack_sha1_file is being called by fsck-cache.  Therefore it should
not assume that
a \0 occurs within the first 8192 bytes of the uncompressed data. 
However, currently
both the sscanf and strlen calls do just that.

Also, unpack_sha1_file should call inflateEnd in a couple of the error cases.

Finally, if *size==0, shouldn't unpack_sha1_file allocate a single
byte to prevent
malloc from returning NULL?

Morten
