From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git archive
Date: Fri, 24 Oct 2008 10:58:53 +0700
Message-ID: <fcaeb9bf0810232058j1c52b824rbb51258e65f7a510@mail.gmail.com>
References: <gdmp0p$92r$1@ger.gmane.org>
	 <20081022130829.GC2015@riemann.deskinm.fdns.net>
	 <fcaeb9bf0810230833i3953a5abt2d2ba6ca1b751754@mail.gmail.com>
	 <20081023182103.GA8320@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "kenneth johansson" <ken@kenjo.org>, git@vger.kernel.org
To: "Deskin Miller" <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Fri Oct 24 06:00:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtDqK-00081G-L0
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 06:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbYJXD64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 23:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbYJXD64
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 23:58:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:1692 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYJXD6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 23:58:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so819331fgg.17
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 20:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=B5mT8c7NHfm5UN69qwAp5nXIwVds/Q2N2UJPf463880=;
        b=H9xhCjvhwf8hVGGyF9vKjDh/2oT/ZdO3ZXTt7Vo2MiOisq5qrxKjEhx9CmSg5LqN2e
         0k97ViDxP5JqNqy7koCRUZaJxisND1SvczVxl3CmLQzBJw6BMOoY0Hi87jjAxyFobdgG
         xiYKWQlHjPn3okQBihY7H0sIRT2CUskdxYOwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KjOSBxSmelOt1xe110duI7Ys/F0oZUMDX9Lcwuhtqg/60wYeNkdnsmmC3UDgm0A7sT
         3eVcoxVHZJGh9XIHubu45RLx8oPbYVKypoC4tjaqfQWFlzUacjJj0O8R7mQT5Md2n/nr
         N0YXPgElvkkgRPi2kzfoAbJPydEYDpXPX+Ln0=
Received: by 10.86.97.7 with SMTP id u7mr75264fgb.49.1224820733364;
        Thu, 23 Oct 2008 20:58:53 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 23 Oct 2008 20:58:53 -0700 (PDT)
In-Reply-To: <20081023182103.GA8320@euler>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99007>

On 10/24/08, Deskin Miller <deskinm@umich.edu> wrote:
> On Thu, Oct 23, 2008 at 10:33:31PM +0700, Nguyen Thai Ngoc Duy wrote:
>  > On 10/22/08, Deskin Miller <deskinm@umich.edu> wrote:
>  > > On Wed, Oct 22, 2008 at 08:42:01AM +0000, kenneth johansson wrote:
>  > >  > I was going to make a tar of the latest stable linux kernel.
>  > >  > Done it before but now I got a strange problem.
>  > >  >
>  > >  > >git archive --format=tar v2.6.27.2
>  > >  > fatal: Not a valid object name
>  > >
>  > >
>  > > I had the same thing happen to me, while trying to make an archive of Git.
>  > >  Were you perchance working in a bare repository, as I was?  I spent some time
>  > >  looking at it and I think git archive sets up the environment in the wrong
>  > >  order, though of course I never finished a patch so I'm going from memory:
>  > >
>  > >  After looking at the code again, I think the issue is that git_config is called
>  > >  in builtin-archive.c:cmd_archive before setup_git_directory is called in
>  > >  archive.c:write_archive.  The former ends up setting GIT_DIR to be '.git' even
>  > >  if you're in a bare repository.  My coding skills weren't up to fixing it
>  > >  easily; moving setup_git_directory before git_config in builtin-archive caused
>  > >  last test of t5000 to fail: GIT_DIR=some/nonexistent/path git archive --list
>  > >  should still display the archive formats.
>  >
>  > The problem affects some other commands as well. I tried the following
>  > patch, ran "make test" and discovered "git mailinfo", "git
>  > verify-pack", "git hash-object" and "git unpack-file". A bandage patch
>  > is at the end of this mail. Solution is as Jeff suggested: call
>  > setup_git_directory_gently() early.
>
>
> Nice work.  The patches look like they're on the right track (to me at least).
>  I'm not sure though what you want to ultimately submit as a patch; I'd suggest
>  both, squashed into one, since the check seems like something we'd reasonably
>  want no matter what.

No, the patches are not in good shape and have not been tested well. I
just wanted to point out the problem in other commands. Ideally the
check in setup_git_env() should go along with discover_git_directory()
as part of git setup rework.

>
>  Few comments spread around below; also, can we see some testcases for
>  regression?  Or, does the first patch preclude the need for testcases?
>
>  Deskin Miller
>
>
>  > ---<---
>  > diff --git a/environment.c b/environment.c
>  > index 0693cd9..00ed640 100644
>  > --- a/environment.c
>  > +++ b/environment.c
>  > @@ -49,14 +49,18 @@ static char *work_tree;
>  >
>  >  static const char *git_dir;
>  >  static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
>  > +int git_dir_discovered;
>
>
> Should this be 'int git_dir_discovered = 0;' ?

It is initialized by default IIRC.

>  > Bandage patch:
>  >
>  > ---<---
>  > diff --git a/builtin-archive.c b/builtin-archive.c
>  > index 432ce2a..5ea0a12 100644
>  > --- a/builtin-archive.c
>  > +++ b/builtin-archive.c
>  > @@ -110,7 +110,9 @@ static const char *extract_remote_arg(int *ac,
>  > const char **av)
>  >  int cmd_archive(int argc, const char **argv, const char *prefix)
>  >  {
>  >       const char *remote = NULL;
>  > +     int nongit;
>  >
>  > +     prefix = setup_git_directory_gently(&nongit);
>
>
> Here and elsewhere, the 'nongit' variable isn't used.
>  setup_git_directory_gently can be passed a NULL pointer, why not do that?

Passing NULL to setup_git_directory_gently() tells it to die() if no
git repo can be found. If you pass a variable to it, it will set the
variable to 1 if no repo is found, 0 otherwise.

>  >       git_config(git_default_config, NULL);
>  >       while (1 < argc) {
>  >               if (!no_more_options && argv[1][0] == '-') {
>  > diff --git a/hash-object.c b/hash-object.c
>  > index 20937ff..a52b6be 100644
>  > --- a/hash-object.c
>  > +++ b/hash-object.c
>  > @@ -78,19 +78,20 @@ int main(int argc, const char **argv)
>  >       const char *prefix = NULL;
>  >       int prefix_length = -1;
>  >       const char *errstr = NULL;
>  > +     int nongit;
>  >
>  >       type = blob_type;
>  >
>  > -     git_config(git_default_config, NULL);
>  > -
>  >       argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
>  >
>  > -     if (write_object) {
>  > -             prefix = setup_git_directory();
>  > -             prefix_length = prefix ? strlen(prefix) : 0;
>  > -             if (vpath && prefix)
>  > -                     vpath = prefix_filename(prefix, prefix_length, vpath);
>  > -     }
>  > +     prefix = setup_git_directory_gently(&nongit);
>  > +     git_config(git_default_config, NULL);
>  > +     prefix_length = prefix ? strlen(prefix) : 0;
>  > +     if (vpath && prefix)
>  > +             vpath = prefix_filename(prefix, prefix_length, vpath);
>  > +
>  > +     if (write_object && nongit)
>  > +             die("Git repository required");
>
>
> I'd move this check up to just after setup_git_directory_gently.

Yeah, sounds reasonable.

-- 
Duy
