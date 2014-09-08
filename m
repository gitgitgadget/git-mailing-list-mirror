From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 8/8] log --remerge-diff: show what the conflict resolution changed
Date: Mon, 08 Sep 2014 11:28:35 -0700
Message-ID: <xmqq38c2nezv.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<29c15efe998630143eaa75ec7155a31ce17bd433.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:29:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR3gp-0004sx-6w
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbaIHS3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 14:29:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62866 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbaIHS3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 14:29:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54687365F8;
	Mon,  8 Sep 2014 14:29:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7WSvWNN62rQ3q/V+dkYotjE8sc=; b=QDubgJ
	BMu0SnDC2R9ttzZHShoagboVTj8CUspxFad54pvPUy9vrwZXfJ5rimfiIAR8ub3q
	3z9EKDluFGIpShq/4eEbb1wEsXhKzfmxmy2zWp0liZWfMOcK9YX+b6ikk9pq/mhp
	EizzWod26Q5JCyWv2WnokhqPdbWy54JVV2OYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jh9+65uC9KVHJARpbjl+0usrqtGGZUzf
	uzXdoeYs4dHQvG6RDwWwQDuoHhwBX5vq40gtAHFTJM9/dleTvjauLMoVQnWMTKpo
	xwxhbBDFU4AiZGye/iT42jcGBqs6U6w1pHaK0BnIO/BvPuEfp3mSxv2H7P0Z8hqf
	junJauYDrHg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AE7D365F6;
	Mon,  8 Sep 2014 14:29:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95EEC3659C;
	Mon,  8 Sep 2014 14:28:37 -0400 (EDT)
In-Reply-To: <29c15efe998630143eaa75ec7155a31ce17bd433.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F312D1B2-3785-11E4-BA01-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256666>

Thomas Rast <tr@thomasrast.ch> writes:

> +static void assemble_conflict_entry(struct strbuf *sb,
> +				    const char *branch1,
> +				    const char *branch2,
> +				    struct cache_entry *entry1,
> +				    struct cache_entry *entry2)
> +{
> +	strbuf_addf(sb, "<<<<<<< %s\n", branch1);
> +	strbuf_append_cache_entry_blob(sb, entry1);
> +	strbuf_addstr(sb, "=======\n");
> +	strbuf_append_cache_entry_blob(sb, entry2);
> +	strbuf_addf(sb, ">>>>>>> %s\n", branch2);
> +}

I didn't read 6 thru 8 as carefully as I did the earlier ones, but
this part stood out.  How does the above hardcoded markers interact
with the conflict-marker-size attribute set to the path?
