Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295DA2A
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790026; cv=none; b=AG84pPY5+MwxtSiUOtS7clhgvYC2mLBgq2YmL8/gjposcwCjdpuUYJL6ZXjNsSYLx7945CJQurueGTYm8AXkx4c1lKJ7NVzWcB024QlbVtj5vdc+/fFeXMFhghN06/o0jvXUPTTDL50vqYW4mweohkupbQqKBTCEGUHP8zRYcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790026; c=relaxed/simple;
	bh=OHcnFBymaofvPNJ2N1MjI4CgANPthRJ42NvX43vYbkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5E7QZtC/OMaDEMZs07LBwrwNi9XgGxcfO0pQtDS7A3w1Nv4Kd+wMaUHw9FhvHhVxRytZXgSxwG/OLM8lcyb3hWkKzQEwPOHMJ7/PtsON8GillxbW1NiVauRpB/CsBd9cE3mx1yQrHH2gxG3gqyJvwqT7rGDVzZjZpgMgdhS1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aASfHcqE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aASfHcqE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E75E2B079;
	Sun,  4 Aug 2024 12:46:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OHcnFBymaofvPNJ2N1MjI4CgANPthRJ42NvX43
	vYbkM=; b=aASfHcqE1eEtdn0qxedY4toySDd2S9IQDqm/OWQoXMXysziyFgDQfs
	Oa3s2zvKKSkz6CSXGfu0veurwwoCmnPNhzrqWz+l+3X10RyfJH+8UmHh8NHnisqz
	+n6Hnapsuq53JZUTwAdorwaRIlYLIc7p6mxRZIFiOs7w3pRYY1LqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 374672B078;
	Sun,  4 Aug 2024 12:46:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96C922B077;
	Sun,  4 Aug 2024 12:46:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] [Newcomer] t7004-tag: do not prepare except
 outside test_expect_success
In-Reply-To: <20240804071137.30326-5-abdobngad@gmail.com> (AbdAlRahman Gad's
	message of "Sun, 4 Aug 2024 10:11:35 +0300")
References: <20240804071137.30326-1-abdobngad@gmail.com>
	<20240804071137.30326-5-abdobngad@gmail.com>
Date: Sun, 04 Aug 2024 09:46:55 -0700
Message-ID: <xmqqv80g5j7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 292502D6-5281-11EF-8D78-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

There are other "prepare for next test" remaining even after
applying this patch, though.

> diff --git c/t/t7004-tag.sh w/t/t7004-tag.sh
> index cfe7653317..96aa908eaf 100755
> --- c/t/t7004-tag.sh
> +++ w/t/t7004-tag.sh
> ...
> -cat >expect <<EOF
> -mytag
> -EOF
>  test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
> +	cat >expect <<-\EOF &&
> +	mytag
> +	EOF
>  	git tag -l -l >actual &&
>  	test_cmp expect actual &&
>  	git tag --list --list >actual &&
>  	test_cmp expect actual &&
>  	git tag --list -l --list >actual &&
>  	test_cmp expect actual
>  '

Good.

> -cat >expect <<EOF
> -myhead
> -mytag
> -EOF
>  test_expect_success \
>  	'trying to delete tags without params should succeed and do nothing' '
> +	cat >expect <<-\EOF &&
> +	myhead
> +	mytag
> +	EOF
>  	git tag -l >actual &&
>  	test_cmp expect actual &&
>  	git tag -d &&
>  	git tag -l >actual &&
>  	test_cmp expect actual
>  '

Good too.

>  # creating annotated tags:
>  
>  get_tag_msg () {
>  	git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
>  }
>  
>  # run test_tick before committing always gives the time in that timezone
>  get_tag_header () {
>  cat <<EOF
>  object $2
>  type $3
>  tag $1
>  tagger C O Mitter <committer@example.com> $4 -0700
>  
>  EOF
>  }
>
>  commit=$(git rev-parse HEAD)
>  time=$test_tick
>  
>  get_tag_header annotated-tag $commit commit $time >expect
>  echo "A message" >>expect
>  test_expect_success \
>  	'creating an annotated tag with -m message should succeed' '
>  	git tag -m "A message" annotated-tag &&
>  	get_tag_msg annotated-tag >actual &&
>  	test_cmp expect actual
>  '

The creation of $commit, holding the timestamp in $time, calling the
get_tag_header helper helper function, and addition of the message
to 'expect' file.  Moving all of them inside expect_success block is
perfectly in line with the theme of this step.

>  get_tag_header annotated-tag-edit $commit commit $time >expect
>  echo "An edited message" >>expect
>  test_expect_success 'set up editor' '
>  	write_script fakeeditor <<-\EOF
>  	sed -e "s/A message/An edited message/g" <"$1" >"$1-"
>  	mv "$1-" "$1"
>  	EOF
>  '
>  test_expect_success \
> ...

Ditto here.  In addition, there is a blank line lacking after the
above test piece and before the next one.

>  cat >msgfile <<EOF
>  Another message
>  in a file.
>  EOF
>  get_tag_header file-annotated-tag $commit commit $time >expect
>  cat msgfile >>expect
>  test_expect_success \
>  	'creating an annotated tag with -F messagefile should succeed' '
>  	git tag -F msgfile file-annotated-tag &&
>  	get_tag_msg file-annotated-tag >actual &&
>  	test_cmp expect actual
>  '

Ditto.

