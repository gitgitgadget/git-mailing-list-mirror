From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] combine-diff: speed it up, by using multiparent diff tree-walker directly
Date: Thu, 13 Feb 2014 11:55:08 -0800
Message-ID: <xmqq7g8ylrdv.fsf@gitster.dls.corp.google.com>
References: <cover.1392299516.git.kirr@mns.spb.ru>
	<f74c494d4afd0f7428288ce1099a91c9d2ae2125.1392299516.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Feb 13 20:55:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE2NY-0002SD-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 20:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbaBMTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 14:55:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbaBMTzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 14:55:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD94D6C7D7;
	Thu, 13 Feb 2014 14:55:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V19N35+AVjip6EQQs/z0UEr422Y=; b=XNOwRU
	6sD3QKm/zcBTM8v3f5E44ITg0hsXjoYt5sfJ6OSORigQvwBQkgneSc9801tMwSZa
	WZ6VSmTgAKZjUS1GULtA9ps39dzrY4uO6Qtu2kZzkTPgiJ/cyIOwOjU/1KF2NV3J
	ZyKOYllS2aqw0Z3g6DQ9wh0T0AljyPvcLu86I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UxSItgSWQlLY/pG4kC1igEuiIesVGOWM
	SVBdhdvoliGID0pnOtcOF6Js2H1njkpJyHOjEuXwlenjXSFSiHqyz20h3TM2RaRP
	PP+s7UjERGDcTacyPXs0qB8kG2H2xxWB5gYzoUVT49ik+heSUrdWDR/u4DUuTsYQ
	hB+oxAg1tnQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62E4D6C7D6;
	Thu, 13 Feb 2014 14:55:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D59876C7D1;
	Thu, 13 Feb 2014 14:55:10 -0500 (EST)
In-Reply-To: <f74c494d4afd0f7428288ce1099a91c9d2ae2125.1392299516.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Thu, 13 Feb 2014 18:02:55 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEFD377C-94E8-11E3-A91D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242076>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> +	if (need_generic_pathscan) {
> +		/* NOTE generic case also handles --stat, as it computes
> +		 * diff(sha1,parent_i) for all i to do the job, specifically
> +		 * for parent0.
> +		 */
> +		paths = find_paths_generic(sha1, parents, &diffopts);
> +	}
> +	else {
> +		paths = find_paths_multitree(sha1, parents, &diffopts);
> +
> +		/* show stat against the first parent even
> +		 * when doing combined diff.
> +		 */
> +		int stat_opt = (opt->output_format &
> +				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));

/*
 * We see decl-after-stmt here.
 * Also please have slash-asterisk and asterisk-slash
 * at the beginning and the end of a multi-line comment
 * block on their own line.
 */
