Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC12A1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 14:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfG1OUL (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 10:20:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47073 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726043AbfG1OUL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 10:20:11 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SEJw20011430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 10:20:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2503F4202F5; Sun, 28 Jul 2019 10:19:57 -0400 (EDT)
Date:   Sun, 28 Jul 2019 10:19:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org
Subject: Re: git maintainer workflow tools?
Message-ID: <20190728141957.GD1499@mit.edu>
References: <20190728072318.GO1402@hoshi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728072318.GO1402@hoshi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 28, 2019 at 09:23:18AM +0200, Matthias Beyer wrote:
> 
> So what I am looking for is tools to automate contributor and maintainer
> workflow, especially:
> 
> 1) Repliying to each emailpatch of a set of patches with
>    "Reviewed-by: <user@host>" (or other trailers)
> 
>    Szenario: I see a patchset on a mailinglist. I apply this patchset to my
>    local copy of the repository, review it and test it.
>    I want to send "Reviewed-by" and "Tested-by" trailers for each patch.

I have the following in my ~/.emacs.el file:

(defvar signed-off-by-address "Theodore Ts\'o <tytso@mit.edu>"
  "Address used by insert-signed-off-by")

(defun insert-signed-off-by ()
  (interactive)
  (insert (concat "Signed-off-by: " signed-off-by-address "\n")))

(defun insert-reviewed-by ()
  (interactive)
  (insert (concat "Reviewed-by: " signed-off-by-address "\n")))

(global-set-key "\^Cs" 'insert-signed-off-by)
(global-set-key "\^Cr" 'insert-reviewed-by)

If I see an e-mail on the mailing list for me to review, I may or may
not apply it to my tree depending on how complex it is to review.  But
then in the e-mail reply, I just type "^C r" to insert the Reviwed-by
tag in my e-mail response.

Typically my replies will end with something like this:

	Once you address the above comments, feel free to add:

	Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Or a straight LGTM:

	Looks good, feel free to add:

	Reviewed-by: Theodore Ts'o <tytso@mit.edu>

> 
> 2) Applying a set of emails as patches, where "Reviewed-by" and other trailers
>    from the tree of emails are automatically included in the commit message when
>    applying (how do the kernel people do this? By hand? I don't think so, do
>    they?)

Patchwork will automatically include the Reviwed-by tags from the
e-mail thread.

So for example, see this patch:

	http://patchwork.ozlabs.org/patch/1064297/

If you click the series link, you'll get a Unix mbox file with all of
the patches in the patch series, complete with the tags from the
replies tagged.  (e.g, where people have replied with "Looks good,
feel free to add...")  It is suitable for application using "git am -s".

There are other tools and scripts people might use, but this is one
such workflow.

Hope this helps,

					- Ted
