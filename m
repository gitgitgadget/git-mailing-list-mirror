Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E8420189
	for <e@80x24.org>; Sun, 19 Jun 2016 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbcFSSNu (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:13:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751327AbcFSSNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:13:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7169724D1D;
	Sun, 19 Jun 2016 14:13:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rDHsVjuHNKhbVgSOT5I5ihA6ug=; b=kmnvnW
	tYx85cFtUUkna3YxSa2aD/mJOC7GhDfpz5cjArxqj0IYFTf+0E8HAD+5VwLMnkgf
	1j3mS2m2CgPxvaqVc/qSGBmcufwskQd9yqBL3dTqugbsS2DnS1Tt2T1l4f5eMnzs
	NOTFQosrZI2z2g5tdPPsQosjHH3jf8PxmUhbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eoXsc0eIVCWMCQm6OuTVSZ+dPxbmuofs
	Hf82g+H+Vzf4WEelq95MlJokNbqlRTYQhIF0aNR02aPV4gaSRN2L+CAa9FXVXZoy
	mQI5LCk/1+eLCmi9ymLZc6vkwPq4DmItIaw0bn+DKzxaGU5WtZ8BfIIGFIcOBMW1
	3F8EqLixvrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6845524D1C;
	Sun, 19 Jun 2016 14:13:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6FC124D1A;
	Sun, 19 Jun 2016 14:13:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
	<576650E7.70107@alum.mit.edu>
	<3E132EEE-CEBA-4C0D-A5C4-62F587A02225@gmail.com>
	<BC5163B8-7CF2-4106-9FBE-8CCD096252A2@gmail.com>
Date:	Sun, 19 Jun 2016 11:13:46 -0700
In-Reply-To: <BC5163B8-7CF2-4106-9FBE-8CCD096252A2@gmail.com> (Lars
	Schneider's message of "Sun, 19 Jun 2016 18:11:03 +0200")
Message-ID: <xmqqinx5vyg5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 914C3CF6-3649-11E6-BC25-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> This seems to fix the issue:
>
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
>          self.useClientSpec_from_options = False
>          self.clientSpecDirs = None
>          self.tempBranches = []
> -        self.tempBranchLocation = "git-p4-tmp"
> +        self.tempBranchLocation = "refs/heads/git-p4-tmp"
>          self.largeFileSystem = None
>  
>          if gitConfig('git-p4.largeFileSystem'):

Anywhere in refs/ would be OK, but don't you need to adjust the
test, too?

Even though I do not use git-p4, I'd imagine that I would be upset
if temporary refs that are used only during sync contaminated the
set of local branches I have, if I were a user of git-p4.  Would it
make sense to use "refs/git-p4-tmp" or something instead?


