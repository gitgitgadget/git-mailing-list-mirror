From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 44/47] Remove all logic from get_git_work_tree()
Date: Tue, 21 Dec 2010 17:56:18 -0800
Message-ID: <7vpqsu6059.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-45-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 02:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVDwU-0002aD-NH
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 02:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0LVB40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 20:56:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0LVB4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 20:56:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7439A3936;
	Tue, 21 Dec 2010 20:56:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=hxPq28qAWAHAdMRAE/K7+DZhU
	C4=; b=CDzEQQu0V/ysKvd7S/pNWnJG+6nUr3A3rY/Wq5ywM6J8O94GM9fIrKk78
	oAAZReM2nnsEjeGW/BZygqzxutPLbnWuUWbmcIFOYmCn8vUFnuR7Xh3rZTNFAlOO
	oIqVe+vt6ng4iTnnbqirnB/uMrHYeA1ThA9aFNxEvueO4JL/us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=xdKV/EOM0x7KNNHTRGx
	AAlHFs67wf+/dbG0hrlW4hz9RFLgjSkSGuFthsZ/IUr6pqBe+NJlulDvghHPserJ
	liDPDbX0kBji9Ah20HkdG/KiVs3Gi2E9rU6EOne5H9W+uyB0U4J+rNhDp6nQQDBi
	l/8L4VNDA07ULQQ7RYfSsUa0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 505223934;
	Tue, 21 Dec 2010 20:56:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BA893926; Tue, 21 Dec 2010
 20:56:49 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BEFC9998-0D6E-11E0-927A-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164069>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This logic is now only used by cmd_init_db(). setup_* functions do no=
t
> rely on it any more. Move all the logic to cmd_init_db() and turn
> get_git_work_tree() into a simple function.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/environment.c b/environment.c
> index d811049..149c132 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -137,36 +137,20 @@ static int git_work_tree_initialized;
>   */
> ...
>  const char *get_git_work_tree(void)
>  {
> -	if (startup_info && !startup_info->setup_explicit) {
> -...
> -	}
>  	return work_tree;
>  }

Would it be a bug in the new set-up code if this function gets called a=
nd
work_tree is still NULL?

There are quite a few callers that call get_git_work_tree() and expect
that it will always return a non NULL pointer.  Perhaps we would want a=
n
assertion here?
