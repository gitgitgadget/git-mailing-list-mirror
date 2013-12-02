From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 2 Dec 2013 01:21:14 +0100
Message-ID: <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 01:22:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnHHI-0006ct-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 01:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab3LBAV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 19:21:57 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46605 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab3LBAV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 19:21:56 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so9425996wgh.35
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9VnWI1dggawsV0AWTB5uwZKrY1RttxZ4n82cJF4E59I=;
        b=xcMhnYZbPLnGjVyaWBNLDYXTLu3McqagZPbbHa5F2PVk/SbtuyIrF3OjqFvxGUZ4JM
         TCooIKZ8xUAa8KM+igYOcugqbZUiEeVAlWqvdW5VYLto4iwpl5CXeWVGzg/vw8XgmR3G
         yBUAN+I/8ATyJ0P9sfUJw375ffldpkCmAMNNsb+KNN+QUC4v0MoQvQ76EbKIw+gjHpeK
         cO3vlkDN/1Ly4EHAnzdza+FSdQqqcO5Db5cMH1qTsjbtgpM7/LpayHLNBNHpkVQZTbH6
         o1Gym4agM6ngj5LpfnKf9MCI79VvgnCuju6yKAL5E4Zlb1M+3X5osPSgxhL/8BN5t4tk
         XevQ==
X-Received: by 10.180.19.201 with SMTP id h9mr15622150wie.36.1385943714305;
 Sun, 01 Dec 2013 16:21:54 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Sun, 1 Dec 2013 16:21:14 -0800 (PST)
In-Reply-To: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238605>

On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
<krzesimir@endocode.com> wrote:

> Allow @additional_branch_refs configuration variable to tell gitweb to
> show refs from additional hierarchies in addition to branches in the
> list-of-branches view.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>

Why not use %feature hash instead of adding new configuration variable?
I think that this option is similar enough to 'remote_heads' feature
(which BTW should be 'remote-heads'), and could conceveilably enabled
on a per-repository basis, i.e. with repository configuration override,
isn't it?

Usually %feature hash is preferred over adding new configuration variable
but this is not some hard rule. Note however that patches adding new config
are met with more scrutiny, as it is harder to fix mistakes because of
requirement of backwards compatibility of configuration files.

BTW. there really should be gitweb/CodingGuidelines...

> ---
>  Documentation/gitweb.conf.txt | 13 ++++++++
>  gitweb/gitweb.perl            | 75 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 71 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index e2113d9..cd1a945 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -549,6 +549,19 @@ This variable matters only when using persistent web environments that
>  serve multiple requests using single gitweb instance, like mod_perl,
>  FastCGI or Plackup.
>
> +@additional_branch_refs::
> +       List of additional directories under "refs" which are going to be used
> +       as branch refs. You might want to set this variable if you have a gerrit
> +       setup where all branches under refs/heads/ are official,
> +       push-after-review ones and branches under refs/sandbox/, refs/wip and
> +       refs/other are user ones where permissions are much wider, for example
> ++
> +--------------------------------------------------------------------------------
> +our @additional_branch_refs = ('sandbox', 'wip', 'other');
> +--------------------------------------------------------------------------------

I think the last (long) sentence would better read if it began with "For example
if you have... then you could set this variable to ...", IMVHO.

BTW. if we decide on using %feature hash instead, it would be in the
"CONFIGURING GITWEB FEATURES" section.

> ++
> +It is an error to specify a ref that does not pass "git check-ref-format"
> +scrutiny.

Hmmm... One one hand erroring out on invalid refs means that we can
find error in config earlier and easier, on the other hand ignoring invalid
refs would make it resilent to errors in gitweb config (and repository config,
if we use %feature with per-repository override).


> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
[...]
> @@ -626,6 +630,10 @@ sub feature_avatar {
>         return @val ? @val : @_;
>  }
>
> +sub get_branch_refs {
> +    return ('heads', @additional_branch_refs);
> +}

Nice way of ensuring that list of all branches starts with "heads".

>  # checking HEAD file with -e is fragile if the repository was
>  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
>  # and then pruned.
> @@ -680,6 +688,19 @@ sub read_config_file {
>         return;
>  }
>
> +# performs sanity checks on parts of configuration.
> +sub config_sanity_check {
> +       # check additional refs validity
> +       my %unique_branch_refs = ();
> +       for my $ref (@additional_branch_refs) {
> +               die_error(500, "Invalid ref '$ref' in \@additional_branch_refs") unless (validate_ref($ref));
> +               # 'heads' are added implicitly in get_branch_refs().
> +               $unique_branch_refs{$ref} = 1 if ($ref ne 'heads');
> +       }
> +       @additional_branch_refs = sort keys %unique_branch_refs;
> +       %unique_branch_refs = undef;
> +}

