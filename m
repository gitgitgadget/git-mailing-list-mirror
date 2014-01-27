From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tree_entry_interesting: match against all pathspecs
Date: Mon, 27 Jan 2014 08:57:40 -0800
Message-ID: <xmqq4n4ppdkr.fsf@gitster.dls.corp.google.com>
References: <20140125220646.GA24370@pileus.org> <20140125224833.GA19549@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Spencer <andy753421@gmail.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 17:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7pVN-0007Vs-Ta
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 17:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbaA0Q5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 11:57:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbaA0Q5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 11:57:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DECDD6791D;
	Mon, 27 Jan 2014 11:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a5llR6ZX0Cb1DlXMa1n3So5ltvE=; b=cCEFTd
	wjz3DKAZ+H7bcq35GTXlCJtqGFyNWLm+W+KT+A0SBUJi18Pn7EsH5r8BSfKZCzxB
	uhbuF57m0v0Av+dUXTv+yFC0x6tw0yrScUZLnUXXtsNELLBby0/CSio4Z2GE7QfH
	rMYS6wpB6caXKx/zp8kDxPhEXPS0xnTUitEZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IDvuKgX96tnqCkSkPGJVr/8QVYQahlad
	prmRLoRlq1XO7z3nFPCNGtkGx8AJmEGcy429g3SOuDxpj9/TuoztwvnnV4pQqOIF
	rGZj7dGLfgPbqZLTH3oAtTdZPnTX4LT/r/bxO8MZRHq+698OHAaX1us940lZFAPg
	YZKgd6U8LAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE39C6791C;
	Mon, 27 Jan 2014 11:57:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ABDD6791B;
	Mon, 27 Jan 2014 11:57:44 -0500 (EST)
In-Reply-To: <20140125224833.GA19549@lanh> (Duy Nguyen's message of "Sun, 26
	Jan 2014 05:48:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2409D45E-8774-11E3-A2DA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241149>

Duy Nguyen <pclouds@gmail.com> writes:

> Ack. Perhaps this on top to verify it
>
> -- 8< --
> diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
> index af5134b..d9f37c3 100755
> --- a/t/t4010-diff-pathspec.sh
> +++ b/t/t4010-diff-pathspec.sh
> @@ -110,4 +110,17 @@ test_expect_success 'diff-tree -r with wildcard' '
>  	test_cmp expected result
>  '
>  
> +test_expect_success 'diff multiple wildcard pathspecs' '
> +	mkdir path2 &&
> +	echo rezrov >path2/file1 &&
> +	git update-index --add path2/file1 &&
> +	tree3=`git write-tree` &&
> +	git diff --name-only $tree $tree3 -- "path2*1" "path1*1" >actual &&
> +	cat <<EOF >expect &&
> +path1/file1
> +path2/file1
> +EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 8< --

Thanks, both.  Will queue.
