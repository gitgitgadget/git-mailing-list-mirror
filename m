From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Sat, 31 Mar 2012 10:49:42 -0700
Message-ID: <7v62dkk6dl.fsf@alter.siamese.dyndns.org>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120331055520.GA7939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, peff@peff.net,
	j.sixt@viscovery.net, gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 19:50:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE2RX-0001w1-Rr
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 19:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2CaRtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 13:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427Ab2CaRtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 13:49:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F1846301;
	Sat, 31 Mar 2012 13:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vPYkaT9CwW1p3QlN1K8cewsjJr4=; b=UqBK//
	tyFvjyXvz+2pp+CC6u5uB3Ua0Id5eLnB8D3m/aPdF1td8BIzq1rdZz0gKt5vu0wd
	V3GJUTAG301ZkNNqbmIdyT87h8sySpj2IklJKDU93DKhsYbqlCOSeB1uxhiQh9+r
	wPFHZbi76wsiFf16ZXkmP0orTSIBVK8zxVuxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HWald0XOHhaL2TK5iOZO4cbgcJsCAIjg
	4MtCWdaQtUXPODxgq+agyrC/7HxN6sWH0uJON6BmitGIUy5aDLkoSCTJWVzQLAJ0
	SXcuAvwt5kwDiIwapcVFiEfVSKIugPw9CazROp3EOrUC9eVKzN9v5np7KbzPv7Nf
	Vj4tapOUXlI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364AD6300;
	Sat, 31 Mar 2012 13:49:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B892262FE; Sat, 31 Mar 2012
 13:49:43 -0400 (EDT)
In-Reply-To: <20120331055520.GA7939@burratino> (Jonathan Nieder's message of
 "Sat, 31 Mar 2012 00:55:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5EFF05E-7B59-11E1-A1EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194457>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sorry I forgot to send this before.  Quick tweaks:
>
>  - let assembler listings (from "make run-command.s") and sparse checks
>    reflect the SHELL_PATH setting, too
>
>  - the entire -DFOO="bar" argument is surrounded with single quotes
>    in other EXTRA_CPPFLAGS settings, so let this one follow that
>    pattern to avoid standing out
>
> diff --git i/Makefile w/Makefile
> index dea1f157..a3791139 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -1913,7 +1913,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
>  	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
>  	'-DGIT_INFO_PATH="$(infodir_SQ)"'
>  
> -run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH_SQ)"'
> +run-command.sp run-command.s run-command.o: EXTRA_CPPFLAGS = \
> +	'-DSHELL_PATH="$(SHELL_PATH_SQ)"'
>  
>  $(BUILT_INS): git$X
>  	$(QUIET_BUILT_IN)$(RM) $@ && \

Actually, I do not think this is sufficient, and it happens that you and I
are the best position to realize it ;-).

Look at what is done in the Makefile for DEFAULT_EDITOR and DEFAULT_PAGER,
and compare with what the above is doing, and think why the EDITOR/PAGER
needs to have another level of quoting.
