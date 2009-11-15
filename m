From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sun, 15 Nov 2009 01:05:47 -0800
Message-ID: <7vd43krwd0.fsf@alter.siamese.dyndns.org>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock> <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com> <20091114110141.GB1829@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9b3l-0000v2-3h
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbZKOJF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZKOJF7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:05:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZKOJF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:05:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCA37F3C6;
	Sun, 15 Nov 2009 04:06:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XtFzgtVX5iSFjpz7UmxTIvIlWTU=; b=hjaEQBJS8MKpkJkPRdfTv3Z
	3Lu1A2ZqgoAlnF7EBspDP4EAkS2Cre1tYZlViG95r5OBiGq4e/NnPIQDXtm3p4+O
	lLqrZOdmKl/n5MEQ1eJJeGTh986lcm8bs0925rw5f2Cwl6H67zbDn40MUWNBNBb6
	a7olZGJsXV4Gve11A8KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=phXzQJioW4lVQvH42S7HHOrb2tzBxTJutpBU+NQ8mDuwQXNV5
	pk/IUWwpkuBWCK9rir30OzRhMLzzdDPqGSr01BXn+BLlf52d7j/k3bMT/FpU+YuG
	9QlsOk7ObnYjyX0/NZuiJN8zYkvhtW9r20WUfhnNjwqgKZaxbyiAfXdIZ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B60B97F3C5;
	Sun, 15 Nov 2009 04:05:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CCEF7F3C3; Sun, 15 Nov
 2009 04:05:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1532C994-D1C6-11DE-A89D-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132916>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  __git_compute_merge_strategies ()
>  {
> -	: ${__git_merge_strategies=$(__git_list_merge_strategies)}
> +	__git_merge_strategies=$(__git_list_merge_strategies)

Wouldn't

	: ${__gms:=$(command)}

run command only until it gives a non-empty string?
