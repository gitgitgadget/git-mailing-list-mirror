From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] contrib/subtree/t: Added tests for .gitsubtree
 support
Date: Sun, 17 Feb 2013 16:35:26 -0800
Message-ID: <20130218003526.GA3221@elie.Belkin>
References: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
 <20130215225624.GB21165@google.com>
 <CALeLG_nLz9Gfqcfk4EcWixRXbWC0x0GUVFDAKD20DGbkhRNWvQ@mail.gmail.com>
 <20130217113723.GA9882@elie.Belkin>
 <CALeLG_n-WocsMTvRZHm6v-+wrCNVvCh6O2baVDALSE3JB8ibng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:36:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EiF-0006cc-BN
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab3BRAfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:35:36 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:36914 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab3BRAff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:35:35 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so2169112dak.25
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4uND7Gi8B4vv47YPn9hCuiFMQZNu89Z9sHCX02AmVeM=;
        b=ZY4VZIzxRfUVcnVGWCrjTJKYQ9i0mwFShF4A5uoC2zqO5sFS1s3CTFF5vh4otyYvkM
         5k1F2+ORxHE+WsHrIHs74zwY9QfAHOV+wk020wZRAYMqW6NToKhhpf/GQzqHk+JpZkmm
         U6I/oxxfx6lqjUlRSJTdybAPTJehwiQYCnOpVAYQHEDDySxzr9CqHJwCLy5gA3GI9iR+
         gdX68R0i7xQ/ZRB6168I32/bQKGtXexV95MpljaCkYPaeuiiTBnJ3I6N2B7B68YUx3fw
         Q4ulAiLiHsdTM3NGrTgwyKd0xt9a9i5lR9zjlOYBDBnjRI7WQ+EcuA3Le2v0vUNtUoi1
         4r5Q==
X-Received: by 10.66.79.135 with SMTP id j7mr31604998pax.0.1361147734908;
        Sun, 17 Feb 2013 16:35:34 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ww9sm12473639pbc.41.2013.02.17.16.35.32
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 16:35:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALeLG_n-WocsMTvRZHm6v-+wrCNVvCh6O2baVDALSE3JB8ibng@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216422>

Paul Campbell wrote:

> Here's the updated version of the tests:

Just a few more nits:

> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -465,4 +465,37 @@ test_expect_success 'verify one file change per commit' '
[...]
> +test_expect_success 'change in subtree is pushed okay' '
> +	(cd copy0 && create new_file && git commit -m"Added new_file") &&

Style: this would be easier to read with each command on a separate
line, like so:

	(
		cd copy0 &&
		create new_file &&
		test_tick &&
		git commit -m "Add new_file"
	) &&

[...]
> +test_expect_success 'pull into subtree okay' '
> +	git subtree add --prefix=copy1 sub1 &&
> +	git subtree add --prefix=copy2 sub1 &&
> +	(cd copy1 && create new_file_in_copy1 && git commit -m"Added new_file_in_copy1") &&

Likewise (and as a nice side-benefit, it would avoid a long line that
mailers like to wrap).

> +	git subtree push --prefix=copy1 &&
> +	git subtree pull --prefix=copy2 | grep "^ create mode 100644 copy2/new_file_in_copy1$"

Likewise.  More importantly, this forgets the exit status from "git
subtree pull", so if it were to segfault after writing appropriate
output, the test wouldn't notice.  How about:

	git subtree pull --prefix=copy2 >output &&
	grep "^ create mode 100644 copy2/new_file_in_copy1\$" output

Thanks,
Jonathan
