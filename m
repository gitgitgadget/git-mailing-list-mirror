From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 1/7] git submodule: teach `add` to label submodules
Date: Tue, 22 Mar 2016 15:28:03 -0700
Message-ID: <xmqqio0ef8r0.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, sschuberth@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:28:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUmc-0007H2-0q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbcCVW2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:28:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751213AbcCVW2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:28:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D2E34E8FF;
	Tue, 22 Mar 2016 18:28:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+wB52wYtf1YJtXeBQ0vadgrOFfI=; b=r/t1+h
	Z95grPUIES7gyiNIfvle/I97Qw+kzHn4MYJJI7axreOg7xm0VsYmBC63UPErLDD1
	P0QaEb3Tkqkp0gn1tvfPCYEGF/G5M+SbZxcChcq+aV4S8tpF9LEd1G0zb6BYyhhI
	WHbOuuEanYP2zl8SRzQ5q8ONJjvZyi3b9SLa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bl9sut3aBqm99/wB5B6O0qWKdC/pMUHU
	bi1iczxCiinuOI4LNUlxvSYaLmV55YlQfKdqyurB43CvsAyB07lxLHWwMoZocE0z
	TGbVaFH40RVVNQlQNyWw+WQzPny/4SfVIOzpUVjub2Sg/W8FpG7EmaEnTKvrzZOP
	z6p8xc5iXn8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04D654E8FE;
	Tue, 22 Mar 2016 18:28:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 31B314E8FD;
	Tue, 22 Mar 2016 18:28:06 -0400 (EDT)
In-Reply-To: <1458612372-10966-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Mar 2016 19:06:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 592A667A-F07D-11E5-A3A2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289579>

Stefan Beller <sbeller@google.com> writes:

> When adding new submodules, you can specify the
> label(s) the submodule belongs to by giving one or more
> --label arguments. This will record each label in the
> .gitmodules file as a value of the key
> "submodule.$NAME.label".

Can you define the semantics of "label" with a bit more detail in
the doc?  For example, it is unclear from the description if a
submodule can have multiple labels (I can read the patch, and I am
not asking you to explain it to _me_).  It also is unclear if a user
can tweak the set of labels a submodule has locally, iow, without
modifying .gitmodules that would end up affecting other people.

I think the expected use of "label" is to have the whole project to
share which labels a given submodule should have (i.e. it is not
like branches you can freely create in your repository, but more
like tags that give all project participant shared understanding of
stable anchoring points), and I am guessing that there is no need
for "repository local labels" for that reason, but we'd need to see
that kind of design decisions spelled out in the documentation to
avoid end-user confusion.

Thanks.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-submodule.txt |  5 ++++-
>  git-submodule.sh                | 14 +++++++++++++-
>  t/t7400-submodule-basic.sh      | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 13adebf..c0744eb 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> -'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> +'git submodule' [--quiet] add [-b <branch>] [-f|--force] [-l|--label <label>]
>  	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> @@ -101,6 +101,9 @@ is the superproject and submodule repositories will be kept
>  together in the same relative location, and only the
>  superproject's URL needs to be provided: git-submodule will correctly
>  locate the submodule using the relative URL in .gitmodules.
> ++
> +If at least one label argument was given, all labels are recorded in the
> +.gitmodules file in the label fields.
>  
>  status::
>  	Show the status of the submodules. This will print the SHA-1 of the
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 97a3097..def1e1c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,7 +5,7 @@
>  # Copyright (c) 2007 Lars Hjemli
>  
>  dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> +USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-l|--label <label>][--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> @@ -130,6 +130,7 @@ cmd_add()
>  {
>  	# parse $args after "submodule ... add".
>  	reference_path=
> +	labels=
>  	while test $# -ne 0
>  	do
>  		case "$1" in
> @@ -165,6 +166,13 @@ cmd_add()
>  		--depth=*)
>  			depth=$1
>  			;;
> +		-l|--label)
> +			labels="${labels} $2"
> +			shift
> +			;;
> +		--label=*)
> +			labels="${labels} ${1#--label=}"
> +			;;
>  		--)
>  			shift
>  			break
> @@ -292,6 +300,10 @@ Use -f if you really want to add it." >&2
>  
>  	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
>  	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
> +	for label in $labels
> +	do
> +		git config --add -f .gitmodules submodule."$sm_name".label "${label}"
> +	done &&
>  	if test -n "$branch"
>  	then
>  		git config -f .gitmodules submodule."$sm_name".branch "$branch"
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5991e3c..fc948fd 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -986,6 +986,7 @@ test_expect_success 'submodule with UTF-8 name' '
>  '
>  
>  test_expect_success 'submodule add clone shallow submodule' '
> +	test_when_finished "rm -rf super" &&
>  	mkdir super &&
>  	pwd=$(pwd) &&
>  	(
> @@ -999,5 +1000,36 @@ test_expect_success 'submodule add clone shallow submodule' '
>  	)
>  '
>  
> +test_expect_success 'submodule add records a label' '
> +	test_when_finished "rm -rf super" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule &&
> +		git config -f .gitmodules submodule."submodule".label >actual &&
> +		echo labelA >expected &&
> +		test_cmp expected actual
> +	)
> +'
> +
> +cat >expected <<-EOF
> +labelA
> +labelB
> +EOF
> +
> +test_expect_success 'submodule add records multiple labels' '
> +	test_when_finished "rm -rf super" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --label=labelA -l labelB file://"$pwd"/example2 submodule &&
> +		git config --get-all -f .gitmodules submodule."submodule".label >../actual
> +	) &&
> +	test_cmp expected actual
> +'
>  
>  test_done
