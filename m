From: David Roundy <roundyd@physics.oregonstate.edu>
Subject: Re: [PATCH/RFC 2/2] Provide a build time default-editor setting
Date: Thu, 29 Oct 2009 06:36:59 -0400
Message-ID: <117f2cc80910290336k1e7b5877uc472ad511bb6f5ae@mail.gmail.com>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
	 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
	 <20091029073224.GA15403@progeny.tock>
	 <20091029075021.GC15403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 11:38:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3SNP-0008Bw-AV
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 11:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbZJ2Kg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 06:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZJ2Kg4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 06:36:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:55163 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbZJ2Kgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 06:36:54 -0400
Received: by qyk4 with SMTP id 4so1041140qyk.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=oGF12QkNP6mAi6JdT0tz9vwk+ia+gL8d7vqqzm+NRhI=;
        b=rwayWCDnxiJ+TGP2YXROV8PNQEoNnEL2j8Xa1VZTjlvVcaukAKnKFUf4q1DN8CUV02
         MJtInTGYPzlekJ3Ms5n1Jqjj4JV+yG8r4Nmm5/iT7cygry+Xbae4MzikwymRxwnMaxQd
         hqFLHWhISuMyq6AJGG9V8jBcOCBVzHxT2hmYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=BErWCNWn5/cUwwfNMZrwTOefJMqCbuCAdujfWeiZJ8IN0LCieiBRkd+QsBcZAkpbnk
         LcWjDcLx8fULTTAG9HVQMLWegtsLZJWfBOUR6gqI74Ifny5TSu5HRuXjCvGQWmvGzsLP
         Ix6tY+KvubJzNbqdWnYWWS4M2oUYFQzcIh6L8=
Received: by 10.224.48.4 with SMTP id p4mr9894085qaf.231.1256812619258; Thu, 
	29 Oct 2009 03:36:59 -0700 (PDT)
In-Reply-To: <20091029075021.GC15403@progeny.tock>
X-Google-Sender-Auth: 7ea0527189893af9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131579>