This subroutine is quite similar to filter_snapshot_fmts for 'snapshot'
feature, perhaps the name should be patterned after it, i.e.
filter_branch_refs() or something...

If there were generic config_sanity_check(), it would call filter_branch_refs().

> @@ -698,8 +719,11 @@ sub evaluate_gitweb_config {
>
>         # Use first config file that exists.  This means use the per-instance
>         # GITWEB_CONFIG if exists, otherwise use GITWEB_SYSTEM_CONFIG.
> -       read_config_file($GITWEB_CONFIG) and return;
> -       read_config_file($GITWEB_CONFIG_SYSTEM);
> +       if (!read_config_file($GITWEB_CONFIG)) {
> +               read_config_file($GITWEB_CONFIG_SYSTEM);
> +       }
> +
> +       config_sanity_check();
>  }

I'm not sure if evaluate_gitweb_config is best place for sanity check
of said gitweb config, and not e.g. in run_request()... though having
it there has its own advantages.

BTW. it can be written as:

  -       read_config_file($GITWEB_CONFIG) and return;
  -       read_config_file($GITWEB_CONFIG_SYSTEM);
  +      read_config_file($GITWEB_CONFIG) or
  +      read_config_file($GITWEB_CONFIG_SYSTEM);
  +
  +       config_sanity_check();


Anyway if we were to use %feature hash, there is configure_gitweb_features()
for calling filter_branch_refs().

>  # Get loadavg of system, to compare against $maxload.
> @@ -1452,6 +1476,16 @@ sub validate_pathname {
>         return $input;
>  }
>
> +sub validate_ref {
> +       my $input = shift || return undef;
> +
> +       # restrictions on ref name according to git-check-ref-format
> +       if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> +               return undef;
> +       }
> +       return $input;
> +}
> +
>  sub validate_refname {
>         my $input = shift || return undef;

Hmmm... validate_ref() is IMHO too similar to validate_refname(),
and it isn't about *parameter* validation. Perhaps check_ref_format()?

> @@ -1462,10 +1496,9 @@ sub validate_refname {
>         # it must be correct pathname
>         $input = validate_pathname($input)
>                 or return undef;
> -       # restrictions on ref name according to git-check-ref-format
> -       if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> -               return undef;
> -       }
> +       # check git-check-ref-format restrictions
> +       $input = validate_ref($input)
> +               or return undef;
>         return $input;
>  }

Nice refactoring (it *could*, but doesn't need to, be in separate patch).

> @@ -2515,6 +2548,7 @@ sub format_snapshot_links {
>  sub get_feed_info {
>         my $format = shift || 'Atom';
>         my %res = (action => lc($format));
> +       my $matched_ref = 0;
>
>         # feed links are possible only for project views
>         return unless (defined $project);
> @@ -2522,12 +2556,17 @@ sub get_feed_info {
>         # or don't have specific feed yet (so they should use generic)
>         return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
>
> -       my $branch;
> -       # branches refs uses 'refs/heads/' prefix (fullname) to differentiate
> -       # from tag links; this also makes possible to detect branch links
> -       if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
> -           (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
> -               $branch = $1;
> +       my $branch = undef;
> +       # branches refs uses 'refs/' + $get_branch_refs()[x] + '/' prefix
> +       # (fullname) to differentiate from tag links; this also makes
> +       # possible to detect branch links
> +       for my $ref (get_branch_refs()) {
> +               if ((defined $hash_base && $hash_base =~ m!^refs/\Q$ref\E/(.*)$!) ||
> +                   (defined $hash      && $hash      =~ m!^refs/\Q$ref\E/(.*)$!)) {
> +                       $branch = $1;
> +                       $matched_ref = $ref;
> +                       last;
> +               }
>         }

Nice!

> @@ -3662,7 +3701,8 @@ sub git_get_heads_list {
>                 my ($committer, $epoch, $tz) =
>                         ($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>                 $ref_item{'fullname'}  = $name;
> -               $name =~ s!^refs/(?:head|remote)s/!!;
> +               my $strip_refs = join '|', map { quotemeta } get_branch_refs();
> +               $name =~ s!^refs/(?:$strip_refs|remotes)/!!;
>
>                 $ref_item{'name'}  = $name;
>                 $ref_item{'id'}    = $hash;
> @@ -7179,7 +7219,8 @@ sub snapshot_name {
>                 $ver = $1;
>         } else {
>                 # branches and other need shortened SHA-1 hash
> -               if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
> +               my $strip_refs = join '|', map { quotemeta } get_branch_refs();
> +               if ($hash =~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
>                         $ver = $1;
>                 }
>                 $ver .= '-' . git_get_short_hash($project, $hash);

One one hand, it is about threating extra branch refs the same way as 'head'.
On the other hand we loose distinction between 'refs/heads/foo' and e.g.
'refs/wip/foo'. But maybe that's all right...

-- 
Jakub Narebski
