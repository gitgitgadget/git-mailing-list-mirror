From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] contrib/subtree/t: Added tests for .gitsubtree
 support
Date: Fri, 15 Feb 2013 14:56:24 -0800
Message-ID: <20130215225624.GB21165@google.com>
References: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:57:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6UDO-0005hw-VN
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 23:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab3BOW4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 17:56:34 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:56124 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab3BOW4c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 17:56:32 -0500
Received: by mail-pa0-f50.google.com with SMTP id fa11so1976979pad.9
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IKiVT8W8dHcr7M30uQGO7EjlI+17+STmfGmI9bATeUg=;
        b=x4rXaGwihdMyJENDAet9Uk7Jpx176e+lZ5Rb2KPRVrTV0dWdGEJhqhLtpCKbWVhL93
         FbhMPHwJ5fi7HT76pv6kOOBDDt9L5pfenpMfvR6numI+0yt9ixVte81nFzXnqcok/k8V
         DJr3QRZmWwwHXNgixyNDmCllTRb/IXve12WNFw8R3DZ1qO+L0xjJ/eqOB+PQwi5/mSm4
         BbSXMk4jiboyVRcA6WYXLc4pFVrIFo5PVPoJ6GzbesE8drO9vDrH2nD5kLNU+MRDBgce
         xjTr2K1Vi5lYH6Oqo/gjQBLMbvw9PkOAaDOwhOIAofatv7RdSLHbC2E0QqzbGKvusaJG
         wuWw==
X-Received: by 10.68.232.69 with SMTP id tm5mr9677714pbc.150.1360968992409;
        Fri, 15 Feb 2013 14:56:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id hu2sm5982915pbc.38.2013.02.15.14.56.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 14:56:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216362>

Hi Paul,

Paul Campbell wrote:

> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -465,4 +465,34 @@ test_expect_success 'verify one file change per commit' '
[...]
> +test_expect_success 'change in subtree is pushed okay' '
> +        cd copy0 && create new_file && git commit -m"Added new_file" &&
> +        cd .. && git subtree push --prefix=copy0 2>&1 | \

If it possible to restrict the chdirs to subshells, that can make the
test more resiliant to early failures without breaking later tests.

That is:

	(
		cd copy0 &&
		create new_file &&
		test_tick &&
		git commit -m "add new_file"
	) &&
	git subtree push --prefix=copy0 >output 2>&1 &&
	grep "..." output

> +                grep "^\s\{3\}[0-9a-f]\{7\}\.\.[0-9a-f]\{7\}\s\s[0-9a-f]\{40\}\s->\ssub1$"

This might not be portable if I understand
Documentation/CodingGuidelines correctly.

[...]
> +        (grep "^copy3 . sub2$" .gitsubtree && die || true) &&

	! grep "^copy3 . sub2\$" .gitsubtree &&

Hope that helps,
Jonathan
