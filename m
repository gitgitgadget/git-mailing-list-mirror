From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 18:09:17 +0000
Message-ID: <20130212180917.GD13501@farnsworth.metanate.com>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
 <20130212095340.GG2270@serenity.lan>
 <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
 <7vvc9xh0p1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KIZ-0006A8-JW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199Ab3BLSJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:09:19 -0500
Received: from dougal.metanate.com ([90.155.101.14]:31597 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932370Ab3BLSJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BOHgLFtj8CgfRp1Mszy1a0VH2qIqZ9lX9Us52rOvdbU=;
	b=PD2uIDuohu+wFX+ebBD7P1LWQvYBl4a5w1pFKTzxCzYlvoa9OU+Ti+bFLDUTw4hAGNeImIvgMdQifsCl2PN62ZO3TKsDRAhmU/RXB5q8gh0C3kT8/pfzwL/QBvUIlwfiTrNo4LsunZ8opAbHunmLR9jaCNTQ/UjAXmuPIRXUMA2LledmcN13zuoqVg3NM+hunbP5L+MfF+LTvoNCfGk5RS6u23mmfD49cnb8rbx85u5JD6qHrDMxt2SEAiPfwP18FxMZTwciu5SGvaJLL2F3Qj2OexAJ7PgaCqbqwNv4J+6tT2ZtZFDpThePZeb9SbBrXl1OEYxnPu0vDatqs2PQpw==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1U5KI9-00071j-43; Tue, 12 Feb 2013 18:09:17 +0000
Content-Disposition: inline
In-Reply-To: <7vvc9xh0p1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216170>

On Tue, Feb 12, 2013 at 10:00:26AM -0800, Junio C Hamano wrote:
>
> So it needs to be more like this, and I think it still is more
> readable.

Agreed.  Will you squash this in or do you want a re-roll?

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index cbe36bf..8b3e2cd 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -945,13 +945,11 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	git checkout E^0 &&
>  	git config core.commentchar "\\" &&
>  	test_when_finished "git config --unset core.commentchar" &&
> -	cat >comment-lines.sh <<EOF &&
> -#!$SHELL_PATH
> -sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
> -mv "\$1".tmp "\$1"
> -EOF
> -	chmod a+x comment-lines.sh &&
> -	test_set_editor "$(pwd)/comment-lines.sh" &&
> +	write_script remove-all-but-first.sh <<-\EOF &&
> +	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
> +	mv "$1.tmp" "$1"
> +	EOF
> +	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
>  	git rebase -i B &&
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
