From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] status: introduce status.short to enable --short by default
Date: Mon, 10 Jun 2013 11:16:14 -0700
Message-ID: <7vr4g9j0gh.fsf@alter.siamese.dyndns.org>
References: <1370878068-7643-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6dj-00086W-9D
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab3FJSQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:16:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386Ab3FJSQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:16:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FF14277EA;
	Mon, 10 Jun 2013 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JMESDfmCpasS6CW2qH3vGeGjRqE=; b=ovC7ld
	JHuuPKCrmXQXQseixVhU7lrITtFu3DycMJpu5DP5/LlOHAaBVf5SYZckb1djiD8Y
	9hB1Gf7h0E+FqKOLkAVmKbyKKZL+j1OPOmiHj+DgtvgWLqXMYSiNtAlyThyB0SKj
	pjybI1D471p+zzvhXPWeu4cTv+ckoNsyNDFn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cIqVy9i0Y/x9RH0vymMokyYIEANeMW5B
	7Y3KcTb+kDWzH5XJX94jLj2xHxeVXwEBP+vwCfDIVMyUmf9Hic85NMIrd9QWft4h
	Z+fKc7p+GaSz6nc9B6IZP0Heu0WLB9enSFsBjE78c25kGO90WrNNbANr9W4qnvs9
	MskdGXBJRXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 130FA277E9;
	Mon, 10 Jun 2013 18:16:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B565277E8;
	Mon, 10 Jun 2013 18:16:15 +0000 (UTC)
In-Reply-To: <1370878068-7643-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge Juan Garcia Garcia's message of "Mon, 10 Jun 2013 17:27:47
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D71C8720-D1F9-11E2-BAC0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227339>

Jorge Juan Garcia Garcia  <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
writes:

> Some people always run 'git status -s'.
> The configuration variable status.short allows to set it by default.
>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>
> Changes since v2:
>  -removal of double quotes in test
>  -use of git config --unset to clean up test environment
>
>  Documentation/config.txt |    4 ++++
>  builtin/commit.c         |    5 +++++
>  t/t7508-status.sh        |   35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6e53fc5..1983bf7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2066,6 +2066,10 @@ status.relativePaths::
>  	relative to the repository root (this was the default for Git
>  	prior to v1.5.4).
>  
> +status.short::
> +	Set to true to enable --short by default in linkgit:git-status[1].
> +	The option --no-short takes precedence over this variable.
> +
>  status.showUntrackedFiles::
>  	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
>  	files which are not currently tracked by Git. Directories which
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1621dfc..287f1cb 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1112,6 +1112,11 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  			s->submodule_summary = -1;
>  		return 0;
>  	}
> +	if (!strcmp(k, "status.short")) {
> +		if (git_config_bool(k, v))
> +			status_format = STATUS_FORMAT_SHORT;

And if the user has

	[status]
        	short = no

in $GIT_DIR/config for this particular project, perhaps in order to
override a blanket setting

	[status]
		short

that is in $HOME/.gitconfig, what should happen?

Perhaps you need

	if (git_config_bool(...))
        	status_format = STATUS_FORMAT_SHORT;
	else        	
        	status_format = STATUS_FORMAT_NONE; /* default */

or something here?

> +		return 0;
> +	}
>  	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
>  		s->use_color = git_config_colorbool(k, v);
>  		return 0;
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index e2ffdac..d99ca9f 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1335,4 +1335,39 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
>  	git config -f .gitmodules  --remove-section submodule.subname
>  '
>  
> +test_expect_success 'Setup of test environment' '
> +	git config status.showUntrackedFiles no
> +'
> +
> +test_expect_success '"status.short=true" same as "-s"' '
> +	git -c status.short=true status >actual &&
> +	git status -s >expected_short &&
> +	test_cmp actual expected_short
> +'
> +
> +test_expect_success '"status.short=true" different from "--no-short"' '
> +	git status --no-short >expected_noshort &&
> +	test_must_fail test_cmp actual expected_noshort
> +'
> +
> +test_expect_success '"status.short=true" weaker than "--no-short"' '
> +	git -c status.short=true status --no-short >actual &&
> +	test_cmp actual expected_noshort
> +'
> +
> +test_expect_success '"status.short=false" same as "--no-short"' '
> +	git -c status.short=false status >actual &&
> +	git status -s >expected_short &&
> +	test_cmp actual expected_noshort
> +'
> +
> +test_expect_success '"status.short=false" weaker than "-s"' '
> +	git -c status.short=false status -s >actual &&
> +	test_cmp actual expected_short
> +'
> +
> +test_expect_success 'Restore default test environment' '
> +	git config --unset status.showUntrackedFiles
> +'

A few observations.

 * It is very good that you check not just positive cases that show
   off how well this new feature works (i.e. status.short set
   without command line override gives a short output) but also
   negative cases that make sure the new feature does not kick in
   when it should not.  You test all four combinations, which is
   good.

 * If any of the first three fails, you may not have the correct
   string in expected_short or expected_noshort when running later
   tests that depend on them.

 * Similarly, if the first one to set showUntrackedFiles fails, the
   last one to --unset would also fail.

Perhaps limiting the number of tests that must pass (otherwise the
remainder becomes useless) by doing something like this is a better
alternative:


	test_expect_success 'setup for status.short' '
		git status --short >expected_short &&
                git status --no-short >expected_noshort
	'

	test_expect_success '-c status.short=true == status -s' '
        	test_config status.showUntrackedFile no &&
        	test_config status.short yes &&
                git status >actual &&
                test_cmp expected_short actual
	'

	test_expect_success 'status --no-short defeats status.short=true' '
        	test_config status.showUntrackedFile no &&
        	test_config status.short yes &&
                git status --no-short >actual &&
                test_cmp expected_noshort actual
	'

	... other two combinations here ...

Points to note:

 * test_config takes care of setting configuration variables and
   then unsetting them when the test is done.

 * test_cmp should compare expected with actual, not the other way,
   so that "./t7508-status.sh -v" shows the diff between the two 
   shows how the actual output differs from what is expected.
