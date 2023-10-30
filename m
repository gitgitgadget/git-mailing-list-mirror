Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630E10F4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="puBj40j0"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3B90
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 22:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698644164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlcO4eWZN0Q5v+Qo73NrTnuBTSbYuYmfvL3rDYw0hGI=;
	b=puBj40j0iWgCstyJnG7shK6Ttb0Hv/Pb++Knf4qcirJqDOe3iqg7ioVZLo8F5P2swKe7iF
	GGdk9pzMcDa5v1ryJiYQzyToB3RPUbw3XOVqss436TuslPsAb5wZkbJgNMn7xgadetDzE0
	HtDcAo+Y1mByZ1ElgKo8kfvHSxKd2DK+4lS/4zVpsYQjkN01CuM9URM80sS2FlgJbOFfWO
	VBkU3fk4cin8waFxh7zD9zQuqec+MxHkevHD3uFSxHlBZQ7nxBCTo1Gh32VmYxRUep6LzO
	RxPEuN8qN7VqMIFVYJ/Jt9DnSfugZLFpmlfmASg1Za3Cl3XZ5J4iDvNa+mfklQ==
Date: Mon, 30 Oct 2023 06:36:03 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Avoid passing global comment_line_char repeatedly
In-Reply-To: <20231030051034.2295242-1-gitster@pobox.com>
References: <20231030051034.2295242-1-gitster@pobox.com>
Message-ID: <cb82440280c7112a0c1599ba4b6c90b6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-30 06:10, Junio C Hamano wrote:
> Two strbuf functions used to produce commented lines take the
> comment_line_char as their parameter, but in practice, all callers
> feed the global variable comment_line_char from environment.[ch].
> 
> Dropping the parameter from the callchain will make the interface
> less flexible, and less error prone.  If we choose to change the
> implementation of the customizable comment line character (e.g., we
> may want to stop referencing the global variable and instead use a
> getter function), we will have fewer places we need to modify.
> 
> Junio C Hamano (2):
>   strbuf_commented_addf(): drop the comment_line_char parameter
>   strbuf_add_commented_lines(): drop the comment_line_char parameter

This series looks good to me.  It removes unnecessary complexity that 
provided pretty much no value.

>  add-patch.c          |  8 ++++----
>  builtin/branch.c     |  2 +-
>  builtin/merge.c      |  8 ++++----
>  builtin/notes.c      |  9 ++++-----
>  builtin/stripspace.c |  2 +-
>  builtin/tag.c        |  4 ++--
>  fmt-merge-msg.c      |  9 +++------
>  rebase-interactive.c |  8 ++++----
>  sequencer.c          | 14 ++++++--------
>  strbuf.c             |  9 +++++----
>  strbuf.h             |  7 +++----
>  wt-status.c          |  6 +++---
>  12 files changed, 40 insertions(+), 46 deletions(-)