>  get_tag_header file-annotated-tag-edit $commit commit $time >expect
>  sed -e "s/Another message/Another edited message/g" msgfile >>expect
>  test_expect_success 'set up editor' '
>  	write_script fakeeditor <<-\EOF
>  	sed -e "s/Another message/Another edited message/g" <"$1" >"$1-"
>  	mv "$1-" "$1"
>  	EOF
>  '
>  test_expect_success \
>  	'creating an annotated tag with -F messagefile --edit should succeed' '
>  	GIT_EDITOR=./fakeeditor git tag -F msgfile --edit file-annotated-tag-edit &&
>  	get_tag_msg file-annotated-tag-edit >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >inputmsg <<EOF
>  A message from the
>  standard input
>  EOF
>  get_tag_header stdin-annotated-tag $commit commit $time >expect
>  cat inputmsg >>expect
>  test_expect_success 'creating an annotated tag with -F - should succeed' '
>  	git tag -F - stdin-annotated-tag <inputmsg &&
>  	get_tag_msg stdin-annotated-tag >actual &&
>  	test_cmp expect actual
>  '

Ditto.

>  # blank and empty messages:
>  
>  get_tag_header empty-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with an empty -m message should succeed' '
>  	git tag -m "" empty-annotated-tag &&
>  	get_tag_msg empty-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  >emptyfile
>  get_tag_header emptyfile-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with an empty -F messagefile should succeed' '
>  	git tag -F emptyfile emptyfile-annotated-tag &&
>  	get_tag_msg emptyfile-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
>  printf '\n\t \t  \nRepeated blank lines\n' >>blanksfile
>  printf '\n\n\nTrailing spaces      \t  \n' >>blanksfile
>  printf '\nTrailing blank lines\n\n\t \n\n' >>blanksfile
>  get_tag_header blanks-annotated-tag $commit commit $time >expect
>  cat >>expect <<EOF
>  Leading blank lines
>  
>  Repeated blank lines
>  
>  Trailing spaces
>  
>  Trailing blank lines
>  EOF
>  test_expect_success \
>  	'extra blanks in the message for an annotated tag should be removed' '
>  	git tag -F blanksfile blanks-annotated-tag &&
>  	get_tag_msg blanks-annotated-tag >actual &&
>  	test_cmp expect actual
>  '

Ditto.

>  get_tag_header blank-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with blank -m message with spaces should succeed' '
>  	git tag -m "     " blank-annotated-tag &&
>  	get_tag_msg blank-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  echo '     ' >blankfile
>  echo ''      >>blankfile
>  echo '  '    >>blankfile
>  get_tag_header blankfile-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with blank -F messagefile with spaces should succeed' '
>  	git tag -F blankfile blankfile-annotated-tag &&
>  	get_tag_msg blankfile-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  printf '      ' >blanknonlfile
>  get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with -F file of spaces and no newline should succeed' '
>  	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
>  	get_tag_msg blanknonlfile-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  # messages with commented lines:
>  
>  cat >commentsfile <<EOF
>  # A comment
>  
>  ############
>  The message.
>  ############
>  One line.
>  
>  
>  # commented lines
>  # commented lines
>  
>  Another line.
>  # comments
>  
>  Last line.
>  EOF
>  get_tag_header comments-annotated-tag $commit commit $time >expect
>  cat >>expect <<EOF
>  The message.
>  One line.
>  
>  Another line.
>  
>  Last line.
>  EOF
>  test_expect_success \
>  	'creating a tag using a -F messagefile with #comments should succeed' '
>  	git tag -F commentsfile comments-annotated-tag &&
>  	get_tag_msg comments-annotated-tag >actual &&
>  	test_cmp expect actual
>  '

Ditto.

>  get_tag_header comment-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with a #comment in the -m message should succeed' '
>  	git tag -m "#comment" comment-annotated-tag &&
>  	get_tag_msg comment-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  echo '#comment' >commentfile
>  echo ''         >>commentfile
>  echo '####'     >>commentfile
>  get_tag_header commentfile-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with #comments in the -F messagefile should succeed' '
>  	git tag -F commentfile commentfile-annotated-tag &&
>  	get_tag_msg commentfile-annotated-tag >actual &&
>  	test_cmp expect actual
>  '
>  
>  printf '#comment' >commentnonlfile
>  get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
>  test_expect_success \
>  	'creating a tag with a file of #comment and no newline should succeed' '
>  	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
>  	get_tag_msg commentnonlfile-annotated-tag >actual &&
>  	test_cmp expect actual
>  '

Ditto.

>  echo 'tag line one' >annotagmsg
>  echo 'tag line two' >>annotagmsg
>  echo 'tag line three' >>annotagmsg
>  test_expect_success \
>  	'listing many message lines of a non-signed tag should succeed' '
>  	git tag -F annotagmsg tag-lines &&
>  ...

Ditto.

>  # creating and verifying signed tags:
>  
>  get_tag_header signed-tag $commit commit $time >expect
>  echo 'A signed tag message' >>expect
>  echo '-----BEGIN PGP SIGNATURE-----' >>expect
>  test_expect_success GPG 'creating a signed tag with -m message should succeed' '
>  	git tag -s -m "A signed tag message" signed-tag &&
>  	get_tag_msg signed-tag >actual &&
>  	test_cmp expect actual
>  '

Ditto.

>  get_tag_header u-signed-tag $commit commit $time >expect
>  echo 'Another message' >>expect
>  echo '-----BEGIN PGP SIGNATURE-----' >>expect
>  test_expect_success GPG 'sign with a given key id' '
>  
>  	git tag -u committer@example.com -m "Another message" u-signed-tag &&
>  	get_tag_msg u-signed-tag >actual &&
>  	test_cmp expect actual
>  
>  '

Ditto.

If it is too much to include all of the above in the same patch I
think it would be OK to stop at "move prepatation of the expect file
using cat and here-doc into test_expect_success block", as long as
we make it clear in the log message that we are drawing the line
there in the patch, and leaving other similar issues untouched to
keep the step manageably short.  Adding a new patch to clean up the
"other similar issues" is entirely optional, but doing so would make
the series even more thorough.

Thanks.



