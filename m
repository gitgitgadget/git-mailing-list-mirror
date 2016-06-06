From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Mon, 6 Jun 2016 17:29:39 +0100
Organization: OPDS
Message-ID: <2DE0829216C940168DCD804378CD18CC@PhilipOakley>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org> <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <jordan.de-gea@grenoble-inp.org>, <samuel.groot@grenoble-inp.org>,
	<erwan.mathoniere@grenoble-inp.org>,
	<tom.russello@grenoble-inp.org>, <gitster@pobox.com>,
	"Matthieu Moy" <matthieu.moy@grenoble-inp.fr>
To: "Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:29:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xPT-0007gj-C0
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbcFFQ3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:29:46 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:37259 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbcFFQ3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:29:43 -0400
Received: from PhilipOakley ([92.22.6.31])
	by smtp.talktalk.net with SMTP
	id 9xPHbu2Z2sdET9xPHb759F; Mon, 06 Jun 2016 17:29:40 +0100
X-Originating-IP: [92.22.6.31]
X-Spam: 0
X-OAuthority: v=2.2 cv=B/D766lM c=1 sm=1 tr=0 a=6rKLwjNE5rx67PMj20oCSw==:117
 a=6rKLwjNE5rx67PMj20oCSw==:17 a=8nJEP1OIZ-IA:10 a=aSBN74SrAAAA:8
 a=rJg5hy6MCaHl_4QEEMMA:9 a=QLKLDn6n7aLR3e0nYJH2:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOYTi5joKDKadYj/1Lyvz/m3oXcBmnVER2JmJ7RqMab+BeyAjf3wHd67p0gv8tr8GdtKBCR9sSZRmZwN2yg6ZqmPetGgfZZAjPhEyRTy/9P/lPqs7QCV
 0BN7A/ncZVCBPpTOCqR49Gpc0GwpyHHZXb8f6kiYC+TPxuEbYtcbQCzphNZ74Yox7TJ+UBeee7paFIh7C5CfTz32ECmJAl+oOM5DgqT2fIS26E7jnhJcOkbB
 sKrG4SkPz6dc1zQXZ8Ldf0amN6HnmuMO40if0YuzstsxwspxsyMvpXBCvlnQ2m9+tW8QRRykO+yyxJBwB6nj9nhqTHP4R1PG+dMOa/8C/uj8wKhTP5HjvLDk
 3QfBSRtTQXx8aq//70Jv5RO57JCbgzsKyl8u1qzLimp+cVAM/NUieh2Nk5b6d01HUI6Ry7E3DRgdXZb+oafdC8oAM1m4uzyO7MmxU/9JHcrHmBygAwE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296529>

From: "Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>
> Implement `git pull [--set-upstream | -u] <remote> <refspecs>` that set
> tracking to the remote branch the user just pulled from.
>
> After successfully pulling from `<remote>`, for each `<refspec>`
> described in format `<remote_branch>:<local_branch>`, set
> `branch.<local_branch>.remote` to `<remote>` and
> `branch.<local_branch>.merge` to `refs/heads/<remote_branch>`. If
> `<refspec>` lacks `<local_branch>` in the previous format or directly
> refers to a branch, use the current branch as `<local_branch>` in the
> above configuration setting.
>
> `git push` has already its `--set-upstream`, it makes sense to have its
> symmetrical for `git pull`.
>
> For a beginner, when trying to use argumentless `git pull` without
> tracking information set, advising to use
> `git branch --set-upstream-to` to set upstream can be quite confusing.
> Using this `git pull --set-upstream` is easier and more natural.
>
> Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
> Signed-off-by: Jordan De Gea <jordan.de-gea@grenoble-inp.org>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>
> Changes from v1:
> - Code reshaped to :
>  * warn + no-op when pulling from or to something that isn't a branch
> or a configured remote
>  * set upstream only after successfully merging/rebasing
> - More relevant documentation
> - Tests reshaped to be more independent from each others
> - More tests (tags, detached heads, non-configured remote...)
>
>
> For now, the documentation is quite hard to understand, but I didn't
> figure how to explain without using too technical words. Should it stay
> as it is or should I write something similar the above commit message?
>
> Allowing to set non-configured repository as upstream isn't easy to
> handle since the type of refspec must be checked and this is done by
> verifying the existence of the remote-tracking branch at
> `refs/remotes/<remote>/<branch>`.
>
>
> Documentation/git-pull.txt |  18 +++++
> builtin/pull.c             | 106 ++++++++++++++++++++++++++++-
> t/t5544-pull-upstream.sh   | 164 
> +++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 285 insertions(+), 3 deletions(-)
> create mode 100755 t/t5544-pull-upstream.sh
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index d033b25..6ae5e58 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -93,6 +93,24 @@ OPTIONS
>  has to be called afterwards to bring the work tree up to date with the
>  merge result.
>
> +-u::
> +--set-upstream::
> + After successfully pulling from explicitly given <repository> and

s/from explicitly/from an explicitly/

> + <refspecs>, set the configuration of the local branches pulled on, so

s/branches pulled on/branches that were pulled/

> + that each one tracks the remote branch pulled from. If a configuration
> + already exists, it is overwriten. For example, with `git pull -u origin
> + branch` the current branch will track `branch` from `origin`.
> ++
> +If two or more branches are pulled on the same local branch, only the 
> last one
> +in arguments will be tracked.

Is this specific to this pull --setupstream or a general worning ? i.e. that 
a second entry is created in the config file, or that only the last branch 
refspec will be added?

> ++
> +The given <repository> must be a configured remote. Can only set tracking 
> to
> +remote branches (e.g. can't set upstream to remote HEAD).
> ++
> +Works symmetrically as `--set-upstream` for linkgit:git-push[1]. Allow 
> using
> +argumentless linkgit:git-pull[1] and other commands.  For more 
> information, see
> +`branch.<name>.merge` in linkgit:git-config[1].
> +
> Options related to merging
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/pull.c b/builtin/pull.c
[snip] 
