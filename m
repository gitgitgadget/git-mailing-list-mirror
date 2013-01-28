From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! git-remote-testpy: fix path hashing on Python 3
Date: Mon, 28 Jan 2013 09:53:46 -0800
Message-ID: <7v8v7dxkgl.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan> <20130127145056.GP7498@serenity.lan>
 <51065692.9000708@alum.mit.edu> <20130128112043.GZ7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 28 18:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzsuK-0004lh-1A
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 18:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633Ab3A1Rxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 12:53:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757603Ab3A1Rxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 12:53:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62D04C606;
	Mon, 28 Jan 2013 12:53:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fnh2thjDb0V1qiA3ADMkdoqbpqI=; b=V7abV9
	9V6bQa3+9uNIkhHHBuD/gpa/ESYhrIXXnlsuIrYLMF1mdn/XTd4rsmhNm5DqM8cr
	1xL7wn7dfIIWhqgPDLSY/2ForeRreZaglBUFGvC2Gru8oasv9RejCNC5brNv6ZEp
	XbU+4F08IpIoOxSL7rZhznG7w4CJ66unfS+q4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwq95VNRfrJsK6/ZgwAurRCzVw1JNZAP
	7Qm5lc9ZEOSCjM6/NAzUepVsA510pWJh0LIFU/FrS3tRsXc4OlNXXt51Smv94KI2
	ZCUyHxLcV6uZgPY5JScAdW8JAHSfjpul6p+sMHm/MSeARhqcmYETdv9D/pcc/9jH
	iRkxzgGEm4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56F47C605;
	Mon, 28 Jan 2013 12:53:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD67FC601; Mon, 28 Jan 2013
 12:53:48 -0500 (EST)
In-Reply-To: <20130128112043.GZ7498@serenity.lan> (John Keeping's message of
 "Mon, 28 Jan 2013 11:20:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB1825D8-6973-11E2-8EB6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214843>

John Keeping <john@keeping.me.uk> writes:

> ---
> On Mon, Jan 28, 2013 at 11:44:34AM +0100, Michael Haggerty wrote:
>> NAK.  It is still not right.  If the locale is not utf-8 based, then it
>> is incorrect to re-encode the string using utf-8.  I think you really
>> have to use sys.getfilesystemencoding() as I suggested.
>
> If you'd asked me what the patch contained I would have said it did use
> getfilesystemencoding(), but I can't disbelieve my own eyes :-(
>
> Junio, please can you squash this in?

Sure.  Thanks for double-checking, Michael.  I knew there was
something missing but I didn't spot the difference myself.

>  git-remote-testpy.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> index 6098bdd..ca67899 100644
> --- a/git-remote-testpy.py
> +++ b/git-remote-testpy.py
> @@ -49,7 +49,7 @@ def encode_filepath(path):
>      """
>      if sys.hexversion < 0x03000000:
>          return path
> -    return path.encode('utf-8', 'surrogateescape')
> +    return path.encode(sys.getfilesystemencoding(), 'surrogateescape')
>  
>  
>  def get_repo(alias, url):
