From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Mon, 18 May 2015 14:30:36 +0200
Message-ID: <20150518123036.GB16841@book.hvoigt.net>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
 <20150501175757.GA10569@book.hvoigt.net>
 <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
 <5547C961.7070909@web.de>
 <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
 <37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
 <CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 14:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuKCR-0004Ko-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 14:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbbERMbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 08:31:12 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:59024 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbbERMal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 08:30:41 -0400
Received: from [195.71.20.144] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YuKBq-0004yi-7E; Mon, 18 May 2015 14:30:38 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269229>

Hi,

On Fri, May 15, 2015 at 03:33:07PM -0500, Robert Dailey wrote:
> On Tue, May 5, 2015 at 12:49 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Hi Robert,
> >
> > On 2015-05-04 22:21, Robert Dailey wrote:
> >
> >> Since I am not a linux user, I have implemented this feature against
> >> the Git for Windows fork of git. I am not able to verify changes if I
> >> make them directly against the Git repository.
> >
> > That is why I worked so hard on support of Vagrant: https://github.com/msysgit/msysgit/wiki/Vagrant -- in short, it makes it dead easy for you to set up a *minimal* Linux VM inside your Git SDK and interact with it via ssh.
> >
> > With the Vagrant solution, you can easily test Linux Git even on Windows.
> >
> > Ciao,
> > Johannes
> 
> At the moment I have a "half-ass" patch attached. This implements the
> feature itself. I'm able to test this and it seems to be working.
> Please note I'm a C++ developer and straight C / Bash are not my
> strong suits. I apologize in advance for any mistakes. I am open to
> taking recommendations for corrections.

Please inline the patch, so people can easily comment. Have a look at
Documentation/SubmittingPatches and patches on this list for an example.
I have inlined your patch below for comments.

> I'm not sure how I can verify the feature in a unit test. In addition
> to learning bash scripting well enough to write the test, I am not
> sure how to use git to check for the additional commits. Plus the repo
> for the test will need to handle a submodule change to a merge commit
> as well. Any advice on setting up a good test case for this? What
> conditions should I check for, as far as log output goes?

The testsuite can be found in t/ the README there describes most of it.
Have a look at t4041-diff-submodule-option.sh and imitate the tests for
the existing log option. What they basically do is: Write a file with
the expected output of the diff and then compare the actual output with
it. That should also be possible for your option.

As for the merge commit: If there is no merge commit in the submodule
that is used for testing you can simply add a sequence of git commands
that manufactures the situation in the test repository as you need it.

'test_pause' is a helpful command to interactively debug/develop tests.
Run the test with the -v -i switches (maybe -d) when developing.

Comments for your patch please see below.

Cheers Heiko

