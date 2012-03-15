From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: print list of valid tools with '--tool-help'
Date: Thu, 15 Mar 2012 15:32:53 -0700
Message-ID: <7vk42lijfu.fsf@alter.siamese.dyndns.org>
References: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8JED-0008D6-G3
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761625Ab2COWc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:32:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761538Ab2COWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:32:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5C007D98;
	Thu, 15 Mar 2012 18:32:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JWJuciXwDanJt6CNqV0AAoz9lOM=; b=qbICkc
	HbChsZL9Kv++kgABL95P26eLHLv536oglYtKC4NHFptUE2vS0zwPtHLl+RgmDCX+
	m3aVlmu7NNn9CXJJ/ugNeQeML48iK/jrdup7E54Zb6hH1vBmMxfonHQS48bsqmjP
	wuj7q3MBgQnmiI604Ormqsl7F8GYrtaRG9A74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tD6QFbrFr75SRv9wcu2I0hOJqmELegfy
	jCinZyLH+5KW/ZXCLixefe3T5bbLLBFTFAdkph+GSssxbE+THZf1u4a4HuwRQlHX
	EHaBpbH68j2FLM4MpD6x5i56Zcbd545fRykowrVaoZ5xOXCHLS1RbQJS6+ZGrLrM
	6NVLkox+cIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6177D97;
	Thu, 15 Mar 2012 18:32:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1947B7D95; Thu, 15 Mar 2012
 18:32:55 -0400 (EDT)
In-Reply-To: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 15 Mar 2012 18:25:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEF34D1E-6EEE-11E1-BA9C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193235>

Tim Henigan <tim.henigan@gmail.com> writes:

> @@ -100,6 +101,15 @@ sub generate_command
>  		if ($arg eq '-h') {
>  			usage();
>  		}
> +		if ($arg eq '--tool-help') {
> +			my $gitpath = Git::exec_path();
> +			print "'git difftool --tool=<tool>' may be set to one of the following:\n";
> +			for (glob "$gitpath/mergetools/*") {
> +				next if /defaults$/;
> +				print "\t" . basename($_) . "\n";
> +			}
> +			exit(1);
> +		}

I know the call to usage() against "-h" has the same issue, but I think
people find it offensive when they ask for help and the command reports a
failure with a non-zero exit code.

Other than that, looks good from a cursory look.  Davidd, any comments?

>  		push @command, $arg;
>  	}
>  	if ($prompt eq 'yes') {
