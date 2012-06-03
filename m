From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Sun, 03 Jun 2012 15:00:05 -0700
Message-ID: <7v7gvoxdi2.fsf@alter.siamese.dyndns.org>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:01:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbIr3-0002Vt-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 00:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab2FCWAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 18:00:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871Ab2FCWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 18:00:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83D2F8C5F;
	Sun,  3 Jun 2012 18:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89H0WXiOztDPTNdmzLuaUyumqNc=; b=Ldcm8T
	kzmDgg/9LUIYztQ9G94sjvlxjuUeZTLkG7b1bGfF41d6D5WzbFhOccu1X4xt3V3H
	qD6Lcaw0ZfstFCyTyoVStdkVoAuneKmr3XTjv2JuhKBjPwX6ILSuNCC0+XsCeIRY
	W4HQEs73bM6FWSNcBSUZoJ01y4KoyCKq8cuSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0deE+5EIM/ItYLeHrQRjfJloWGOWauv
	ba3/TIQcCJxBRS3C7avcb1Fc3ILme2DHxWA9bwYjtjfO/3YukhnBojvRH04A4cr3
	fhzd0FKLwYvORJ98N6rMivZzt990jDJrMztA4KjAuIDzqryKnQ3vvIlqF4LPwqla
	jgccTRM9SvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7610B8C5E;
	Sun,  3 Jun 2012 18:00:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E35808C55; Sun,  3 Jun 2012
 18:00:06 -0400 (EDT)
In-Reply-To: <1338748217-16440-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Sun, 3 Jun 2012 20:30:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AE4D28E-ADC7-11E1-893D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199107>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 2bb43f3..0b7f231 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -106,7 +106,7 @@ test_expect_success 'status when rebase in progress before rebase --continue' '
>  
>  test_expect_success 'status when rebasing -i in edit mode' '
>  	git init git &&
> -	test_when_finished "rm -rf git fake-editor.sh" &&
> +	test_when_finished "rm -rf git" &&

Hrph.  Is this an "oops" fixup of an earlier patch?

> @@ -130,6 +130,67 @@ test_expect_success 'status when rebasing -i in edit mode' '
> ...
> +test_expect_failure 'status after editing the last commit with --amend during a rebase -i' '
> +	git init git &&
> +	test_when_finished "rm -rf git fake-editor.sh" &&

You do not seem to remove fake-editor.sh in this test.  Why do you
remove it here?

> diff --git a/wt-status.c b/wt-status.c
> index 5034eee..bbb3370 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -819,6 +820,69 @@ static void show_am_in_progress(struct wt_status *s,
>  	wt_status_print_trailer(s);
>  }
>  
> +static int split_commit_in_progress()
> +{
> +	int split_in_progress = 0;
> +
> +	FILE *head = fopen(git_path("HEAD"), "r");
> +	if (!head)
> +		return 0;
> +
> ...
> +	struct strbuf buf_head = STRBUF_INIT;
> +	struct strbuf buf_orig_head = STRBUF_INIT;
> +	struct strbuf buf_rebase_amend = STRBUF_INIT;
> +	struct strbuf buf_rebase_orig_head = STRBUF_INIT;


Please avoid decl-after-statement by declaring all variables at the
beginning of the function before the first statement.
