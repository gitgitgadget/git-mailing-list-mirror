Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B161020C11
	for <e@80x24.org>; Wed,  6 Dec 2017 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdLFVVE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:21:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:54784 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbdLFVVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:21:03 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlXnX-1exwok0a3z-00bLpC; Wed, 06
 Dec 2017 22:21:01 +0100
Date:   Wed, 6 Dec 2017 22:20:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] pathspec: only match across submodule boundaries when
 requested
In-Reply-To: <20171205000734.69530-1-bmwill@google.com>
Message-ID: <alpine.DEB.2.21.1.1712062220380.98586@virtualbox>
References: <20171128232237.54453-1-bmwill@google.com> <20171205000734.69530-1-bmwill@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:I/XDx57v957/XhE0Ugv5fJf9SwxnpjumDvjO3fO9xCRc74a+5vg
 52rB+P/ThfjWh6OBVagpvnJkOQf46TWFbMkQugrayjkssD5neY0SNPfSsjS+YIHx+VCB80r
 oaj61PqMlUOJc1p7SKoa+7g9rKSq9bjoINq07ViXLPM7cgwNV4/8xM2w2S7r/iezc7nMoe0
 LnUVgR/jXItYNn0HROnZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h+E0KgmNuGI=:XNdXqWB8GzAZD9sHq5A3MY
 8Yp9GnoH0aQVFtCCcYWihoZ6tUR2PkLJlWMszHTUSC+OoCz9Rs+V9EsyUSLtwf4+UJkICZlut
 agqsZ6W3rcNlpwZ0+10JCoaYtNFavNsotHYiyuE+luni2ESE4HKjdHMaGo6oH0xsDa/3WgEms
 800A+UIg5FR4+Yv7EhSfoH0X1tavkkEZMqE9vosxGhxIsLnzOIqDERFAXSda9LhLI099wysjv
 9IgFAxjXaMnySDUlwCebfva/tpu+WbgBxh0xeEOq+fEa6lzLd6smjMR2UjLIWHVoSHYvuxDda
 auXrh8HcNrBxxGK6bQgQae+0mf/jO0mvkT8Ef5LdC1+LJyrxiq/V6FW+/M3SOnl+80PTkOKOU
 NiCsd3LY7pjv7WDoffg8EgptgNWH0qNuzbzF1zvGi8bF6LlLICRrSped3dNbJupOEkTdr7Lg2
 BjnOMIQ86ZJxaS+HvW/IVS0s/IQM1JpLAwZrdMdHKGLldWeh8Pt39ZUOKuQ9OQBM+METXtcjy
 JBEXt/l+3d+HaEBy0IuYQ+UW5HVUFfy25mpJ90SxYb/907aRGHD/8VtSRkbAb+q9UJDfWEmX7
 fLTj9FDmNKfVOgzvUBPnukX/SaAhh9mWbKXpCSUx3s4MPXjcrItdrWcIg+yNY5U+ob5dHeOpA
 rKs6F4i/xAielNTkopSen+59vkihHsNk2F82heAQmNIeZVUkWT4fXSsqY21ChNu60cIHf34EZ
 AfpWLNYVUqBRocAdy8SdhTOOurYtuvUVuVCwpvuTPHEUVFaUyXiYii8yEA0365XMbNEu4Xc6M
 RA/oyfZXZu3FWHuWAJ6qw/TVlkMIpmYVAOGwffZhDQXl0jfbIp9/7hSYe8wUoE9LBDVvBds
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Mon, 4 Dec 2017, Brandon Williams wrote:

> Commit 74ed43711fd (grep: enable recurse-submodules to work on <tree>
> objects, 2016-12-16) taught 'tree_entry_interesting()' to be able to
> match across submodule boundaries in the presence of wildcards.  This is
> done by performing literal matching up to the first wildcard and then
> punting to the submodule itself to perform more accurate pattern
> matching.  Instead of introducing a new flag to request this behavior,
> commit 74ed43711fd overloaded the already existing 'recursive' flag in
> 'struct pathspec' to request this behavior.
> 
> This leads to a bug where whenever any other caller has the 'recursive'
> flag set as well as a pathspec with wildcards that all submodules will
> be indicated as matches.  One simple example of this is:
> 
> 	git init repo
> 	cd repo
> 
> 	git init submodule
> 	git -C submodule commit -m initial --allow-empty
> 
> 	touch "[bracket]"
> 	git add "[bracket]"
> 	git commit -m bracket
> 	git add submodule
> 	git commit -m submodule
> 
> 	git rev-list HEAD -- "[bracket]"
> 
> Fix this by introducing the new flag 'recurse_submodules' in 'struct
> pathspec' and using this flag to determine if matches should be allowed
> to cross submodule boundaries.
> 
> This fixes https://github.com/git-for-windows/git/issues/1371.

Thanks,
Dscho
