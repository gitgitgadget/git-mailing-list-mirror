From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit
 code if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 10:38:50 -0700
Message-ID: <7vmxg2s1jp.fsf@alter.siamese.dyndns.org>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
 <1311519554-16587-3-git-send-email-jon.seymour@gmail.com>
 <CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com>
 <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jens.Lehmann@web.de, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 19:39:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlP7N-0007WB-4u
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 19:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab1GYRi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 13:38:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab1GYRiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 13:38:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A873B78;
	Mon, 25 Jul 2011 13:38:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/jkHWl96XMfrwlGyXP++AhB/gU=; b=WgHYFK
	6OJ0X8tbzuudjcAKH7AOFRclXrU/GPigyxJe5JTskdNHH+nFcJe/mxuAKOJJPXtJ
	Q7gnnSL6u4EbKxSmJbvazZiGYxv3iRKasAwz7G3QyFia2KfhthlRQ69lbEkwm8RP
	OGU3JkHKVdH5wB+uWOsDZS/KwQDsal0Hq2g/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HfrB0ci9wTnCGNiNeuHHo8oxYGwXpFqx
	qKMGKB0K5YVFVq6LJSdLAT5Uy8Kg51L13tYfqWRAd2LVI5RGzIkzy1frDPlIjMeV
	X6/6LbXT3GIq5RKcLUosTHGVc6NNx+pHPg10XoEmwMrf9NlHm4SlPSXehggZK6ow
	MvnHY1Tyd64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC303B77;
	Mon, 25 Jul 2011 13:38:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C65B03B76; Mon, 25 Jul 2011
 13:38:51 -0400 (EDT)
In-Reply-To: <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com> (Jon
 Seymour's message of "Mon, 25 Jul 2011 18:45:35 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6161150-B6E4-11E0-9C64-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177803>

Jon Seymour <jon.seymour@gmail.com> writes:

> @@ -173,6 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const
> char *prefix)
>         tree = parse_tree_indirect(sha1);
>         if (!tree)
>                 die("not a tree object");
> -       return read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
> +       ret = read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
>
> +       return ret ? 1 : 0;
>  }

Surely, or "return !!read_tree_recursive(...);" is fine as well.
