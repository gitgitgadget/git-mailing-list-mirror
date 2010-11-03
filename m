From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Work around EMFILE when there are too many pack
 files
Date: Wed, 03 Nov 2010 10:06:55 -0700
Message-ID: <7vaalqxro0.fsf@alter.siamese.dyndns.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
 <1288652061-19614-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 18:07:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgo3-0000Ta-Be
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 18:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0KCRHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 13:07:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab0KCRHC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 13:07:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F29A41D5F;
	Wed,  3 Nov 2010 13:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0SjjpDPN2MWC49fihNCJjFFrMAM=; b=OGE1a+
	qlH0d7bavQOO/5Rbt4CWCM+ET6T7qfaaYVWOjSM7aQan1bQkqMbFRxixOwCNGZes
	98ct8twh3m+IGN+d6FDyDU0J39YX+VGymKvpFNfT+QqDqBkQ4plk7x0eN8tStAHw
	qyn+Llkl2yGaAp3pU1lekOHXi0tsKMuJJrsPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T2JGFcrioJYgIg146W9u1wqIT7kn1E+z
	EJ0JhqSsUpBaFJcXRo1KZdAi/9ipDXmi0aox+dhmvNHZVuGesVjSHPuwp9/MPXmg
	WdLkwWlWt0PB80BUXUpY6fljL1lxm/55VN5xFjNKGRwCAc0bog/41OR0OaXLX6/G
	27JbxAn1T0Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CDB8B1D5E;
	Wed,  3 Nov 2010 13:06:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 305741D5C; Wed,  3 Nov
 2010 13:06:57 -0400 (EDT)
In-Reply-To: <1288652061-19614-3-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Mon\,  1 Nov 2010 15\:54\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C55DE62A-E76C-11DF-9C1A-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160627>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> @@ -876,7 +874,7 @@ static void prepare_packed_git_one(char *objdir, int local)
>  	sprintf(path, "%s/pack", objdir);
>  	len = strlen(path);
>  	dir = opendir(path);
> -	while (!dir && errno == EMFILE && unuse_one_window(packed_git, -1))
> +	while (!dir && errno == EMFILE && unuse_one_window(NULL, -1))

Hmmmm, why?

> @@ -2314,7 +2325,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>  
>  	filename = sha1_file_name(sha1);
>  	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
> -	while (fd < 0 && errno == EMFILE && unuse_one_window(packed_git, -1))
> +	while (fd < 0 && errno == EMFILE && unuse_one_window(NULL, -1))

Again, why?