Any chance this will be exported as plumbing? I know it's pretty
high-level, but it'd be handy to have be able to write `git editor
$FILENAME` and just have it do the right thing.  This would also mean
that the perl scripts below could be simplified.

Same goes for pager, of course...

David

On Thu, Oct 29, 2009 at 3:50 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Provide a DEFAULT_EDITOR knob to allow the fallback editor (to
> use instead of vi if VISUAL, EDITOR, and GIT_EDITOR are unset) to
> be set at build time according to a system=E2=80=99s policy. =C2=A0Fo=
r
> example, on Debian systems, the default editor should be the
> 'editor' command.
>
> The contrib/fast-import/git-p4 script still uses vi, since it is
> not modified by the Makefile currently, and making it require
> build-time modification would create too much trouble for people
> deploying that script.
>
> This change makes t7005-editor into a mess. =C2=A0Any ideas for fixin=
g
> this?
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 10 ++++++++++
> =C2=A0editor.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0git-add--interactive.perl | =C2=A0 =C2=A03 ++-
> =C2=A0git-sh-setup.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A06 ++++--
> =C2=A0git-svn.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A05 +++--
> =C2=A0t/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A02 ++
> =C2=A0t/t7005-editor.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 29 +++++=
+++++++++++++++++-------
> =C2=A07 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index fc1a461..fae8647 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -203,6 +203,9 @@ all::
> =C2=A0#
> =C2=A0# Define DEFAULT_PAGER to the path of a sensible pager (default=
s to "less") if
> =C2=A0# you want to use something different.
> +#
> +# Define DEFAULT_EDITOR to a sensible editor command (defaults to "v=
i") if you
> +# want to use something different.
>
> =C2=A0GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0@$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -1301,6 +1304,11 @@ ifndef DEFAULT_PAGER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DEFAULT_PAGER =3D less
> =C2=A0endif
> =C2=A0BASIC_CFLAGS +=3D -DDEFAULT_PAGER=3D'"$(DEFAULT_PAGER)"'
> +ifndef DEFAULT_EDITOR
> + =C2=A0 =C2=A0 =C2=A0 DEFAULT_EDITOR =3D vi
> +endif
> +export DEFAULT_EDITOR
> +BASIC_CFLAGS +=3D -DDEFAULT_EDITOR=3D'"$(DEFAULT_EDITOR)"'
>
> =C2=A0ifdef USE_NED_ALLOCATOR
> =C2=A0 =C2=A0 =C2=A0 =C2=A0COMPAT_CFLAGS +=3D -DUSE_NED_ALLOCATOR -DO=
VERRIDE_STRDUP -DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
> @@ -1435,6 +1443,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e 's|@SHELL_PATH@|$(SHELL_P=
ATH_SQ)|' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e 's/@@GIT_VERSION@@/$(GIT_=
VERSION)/g' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e 's/@@NO_CURL@@/$(NO_CURL)=
/g' \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e 's|DEFAULT_EDITOR:=3Dvi|DEFAU=
LT_EDITOR:=3D$(DEFAULT_EDITOR)|' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e $(BROKEN_PATH_FIX) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$@.sh >$@+ && \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chmod +x $@+ && \
> @@ -1459,6 +1468,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e 's|@@INSTLIBDIR@@|'"$$INS=
TLIBDIR"'|g' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e 's/@@GIT_VERSION@@/$(GIT_=
VERSION)/g' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e 's/@@DEFAULT_PAGER@@/$(DE=
=46AULT_PAGER)/g' \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e 's/@@DEFAULT_EDITOR@@/$(DEFAU=
LT_EDITOR)/g' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$@.perl >$@+ && \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chmod +x $@+ && \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv $@+ $@
> diff --git a/editor.c b/editor.c
> index 4d469d0..93b8cbb 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -19,7 +19,7 @@ int launch_editor(const char *path, struct strbuf *=
buffer, const char *const *en
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("=
Terminal is dumb but no VISUAL nor EDITOR defined.");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!editor)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 editor =3D "vi";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 editor =3D DEFAULT=
_EDITOR;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(editor, ":")) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len =3D=
 strlen(editor);
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 69aeaf0..c3d932c 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1,6 +1,7 @@
> =C2=A0#!/usr/bin/perl -w
>
> =C2=A0use strict;
> +use constant DEFAULT_EDITOR =3D> '@@DEFAULT_EDITOR@@';
> =C2=A0use Git;
>
> =C2=A0binmode(STDOUT, ":raw");
> @@ -988,7 +989,7 @@ EOF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0close $fh;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0my $editor =3D $ENV{GIT_EDITOR} || $repo->=
config("core.editor")
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || $ENV{VISUAL} ||=
 $ENV{EDITOR} || "vi";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || $ENV{VISUAL} ||=
 $ENV{EDITOR} || DEFAULT_EDITOR;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0system('sh', '-c', $editor.' "$@"', $edito=
r, $hunkfile);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ($? !=3D 0) {
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index c41c2f7..d053d56 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -99,19 +99,21 @@ set_reflog_action() {
> =C2=A0}
>
> =C2=A0git_editor() {
> + =C2=A0 =C2=A0 =C2=A0 : "${DEFAULT_EDITOR:=3Dvi}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: "${GIT_EDITOR:=3D$(git config core.edito=
r)}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: "${GIT_EDITOR:=3D${VISUAL:-${EDITOR}}}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$GIT_EDITOR,$TERM" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,dumb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "No e=
ditor specified in GIT_EDITOR, core.editor, VISUAL,"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo >&2 "or EDITO=
R. Tried to fall back to vi but terminal is dumb."
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo >&2 "or EDITO=
R. Tried to fall back to $DEFAULT_EDITOR" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "but terminal is dumb."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "Plea=
se set one of these variables to an appropriate"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "edit=
or or run $0 with options that will not cause an"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "edit=
or to be invoked (e.g., -m or -F for git-commit)."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> - =C2=A0 =C2=A0 =C2=A0 eval "${GIT_EDITOR:=3Dvi}" '"$@"'
> + =C2=A0 =C2=A0 =C2=A0 eval "${GIT_EDITOR:=3D$DEFAULT_EDITOR}" '"$@"'
> =C2=A0}
>
> =C2=A0is_bare_repository () {
> diff --git a/git-svn.perl b/git-svn.perl
> index c270b23..b98d378 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3,12 +3,13 @@
> =C2=A0# License: GPL v2 or later
> =C2=A0use warnings;
> =C2=A0use strict;
> -use vars qw/ =C2=A0 $AUTHOR $VERSION $DEFAULT_PAGER
> +use vars qw/ =C2=A0 $AUTHOR $VERSION $DEFAULT_PAGER $DEFAULT_EDITOR
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$sha1 $sha1_sh=
ort $_revision $_repository
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$_q $_authors =
$_authors_prog %users/;
> =C2=A0$AUTHOR =3D 'Eric Wong <normalperson@yhbt.net>';
> =C2=A0$VERSION =3D '@@GIT_VERSION@@';
> =C2=A0$DEFAULT_PAGER =3D '@@DEFAULT_PAGER@@';
> +$DEFAULT_EDITOR =3D '@@DEFAULT_EDITOR@@';
>
> =C2=A0# From which subdir have we been invoked?
> =C2=A0my $cmd_dir_prefix =3D eval {
> @@ -1322,7 +1323,7 @@ sub get_commit_entry {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0close $log_fh or croak $!;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ($_edit || ($type eq 'tree')) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $editor =3D $EN=
V{VISUAL} || $ENV{EDITOR} || 'vi';
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $editor =3D $EN=
V{VISUAL} || $ENV{EDITOR} || $DEFAULT_EDITOR;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# TODO: strip =
out spaces, comments, like git-commit.sh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system($editor=
, $commit_editmsg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> diff --git a/t/Makefile b/t/Makefile
> index bd09390..9174bbb 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -9,6 +9,8 @@
> =C2=A0SHELL_PATH ?=3D $(SHELL)
> =C2=A0TAR ?=3D $(TAR)
> =C2=A0RM ?=3D rm -f
> +DEFAULT_EDITOR ?=3D vi
> +export DEFAULT_EDITOR
>
> =C2=A0# Shell quote;
> =C2=A0SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index b647957..2b76f72 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -4,7 +4,18 @@ test_description=3D'GIT_EDITOR, core.editor, and stu=
ff'
>
> =C2=A0. ./test-lib.sh
>
> -for i in GIT_EDITOR core_editor EDITOR VISUAL vi
> +: ${DEFAULT_EDITOR=3Dvi}
> +
> +unset EDITOR VISUAL GIT_EDITOR
> +
> +case "$DEFAULT_EDITOR" in
> +*/* | [A-Z]*)
> + =C2=A0 =C2=A0 =C2=A0 DEFAULT_EDITOR=3D
> + =C2=A0 =C2=A0 =C2=A0 ;;
> +esac
> +
> +for i in GIT_EDITOR core_editor EDITOR VISUAL \
> + =C2=A0 =C2=A0 =C2=A0 ${DEFAULT_EDITOR:+"$DEFAULT_EDITOR"}
> =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cat >e-$i.sh <<-EOF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#!$SHELL_PATH
> @@ -12,15 +23,17 @@ do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chmod +x e-$i.sh
> =C2=A0done
> -unset vi
> -mv e-vi.sh vi
> -unset EDITOR VISUAL GIT_EDITOR
> +
> +if test -n "$DEFAULT_EDITOR"
> +then
> + =C2=A0 =C2=A0 =C2=A0 mv "e-$DEFAULT_EDITOR.sh" "$DEFAULT_EDITOR"
> +fi
>
> =C2=A0test_expect_success setup '
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg=3D"Hand edited" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "$msg" >expect &&
> - =C2=A0 =C2=A0 =C2=A0 git add vi &&
> + =C2=A0 =C2=A0 =C2=A0 git add "e-VISUAL.sh" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "$msg" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git show -s --pretty=3Doneline |
> @@ -44,7 +57,8 @@ test_expect_success 'dumb should error out when fal=
ling back on vi' '
>
> =C2=A0TERM=3Dvt100
> =C2=A0export TERM
> -for i in vi EDITOR VISUAL core_editor GIT_EDITOR
> +for i in ${DEFAULT_EDITOR:+"$DEFAULT_EDITOR"} \
> + =C2=A0 =C2=A0 =C2=A0 EDITOR VISUAL core_editor GIT_EDITOR
> =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "Edited by $i" >expect
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unset EDITOR VISUAL GIT_EDITOR
> @@ -68,7 +82,8 @@ done
>
> =C2=A0unset EDITOR VISUAL GIT_EDITOR
> =C2=A0git config --unset-all core.editor
> -for i in vi EDITOR VISUAL core_editor GIT_EDITOR
> +for i in ${DEFAULT_EDITOR:+"$DEFAULT_EDITOR"} \
> + =C2=A0 =C2=A0 =C2=A0 EDITOR VISUAL core_editor GIT_EDITOR
> =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "Edited by $i" >expect
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$i" in
> --
> 1.6.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
David Roundy
