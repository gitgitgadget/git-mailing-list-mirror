From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git am" crash (builtin/apply.c:2108) + small repro
Date: Fri, 12 Oct 2012 14:35:55 -0700
Message-ID: <7vtxtz2x1g.fsf@alter.siamese.dyndns.org>
References: <CAOKKMFG4JsNyMY7=SB6EuR8_GnpAu-ysH02J5pwD1cNzUgaieQ@mail.gmail.com>
 <CACsJy8B9NDmGnopoFEAA0T4mgG+54npYnbb_d4tihRNB=xrGnw@mail.gmail.com>
 <CAOKKMFFGz5Waz3OV4_uTgwDaL=S9NWAnLnACPzSkGpu_rrChvQ@mail.gmail.com>
 <CACsJy8B4xeLSDPC42JifZwC7VWTPRd2iZfnxtPhf7u3OzOm_6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Spiridonov <snarkmaster@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 23:36:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMmtv-0007oR-G4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 23:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab2JLVf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 17:35:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab2JLVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 17:35:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED72B9624;
	Fri, 12 Oct 2012 17:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ny4nNy13HXSBizObyu9y+coDzA=; b=RULJOs
	9N9diPMCZZCCKzqqbP0yT27OSV0Lz6KsBZl4hnHY8JeS4cvUMb47fVzNAIFALY1z
	ZoKFWbFgcGDzAyYS9ntPgwetMvzAQl6rDgs0fp+3kwuUUcVhk9YIfEBDX13DtN2o
	hH6CpYZz0GlWAKMDT8JHwHNslD+Jt0+uSlrGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yhqtJYramLSU0Yg0cxnhwVw67BAOKSr8
	UeVlVjCg6LY+4/GxxDpLPrQpRjwG/js74XGhCl9Yj4CavFzOOLg+GtGSBEkPUB62
	jKVfgFjTic+pOXO3GoR1JcgPbHyFWpfZgPD6o2k51htBjBGRkdeKv8uD8n3nxk+8
	JHeZ+y80f4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9CA59623;
	Fri, 12 Oct 2012 17:35:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 580109622; Fri, 12 Oct 2012
 17:35:57 -0400 (EDT)
In-Reply-To: <CACsJy8B4xeLSDPC42JifZwC7VWTPRd2iZfnxtPhf7u3OzOm_6Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 7 Oct 2012 10:33:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEF9D7F8-14B4-11E2-989B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207565>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Oct 3, 2012 at 10:44 PM, Alexey Spiridonov
> <snarkmaster@gmail.com> wrote:
>> Thanks a lot for trying this.
>>
>> My hashes match. I just re-reproduced it on two flavors of Linux (64
>> and 32-bit), with two different Git versions (see below). What
>> platform are you using?
>
> x86, 32 bit. Perhaps it has something to do with your configuration
> (config files, hooks, attributes). Assuming you use standard
> repository templates, you create new repo in your test so hooks and
> attributes are out. Is there anything suspicuous in "git config -l"?

I've never been a fan of update_pre_post_images().  I think I know
what is going on (--whitespace=fix).  Will post a fix sometime
later.
