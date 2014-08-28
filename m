From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t9300: test filedelete root
Date: Thu, 28 Aug 2014 15:30:41 -0700
Message-ID: <xmqqa96o8cxa.fsf@gitster.dls.corp.google.com>
References: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
	<1409237674-74185-2-git-send-email-satori@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maxim Bublis <satori@yandex-team.ru>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN8Dg-00085w-FG
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 00:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbaH1Way (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 18:30:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64669 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaH1Wax (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 18:30:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19D9E36743;
	Thu, 28 Aug 2014 18:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=73Xi8ydxpdccRcbRHRlD6RQH3m8=; b=OUL05S
	THNo12n3qFFB0As5V6dc3CNyEYNXh0tlkGJoMGWKi1Aod7+ZtMLDg7+v26upPdWf
	MOvVd5/SuHJ85vevxDgVvwo9pca/QsW6f8GBbbYqepK08fZraBApfYOP7honV8PZ
	u9mm5rEuSazyzK9Pyejsq4OjLaK2VUoZFWPpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYdoTRw3QZ0efZ09yOl6Cq7RKhR05KVa
	oOD2X4G9ZJDgUUBtIsJAbhnvXDo33oFCOgWtNa2Ef884+N1oH2Ux+pxsXu1hpUqM
	wqpSkmjNSyqDvrMpH/D4KskiipBmkUEBWozfi9HAAv6+H1TTH0qS65cLsDYhs/G4
	PnECHcSS+Z4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1150336742;
	Thu, 28 Aug 2014 18:30:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 52FD736735;
	Thu, 28 Aug 2014 18:30:43 -0400 (EDT)
In-Reply-To: <1409237674-74185-2-git-send-email-satori@yandex-team.ru> (Maxim
	Bublis's message of "Thu, 28 Aug 2014 18:54:33 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F289A1CA-2F02-11E4-ACD3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256130>

Maxim Bublis <satori@yandex-team.ru> writes:

> Add new fast-import test series for filedelete command.
>
> Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
> ---

You may have been concentrating on the "delete root" case, but as
long as you claim "We add a series to test filedelete command", it
would be sensible to test more typical cases of deleting files, not
the entire tree as well, no?  Perhaps add three paths in the initial
commit e.g. hello.c, good/night.txt and good/bye.txt, first remove
good/night.txt and validate the result, then remove good/ directory
and validate the result, and finally remove the whole thing and
validate the result, or something like that?

In a patch series that introduces a demonstration of existing
breakage and then fixes the breakage in a separate patch, mark the
test that shows the known breakage with test_expect_failure and then
turn that line into test_expect_success in the later patch that
fixes the breakage.

What the test checks and the fix in 2/2 both looked sensible from a
cursory read.

Thanks.

>  t/t9300-fast-import.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 5fc9ef2..3d557b3 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3017,4 +3017,50 @@ test_expect_success 'T: empty reset doesnt delete branch' '
>  	git rev-parse --verify refs/heads/not-to-delete
>  '
>  
> +###
> +### series U (filedelete)
> +###
> +
> +cat >input <<INPUT_END
> +commit refs/heads/U
> +committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +data <<COMMIT
> +test setup
> +COMMIT
> +M 100644 inline hello.c
> +data <<BLOB
> +blob 1
> +BLOB
> +
> +INPUT_END
> +
> +test_expect_success 'U: initialize for U tests' '
> +	git fast-import <input
> +'
> +
> +cat >input <<INPUT_END
> +commit refs/heads/U
> +committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +data <<COMMIT
> +must succeed
> +COMMIT
> +from refs/heads/U^0
> +D ""
> +
> +INPUT_END
> +
> +test_expect_success 'U: filedelete root succeeds' '
> +    git fast-import <input
> +'
> +
> +cat >expect <<EOF
> +:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
> +EOF
> +
> +git diff-tree -M -r U^1 U >actual
> +
> +test_expect_success 'U: validate filedelete result' '
> +	compare_diff_raw expect actual
> +'
> +
>  test_done
