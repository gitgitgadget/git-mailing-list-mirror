From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Tue, 16 Nov 2010 11:10:40 -0800
Message-ID: <7vtyjhgk3z.fsf@alter.siamese.dyndns.org>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
 <7vaalajkiq.fsf@alter.siamese.dyndns.org> <4CE22EC2.7040603@viscovery.net>
 <20101116171031.GB13398@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 20:11:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIQvk-0004T3-CI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab0KPTKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:10:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab0KPTKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:10:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8947F2A79;
	Tue, 16 Nov 2010 14:11:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=75ByY/4go21s9cCAkUqln3HN53g=; b=JZjdQ7
	G0Ut20Lf3/BsFlntMQgqyiNSPKZGaSBsbwLqb6qtC6R4Oxp64omg/Zu2DCYpYe9d
	4buxT37W9WSSeGm1qG06GTcwSCc1aV9nJUK5RcdkbWdBVJWOlmvnNLF7gbw+VCng
	keFfNVBnMtcQ4KOoBw+Lfp/NwNC9apRjcAw5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZV61CgoGBw3CsNnmzaWjAi0J7Xvn/Wu
	kr91mizrY1RroneFdWl5up48HlOtoHHH0zXbvhatpLZKNc79Ou98GpGVBWuHhKbe
	pZ35cXMONwNp7GvfIkgTlK9h3iwsZ8k01tG1AnWPLNwydA3cZN/jycCMs3qRgn76
	LXKsb+solYc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4914F2A75;
	Tue, 16 Nov 2010 14:10:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD4FF2A73; Tue, 16 Nov 2010
 14:10:52 -0500 (EST)
In-Reply-To: <20101116171031.GB13398@burratino> (Jonathan Nieder's message of
 "Tue\, 16 Nov 2010 11\:10\:32 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E574998-F1B5-11DF-BF81-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161577>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Sixt wrote:
>
>> - It doesn't save any messages or fix-ups during review: instead of "do
>> not quote!" we have to say "use test_line_count!".
>
> I was nervous about introducing test_line_count for that reason.
>
> Another consideration won out: not syntax but output format.  See
> cae3aa79 (t6022 (renaming merge): chain test commands with &&,
> 2010-10-31).  Kind of analogous to test_cmp, which is a similar
> headache to get used over less portable or less pleasant alternatives.
>
> If a piped variant is needed, I would prefer it to work something
> like this.  Usage:
>
> 	{
> 		command_producing_five_lines |
> 		test_line_count = 5 -
> 	}
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1ea0116..35a5634 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -660,15 +660,24 @@ test_path_is_missing () {
>  # output through when the number of lines is wrong.
>  
>  test_line_count () {
> +	line_count_tmp=
>  	if test $# != 3
>  	then
>  		error "bug in the test script: not 3 parameters to test_line_count"
> -	elif ! test $(wc -l <"$3") "$1" "$2"
> +	fi
> +	if test "$3" = -
> +	then
> +		line_count_tmp=test_line_count.output
> +		cat >"$line_count_tmp"
> +		set -- "$1" "$2" "$line_count_tmp"
> +	fi
> +	if ! test $(wc -l <"$3") "$1" "$2"
>  	then
>  		echo "test_line_count: line count for $3 !$1 $2"
>  		cat "$3"
>  		return 1

You forgot to clean the temporary file here.

Also if the file is huge, do we really want to cat the whole thing?

>  	fi
> +	rm -f "$line_count_tmp"
>  }
>  
>  # This is not among top-level (test_expect_success | test_expect_failure)
