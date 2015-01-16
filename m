From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault in git apply
Date: Fri, 16 Jan 2015 11:58:55 -0800
Message-ID: <xmqqbnly1oqo.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
	<CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com>
	<CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com>
	<CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com>
	<CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com>
	<CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com>
	<99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com>
	<4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:59:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCD2t-0001pL-6N
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbbAPT67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:58:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752554AbbAPT66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:58:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD9C30F20;
	Fri, 16 Jan 2015 14:58:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVoWVxiJJHygFQ0k//5k5rNYQ9Q=; b=lExXyu
	xVG5LjegwOJt8ZJ+8S7mrQ4u/N2S+yTR2qU5RkpVavwXogfMJ+G5x4zTOZjh4nNb
	gQgO6C9mZdFaaiADsDXL/9Yc9OOws8h5JUoRSHTAkx1RT0G8aobJfaUSQQuTGrJo
	AkN6FoQp1kOJxJYRdEZLqSX9bJZ4LlYn8N2Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EodTs6DVC2apjQfNX4zE62gHjg/Gp72R
	gojEEdoBDlM5UaeW6azo39Car2gU53K/LmURYIjL8g7Ap0EyN+p/5JbVKoMPna3w
	VtvOsTB4hHhIEHGeAvPuer+7XO7MMzSqzzeRBjhBNlQ5eI1gScaQ2qKJWJN4C4Sq
	se4Jb+Jzg+A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 789E130F17;
	Fri, 16 Jan 2015 14:58:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC35F30F0E;
	Fri, 16 Jan 2015 14:58:56 -0500 (EST)
In-Reply-To: <4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com> (Kyle J. McKay's
	message of "Thu, 15 Jan 2015 01:10:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AF61898-9DBA-11E4-94D0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262570>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> If I make this change on top of 250b3c6c:
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index df773c75..8795e830 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2390,6 +2390,8 @@ static int match_fragment(struct image *img,
>  	fixed_buf = strbuf_detach(&fixed, &fixed_len);
>  	if (postlen < postimage->len)
>  		postlen = 0;
> +	if (postlen)
> +		postlen = 2 * postimage->len;
>  	update_pre_post_images(preimage, postimage,
>  			       fixed_buf, fixed_len, postlen);
>  	return 1;
>
> Then the problem goes away.  That seems to suggest that postlen is
> being computed incorrectly, but someone more familiar with
> bulitin/apply.c is going to need to look at it.

Indeed, with this, the test case detects under-counting in the
caller (the caller counts 262 bytes but the expansion consumes 273
bytes).

-- >8 --
Subject: apply: make update_pre_post_images() sanity check the given postlen

---
 builtin/apply.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 622ee16..18b7997 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2174,6 +2174,10 @@ static void update_pre_post_images(struct image *preimage,
 	/* Fix the length of the whole thing */
 	postimage->len = new - postimage->buf;
 	postimage->nr -= reduced;
+
+	if (postlen && postlen < (new - postimage->buf))
+		die("BUG: postlen = %d, used = %d",
+		    (int)postlen, (int)(new - postimage->buf));
 }
 
 static int match_fragment(struct image *img,
-- 
2.3.0-rc0-149-g0286818
