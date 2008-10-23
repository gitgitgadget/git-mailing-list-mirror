From: Deskin Miller <deskinm@umich.edu>
Subject: Re: git archive
Date: Thu, 23 Oct 2008 14:21:03 -0400
Message-ID: <20081023182103.GA8320@euler>
References: <gdmp0p$92r$1@ger.gmane.org> <20081022130829.GC2015@riemann.deskinm.fdns.net> <fcaeb9bf0810230833i3953a5abt2d2ba6ca1b751754@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kenneth johansson <ken@kenjo.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:22:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt4pO-0004vd-4M
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 20:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbYJWSVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 14:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758249AbYJWSVO
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 14:21:14 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:33966 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029AbYJWSVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 14:21:12 -0400
Received: by yw-out-2324.google.com with SMTP id 9so143815ywe.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=XPPEnHjXNpgNzZ5p7nBJRtaCd79+pvNZFDAvePNM7E8=;
        b=KRnBaDaFZSt16edjljoOI6DY2vqt+PLhBNdVCOPWxb2OPxdjnsYR0HoeGejVYadElF
         mQkl5aaeh6TYaTWw/CbkLIHU6QG4bTaW+1qP2D/0ayXkyUvIamrTfW1qsKlU+doGKP4/
         BF+phRJ61EufTFClw3PvJOfzyfJ2owhIVZeHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=b02/waZKpS+NlS8H0ZUOWjMZjyolsQjij8nKagUJeEzAXDjT6gjmewJnvP7aW7LJRk
         ScUxhcrjE++iumAdxmnc8Z6Ww8tLreJ/aFmhBR5DnBO4YFyKsl1bkKycITp7+2WnOtDQ
         S+JfvBwo8lcQWMRZl4D65Zv3ELVrIjKnc9eRo=
Received: by 10.231.18.130 with SMTP id w2mr559277iba.43.1224786069813;
        Thu, 23 Oct 2008 11:21:09 -0700 (PDT)
Received: from euler ([141.213.134.57])
        by mx.google.com with ESMTPS id 7sm10753103ywo.7.2008.10.23.11.21.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 11:21:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0810230833i3953a5abt2d2ba6ca1b751754@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98979>

On Thu, Oct 23, 2008 at 10:33:31PM +0700, Nguyen Thai Ngoc Duy wrote:
> On 10/22/08, Deskin Miller <deskinm@umich.edu> wrote:
> > On Wed, Oct 22, 2008 at 08:42:01AM +0000, kenneth johansson wrote:
> >  > I was going to make a tar of the latest stable linux kernel.
> >  > Done it before but now I got a strange problem.
> >  >
> >  > >git archive --format=tar v2.6.27.2
> >  > fatal: Not a valid object name
> >
> >
> > I had the same thing happen to me, while trying to make an archive of Git.
> >  Were you perchance working in a bare repository, as I was?  I spent some time
> >  looking at it and I think git archive sets up the environment in the wrong
> >  order, though of course I never finished a patch so I'm going from memory:
> >
> >  After looking at the code again, I think the issue is that git_config is called
> >  in builtin-archive.c:cmd_archive before setup_git_directory is called in
> >  archive.c:write_archive.  The former ends up setting GIT_DIR to be '.git' even
> >  if you're in a bare repository.  My coding skills weren't up to fixing it
> >  easily; moving setup_git_directory before git_config in builtin-archive caused
> >  last test of t5000 to fail: GIT_DIR=some/nonexistent/path git archive --list
> >  should still display the archive formats.
> 
> The problem affects some other commands as well. I tried the following
> patch, ran "make test" and discovered "git mailinfo", "git
> verify-pack", "git hash-object" and "git unpack-file". A bandage patch
> is at the end of this mail. Solution is as Jeff suggested: call
> setup_git_directory_gently() early.

Nice work.  The patches look like they're on the right track (to me at least).
I'm not sure though what you want to ultimately submit as a patch; I'd suggest
both, squashed into one, since the check seems like something we'd reasonably
want no matter what.

Few comments spread around below; also, can we see some testcases for
regression?  Or, does the first patch preclude the need for testcases?

Deskin Miller
 
> ---<---
> diff --git a/environment.c b/environment.c
> index 0693cd9..00ed640 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -49,14 +49,18 @@ static char *work_tree;
> 
>  static const char *git_dir;
>  static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
> +int git_dir_discovered;

Should this be 'int git_dir_discovered = 0;' ?
 
