From: Dan McGee <dan@archlinux.org>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 2 Jan 2013 08:18:12 -0600
Message-ID: <CAEik5nMRAoHdx166Q7Zb5Yve6DiyVgN6EXQWGF=GgUtSyjiuSA@mail.gmail.com>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
	<7va9ss5fhq.fsf@alter.siamese.dyndns.org>
	<20130102065345.GA8685@sigill.intra.peff.net>
	<7v1ue459yh.fsf@alter.siamese.dyndns.org>
	<20130102085935.GB9328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 15:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqP9P-0002gF-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 15:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab3ABOSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 09:18:17 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39301 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ABOSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 09:18:15 -0500
Received: by mail-vc0-f181.google.com with SMTP id gb30so13988762vcb.26
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=vYYb5oDnvZ2bHaDgfiaqN06y0QnQOr/U1gKEw7GzCUQ=;
        b=nMyf71VzhxHCzMX6Pxw9FGT/ifsrKIWeM0zA8fbq/3VQeSJORqdmK5XjoxgQhyawsZ
         2vKPcyVeS5Y60MZPYY4QDBSstxzbGKEniDyyJQm5eFl6yZYc6cDxGz9Filzw3nOZnTER
         wB/3s59YGCbscBiVN+NrFjNnqCBCfOW6nB1uW4TtHjsPrJDKNIDqOp9G2ohj28uvUsw1
         7MiQKz7wi8ut44Te8GqpxmyRYUcy+D3y8jGNf9vuAbiNLZ8JmLWaPg8yykks0jMdFGb+
         lgvz4+AebnsQ7uv9AQeIBFra9CAwEBWHFNRuZB3HFh8FQ59iwXhlGKa93ZmNpcnu393a
         42sQ==
Received: by 10.52.88.19 with SMTP id bc19mr31236004vdb.67.1357136292920; Wed,
 02 Jan 2013 06:18:12 -0800 (PST)
Received: by 10.58.34.11 with HTTP; Wed, 2 Jan 2013 06:18:12 -0800 (PST)
In-Reply-To: <20130102085935.GB9328@sigill.intra.peff.net>
X-Google-Sender-Auth: YCFrQvjE9_5S4OVwnZUY_pP6JEI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212515>

On Wed, Jan 2, 2013 at 2:59 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 01, 2013 at 11:18:46PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > [1] This symlink is doubly wrong, because any use of symbolic links
>> >     in the test scripts needs to depend on the SYMLINKS prereq, and this
>> >     does not.
>>
>> Yeah, I think we have discussed this once already in
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/210688/focus=210714
>
> Thanks for the pointer; it looks like nothing productive came of the
> earlier discussion. To give a hat trick of failure to this line of code,
> I notice that the existing code also does not properly put quotes around
> $GIT_BUILD_DIR.
>
>> > [2] In both the current code and what I showed above, the test scripts
>> >     depend on things in contrib/. This is probably a bad idea in
>> >     general, as the quality of what goes into contrib is not as closely
>> >     watched (especially with respect to things like portability).
>> >     Certainly I would not have known to look more carefully at a patch
>> >     to contrib/svn-fe for breakage to the test suite.
>>
>> As long as such tests are made skippable with appropriate
>> prerequisites, I do not think it is bad to have their tests in t/; I
>> would say it is rather better than having them in contrib/ and leave
>> it not run by anybody, which happened to some of the stuff in
>> contrib/ already.
>
> Good point. While my sense of decorum wants to keep contrib totally
> split out, from a practical point of view, it is better to have more
> people run the tests and report failures than not.
>
> Whether we end up doing something with contrib and tests or not, the
> patch below gives a minimal fix in the meantime. Dan, does it fix your
> problem?

This works great now, thanks! I ran it through our package build
scripts and all tests now pass as expected.

Signed-off-by: Dan McGee <dan@archlinux.org>

> -- >8 --
> Subject: [PATCH] t9020: don't run python from $PATH
>
> In t9020, we symlink in a python script from contrib to help
> with the testing. However, we don't munge its #!-line, which
> means we may run the wrong python (we want the one in
> PYTHON_PATH). On top of this, we use a symlink without
> checking the SYMLINKS prereq, and we fail to properly quote
> GIT_BUILD_DIR, which may have spaces.
>
> Instead of symlinking, let's just write a small script which
> will feed the contrib script to PYTHON_PATH. To avoid
> quoting issues, we just export the variables the script
> needs to run.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t9020-remote-svn.sh | 5 ++++-
>  t/test-lib.sh         | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> index 4f2dfe0..416623b 100755
> --- a/t/t9020-remote-svn.sh
> +++ b/t/t9020-remote-svn.sh
> @@ -14,7 +14,10 @@ export PATH="$HOME:$PATH"
>
>  # We override svnrdump by placing a symlink to the svnrdump-emulator in .
>  export PATH="$HOME:$PATH"
> -ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
> +export GIT_BUILD_DIR
> +write_script svnrdump <<\EOF
> +exec "$PYTHON_PATH" "$GIT_BUILD_DIR"/contrib/svn-fe/svnrdump_sim.py "$@"
> +EOF
>
>  init_git () {
>         rm -fr .git &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f50f834..c17db19 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -45,7 +45,7 @@ fi
>  fi
>
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> -export PERL_PATH SHELL_PATH
> +export PERL_PATH SHELL_PATH PYTHON_PATH
>
>  # if --tee was passed, write the output not only to the terminal, but
>  # additionally to the file test-results/$BASENAME.out, too.
> --
> 1.8.1.rc3.4.gf3a2f57
>
