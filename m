From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 17:24:03 -0500
Message-ID: <53559a8333aaa_6c39e772f07f@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <53558AD0.3010602@gmail.com>
 <53558a663ea74_604be1f30c2c@nysa.notmuch>
 <53558F6F.7080306@gmail.com>
 <53558f285f379_640076f2f094@nysa.notmuch>
 <CADcHDF+XcWEkvyP3tL4ibicnaMVJpixUZu1Ces0BXWkzPGsodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 00:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcMnP-00076d-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbaDUWef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:34:35 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:59672 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbaDUWe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:34:26 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so3931218ykr.37
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=00aVUhLjo3uqNUt7HD4Rlx86J8qPyXOxy6oiWbR/k6M=;
        b=pi9Yj8lCKekLdwwUeMcq05oAKom5Rlv95j9eXj7LI1VnAmFw1FGxatptRO7UtFWrz+
         MOYvTSgnfyNJuhuQt0bC1dqPHIXNL0jNIq2tuU3pt7rT8mf9RcJrVx0CjDHmWH5vOtmF
         bJhhLEZLrHmhNGNUD9Ui/BW6HOnFSB62B7ELdjMBA0OiEgVWFkA6lNx1yBoHSwFbjFC9
         Nz8qPmj8dBlv1UlYpvCh0rIuowil4DcacuG4j4m14i+0W5SGdVwnyNRblSKoxpbLohHV
         3j5vWxFnwweP3MgQw03bDjFmQ19d/Vbly+x4VeM4pabCxJjJI7GcxkGX7LfCCSqceHH7
         jSOg==
X-Received: by 10.236.26.72 with SMTP id b48mr56298228yha.59.1398119665845;
        Mon, 21 Apr 2014 15:34:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t42sm74975793yhn.12.2014.04.21.15.34.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 15:34:24 -0700 (PDT)
In-Reply-To: <CADcHDF+XcWEkvyP3tL4ibicnaMVJpixUZu1Ces0BXWkzPGsodw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246660>

Ilya Bobyr wrote:
> On Mon, Apr 21, 2014 at 2:35 PM, Felipe Contreras <
> felipe.contreras@gmail.com> wrote:
> > Ilya Bobyr wrote:
> > > test_expect_success 'setup' "
> > >       mkdir -p .git/hooks &&
> > >       cat > .git/hooks/update-branch <<-\\EOF &&
> > >       #!/bin/sh
> > >       echo \$@ > .git/update-branch.args
> > >       EOF
> > >       chmod +x .git/hooks/update-branch &&
> > >       echo one > content &&
> > >       git add content &&
> > >       git commit -a -m one
> > > "
> >
> > That is not maintainable at all.
> 
> Maybe you could explain how is this less maintainable, compared to a separate
> function?

Do I really have to explain that manually escaping a shell script is not
maintainable?

> This is how it is suggested by t/README and how it is done in the other
> test suites.
> I can not see how your case is different, but I might be missing something.

Let's take a cursoy look at `git grep -l "'EOF'" t`.

== t/t0009-prio-queue.sh ==

  cat >expect <<'EOF'
  1
  2
  3
  4
  5
  5
  6
  7
  8
  9
  10
  EOF
  test_expect_success 'basic ordering' '
	  test-prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
	  test_cmp expect actual
  '

Look at that, code outside the cage, not once, but in every test.

== t/t0040-parse-options.sh ==

  cat >>expect <<'EOF'
  list: foo
  list: bar
  list: baz
  EOF
  test_expect_success '--list keeps list of strings' '
	  test-parse-options --list foo --list=bar --list=baz >output &&
	  test_cmp expect output
  '

Once again.

== t/t1411-reflog-show.sh ==
== t/t2020-checkout-detach.sh ==
== t/t3203-branch-output.sh ==
== t/t3412-rebase-root.sh ==
== t/t4014-format-patch.sh ==
== t/t4030-diff-textconv.sh ==

All these do something similar, not once, but many many times.

== t/t4031-diff-rewrite-binary.sh ==

  {
	  echo "#!$SHELL_PATH"
	  cat <<'EOF'
  "$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
  EOF
  } >dump
  chmod +x dump

More code outside.

== t/t4042-diff-textconv-caching.sh ==

  cat >helper <<'EOF'
  #!/bin/sh
  sed 's/^/converted: /' "$@" >helper.out
  cat helper.out
  EOF
  chmod +x helper

== t/t5401-update-hooks.sh ==

  cat >victim.git/hooks/pre-receive <<'EOF'
  #!/bin/sh
  printf %s "$@" >>$GIT_DIR/pre-receive.args
  cat - >$GIT_DIR/pre-receive.stdin
  echo STDOUT pre-receive
  echo STDERR pre-receive >&2
  EOF
  chmod u+x victim.git/hooks/pre-receive

Would you look at that? This is actually a hook test that is changing the hook
*outside* the cage.

== t/t5402-post-merge-hook.sh ==

  for clone in 1 2; do
      cat >clone${clone}/.git/hooks/post-merge <<'EOF'
  #!/bin/sh
  echo $@ >> $GIT_DIR/post-merge.args
  EOF
      chmod u+x clone${clone}/.git/hooks/post-merge
  done

Another hook test with code outside.

== t/t5403-post-checkout-hook.sh ==

Doing the same.

== t/t5516-fetch-push.sh ==

  mk_test_with_hooks() {
	  repo_name=$1
	  mk_test "$@" &&
	  (
		  cd "$repo_name" &&
		  mkdir .git/hooks &&
		  cd .git/hooks &&

		  cat >pre-receive <<-'EOF' &&
		  #!/bin/sh
		  cat - >>pre-receive.actual
		  EOF

		  cat >update <<-'EOF' &&
		  #!/bin/sh
		  printf "%s %s %s\n" "$@" >>update.actual
		  EOF

		  cat >post-receive <<-'EOF' &&
		  #!/bin/sh
		  cat - >>post-receive.actual
		  EOF

		  cat >post-update <<-'EOF' &&
		  #!/bin/sh
		  for ref in "$@"
		  do
			  printf "%s\n" "$ref" >>post-update.actual
		  done
		  EOF

		  chmod +x pre-receive update post-receive post-update
	  )
  }

This one is using a function, just like I am. It's not run outside, but we can
do the same.

== t/t5571-pre-push-hook.sh ==

  write_script "$HOOK" <<'EOF'
  echo "$1" >actual
  echo "$2" >>actual
  cat >>actual
  EOF

Anhoter hook test with code outside.

== t/t7004-tag.sh ==

  cat >fakeeditor <<'EOF'
  #!/bin/sh
  test -n "$1" && exec >"$1"
  echo A signed tag message
  echo from a fake editor.
  EOF
  chmod +x fakeeditor

== t/t7008-grep-binary.sh ==

  cat >nul_to_q_textconv <<'EOF'
  #!/bin/sh
  "$PERL_PATH" -pe 'y/\000/Q/' < "$1"
  EOF
  chmod +x nul_to_q_textconv

== t/t7504-commit-msg-hook.sh ==
== t/t8006-blame-textconv.sh ==
== t/t8007-cat-file-textconv.sh ==
== t/t9138-git-svn-authors-prog.sh ==

Very similar: scripts outside the cage.


In fact my version is actually cleaner than these, because the code that is run
outside the cage is clearly delimited by a function.

-- 
Felipe Contreras