>  static void setup_git_env(void)
>  {
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
>  	if (!git_dir)
>  		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> -	if (!git_dir)
> +	if (!git_dir) {
> +		if (!git_dir_discovered)
> +			die("Internal error: .git must be relocated at cwd by setup_git_*");
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> +	}
>  	git_object_dir = getenv(DB_ENVIRONMENT);
>  	if (!git_object_dir) {
>  		git_object_dir = xmalloc(strlen(git_dir) + 9);
> diff --git a/setup.c b/setup.c
> index 78a8041..d404c21 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -368,6 +368,7 @@ const char *read_gitfile_gently(const char *path)
>   * We cannot decide in this function whether we are in the work tree or
>   * not, since the config can only be read _after_ this function was called.
>   */
> +extern int git_dir_discovered;
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>  	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
> @@ -472,6 +473,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		}
>  		chdir("..");
>  	}
> +	/* It is safe to call setup_git_env() now */
> +	git_dir_discovered = 1;
> 
>  	inside_git_dir = 0;
>  	if (!work_tree_env)
> ---<---
> 
> 
> Bandage patch:
> 
> ---<---
> diff --git a/builtin-archive.c b/builtin-archive.c
> index 432ce2a..5ea0a12 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -110,7 +110,9 @@ static const char *extract_remote_arg(int *ac,
> const char **av)
>  int cmd_archive(int argc, const char **argv, const char *prefix)
>  {
>  	const char *remote = NULL;
> +	int nongit;
>
> +	prefix = setup_git_directory_gently(&nongit);

Here and elsewhere, the 'nongit' variable isn't used.
setup_git_directory_gently can be passed a NULL pointer, why not do that?

>  	git_config(git_default_config, NULL);
> 
>  	remote = extract_remote_arg(&argc, argv);
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index e890f7a..5d401fb 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -916,10 +916,9 @@ static const char mailinfo_usage[] =
>  int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>  {
>  	const char *def_charset;
> +	int nongit;
> 
> -	/* NEEDSWORK: might want to do the optional .git/ directory
> -	 * discovery
> -	 */
> +	prefix = setup_git_directory_gently(&nongit);

Same 'nongit' issue.

>  	git_config(git_default_config, NULL);
> 
>  	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
> diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
> index 25a29f1..35a4eb2 100644
> --- a/builtin-verify-pack.c
> +++ b/builtin-verify-pack.c
> @@ -115,7 +115,9 @@ int cmd_verify_pack(int argc, const char **argv,
> const char *prefix)
>  	int verbose = 0;
>  	int no_more_options = 0;
>  	int nothing_done = 1;
> +	int nongit;
> 
> +	prefix = setup_git_directory_gently(&nongit);

Same 'nongit' issue.

>  	git_config(git_default_config, NULL);
>  	while (1 < argc) {
>  		if (!no_more_options && argv[1][0] == '-') {
> diff --git a/hash-object.c b/hash-object.c
> index 20937ff..a52b6be 100644
> --- a/hash-object.c
> +++ b/hash-object.c
> @@ -78,19 +78,20 @@ int main(int argc, const char **argv)
>  	const char *prefix = NULL;
>  	int prefix_length = -1;
>  	const char *errstr = NULL;
> +	int nongit;
> 
>  	type = blob_type;
> 
> -	git_config(git_default_config, NULL);
> -
>  	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
> 
> -	if (write_object) {
> -		prefix = setup_git_directory();
> -		prefix_length = prefix ? strlen(prefix) : 0;
> -		if (vpath && prefix)
> -			vpath = prefix_filename(prefix, prefix_length, vpath);
> -	}
> +	prefix = setup_git_directory_gently(&nongit);
> +	git_config(git_default_config, NULL);
> +	prefix_length = prefix ? strlen(prefix) : 0;
> +	if (vpath && prefix)
> +		vpath = prefix_filename(prefix, prefix_length, vpath);
> +
> +	if (write_object && nongit)
> +		die("Git repository required");

I'd move this check up to just after setup_git_directory_gently.
 
>  	if (stdin_paths) {
>  		if (hashstdin)
> diff --git a/unpack-file.c b/unpack-file.c
> index bcdc8bb..1a58d72 100644
> --- a/unpack-file.c
> +++ b/unpack-file.c
> @@ -27,10 +27,10 @@ int main(int argc, char **argv)
> 
>  	if (argc != 2)
>  		usage("git-unpack-file <sha1>");
> +	setup_git_directory();
>  	if (get_sha1(argv[1], sha1))
>  		die("Not a valid object name %s", argv[1]);
> 
> -	setup_git_directory();
>  	git_config(git_default_config, NULL);
> 
>  	puts(create_temp_file(sha1));
> ---<---
> -- 
> Duy
