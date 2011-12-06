From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 06/13] credential: apply helper config
Date: Tue, 06 Dec 2011 15:58:35 -0800
Message-ID: <7vsjkxckwk.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062247.GF29233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 00:58:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY4uJ-0005GT-4x
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 00:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1LFX6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 18:58:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab1LFX6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 18:58:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AED95DA1;
	Tue,  6 Dec 2011 18:58:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FpceRIK+F/DNVI+ndy8ng064xrI=; b=RxM36Y
	5TjCjivVOlmAudih0aH7d58eFe4vh1RBp6DTCWMao9m7RAmju8pm99PncAGY124t
	Oy4J5aR6kUH0Dd20/Uw9BquxCwKH4WrvQ1ZYb4AEpaNfLTB+2tyQSruRe3qiX09k
	K7xHHR/Lr6OYI9bH6QGd4FuNnqKQ/bc9P+2WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GbrzcQp9AlY5xqAD/xZLEZea8HdFHaBt
	Osl05LoflHxylQqomVA16kDmT/CQg6cfVFSj5deGP/Eh9sKFt+Enavrtr8Hu8Kur
	dCEVM2ghsqt8DB7PQZKFsHctNRWv4J2z5m4HVDeTXiFFePiFe4ToVHERA1P0LoIC
	pOGe8xGS+qM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 302A95DA0;
	Tue,  6 Dec 2011 18:58:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB70F5D9F; Tue,  6 Dec 2011
 18:58:36 -0500 (EST)
In-Reply-To: <20111206062247.GF29233@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 Dec 2011 01:22:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3645DF22-2066-11E1-8437-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186406>

Jeff King <peff@peff.net> writes:

> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 81a455f..e3f61f4 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -192,4 +192,46 @@ test_expect_success 'internal getpass does not ask for known username' '
>  	EOF
>  '
>  
> +HELPER="f() {
> +		cat >/dev/null
> +		echo username=foo
> +		echo password=bar
> +	}; f"
> +test_expect_success 'respect configured credentials' '
> +	test_config credential.helper "$HELPER" &&
> +	check fill <<-\EOF
> +	--
> +	username=foo
> +	password=bar
> +	--
> +	EOF
> +'

Hmm, why do I get ask-ass-{username,password} from this one?

> +test_expect_success 'match configured credential' '
> +	test_config credential.https://example.com.helper "$HELPER" &&
> +	check fill <<-\EOF
> +	protocol=https
> +	host=example.com
> +	path=repo.git
> +	--
> +	username=foo
> +	password=bar
> +	--
> +	EOF
> +'

And this one, too...
