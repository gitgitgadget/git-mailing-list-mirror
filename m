From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 09 Dec 2013 09:48:35 -0800
Message-ID: <xmqq7gbd29vw.fsf@gitster.dls.corp.google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52A37D70.3090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 18:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq4wo-0003iM-GW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 18:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759635Ab3LIRsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 12:48:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695Ab3LIRsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 12:48:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5092957268;
	Mon,  9 Dec 2013 12:48:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SIa6BAnXKasDfxbSgW3Rjjt/Lxs=; b=H8iA1T
	SA2TXIrgfvcj43ML72iBkcDIN115D7Np5sfwK2Jh3fsg6WrMNFWJ7dYz9OfVvcAN
	SrNq1P8oHCOvkyVVo2pjsqVN3L/Gn0jPpm6fdhFvtZTICTPPZKgNRDa7PZFPMwf2
	3D31GGPKXYPFd9i85ClcVjf8dYYori5KQBXkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HDPnk7b0W1aM6/UETnEMt8N+IQSh1jBY
	YkiRAhEt+vZdjKGM+NanQs7gN5awVjVYwnej3w8h/GqtxNYf4ZerCShGAcR9xXJL
	z0LdARWQ0Sb8swOg0Jr+FhqB5gy9O4HlfxcYw9z/FP1310WxKDov0BzVziK7oVxK
	Eobk6TTIpOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7B357261;
	Mon,  9 Dec 2013 12:48:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFD835725F;
	Mon,  9 Dec 2013 12:48:38 -0500 (EST)
In-Reply-To: <52A37D70.3090400@gmail.com> (Karsten Blees's message of "Sat, 07
	Dec 2013 20:56:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2290C75E-60FA-11E3-98CB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239073>

Karsten Blees <karsten.blees@gmail.com> writes:

>> * kb/fast-hashmap (2013-11-18) 14 commits
>>   (merged to 'next' on 2013-12-06 at f90be3d) 
>
> Damn, a day too late :-) I found these two glitches today...is a
> fixup patch OK or should I do a reroll (or separate patch on top)?

A separate patch on top would be the most appropriate.  People have
been looking at the change since mid November, and nobody noticed
the problem; having a separate fix on top is a good way to document
what the specific gotcha that can be easily missed is.

I think the patch you attached describes the issue well, possibly
with a retitle (perhaps "hashmap.h: make sure map entries are
tightly packed", or something.)

Thanks.

> --- 8< ---
> Subject: [PATCH] fixup! add a hashtable implementation that supports O(1) removal
>
> Use 'unsigned int' for hash-codes everywhere.
>
> Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
> memory on 64-bit systems. This is already documented in api-hashmap.txt,
> but needs '__attribute__((__packed__))' to work. Reduces e.g.
>
>  struct name_entry {
>      struct hashmap_entry ent;
>      int namelen;
>      char *name;
>  };
>
> from 32 to 24 bytes.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  hashmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hashmap.h b/hashmap.h
> index f5b3b61..b64567b 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -15,7 +15,7 @@ extern unsigned int memihash(const void *buf, size_t len);
>  
>  /* data structures */
>  
> -struct hashmap_entry {
> +struct __attribute__((__packed__)) hashmap_entry {
>  	struct hashmap_entry *next;
>  	unsigned int hash;
>  };
> @@ -43,7 +43,7 @@ extern void hashmap_free(struct hashmap *map, int free_entries);
>  
>  /* hashmap_entry functions */
>  
> -static inline void hashmap_entry_init(void *entry, int hash)
> +static inline void hashmap_entry_init(void *entry, unsigned int hash)
>  {
>  	struct hashmap_entry *e = entry;
>  	e->hash = hash;