> From: Robert Dailey <rcdailey@gmail.com>
> Subject: [PATCH] Add 'full-log' option to diff.submodule
> 
> Like the 'log' option to `diff --submodule`, 'full-log' provides
> logs without the `--first-parent` option.
> ---
>  diff.c      | 16 ++++++++++++----
>  diff.h      |  1 +
>  submodule.c |  9 +++++----
>  submodule.h |  3 ++-
>  4 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 7500c55..58c4872 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -128,10 +128,18 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
>  
>  static int parse_submodule_params(struct diff_options *options, const char *value)
>  {
> -	if (!strcmp(value, "log"))
> +	if (!strcmp(value, "log")) {
>  		DIFF_OPT_SET(options, SUBMODULE_LOG);
> -	else if (!strcmp(value, "short"))
> +		DIFF_OPT_CLR(options, SUBMODULE_FULL_LOG);
> +	}
> +	else if (!strcmp(value, "full-log")) {
> +		DIFF_OPT_SET(options, SUBMODULE_FULL_LOG);
> +		DIFF_OPT_CLR(options, SUBMODULE_LOG);
> +	}
> +	else if (!strcmp(value, "short")) {
>  		DIFF_OPT_CLR(options, SUBMODULE_LOG);
> +		DIFF_OPT_CLR(options, SUBMODULE_FULL_LOG);
> +	}

Here I think clearing the bits first and then setting them would be
simpler and less error prone for further extensions. E.g. in the
beginning of the function:

	DIFF_OPT_CLR(options, SUBMODULE_LOG);
	DIFF_OPT_CLR(options, SUBMODULE_FULL_LOG);

and then

	if (!strcmp(value, "log"))
		DIFF_OPT_SET(options, SUBMODULE_LOG);
	else if (...


>  	else
>  		return -1;
>  	return 0;
> @@ -2240,7 +2248,7 @@ static void builtin_diff(const char *name_a,
>  	struct strbuf header = STRBUF_INIT;
>  	const char *line_prefix = diff_line_prefix(o);
>  
> -	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
> +	if ((DIFF_OPT_TST(o, SUBMODULE_LOG) || DIFF_OPT_TST(o, SUBMODULE_FULL_LOG)) &&

Try to keep your line length less than 80 characters.
(Documentation/CodingGuidelines)

>  			(!one->mode || S_ISGITLINK(one->mode)) &&
>  			(!two->mode || S_ISGITLINK(two->mode))) {
>  		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
> @@ -2248,7 +2256,7 @@ static void builtin_diff(const char *name_a,
>  		show_submodule_summary(o->file, one->path ? one->path : two->path,
>  				line_prefix,
>  				one->sha1, two->sha1, two->dirty_submodule,
> -				meta, del, add, reset);
> +				meta, del, add, reset, DIFF_OPT_TST(o, SUBMODULE_FULL_LOG));

Same as above.

>  		return;
>  	}
>  
> diff --git a/diff.h b/diff.h
> index b4a624d..95f319c 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -90,6 +90,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>  #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
>  #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
>  #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
> +#define DIFF_OPT_SUBMODULE_FULL_LOG  (1 << 31)
>  
>  #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
>  #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
> diff --git a/submodule.c b/submodule.c
> index d37d400..f98173e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -290,14 +290,14 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  
>  static int prepare_submodule_summary(struct rev_info *rev, const char *path,
>  		struct commit *left, struct commit *right,
> -		int *fast_forward, int *fast_backward)
> +		int *fast_forward, int *fast_backward, unsigned full_log)
>  {
>  	struct commit_list *merge_bases, *list;
>  
>  	init_revisions(rev, NULL);
>  	setup_revisions(0, NULL, rev, NULL);
>  	rev->left_right = 1;
> -	rev->first_parent_only = 1;
> +	rev->first_parent_only = full_log ? 0 : 1;
>  	left->object.flags |= SYMMETRIC_LEFT;
>  	add_pending_object(rev, &left->object, path);
>  	add_pending_object(rev, &right->object, path);
> @@ -363,7 +363,8 @@ void show_submodule_summary(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
>  		unsigned dirty_submodule, const char *meta,
> -		const char *del, const char *add, const char *reset)
> +		const char *del, const char *add, const char *reset,
> +		unsigned full_log)
>  {
>  	struct rev_info rev;
>  	struct commit *left = NULL, *right = NULL;
> @@ -381,7 +382,7 @@ void show_submodule_summary(FILE *f, const char *path,
>  		 !(right = lookup_commit_reference(two)))
>  		message = "(commits not present)";
>  	else if (prepare_submodule_summary(&rev, path, left, right,
> -					   &fast_forward, &fast_backward))
> +					   &fast_forward, &fast_backward, full_log))

Line length.

>  		message = "(revision walker failed)";
>  
>  	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> diff --git a/submodule.h b/submodule.h
> index 7beec48..301358b 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -26,7 +26,8 @@ void show_submodule_summary(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
>  		unsigned dirty_submodule, const char *meta,
> -		const char *del, const char *add, const char *reset);
> +		const char *del, const char *add, const char *reset,
> +		unsigned full_log);
>  void set_config_fetch_recurse_submodules(int value);
>  void check_for_new_submodule_commits(unsigned char new_sha1[20]);
>  int fetch_populated_submodules(const struct argv_array *options,

Apart from the comments above, your patch looks good to me.

Cheers Heiko
