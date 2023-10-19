Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5E1DFFC
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692B3A94
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:07:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C181B1F38C
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:07:29 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 834452C52D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:07:29 +0000 (UTC)
Date: Thu, 19 Oct 2023 14:07:28 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: git@vger.kernel.org
Subject: Re: pygit2 claims repository does not exist on
 GIT_DIR_INVALID_OWNERSHIP
Message-ID: <20231019120728.GV6241@kitsune.suse.cz>
References: <20231019093344.GS6241@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019093344.GS6241@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-0.69 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[git@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_ONE(0.00)[1];
	 DMARC_NA(0.20)[suse.de];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-1.18)[88.99%]
X-Spam-Score: -0.69
X-Rspamd-Queue-Id: C181B1F38C

On Thu, Oct 19, 2023 at 11:33:44AM +0200, Michal Suchánek wrote:
> Hello,
> 
> after upgrade from git 2.26 to git 2.35 pygit would claim that my
> repository does not exist:
> 
> :~> git ls-remote /srv/git/kernel-source.git | head -n3
> 41037b9c54949ab7df9d32e8bc753c059b27c66c        HEAD
> 7a68c4c0c640ac07b89722271f866287b9047459        refs/heads/ALP-current
> 4993d1b0a96a0fa7fb0e87d3b1725bc775162283        refs/heads/ALP-current-RT
> :~> python3
> Python 3.6.15 (default, Sep 23 2021, 15:41:43) [GCC] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import pygit2
> >>> pygit2.Repository("/srv/git/kernel-source.git")
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "/usr/lib64/python3.6/site-packages/pygit2/repository.py", line 1498, in __init__
>     path_backend = init_file_backend(path, flags)
> _pygit2.GitError: Repository not found at /srv/git/kernel-source.git
> >>> 
> 
> Could a reasonable diagnostic be provided?

It turns out that I have relatively recent python3-pygit2 but it's
linked against ancient libgit2 causing this error.

Rebuilding python3-pygit2 fixes the problem.

Sorry about the noise.

Thanks

Michal
