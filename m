From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 3/3] cat-file: add --follow-symlinks to --batch
Date: Mon, 11 May 2015 13:03:39 -0400
Organization: Twitter
Message-ID: <1431363819.15048.2.camel@ubuntu>
References: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
	 <1431203769-11855-3-git-send-email-dturner@twopensource.com>
	 <554F0378.2070803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 11 19:03:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrr7M-0005DG-SL
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbEKRDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:03:43 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36365 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbEKRDm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:03:42 -0400
Received: by qcbgy10 with SMTP id gy10so72171290qcb.3
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=A1COfYAM/hUXhN/zfm8LkoaDKuDEO7oWD2vOLNvfbv0=;
        b=W/3pKIOIojFfyvwRexCnUkngsDePzzTYrR0698pldP78+C5nfMtdOeiC/Lz08KtQst
         iEsx4IFAaD0UF04NUGh2X9z5Uhree+PD+Q4M33cc9rmXjR1n55iEJoZWozcmAN8TPzTt
         6W3QiYDrTD6EmJ6sHOGyrbvvEf81zynWyacpwwK6/21Gf9tZi1sEMHGms/jASVTjq1yo
         /3/wQXmec++QunPeoFyCLrV68XscVkwPSKSbyEVW3P12JANeJYOQf2jwymndisL20Nx7
         AaIYLUn3JFQa8+uJfo+T1AkGKoonBE2sewBmmqH/LSKIWZVQLAIj9/skBfbIGfbbXC09
         c1MA==
X-Gm-Message-State: ALoCoQmKdEba1KrZZqhRo846U2LytTy3rbmQxt05dYo+q4UsCP7ZnfxzdWRopo7tsvpu46NkKuVY
X-Received: by 10.55.52.129 with SMTP id b123mr24382534qka.34.1431363821709;
        Mon, 11 May 2015 10:03:41 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id 97sm10943820qkp.39.2015.05.11.10.03.40
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 10:03:40 -0700 (PDT)
In-Reply-To: <554F0378.2070803@kdbg.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268798>

On Sun, 2015-05-10 at 09:06 +0200, Johannes Sixt wrote:
> > +	ln -s loop2 loop1 &&
> > +	git add . &&
> > +	git commit -am "test"
> > +'
> 
> These tests will fail on a file system that does not support symbolic 
> links, such as on Windows. Would you please separate the test cases 
> (that come after the setup) into two groups:
> 
> 1. Those that inspect the filesystem and expect a symbolic link. Protect 
> these tests with a SYMLINKS prerequisite.

I believe that none of these require that.

> Note that you do not require a symlink enabled file system to generate a 
> repository with symlinks, i.e., you don't have to protect the setup code 
> with SYMLINKS. For this, you can use 'test_ln_s_add' instead of the 
> above sequence of 'ln -s' followed by a single 'git add .'.

Will fix, thanks.

> > +
> > +echo $hello_sha1 blob $hello_size > found
> 
> This seems to be used only in the next test. Please move it inside 
> test_expect_success.

This is used in a number of tests, e.g this one:

> > +test_expect_success 'git cat-file --batch-check --follow-symlinks works for in-repo, same-dir links' '
> > +	echo HEAD:same-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
> > +	test_cmp found actual
> > +'
