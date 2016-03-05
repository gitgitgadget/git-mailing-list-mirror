From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] pull --rebase: add --[no-]autostash flag
Date: Sat, 05 Mar 2016 09:04:15 -0800
Message-ID: <xmqqfuw4x3e8.fsf@gitster.mtv.corp.google.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457171545-14496-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 18:04:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acFcu-0005GT-JC
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 18:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbcCEREU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 12:04:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbcCEREU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 12:04:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46AF747D4C;
	Sat,  5 Mar 2016 12:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6xbUwtvZa/SKSLoY2L13JCx0TI0=; b=OOacl7
	IPqB19FYm3sbkbWFyWzFVnhlHYIL7iU7bENqt6eKYvTnk4oCeZbgt8V5QD7MwcTi
	9rmo4rjRtQIdmn/K4PV8tks9xs+HWR1w36YaZhTIzNuI6OTFwfnQvqIhclhBkRNw
	y9Af+zZHSXpQM1YdVh43sSWdz7PShh1PNcijE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N7poqKwfZtQrv4Bkf3RDT886JLOCpUgW
	jPqzDmTxWXMY/f8ufMbxov5ili/WDMHsA/dXsN7QOwieSW4j3hdyCwkEjiUxDpC/
	x3XA4Qv5NI9N13XoB7d/TZyJjyZuxeQTumBoyQvc42olLdS356e76ky6/CDDL9Rs
	j2Kh9MRJJmU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B31347D4B;
	Sat,  5 Mar 2016 12:04:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DCA047D45;
	Sat,  5 Mar 2016 12:04:16 -0500 (EST)
In-Reply-To: <1457171545-14496-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Sat, 5 Mar 2016 15:22:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B2F0E04-E2F4-11E5-AB0D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288315>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> +--autostash::
> +--no-autostash::
> +	Before starting rebase, stash local modifications away (see
> +	linkgit:git-stash.txt[1]) if needed, and apply the stash when
> +	done.
> ++
> +This option is only valid when '--rebase' is used.
> ++
> +'--no-autostash' is useful to override the 'rebase.autoStash'
> +configuration variable (see linkgit:git-config[1]).
> ++
> +[NOTE]
> +Use with care: the final stash application after a successful
> +rebase might result in non-trivial conflicts.
> +

Should this entry be this verbose and have four separate paragraphs?

I think "This option is..." can and should be a part of the first
paragraph, and *NOTE* paragraph does not have to be there.  The
readers have already been referred to rebase.autoStash that warns
them to be prepared to deal with possible conflicts when replaying
the stashed change.

> -		git_config_get_bool("rebase.autostash", &autostash);
> -		if (!autostash)
> +		if (opt_autostash == -1)
> +			git_config_get_bool("rebase.autostash", &opt_autostash);
> +
> +		if (opt_autostash == 0 || opt_autostash == -1)
>  			die_on_unclean_work_tree(prefix);

If the command line didn't give --[no-]autostash when the control
reaches this section of the code, get_bool() is used to see if
rebase.autostash is set.  If it is explicitly set to false or unset,
the command will check if the work tree is clean and complain.

Makes sense.

This does not have to be in the scope of your change, by the way,
but it may make sense to reduce the use of git_config_get_*()
function when the program already contains a call to git_config().

Instead of calling git_default_config callback from there, introduce
a new callback function and read variables that matter from there,
i.e.

static int opt_autostash = -1;
static int config_autostash = -1;
...
static int git_pull_config(const char *var, const char *value, void *cb)
{
	if (!strcmp(var, "rebase.autostash")) {
        	config_autostash = git_config_bool(var, value);
		return 0;
	}
        return git_default_config(var, value, cb);
}

and then you do "the command line overrides the configured value"
with

	if (opt_autostash < 0)
        	opt_autostash = config_autostash;
	if (opt_autostash < 0)
        	die_on_unclean_work_tree(...);

Either way you have to read the config files in full at least once
anyway, but the program does not have to ask the config API to look
up the value with a separate git_config_get_bool() call if you did
so.

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index c952d5e..f5d1d31 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -245,6 +245,25 @@ test_expect_success '--rebase fails with multiple branches' '
>  	test modified = "$(git show HEAD:file)"
>  '
>  
> +test_expect_success 'pull --rebase --no-autostash fails with dirty working directory and rebase.autstash set true' '

This is overly verbose, isn't it?

You are verifying that "--no-autostash overrides rebase.autostash"
in this test, so perhaps make it:

    test_expect_success 'pull --rebase: --no-autostash overrides rebase.autostash'

or something?

> +	test_config rebase.autostash true &&
> +	git reset --hard before-rebase &&
> +	echo dirty >new_file &&
> +	git add new_file &&
> +	test_must_fail git pull --rebase --no-autostash . copy
> +'
> +
> +test_expect_success 'pull --rebase --autostash succeeds with dirty working directory and rebase.autstash set false' '

Likewise.  This verifies that "--autostash overrides rebase.autostash".

> +	test_config rebase.autostash false &&
> +	git reset --hard before-rebase &&
> +	echo dirty >new_file &&
> +	git add new_file &&
> +	git pull --rebase --autostash . copy &&
> +	test_cmp_rev HEAD^ copy &&
> +	test "$(cat new_file)" = dirty &&
> +	test "$(cat file)" = "modified again"
> +'
> +

For completeness, there are two other cases, i.e. rebase.autostash
set to false and --no-autostash given from the command line, and the
variable set to true and --autostash from the command line.

It is worth considering if these two need to be tested.  There are
(at least) two things to take into account:

 - We know, after seeing the current implementation, that these two
   cases do not have to be tested, because the configuration is not
   even looked at when there is a command line option.

 - However, the real reason why we prepare these tests is not to
   demonstrate that the patch that introduces a new feature works as
   expected.  It is to prevent _future_ changes by other people, who
   may not be aware of the reason why we chose not to test these two
   cases, from breaking the code.  If a careless refactoring of the
   code can break our assumption (i.e. "the configuration is not
   even looked at when there is a command line option." above), such
   a change may introduce a bug that disables autostash when both
   variable and option tell the code to autostash, and having the
   two additional tests would catch such a breakage.

>  test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
>  	test_config rebase.autostash true &&
>  	git reset --hard before-rebase &&

These two new tests are inserted in a somewhat strange location, by
the way.  This existing test checks the basic working of rebase.autostash
without any command line override.  Shouldn't the more complex new cases
that deal with command line override come after this one?

Is it worth checking the case where autostash kicks in, rebase
itself is completed successfully, but the final "stash pop" fails in
conflict?  I am thinking aloud and just wondering, not suggesting
to add such a test, or even suggesting that having such a test is
worthwhile. I didn't even check if there is already an existing test
to cover that case.

Other than the above, looking better.  Thanks.
