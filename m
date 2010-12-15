From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6.1 4/8] Implement line-history search (git log -L)
Date: Tue, 14 Dec 2010 16:20:48 -0800
Message-ID: <7vfwtzrin3.fsf@alter.siamese.dyndns.org>
References: <cover.1292366984.git.trast@student.ethz.ch>
 <426fca7313fc9466efa036b7b86947f23548fc26.1292366984.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 01:21:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSf7D-0004FC-Nm
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 01:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466Ab0LOAVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 19:21:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab0LOAVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 19:21:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 541B5362C;
	Tue, 14 Dec 2010 19:21:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AZBe+fjNfcqREo3dFZjuYUJS3Oc=; b=CFuNJm
	XyvMHDCFqew1/XviH+8QcMbhdzkWDNfenF86jvbK+aU7lwQf36ZnOog1LqNq3duf
	yJm+zrUqpxdlk84dXou7kjn6BDXGsAd7iXYS/RCdY0Vd/U/HGBC84U8lqqbCBIZ6
	hzcyCIKVfSR7N5+QfyG9S/7fZ8CqA/HyGauak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=deHE1jjUa6MMnIybk23A8Ldkfhs7wZoZ
	ff4vOzFNGefzoKlKvrg1A6YeujjjohCpNXBT7cDEtPmIMLmZBj6PJy0WQPm1U6WN
	0P8/3ZID+AHHocA1NY7KPKx03+Ls9TWEEaEsWYLyvZK6uBhKWQHbFlddQp/5yYML
	OKNeffht6Ow=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D355362B;
	Tue, 14 Dec 2010 19:21:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 00C96362A; Tue, 14 Dec 2010
 19:21:16 -0500 (EST)
In-Reply-To: <426fca7313fc9466efa036b7b86947f23548fc26.1292366984.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 14 Dec 2010 23\:54\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E07063A-07E1-11E0-9476-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163724>

Thomas Rast <trast@student.ethz.ch> writes:

> +void line_log_init(struct rev_info *rev, struct diff_line_range *r)
> +{
> +	struct commit *commit = NULL;
> +	struct diff_options *opt = &rev->diffopt;
> +
> +	commit = (struct commit *)verify_commit(rev);
> +	parse_lines(commit, r);
> +
> +	add_line_range(rev, commit, r);
> +	/*
> +	 * Note we support -M/-C to detect file rename
> +	 */
> +	opt->nr_paths = 0;
> +	diff_tree_release_paths(opt);
> +}

Note that opt->nr_paths may be going away soon (cf. nd/struct-pathspec
topic).  Do you need this assignment here?
